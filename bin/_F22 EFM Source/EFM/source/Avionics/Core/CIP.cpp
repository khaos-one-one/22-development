#include "CIP.h"

void CIP::initialize() {
    // (Optional init logic)
}

void CIP::update(double dt) {
    trackManager.update(dt);
}

void CIP::setRadarContacts(const std::vector<Contact>& contacts) {
    trackManager.injectAPG77Tracks(contacts);
}

void CIP::setRadarContact(const std::vector<Contact>& contacts)
{
}

const std::vector<FusedTrack>& CIP::getFusedTracks() const {
    return trackManager.getTracks();
}
