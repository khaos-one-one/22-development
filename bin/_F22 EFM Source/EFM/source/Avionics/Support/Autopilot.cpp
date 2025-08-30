// Autopilot.cpp
#include "Autopilot.h"
#include <cmath>
#include <algorithm>

AutopilotSystem::AutopilotSystem(NavigationSystem* nav_ptr)
    : nav(nav_ptr) {
}

void AutopilotSystem::set_current_position(const Vec3& pos) {
    current_position = pos;
}

void AutopilotSystem::set_current_heading(double deg) {
    current_heading = deg;
}

void AutopilotSystem::set_autopilot_enabled(bool enable) {
    enabled = enable;
}

bool AutopilotSystem::is_autopilot_enabled() const {
    return enabled;
}

void AutopilotSystem::set_target_altitude(double alt) {
    target_altitude = alt;
}

void AutopilotSystem::set_altitude_mode(AltitudeMode mode) {
    alt_mode = mode;
}

void AutopilotSystem::set_climb_rate(double rate_fpm) {
    climb_rate_fpm = rate_fpm;
}

void AutopilotSystem::enable_auto_sequence(bool enable) {
    auto_sequence = enable;
}

void AutopilotSystem::set_bank_limit_mode(BankLimiterMode mode) {
    bank_mode = mode;
}

void AutopilotSystem::set_rwr(RWRSystem* rwr_ptr) {
    rwr = rwr_ptr;
}

void AutopilotSystem::update(double dt, double current_alt, std::function<double()> radar_alt_func) {
    if (!enabled) return;

    // Spike evasion (notch turn)
    if (rwr && rwr->get_max_threat_bearing().has_value()) {
        double threat_bearing = rwr->get_max_threat_bearing().value();
        target_heading = std::fmod(threat_bearing + 90.0, 360.0);
        in_spike_turn = true;
    } else {
        target_heading = get_steering_command();
        in_spike_turn = false;
    }

    // Pitch control
    double reference_alt = (alt_mode == AltitudeMode::RADAR && radar_alt_func) ? radar_alt_func() : current_alt;

    double error_ft = target_altitude - reference_alt;
    double desired_fpm = std::clamp(error_ft / dt, -climb_rate_fpm, climb_rate_fpm);
    target_pitch = std::clamp(desired_fpm / 100.0, -10.0, 10.0); // basic pitch rate: 100 fpm ~ 1 deg

    // Auto waypoint sequencing (within 1 km)
    if (auto_sequence && nav && nav->has_navigation_target()) {
        Vec3 to_target = nav->get_navigation_vector(current_position);
        double dist = std::sqrt(to_target.x * to_target.x + to_target.y * to_target.y + to_target.z * to_target.z);
        if (dist < 1000.0) {
            nav->advance_waypoint();
        }
    }
}

double AutopilotSystem::get_steering_command() const {
    if (!enabled || !nav || !nav->has_navigation_target()) return current_heading;

    Vec3 vec = nav->get_navigation_vector(current_position);
    if (vec.x == 0 && vec.y == 0) return current_heading;

    double bearing = std::atan2(vec.y, vec.x) * 180.0 / M_PI;
    if (bearing < 0) bearing += 360.0;

    // Apply bank limiter if enabled
    double delta = bearing - current_heading;
    if (delta > 180.0) delta -= 360.0;
    if (delta < -180.0) delta += 360.0;

    double max_delta = (bank_mode == BankLimiterMode::CRUISE) ? 15.0 : 45.0;
    delta = std::clamp(delta, -max_delta, max_delta);

    return std::fmod(current_heading + delta + 360.0, 360.0);
}

double AutopilotSystem::get_target_pitch() const {
    return target_pitch;
}

double AutopilotSystem::get_target_heading() const {
    return target_heading;
}

