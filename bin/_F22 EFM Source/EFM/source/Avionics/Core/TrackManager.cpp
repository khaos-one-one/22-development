#include "TrackManager.h"
#include "..\Radar\APG77.h"


TrackManager::TrackManager() : nextTrackId(1) {
    tracks.clear();
}

void TrackManager::update(double dt) {
    decayOldTracks();
}

std::vector<FusedTrack> TrackManager::getTracks() const {
    return tracks;
}

void TrackManager::injectAPG77Tracks(const std::vector<RadarContact>& input) {
    for (const auto& r : input) {
        FusedTrack t;
        t.id = nextTrackId++;
        t.lat = 0.0;  // Stubbed: replace with lat/lon if INS nav implemented
        t.lon = 0.0;
        t.range_km = r.range_km;
        t.bearing_deg = r.azimuth_deg;
        t.heading = 0.0;
        t.speed = r.velocity_kts;
        t.rcs = 25.0;
        t.thermal_contrast = 0.0;
        t.source = SensorSource::RADAR_AA;
        t.age_frames = 0;
        t.confidence_score = 0.85;

        tracks.push_back(t);
    }
}

void TrackManager::injectGMTITracks(const std::vector<GMTIContact>& input) {
    for (const auto& c : input) {
        FusedTrack t;
        t.id = nextTrackId++;
        t.lat = c.lat;
        t.lon = c.lon;
        t.range_km = 0.0; // not resolved from lat/lon yet
        t.bearing_deg = 0.0;
        t.heading = c.heading;
        t.speed = c.velocity;
        t.rcs = 5.0;
        t.thermal_contrast = 0.0;
        t.source = SensorSource::RADAR_GMTI;
        t.age_frames = 0;
        t.confidence_score = 0.8;

        tracks.push_back(t);
    }
}


void TrackManager::injectSARTracks(const std::vector<SARTarget>& input) {
    for (const auto& c : input) {
        FusedTrack t;
        t.id = nextTrackId++;
        t.lat = c.lat;
        t.lon = c.lon;
        t.range_km = 0.0;
        t.bearing_deg = 0.0;
        t.heading = 0.0;
        t.speed = 0.0;
        t.rcs = c.rcs;
        t.thermal_contrast = 0.0;
        t.source = SensorSource::RADAR_SAR;
        t.age_frames = 0;
        t.confidence_score = 0.75;

        tracks.push_back(t);
    }
}


void TrackManager::injectSEATracks(const std::vector<SEATarget>& input) {
    for (const auto& c : input) {
        FusedTrack t;
        t.id = nextTrackId++;
        t.lat = c.lat;
        t.lon = c.lon;
        t.range_km = 0.0;
        t.bearing_deg = 0.0;
        t.heading = c.course_deg;
        t.speed = c.speed_knots;
        t.rcs = c.rcs;
        t.thermal_contrast = 0.0;
        t.source = SensorSource::RADAR_SEA;
        t.age_frames = 0;
        t.confidence_score = 0.7;

        tracks.push_back(t);
    }
}


void TrackManager::injectFLIRTracks(const std::vector<FLIRContact>& input) {
    for (const auto& c : input) {
        FusedTrack t;
        t.id = nextTrackId++;
        t.lat = c.lat;
        t.lon = c.lon;
        t.range_km = 0.0;
        t.bearing_deg = 0.0;
        t.heading = 0.0;
        t.speed = 0.0;
        t.rcs = 0.0;
        t.thermal_contrast = c.thermal_contrast;
        t.source = SensorSource::FLIR;
        t.age_frames = 0;
        t.confidence_score = 0.9;

        tracks.push_back(t);
    }
}


void TrackManager::decayOldTracks() {
    for (auto& t : tracks) {
        t.age_frames++;
        t.confidence_score *= 0.95; // degrade over time
    }

    // Prune low-confidence or expired tracks
    tracks.erase(
        std::remove_if(tracks.begin(), tracks.end(),
            [](const FusedTrack& t) {
                return t.age_frames > 120 || t.confidence_score < 0.2;
            }),
        tracks.end()
    );
}

