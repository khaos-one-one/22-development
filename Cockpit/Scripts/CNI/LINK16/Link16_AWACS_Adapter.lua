-- Link16_AWACS_Adapter.lua
-- Simulated AWACS Datalink injection module for Link16

local Link16 = require("Avionics.Link16")
local dev = GetSelf()

local AWACS_Adapter = {
    scan_interval = 5,
    next_scan = 0,
    awacs_types = { "E-3A", "E-2C", "A-50" },
    ewr_types = { "55G6", "1L13 EWR", "P-37", "RLS_19J6" },
    datalink_enabled = true
}

local function is_awacs_unit(unit)
    if not unit or not unit:isExist() then return false end
    local type_name = unit:getTypeName()
    for _, awacs_type in ipairs(AWACS_Adapter.awacs_types) do
        if type_name == awacs_type then
            return true
        end
    end
    return false
end

local function is_ewr_unit(unit)
    if not unit or not unit:isExist() then return false end
    local type_name = unit:getTypeName()
    for _, ewr_type in ipairs(AWACS_Adapter.ewr_types) do
        if type_name == ewr_type then
            return true
        end
    end
    return false
end

local function is_friendly_air_unit(unit, player_coalition)
    if not unit or not unit:isExist() then return false end
    if unit:getCategory() ~= Object.Category.UNIT then return false end
    if unit:getDesc().category ~= Unit.Category.AIRPLANE then return false end
    return unit:getCoalition() == player_coalition
end

local function get_player_coalition()
    local self_unit = getSelf()
    if self_unit and self_unit:isExist() then
        return self_unit:getCoalition()
    end
    return nil
end

local function is_system_failed()
    return dev:get_failure(0) == 1
end

function AWACS_Adapter.collect_contacts_from_awacs()
    if not AWACS_Adapter.datalink_enabled or is_system_failed() then return end

    local player_coalition = get_player_coalition()
    if not player_coalition then return end

    local groups = coalition.getGroups(player_coalition)
    for _, group in ipairs(groups) do
        for _, unit in ipairs(group:getUnits()) do
            if is_awacs_unit(unit) or is_ewr_unit(unit) or is_friendly_air_unit(unit, player_coalition) then
                local controller = unit:getController()
                local contacts = controller:getDetectedTargets()
                local unit_id = tostring(unit:getID())

                Link16.register_unit(unit_id, unit:getPoint(), true, unit:getTypeName())
                Link16.set_transmit(unit_id, true)

                local contact_list = {}
                for target, info in pairs(contacts) do
                    if target and target:isExist() then
                        local pos = target:getPoint()
                        table.insert(contact_list, {
                            name = target:getName(),
                            id = target:getName(),
                            x = pos.x,
                            y = pos.y,
                            z = pos.z,
                            position = { x = pos.x, y = pos.y, z = pos.z },
                            range = info.distance,
                            azimuth = info.azimuth,
                            elevation = info.elevation,
                            classification = "Air",
                            iff = false,
                            source = unit:getTypeName(),
                            source_type = "Datalink"
                        })
                    end
                end

                Link16.broadcast_contacts(unit_id, contact_list, unit:getTypeName())
            end
        end
    end
end

function AWACS_Adapter.update()
    if timer.getTime() >= AWACS_Adapter.next_scan then
        AWACS_Adapter.collect_contacts_from_awacs()
        AWACS_Adapter.next_scan = timer.getTime() + AWACS_Adapter.scan_interval
    end
end

return AWACS_Adapter
