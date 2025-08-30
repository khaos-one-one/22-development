-- FireControl.lua
-- Advanced fire control logic for F-22A weapon system with realistic enhancements

local FireControl = {
    launch_zones = {
        AIM120 = { RMAX = 74000, RTR = 56000, RMIN = 1500 },
        AIM9 = { RMAX = 18000, RTR = 12000, RMIN = 300 },
        AIM260 = { RMAX = 80000, RTR = 60000, RMIN = 1500 },
        JDAM = { RMAX = 15000, RTR = 10000, RMIN = 1000 },
        SDB = { RMAX = 110000, RTR = 85000, RMIN = 4000 },
        MAKO = { RMAX = 75000, RTR = 50000, RMIN = 1500 },
        Meteor = { RMAX = 90000, RTR = 70000, RMIN = 2000 },
        Gun = { RMAX = 1500, RTR = 1000, RMIN = 300 }
    },
    engagement_rules = {
        ROE = "Free Fire",
        WEZ_consent = true,
        allow_salvo = true,
        cooperative_targeting = true,
        allow_AG_release = true
    },
    emcon = false,
    radar_available = true,
    current_target = nil,
    fire_mode = "AUTO",
    mode = "BVR",
    salvo_queue = {},
    cooperative_links = {},
    priority_targets = {},
    target_types = {
        Air = { "AIM120", "AIM260", "AIM9", "Meteor", "MAKO" },
        Ground = { "JDAM", "SDB", "MAKO" },
        Default = { "Gun" }
    },
    last_bvrid_time = 0,
    bvrid_interval = 1.5,
    pending_bvrid = {}
}

function FireControl.set_mode(mode)
    FireControl.mode = mode
end

function FireControl.set_target(target)
    FireControl.current_target = target

    if not target.isIdentified then
        if FireControl.cooperative_links[target.id] then
            target.isIdentified = FireControl.cooperative_links[target.id].identified or false
        elseif SensorAPI and SensorAPI.get_IFF then
            target.isIdentified = SensorAPI.get_IFF(target.id) == "hostile"
        else
            target.isIdentified = false
        end
    end

    if not target.isIdentified and FireControl.mode == "BVR" then
        local now = os.clock()
        if now - FireControl.last_bvrid_time > FireControl.bvrid_interval then
            SensorAPI.queue_bvrid_request(target.id)
            FireControl.last_bvrid_time = now
            print("[FireControl] BVR ID request queued for " .. target.id)
        end
        FireControl.engagement_rules.WEZ_consent = false
    else
        FireControl.engagement_rules.WEZ_consent = true
    end
end

function FireControl.get_launch_zone(missile, target_range)
    local zone = FireControl.launch_zones[missile]
    if not zone then return "OUT" end
    if target_range < zone.RMIN then return "NO ESCAPE" end
    if target_range < zone.RTR then return "RTR" end
    if target_range < zone.RMAX then return "RMAX" end
    return "OUT"
end

function FireControl.estimate_pk(target)
    local range = target.range or 0
    local closure = target.closure or 0
    if range < 20000 and closure > 300 then return 0.9
    elseif range < 40000 then return 0.7
    elseif range < 60000 then return 0.5
    else return 0.2 end
end

function FireControl.check_wez_consent(target, weapon)
    if not FireControl.engagement_rules.WEZ_consent then return true end
    local zone = FireControl.get_launch_zone(weapon, target.range)
    return zone ~= "OUT"
end

function FireControl.check_AG_release(target, weapon)
    if weapon ~= "JDAM" and weapon ~= "SDB" and weapon ~= "MAKO" then return true end
    if not FireControl.engagement_rules.allow_AG_release then return false end
    local zone = FireControl.get_launch_zone(weapon, target.range)
    return zone ~= "OUT"
end

function FireControl.select_highest_threat(targets)
    table.sort(targets, function(a, b)
        return (a.threat_level or 0) > (b.threat_level or 0)
    end)
    return targets[1]
end

function FireControl.select_closest_target(targets)
    table.sort(targets, function(a, b)
        return (a.range or 999999) < (b.range or 999999)
    end)
    return targets[1]
end

function FireControl.radar_track_cue(target)
    if FireControl.radar_available and target and target.id then
        print("[FireControl] Cueing radar STT on: " .. target.id)
        if _G.APG77 and APG77.set_mode then
            APG77:set_mode("STT")
            APG77:set_target(target)
        end
    end
end

function FireControl.select_sensor_source()
    if FireControl.emcon then
        return "IRST"
    else
        return "RADAR"
    end
end

function FireControl.set_emcon(state)
    FireControl.emcon = state
end

function FireControl.queue_salvo(weapon, targets)
    if not FireControl.engagement_rules.allow_salvo then return end
    for _, tgt in ipairs(targets) do
        table.insert(FireControl.salvo_queue, { weapon = weapon, target = tgt })
    end
end

function FireControl.process_salvo()
    for _, shot in ipairs(FireControl.salvo_queue) do
        print("[FireControl] Salvo fire " .. shot.weapon .. " at " .. (shot.target.name or "unknown"))
        FireControl.fire_weapon(shot.weapon, shot.target)
    end
    FireControl.salvo_queue = {}
end

function FireControl.receive_cooperative_target(target)
    if FireControl.engagement_rules.cooperative_targeting then
        FireControl.cooperative_links[target.id] = target
        print("[FireControl] Received cooperative target: " .. target.id)
    end
end

function FireControl.match_weapon_to_target(target)
    local class = target.classification or "Default"
    local options = FireControl.target_types[class] or FireControl.target_types.Default
    for _, weap in ipairs(options) do
        local zone = FireControl.get_launch_zone(weap, target.range or 999999)
        if zone ~= "OUT" then return weap end
    end
    return options[1] or "Gun"
end

function FireControl.fire_weapon(weapon, target)
    print("[FireControl] Firing " .. weapon .. " at " .. (target.name or target.id or "Unknown"))
    -- Future integration: command actual launch here, possibly via WeaponsAPI
end

function FireControl.export_for_HUD()
    return {
        wez = FireControl.current_target and FireControl.get_launch_zone("AIM120", FireControl.current_target.range) or nil,
        pk = FireControl.current_target and FireControl.estimate_pk(FireControl.current_target) or nil,
        current_target = FireControl.current_target and FireControl.current_target.name or nil
    }
end

function FireControl.export_for_MFD()
    return {
        current_target = FireControl.current_target,
        cooperative_links = FireControl.cooperative_links,
        engagement_rules = FireControl.engagement_rules,
        wez_zone = FireControl.current_target and FireControl.get_launch_zone("AIM120", FireControl.current_target.range) or "OUT"
    }
end

return FireControl
