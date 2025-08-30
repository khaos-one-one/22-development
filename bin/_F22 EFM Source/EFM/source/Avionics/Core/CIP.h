#pragma once
#include "TrackManager.h"
#include "../Radar/APG77.h"

class CIP {
public:
    void initialize();
    void update(double dt);

    void setRadarContact(const std::vector<Contact>& contacts);
    const std::vector<FusedTrack>& getFusedTracks() const;

private:
    TrackManager trackManager;
};
