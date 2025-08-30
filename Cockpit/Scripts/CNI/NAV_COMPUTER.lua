-- Navigation.lua
-- F-22A Advanced Navigation Suite (EGI, Waypoints, TACAN, ILS, NDB, Beacon, HUD/MFD integration)

local Terrain = require("terrain")
local Navigation = {
    position = { lat = 0, lon = 0, alt = 0 },
    velocity = { x = 0, y = 0, z = 0 },
    heading = 0,
    magnetic_variation = 0,
    waypoints = {},
    current_wp_index = 1,
    gps_available = true,
    drift_error = { lat = 0, lon = 0 },
    tacan_stations = {},
    ils_stations = {},
    ndb_stations = {},
    beacon_stations = {},
    nav_aids = {},
    selected_tacan = nil,
    selected_ils = nil,
    selected_ndb = nil,
    selected_beacon = nil,
    emcon = false,
    ins_aligned = false,
    ins_fault = false,
    ins_alignment_timer = 0,
    ins_alignment_duration = 60,
    ins_alignment_mode = "stored",
    wind_vector = { x = 0, y = 0 },
    icao_data = {},
    radio_data = {},
    runways = {},
    ils_data = {},
    tacan_data = {},
    ndb_data = {},
}

function Navigation.load_terrain_nav_data()
    local rawAirportData = get_terrain_related_data("Airdromes")
    local beaconsFile = get_terrain_related_data("beaconsFile")

    if beaconsFile then
        local f = loadfile(beaconsFile)
        if f then f() end
    end

    for id, airfield in pairs(rawAirportData or {}) do
        local rwys = {}
        if airfield.runways then
            for _, rw in ipairs(airfield.runways) do
                table.insert(rwys, {
                    heading = rw.course,
                    length = rw.length or 0,
                    name = rw.name or tostring(_)
                })
            end
        end

        local frequencies = {}
        if airfield.radio and airfield.radio.frequency then
            frequencies = airfield.radio.frequency
        elseif airfield.radio and type(airfield.radio) == "table" then
            for _, r in ipairs(airfield.radio) do
                if r.frequency then table.insert(frequencies, r.frequency) end
            end
        end

        table.insert(Navigation.runways, {
            id = id,
            name = airfield.name,
            lat = airfield.reference_point.lat,
            lon = airfield.reference_point.lon,
            alt = airfield.reference_point.alt,
            runways = rwys,
            frequencies = frequencies
        })
    end

    Navigation.ils_data = ILS or {}
    Navigation.ndb_data = NDB or {}
    Navigation.tacan_data = TACAN or {}
end


function Navigation.align_INS(mode)
    Navigation.ins_alignment_mode = mode or "stored"
    Navigation.ins_alignment_timer = 0
    Navigation.ins_aligned = false
    if Navigation.ins_alignment_mode == "stored" then
        Navigation.ins_alignment_duration = 120
    elseif Navigation.ins_alignment_mode == "full" then
        Navigation.ins_alignment_duration = math.random(300, 600)
    else
        Navigation.ins_alignment_duration = 60
    end
end


return Navigation
