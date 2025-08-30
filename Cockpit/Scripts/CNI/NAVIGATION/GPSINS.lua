-- GPSINS.lua
-- Simulates GPS/INS alignment and positioning for the F-22A

local SensorAPI = require("Avionics.CIP.SensorAPI")

local GPSINS = {
    position = { x = 0, y = 0, z = 0 },
    heading = 0,
    aligned = false,
    gps_enabled = true,
    align_progress = 0,
    align_rate = 0.2, -- % per second
    emcon_gps_blocked = false,
    fail_flag = false,
    last_update = 0
}

function GPSINS.set_position(pos)
    GPSINS.position = pos
end

function GPSINS.set_heading(hdg)
    GPSINS.heading = hdg
end

function GPSINS.get_position()
    if GPSINS.aligned and GPSINS.gps_enabled and not GPSINS.emcon_gps_blocked then
        return GPSINS.position
    end
    return nil
end

function GPSINS.get_heading()
    if GPSINS.aligned then
        return GPSINS.heading
    end
    return nil
end

function GPSINS.enable_gps(state)
    GPSINS.gps_enabled = state
end

function GPSINS.set_emcon_block(state)
    GPSINS.emcon_gps_blocked = state
end

function GPSINS.inject_fix(position, heading)
    GPSINS.position = position
    GPSINS.heading = heading
    GPSINS.aligned = true
    GPSINS.align_progress = 100
end

function GPSINS.start_alignment()
    GPSINS.align_progress = 0
    GPSINS.aligned = false
end

function GPSINS.set_failure(state)
    GPSINS.fail_flag = state
end

function GPSINS.update(time)
    if GPSINS.fail_flag then
        GPSINS.aligned = false
        return
    end

    if not GPSINS.aligned then
        local dt = time - GPSINS.last_update
        GPSINS.align_progress = math.min(100, GPSINS.align_progress + dt * GPSINS.align_rate)
        if GPSINS.align_progress >= 100 then
            GPSINS.aligned = true
        end
    end

    -- Update current position and heading from DCS
    local self = getSelf()
    if self and self:isExist() then
        local pos = self:getPoint()
        GPSINS.position = pos
        local orient = self:getDrawArgumentValue(0)
        GPSINS.heading = orient or 0

        -- Forward to SensorAPI
        SensorAPI.set_ownship_position(pos, GPSINS.heading)
    end

    GPSINS.last_update = time
end

return GPSINS
