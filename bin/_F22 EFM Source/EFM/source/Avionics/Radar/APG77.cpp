// APG77.cpp - Block 5+ Realism Enhancements (v1.2 with Spotlight + LPI)
#include "APG77.h"
#include <random>
#include <cmath>

APG77::APG77() {
    // Default constructor
}

#include <ctime>

void APG77::set_mode(const std::string& new_mode) {
    mode = new_mode;
    freeze = false;
    resolution = 1.0;
    lost_lock_time.reset();

    if (mode == "RWS") {
        fov_azimuth = 120;
        scan_rate = 2;
    } else if (mode == "VSR") {
        fov_azimuth = 40;
        scan_rate = 1;
    } else if (mode == "TWS") {
        fov_azimuth = 60;
        scan_rate = 3;
    } else if (mode == "STT") {
        fov_azimuth = 20;
        scan_rate = 4;
    } else if (mode == "SAM") {
        fov_azimuth = 360;
        scan_rate = 1;
    } else if (mode == "GM" || mode == "GM_EXP") {
        fov_azimuth = 60;
        scan_rate = (mode == "GM") ? 2 : 1;
        resolution = (mode == "GM_EXP") ? 4 : 1;
    } else if (mode == "DBS1") {
        fov_azimuth = 30;
        scan_rate = 0.5;
        resolution = 8;
    } else if (mode == "DBS2") {
        fov_azimuth = 10;
        scan_rate = 0.25;
        resolution = 64;
    } else if (mode == "SEA" || mode == "SEA_EXP") {
        fov_azimuth = 90;
        scan_rate = 0.5;
    } else if (mode == "GMTI" || mode == "GMTT") {
        scan_rate = 1.0;
    } else if (mode == "BCN") {
        scan_rate = 0.5;
    }
    std::cout << "[Radar] Mode set to " << mode << std::endl;
}

void APG77::set_submode(const std::string& sub) {
    submode = sub;
    std::cout << "[Radar] Submode set to " << sub << std::endl;
}

void APG77::toggle_freeze() {
    freeze = !freeze;
    std::cout << (freeze ? "[Radar] Freeze Enabled" : "[Radar] Freeze Disabled") << std::endl;
}

double APG77::radar_constant(double rcs) const {
    double gain_linear = std::pow(10.0, gain / 10.0);
    return (transmit_power * std::pow(gain_linear, 2) * std::pow(wavelength, 2) * rcs) /
           std::pow(4 * M_PI, 3);
}

double APG77::snr(double range, double rcs, double jammer_power) const {
    double constant = radar_constant(rcs);
    double received_power = constant / std::pow(range, 4);
    double atmospheric_attenuation = 0.998;
    received_power *= std::pow(atmospheric_attenuation, range / 1000.0);
    double jamming_effect = jammer_power * (1.0 - ecm_resistance);
    double effective_noise = noise_floor + jamming_effect;
    return 10 * std::log10(received_power) - effective_noise;
}

void APG77::update_track_memory(int id, const Contact& target) {
    track_memory[id] = TrackMemory{
        .data = target,
        .timestamp = std::clock() / (double)CLOCKS_PER_SEC,
        .status = "active"
    };
}

void APG77::update_trtn(double delta_time) {
    std::vector<int> expired;
    for (auto& [id, track] : trtn_memory) {
        track.timestamp += delta_time;
        if (track.timestamp > trtn_timeout) {
            expired.push_back(id);
        }
    }
    for (int id : expired) {
        trtn_memory.erase(id);
    }
}

std::optional<Contact> APG77::get_trtn(int id) const {
    auto it = trtn_memory.find(id);
    if (it != trtn_memory.end()) {
        return it->second.data;
    }
    return std::nullopt;
}

void APG77::maintain_tracks(double current_time) {
    std::vector<int> to_remove;
    for (const auto& [id, mem] : track_memory) {
        if ((current_time - mem.timestamp) > 10.0) {
            to_remove.push_back(id);
        }
    }
    for (int id : to_remove) {
        track_memory.erase(id);
    }
}

void APG77::record_trtn(int id, const Contact& target) {
    trtn_memory[id] = TrackMemory{
        .data = target,
        .timestamp = std::clock() / static_cast<double>(CLOCKS_PER_SEC),
        .status = "TRTN"
    };
}

