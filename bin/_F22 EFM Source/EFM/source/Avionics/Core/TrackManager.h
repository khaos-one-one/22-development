#pragma once
#include <vector>

#include "..\Radar\APG77.h"


enum class SensorSource {
    RADAR_AA,
    RADAR_GMTI,
    RADAR_SAR,
    RADAR_SEA,
    FLIR
};

struct FusedTrack {
    int id;
    double lat;
    double lon;
    double range_km;
    double bearing_deg;
    double heading;
    double speed;
    double rcs;
    double thermal_contrast;
    SensorSource source;

    int age_frames;           // How many frames since last update
    double confidence_score;  // Sensor reliability / freshness
};

class TrackManager {
public:
    TrackManager();

    void update(double dt);
    std::vector<FusedTrack> getTracks() const;

    void injectAPG77Tracks(const std::vector<Contact>& input);

private:
    int nextTrackId;
    std::vector<FusedTrack> tracks;

    void decayOldTracks();  // Internal aging/pruning
};

