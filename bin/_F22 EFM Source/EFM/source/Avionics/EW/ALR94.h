// ALR94.h
#pragma once
#include <unordered_map>
#include <vector>
#include <string>
#include <functional>


class ALR94 {
public:
    void detect_emitter(const Contact& emitter, double snr);
    void missile_launch(int source_id);
    void update(double dt);

    std::vector<Contact> get_emitters() const;
    std::vector<int> get_active_missile_alerts() const;

    std::string get_ring_for_range(double range_m) const;

    // Advanced realism
    void set_position(const Vec3& pos);
    void set_signal_floor(double snr_threshold);
    void enable_geolocation(bool enable);
    void set_terrain_occlusion(std::function<bool(const Vec3&, const Vec3&)> func);

private:
    struct TrackedEmitter {
        Contact contact;
        double last_seen;
        double snr;
        bool geolocating = false;
    };

    std::unordered_map<int, TrackedEmitter> threats;
    std::unordered_map<int, double> missile_alerts;

    double now() const;

    Vec3 self_position;
    double signal_threshold_snr = 0.2;
    bool use_geolocation = false;

    std::function<bool(const Vec3&, const Vec3&)> terrain_mask_fn = nullptr;
};
