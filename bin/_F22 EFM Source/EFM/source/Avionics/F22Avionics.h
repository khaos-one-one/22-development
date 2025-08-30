#pragma once
#include "Avionics/Core/CIP.h"
#include "Avionics/Radar/APG77.h"

void F22Avionics_Init();
void F22Avionics_Update(double dt);
int ed_fm_get_track_count();
FusedTrack ed_fm_get_track(int index);

