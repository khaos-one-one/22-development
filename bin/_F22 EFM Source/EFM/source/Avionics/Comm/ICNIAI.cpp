// ICNIAI.cpp
#include "ICNIAI.h"
#include <cmath>
#include <Utility.h>

void ICNIAI::add_waypoint(const Waypoint& wp) {
    waypoints.push_back(wp);
}

void ICNIAI::clear_waypoints() {
    waypoints.clear();
    active_id.reset();
}

void ICNIAI::activate_waypoint(int id) {
    for (auto& wp : waypoints) {
        wp.active = (wp.id == id);
        if (wp.active) active_id = id;
    }
}

void ICNIAI::deactivate_waypoint() {
    for (auto& wp : waypoints) wp.active = false;
    active_id.reset();
}

void ICNIAI::advance_waypoint() {
    if (waypoints.empty()) return;
    auto it = std::find_if(waypoints.begin(), waypoints.end(), [this](const Waypoint& wp) {
        return active_id.has_value() && wp.id == *active_id;
        });
    if (it != waypoints.end() && std::next(it) != waypoints.end()) {
        activate_waypoint(std::next(it)->id);
    }
    else if (!waypoints.empty()) {
        activate_waypoint(waypoints.front().id);
    }
}

void ICNIAI::get_active_waypoint() const {
    if (!active_id.has_value()) return;
    for (const auto& wp : waypoints) {
        if (wp.id == *active_id) return wp;
    }
    return;
}

void ICNIAI::get_all_waypoints() const {
    for (const auto& wp : waypoints) {
        // Process each waypoint (e.g., send to HUD)
    }
}

void ICNIAI::align_INS(const std::string& mode) {
    ins_mode = mode;
    ins_timer = (mode == "FAST") ? 30.0 : (mode == "NORM") ? 120.0 : 0.0;
    ins_aligned = false;
}

void ICNIAI::update_INS(double dt) {
    if (!ins_aligned && ins_timer > 0.0) {
        ins_timer -= dt;
        if (ins_timer <= 0.0) ins_aligned = true;
    }
}

bool ICNIAI::is_INS_aligned() const {
    return ins_aligned;
}

bool ICNIAI::has_navigation_target() const {
    return active_id.has_value();
}

Vec3 ICNIAI::get_navigation_vector(const Vec3& current_pos) const {
    if (!active_id.has_value()) return { 0, 0, 0 };
    for (const auto& wp : waypoints) {
        if (wp.id == *active_id) {
            return {
                wp.position.x - current_pos.x,
                wp.position.y - current_pos.y,
                wp.position.z - current_pos.z
            };
        }
    }
    return { 0, 0, 0 };
}

void ICNIAI::register_tacan(const TacanStation& tac) {
    ICNIAI::tacans[tac.ident] = tac;
}

void ICNIAI::register_ils(const IlsStation& ils) {
    ICNIAI::ils_stations[ils.ident] = ils;
}

void ICNIAI::register_ndb(const NdbStation& ndb) {
    ICNIAI::ndbs[ndb.ident] = ndb;
}

void ICNIAI::get_tacan_solution(const std::string& ident, const Vec3& pos) const {
    auto it = ICNIAI::tacans.find(ident);
    if (it == ICNIAI::tacans.end()) return;
    const auto& station = it->second;
    return Vec3{ station.position.x - pos.x, station.position.y - pos.y, station.position.z - pos.z };
}

void ICNIAI::get_ils_solution(const std::string& ident, const Vec3& pos) const {
    auto it = ils_stations.find(ident);
    if (it == ils_stations.end()) return;
    const auto& ils = it->second;
    return Vec3{ ils.position.x - pos.x, ils.position.y - pos.y, ils.position.z - pos.z };
}

void ICNIAI::get_ndb_solution(const std::string& ident, const Vec3& pos) const {
    auto it = ndbs.find(ident);
    if (it == ndbs.end()) return;
    const auto& station = it->second;
    return Vec3{ station.position.x - pos.x, station.position.y - pos.y, station.position.z - pos.z };
}

ICNIAI::ICNIAI() {
    // Default presets (example)
    uhf_presets = {
        {"A", 225.0}, {"B", 243.0}, {"C", 251.0},
        {"D", 260.0}, {"E", 270.0}, {"F", 300.0}
    };
    vhf_presets = {
        {"1", 118.0}, {"2", 121.5}, {"3", 123.0},
        {"4", 125.0}, {"5", 127.0}, {"6", 130.0}
    };
    uhf.display = "UHF READY";
    vhf.display = "VHF READY";
}


void ICNIAI::set_frequency(const std::string& band, double freq) {
    if (band == "UHF") {
        uhf.freq = freq;
        uhf.preset = -1;
        uhf.display = std::to_string(freq);
    }
    else if (band == "VHF") {
        vhf.freq = freq;
        vhf.preset = -1;
        vhf.display = std::to_string(freq);
    }
}

void ICNIAI::select_preset(const std::string& band, int preset) {
    std::string key = (band == "UHF") ? std::string(1, 'A' + preset) : std::to_string(preset + 1);
    double freq = (band == "UHF") ? uhf_presets[key] : vhf_presets[key];
    set_frequency(band, freq);
    if (band == "UHF") uhf.preset = preset;
    if (band == "VHF") vhf.preset = preset;
}

void ICNIAI::set_emcon(bool state) {
    emcon = state;
    uhf.display = state ? "EMCON" : uhf.display;
    vhf.display = state ? "EMCON" : vhf.display;
}

bool ICNIAI::receive(const std::string& from_id, double freq, const std::string& message,
    const std::string& source_type, double distance) {
    if (emcon) return false;
    if (std::find(guard_freqs.begin(), guard_freqs.end(), freq) == guard_freqs.end() &&
        freq != uhf.freq && freq != vhf.freq) return false;
    if (distance > 500000.0) return false; // 500 km hard cap

    last_rx[freq] = message;
    notify_external_systems(from_id, freq, message, source_type);
    return true;
}

bool ICNIAI::transmit(double freq, const std::string& message,
    const std::string& unit_id, const std::string& unit_type) {
    if (emcon) return false;
    last_tx[freq] = message;
    notify_external_systems(unit_id, freq, message, unit_type);
    return true;
}

void ICNIAI::get_display(const std::string& band) const {
    (band == "UHF") ? uhf.display : vhf.display;
}

std::unordered_map<std::string, std::string> ICNIAI::export_for_hud() const {
    return {
        {"UHF", uhf.display},
        {"VHF", vhf.display},
        {"EMCON", emcon ? "ON" : "OFF"}
    };
}

std::unordered_map<std::string, std::string> ICNIAI::export_for_ufc() const {
    return export_for_hud(); // Same for now
}

void ICNIAI::notify_external_systems(const std::string& from_id, double freq,
    const std::string& message, const std::string& source_type) {

}
