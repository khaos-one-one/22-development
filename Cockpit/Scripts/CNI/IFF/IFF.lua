-- IFF.lua
-- Simulated IFF (Identification Friend or Foe) system with Mode 4 crypto and spoof detection

local SensorAPI = require("Core.SensorAPI")

local IFF = {
    transponder_database = {}, -- [unit_id] = {iff_enabled = true, iff_code = "A1", spoof = false, friendly = true}
    crypto_failure_rate = 0.02,
    mode4_enabled = true
}

-- Register a transponder for a unit
function IFF.register_unit(unit_id, iff_code, spoof, friendly)
    IFF.transponder_database[unit_id] = {
        iff_enabled = true,
        iff_code = iff_code or "A1",
        spoof = spoof or false,
        friendly = friendly or false
    }
end

-- Set IFF status (on/off)
function IFF.set_status(unit_id, enabled)
    if IFF.transponder_database[unit_id] then
        IFF.transponder_database[unit_id].iff_enabled = enabled
    end
end

-- Set IFF code
function IFF.set_code(unit_id, new_code)
    if IFF.transponder_database[unit_id] then
        IFF.transponder_database[unit_id].iff_code = new_code
    end
end

-- Mark spoofing behavior
function IFF.set_spoof(unit_id, is_spoofing)
    if IFF.transponder_database[unit_id] then
        IFF.transponder_database[unit_id].spoof = is_spoofing
    end
end

-- Enable or disable Mode 4 crypto simulation globally
function IFF.set_mode4(enabled)
    IFF.mode4_enabled = enabled
end

-- Simulate Mode 4 crypto check
local function mode4_passes()
    if not IFF.mode4_enabled then return true end
    return math.random() > IFF.crypto_failure_rate
end

-- Interrogate IFF target
function IFF.interrogate(local_unit_id, target_unit_id, expected_code)
    local transponder = IFF.transponder_database[target_unit_id]
    if not transponder or not transponder.iff_enabled then
        return "Unknown"
    end

    if transponder.spoof then
        return "Hostile"
    end

    if expected_code and transponder.iff_code ~= expected_code then
        return "Unknown"
    end

    if not mode4_passes() then
        return "Unknown"
    end

    return transponder.friendly and "Friendly" or "Hostile"
end

-- Broadcast IFF response to SensorAPI
function IFF.broadcast_response(unit_id, code)
    SensorAPI.update_contact("iff:" .. unit_id, {
        name = unit_id,
        source = "IFF",
        code = code,
        result = "Friendly",
        time = os.clock()
    })
end

return IFF
