// Full APG-77 Radar Port (C++)
// Files: APG77.h, APG77.cpp

#pragma once
#include <string>
#include <unordered_map>
#include <vector>
#include <cmath>
#include <iostream>
#include <optional>
#include <algorithm>
#include <ctime>
#include <Utility.h>


struct Contact {
    int id;
    std::string name;
    Vec3 position;
    Vec3 velocity;
    double rcs = 5.0;
    std::string classification;
    bool beacon = false;
    bool burnthrough = false;
    double azimuth = 0;
    double elevation = 0;
    double range = 0;
};

struct TrackMemory {
    Contact data;
    double timestamp;
    std::string status;
};

class APG77 {
public:
    APG77();

    void set_mode(const std::string& new_mode);
    void set_submode(const std::string& sub);
    void toggle_freeze();

    double radar_constant(double rcs) const;
    double snr(double range, double rcs, double jammer_power = 0.0) const;

    void update_track_memory(int id, const Contact& target);
    void update_trtn(double delta_time);
    std::optional<Contact> get_trtn(int id) const;

    std::vector<Contact> perform_mode_logic(const std::vector<Contact>& all_contacts);

    std::vector<Contact> update(const std::vector<Contact>& world_objects, double delta_time);

    void maintain_tracks(double current_time) {
        std::vector<int> to_remove;
        for (const auto& [id, track] : track_memory) {
            if (current_time - track.timestamp > trtn_timeout) {
                to_remove.push_back(id);
            }
        }
        for (int id : to_remove) {
            track_memory.erase(id);
        }
    }

    void record_trtn(int id, const Contact& target);

private:
    double transmit_power = 1200;
    double gain = 40;
    double wavelength = 0.03;
    double noise_floor = -90;
    double ecm_resistance = 0.85;

    int fov_azimuth = 60;
    int scan_rate = 2;
    double resolution = 1.0;

    std::string mode = "RWS";
    std::string submode = "normal";
    bool freeze = false;

    Vec3 radar_position;
    double heading = 0;

    std::optional<Contact> stt_target;
    std::optional<Contact> tracking_target;
    std::optional<double> lost_lock_time;

    std::unordered_map<int, TrackMemory> track_memory;
    std::unordered_map<int, TrackMemory> trtn_memory;
    double trtn_timeout = 5.0;

    std::optional<double> spotlight_bearing;

    std::vector<Contact> apply_threat_priority(std::vector<Contact>& contacts) {
        std::sort(contacts.begin(), contacts.end(), [](const Contact& a, const Contact& b) {
            return a.velocity.x > b.velocity.x; // closure speed approximation
        });
        return contacts;
    }
};