// ALR94.cpp
#include "ALR94.h"
#include <ctime>
#include <cmath>
#include <algorithm>

void ALR94::set_position(const Vec3& pos) {
    self_position = pos;
}

void ALR94::set_signal_floor(double snr_threshold) {
    signal_threshold_snr = snr_threshold;
}

void ALR94::enable_geolocation(bool enable) {
    use_geolocation = enable;
}

void ALR94::set_terrain_occlusion(std::function<bool(const Vec3&, const Vec3&)> func) {
    terrain_mask_fn = func;
}

double ALR94::now() const {
    return std::clock() / static_cast<double>(CLOCKS_PER_SEC);
}

void ALR94::detect_emitter(const Contact& emitter, double snr) {  
    if (snr < signal_threshold_snr) return;  
    if (terrain_mask_fn && terrain_mask_fn(self_position, emitter.position)) return;

    TrackedEmitter entry;  
    entry.contact = emitter;  
    entry.last_seen = now();  
    entry.snr = snr;  
    entry.geolocating = use_geolocation;  
    threats[emitter.id] = entry;  
}

void ALR94::missile_launch(int source_id) {
    missile_alerts[source_id] = now();
}

void ALR94::update(double dt) {
    double t = now();
    max_threat_bearing = std::nullopt;
    double strongest_snr = 0.0;

    for (auto it = threats.begin(); it != threats.end(); ) {
        if ((t - it->second.last_seen) > 10.0) {
            it = threats.erase(it);
        }
        else {
            if (it->second.snr > strongest_snr) {
                strongest_snr = it->second.snr;
                max_threat_bearing = it->second.contact.bearing_deg;
            }
            ++it;
        }
    }

    for (auto it = missile_alerts.begin(); it != missile_alerts.end(); ) {
        if ((t - it->second) > 5.0) {
            it = missile_alerts.erase(it);
        }
        else {
            ++it;
        }
    }
}

std::vector<Contact> ALR94::get_emitters() const {
    std::vector<Contact> result;
    for (const auto& [id, em] : threats) {
        result.push_back(em.contact);
    }
    return result;
}

std::vector<int> ALR94::get_active_missile_alerts() const {
    std::vector<int> result;
    for (const auto& [id, t] : missile_alerts) {
        result.push_back(id);
    }
    return result;
}

std::string ALR94::get_ring_for_range(double range_m) const {
    // This logic can be extended with emitter azimuth for autopilot spike turn cues
    if (range_m < 10000.0) return "INNER";
    if (range_m < 30000.0) return "MIDDLE";
    return "OUTER";
}

std::optional<double> ALR94::get_strongest_emitter_azimuth() const {
    return max_threat_bearing;
}
// In future, consider adapting this logic to emitter azimuth
// to trigger autopilot notching logic or bearing deviation
}

std::optional<double> ALR94::get_max_threat_bearing() const {
    return max_threat_bearing;
}