std::optional<std::string> APG77::get_weapon_cue(const Contact& target) const {
    if (target.range < 1500) return "GUN";
    if (target.range < 30000 && target.classification == "Air") return "AIM-9";
    if (target.range < 60000 && target.classification == "Air") return "AIM-120";
    if (target.range < 80000 && target.classification == "Air") return "AIM-260";
    if (target.classification == "Ground" && target.range < 15000) return "JDAM";
    return std::nullopt;
}

std::vector<Contact> APG77::update(const std::vector<Contact>& world_objects, double delta_time) {
    if (!freeze) {
        maintain_tracks(std::clock() / (double)CLOCKS_PER_SEC);
        update_trtn(delta_time);
    }
    return perform_mode_logic(world_objects);
}

std::vector<Contact> APG77::perform_mode_logic(const std::vector<Contact>& all_contacts) {
    std::vector<Contact> detected;
    if (freeze) return detected;

    std::default_random_engine rng(static_cast<unsigned>(std::clock()));
    std::normal_distribution<double> false_positive(0.0, 2.5);

    for (const auto& obj : all_contacts) {
        Vec3 d = { obj.position.x - radar_position.x, obj.position.y - radar_position.y, obj.position.z - radar_position.z };
        double range = std::sqrt(d.x * d.x + d.y * d.y + d.z * d.z);
        double azimuth = std::fmod(std::atan2(d.y, d.x) * 180.0 / M_PI + 360.0, 360.0);
        double elevation = std::atan2(d.z, std::sqrt(d.x * d.x + d.y * d.y)) * 180.0 / M_PI;

        double jammer_power = 0.0; // Optional: fill in from EW system later
        double snr_val = snr(range, obj.rcs, jammer_power);
        bool detectable = snr_val > 10.0;

        double bearing_diff = spotlight_bearing.has_value() ? std::abs(azimuth - *spotlight_bearing) : 0.0;
        bool spotlight_limited = spotlight_bearing.has_value() && bearing_diff > 10.0;

        bool in_fov = std::abs(azimuth - heading) <= fov_azimuth / 2.0;

        // Simulate LPI (Low Probability of Intercept) mode - lower SNR, tighter FOV
        bool is_lpi_mode = submode == "LPI";
        if (is_lpi_mode) {
            if (!in_fov || range > 50000 || snr_val < 12.0) continue;
        }

        Contact contact = obj;
        contact.azimuth = azimuth + false_positive(rng); // simulate noise
        contact.elevation = elevation;
        contact.range = range;

        if (spotlight_limited) continue;

        if ((mode == "RWS" || mode == "TWS") && detectable && in_fov) {
            update_track_memory(contact.id, contact);
            detected.push_back(contact);
        }
        if (mode == "STT" && (!stt_target || stt_target->id == contact.id) && detectable) {
            stt_target = contact;
            update_track_memory(contact.id, contact);
            detected.push_back(contact);
        }
        if (mode == "SAM" && tracking_target && contact.id == tracking_target->id) {
            if (detectable) {
                update_track_memory(contact.id, contact);
                detected.push_back(contact);
            } else {
                auto trtn = get_trtn(contact.id);
                if (trtn) detected.push_back(*trtn);
            }
        }
        if ((mode == "GM" || mode == "SEA") && contact.classification == "Ground" && detectable) {
            detected.push_back(contact);
        }
        if (mode == "GMTI" && std::abs(contact.velocity.x) > 1.0 && detectable) {
            detected.push_back(contact);
        }
        if (mode == "GMTT" && tracking_target && contact.id == tracking_target->id) {
            detected.push_back(contact);
        }
        if (mode == "BCN" && contact.beacon) {
            detected.push_back(contact);
        }
    }

    if (mode == "RWS" || mode == "TWS") {
        detected = apply_threat_priority(detected);
    }

    return detected;
}

// ✅ Block 5.1 Enhancements:
// - Spotlight scan filter using spotlight_bearing
// - LPI mode suppresses range and angular cone
// - False positive simulation preserved
// - Azimuth wrap logic retained
// - Prepped for integration with EW/ECM inputs

std::optional<std::string> get_weapon_cue(const Contact& target) const
{
    return std::optional<std::string>();
}
