#include "F22Avionics.h"

static CIP cip;
static APG77 radar;

void F22Avionics_Init() {
    cip.initialize();
}

void F22Avionics_Update(double dt) {
    radar.update(dt);
    cip.setRadarContacts(radar.getContacts());
    cip.update(dt);
}

// Optional DCS-bound exports for Lua to access
extern "C" __declspec(dllexport)
int ed_fm_get_track_count() {
    return static_cast<int>(cip.getFusedTracks().size());
}

extern "C" __declspec(dllexport)
FusedTrack ed_fm_get_track(int index) {
    const auto& tracks = cip.getFusedTracks();
    if (index < 0 || index >= static_cast<int>(tracks.size())) {
        return FusedTrack();  // blank fallback
    }
    return tracks[index];
}
