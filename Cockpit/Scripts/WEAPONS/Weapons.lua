-- Weapons.lua
-- F-22A Weapons Management System (A/A and A/G) with FireControl Integration and Target Validity Checks

local Navigation = require("Core.NAV_COMPUTER")
local SensorAPI = require("Core.SensorAPI")
local utils = require("Support.utils")
local FireControl = require("Avionics.FireControlSystem")
local WeaponSystem = require("Avionics.Weapons_System")

local Weapons = {
    inventory = {
        { type = "AIM-9X_BLKII", count = 2, station = {3, 11}, bay_type = "side_bay" },
        { type = "AIM-120C-7", count = 4, station = {4, 5, 8, 9}, bay_type = "main_bay" },
        { type = "AIM-120C-8", count = 2, station = {6, 10}, bay_type = "main_bay" },
        { type = "AIM-120D-3", count = 2, station = {5, 9}, bay_type = "main_bay" },
        { type = "AIM-260A", count = 2, station = {4, 10}, bay_type = "main_bay" },
        { type = "MAKO_A2A_C", count = 2, station = {6, 8}, bay_type = "main_bay" },
        { type = "MAKO_A2G_C", count = 2, station = {5, 9}, bay_type = "main_bay" },
        { type = "GBU-32", count = 4, station = {4, 5, 9, 10}, bay_type = "main_bay" },
        { type = "GBU-39", count = 8, station = {4, 5, 6, 8, 9, 10}, bay_type = "main_bay", smart_rack = true },
        { type = "AGM-65", count = 2, station = {1, 13}, bay_type = "external" },
        { type = "AGM-154B", count = 2, station = {2, 12}, bay_type = "external" }
    },
    selected_weapon = "AIM-120C-7",
    mode = "A/A",
    last_fired = nil,
    cooldown = 2,
    emcon = false,
    trigger_state = "SAFE",
    fire_request = false,
    master_arm = true
}

function Weapons.refresh_inventory()
    local status, info = pcall(function()
        return LoGetPayloadInfo() or {} -- fallback if unavailable
    end)
    if not status then return end

    for _, store in ipairs(Weapons.inventory) do
        store.count = 0 -- reset
    end

    for i, pylon in ipairs(info.stations or {}) do
        if pylon.weapon and pylon.count > 0 then
            for _, store in ipairs(Weapons.inventory) do
                if pylon.weapon:find(store.type) then
                    store.count = store.count + pylon.count
                end
            end
        end
    end
end

function Weapons.validate_inventory()
    for _, store in ipairs(Weapons.inventory) do
        if store.count < 0 then
            store.count = 0
        end
    end
end

function Weapons.export_for_stores()
    local display = {}
    for _, store in ipairs(Weapons.inventory) do
        table.insert(display, {
            type = store.type,
            count = store.count,
            station = store.station,
            bay_type = store.bay_type
        })
    end
    return display
end

function Weapons.select_weapon(type)
    for _, store in ipairs(Weapons.inventory) do
        if store.type == type and store.count > 0 then
            Weapons.selected_weapon = type
            WeaponSystem.select_weapon(type)
            return true
        end
    end
    return false
end

function Weapons.set_mode(new_mode)
    if new_mode == "A/A" or new_mode == "A/G" then
        Weapons.mode = new_mode
        WeaponSystem.set_mode(new_mode)
    end
end

function Weapons.get_target()
    if Weapons.mode == "A/A" then
        local air_targets = SensorAPI.get_sorted_air_targets("closure")
        local tgt = air_targets[1] or SensorAPI.get_weapon_cue_candidate()
        if tgt then FireControl.set_target(tgt) end
        return tgt
    elseif Weapons.mode == "A/G" then
        local wp = Navigation.get_nav_solution()
        if wp and wp.type == "TGT" then
            return {
                lat = wp.target_coordinates.lat,
                lon = wp.target_coordinates.lon,
                alt = wp.target_coordinates.alt,
                name = wp.label,
                range = wp.range
            }
        end
    end
    return nil
end

function Weapons.safe_to_release(target)
    if Weapons.mode == "A/G" then
        return FireControl.check_AG_release(target, Weapons.selected_weapon)
    end
    return FireControl.check_wez_consent(target, Weapons.selected_weapon)
end

function Weapons.can_fire()
    if Weapons.emcon or not Weapons.master_arm then return false end
    local now = os.clock()
    if Weapons.last_fired and now - Weapons.last_fired < Weapons.cooldown then
        return false
    end
    return true
end

function Weapons.fire()
    if not Weapons.can_fire() then return false end
    local target = Weapons.get_target()
    if not target then return false end
    if not Weapons.safe_to_release(target) then
        return false
    end

    for _, store in ipairs(Weapons.inventory) do
        if store.type == Weapons.selected_weapon and store.count > 0 then
            store.count = store.count - 1
            Weapons.last_fired = os.clock()
            WeaponSystem.fire_weapon(store.type, target, store.station)
            FireControl.fire_weapon(store.type, target, store.station)
            return true
        end
    end
    return false
end

function Weapons.set_emcon(state)
    Weapons.emcon = state
    WeaponSystem.set_emcon(state)
    FireControl.set_emcon(state)
end

function Weapons.set_master_arm(state)
    Weapons.master_arm = state
end

function Weapons.update_trigger(state)
    Weapons.trigger_state = state
    WeaponSystem.set_trigger(state)
    if state == "FIRE" then
        Weapons.fire_request = true
    end
end

function Weapons.tick()
    if Weapons.fire_request and Weapons.can_fire() then
        Weapons.fire()
        Weapons.fire_request = false
    end
    FireControl.process_salvo()
end

function Weapons.export_for_HUD()
    return {
        selected = Weapons.selected_weapon,
        mode = Weapons.mode,
        emcon = Weapons.emcon,
        master_arm = Weapons.master_arm,
        ammo = Weapons.inventory
    }
end

function Weapons.export_for_UFC()
    return {
        selected = Weapons.selected_weapon,
        mode = Weapons.mode,
        trigger = Weapons.trigger_state,
        master_arm = Weapons.master_arm,
        inventory = Weapons.inventory
    }
end

return Weapons
