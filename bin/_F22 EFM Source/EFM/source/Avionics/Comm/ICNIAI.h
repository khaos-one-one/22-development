// ICNIAI.h
#pragma once
#include <vector>
#include <optional>
#include <string>
#include <unordered_map>
#include <Utility.h>

struct Waypoint {
    int id;
    std::string name;
    Vec3 position;
    bool active = false;
};

struct TacanStation {
    std::string ident;
    Vec3 position;
};

struct IlsStation {
    std::string ident;
    Vec3 position;
    double heading_deg;
};

struct NdbStation {
    std::string ident;
    Vec3 position;
};

class ICNIAI {
public:
    ICNIAI();

    void add_waypoint(const Waypoint& wp);
    void clear_waypoints();
    void activate_waypoint(int id);
    void deactivate_waypoint();
    void advance_waypoint();

    std::optional<Waypoint> get_active_waypoint() const;
    std::vector<Waypoint> get_all_waypoints() const;

    // INS + GPS logic
    void align_INS(const std::string& mode);
    void update_INS(double dt);
    bool is_INS_aligned() const;

    // Autopilot / navigation vector
    bool has_navigation_target() const;
    Vec3 get_navigation_vector(const Vec3& current_pos) const;

    // Bearing conversion
    double magnetic_variation_deg = 3.0; // static for now

    // Station registration
    void register_tacan(const TacanStation& tac);
    void register_ils(const IlsStation& ils);
    void register_ndb(const NdbStation& ndb);

    std::optional<Vec3> get_tacan_solution(const std::string& ident, const Vec3& pos) const;
    std::optional<Vec3> get_ils_solution(const std::string& ident, const Vec3& pos) const;
    std::optional<Vec3> get_ndb_solution(const std::string& ident, const Vec3& pos) const;

    struct Channel {
        double freq = 0.0;
        int preset = -1;
        std::string display;
    };

    void set_frequency(const std::string& band, double freq);
    void select_preset(const std::string& band, int preset);
    void set_emcon(bool state);

    bool receive(const std::string& from_id, double freq, const std::string& message,
        const std::string& source_type, double distance);
    bool transmit(double freq, const std::string& message, const std::string& unit_id,
        const std::string& unit_type);

    std::string get_display(const std::string& band) const;
    std::unordered_map<std::string, std::string> export_for_hud() const;
    std::unordered_map<std::string, std::string> export_for_ufc() const;
	std::unordered_map<std::string, std::string> export_for_datalink() const;

private:
    Channel uhf;
    Channel vhf;
    std::unordered_map<std::string, double> uhf_presets;
    std::unordered_map<std::string, double> vhf_presets;
    std::unordered_map<double, std::string> last_rx;
    std::unordered_map<double, std::string> last_tx;

    bool emcon = false;
    const std::vector<double> guard_freqs = { 243.0, 121.5 };

    void notify_external_systems(const std::string& from_id, double freq,
        const std::string& message, const std::string& source_type);

    std::vector<Waypoint> waypoints;
    std::optional<int> active_id;

    std::unordered_map<std::string, TacanStation> tacans;
    std::unordered_map<std::string, IlsStation> ils_stations;
    std::unordered_map<std::string, NdbStation> ndbs;

    // INS/GPS emulation
    std::string ins_mode = "OFF";
    double ins_timer = 0.0;
    bool ins_aligned = false;
    bool gps_available = true;
};