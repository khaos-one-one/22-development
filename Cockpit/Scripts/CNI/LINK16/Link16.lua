-- Link16.lua
-- Simulated Link-16 Tactical Data Link System with unit_type support


local Link16 = {
    participants = {}, -- [unit_id] = { position, unit_type, contacts = {}, iff = true/false, alive = true, emcon = false, tx_enabled = false }
    emcon = false
}

-- Register a unit in the network
function Link16.register_unit(unit_id, position, iff, unit_type)
    Link16.participants[unit_id] = {
        position = position,
        unit_type = unit_type or "Unknown",
        contacts = {},
        iff = iff or true,
        alive = true,
        emcon = false,
        tx_enabled = false
    }
end

-- Update position (called per frame/tick)
function Link16.update_position(unit_id, position)
    if Link16.participants[unit_id] then
        Link16.participants[unit_id].position = position
    end
end

-- Enable or disable transmission for a unit (EMCON override)
function Link16.set_transmit(unit_id, enabled)
    if Link16.participants[unit_id] then
        Link16.participants[unit_id].tx_enabled = enabled
    end
end

-- Global EMCON toggle
function Link16.set_emcon(enabled)
    Link16.emcon = enabled
end

-- Send local contacts to the network
function Link16.broadcast_contacts(unit_id, detected_targets, unit_type)
    local sender = Link16.participants[unit_id]
    if not sender or Link16.emcon or not sender.tx_enabled then return end

    sender.unit_type = unit_type or sender.unit_type or "Unknown"
    sender.contacts = {}

    for _, contact in ipairs(detected_targets) do
        table.insert(sender.contacts, {
            name = contact.name,
            id = contact.id or contact.name,
            x = contact.x,
            y = contact.y,
            z = contact.z or 0,
            range = contact.range,
            azimuth = contact.azimuth,
            elevation = contact.elevation,
            classification = contact.classification,
            timestamp = os.time(),
            source_unit = unit_id,
            source_type = sender.unit_type,
            iff = contact.iff or false
        })
    end
end

-- Push remote contacts into SensorAPI fusion core
function Link16.push_to_sensor_fusion(local_unit_id)
    local contacts = Link16.get_network_picture(local_unit_id)
    for _, contact in ipairs(contacts) do
        SensorAPI.update_contact("link16:" .. contact.id, {
            name = contact.name,
            classification = contact.classification,
            source = "Link16",
            source_unit = contact.source_unit,
            x = contact.x,
            y = contact.y,
            z = contact.z,
            time = os.clock(),
            range = contact.range,
            azimuth = contact.azimuth,
            elevation = contact.elevation,
            friendly = contact.iff or false
        })
    end
end

-- Get composite datalink picture
function Link16.get_network_picture(for_unit_id)
    local network_picture = {}
    for id, unit in pairs(Link16.participants) do
        if id ~= for_unit_id and unit.alive then
            for _, contact in ipairs(unit.contacts) do
                table.insert(network_picture, contact)
            end
        end
    end
    return network_picture
end

-- Mark unit as destroyed or inactive
function Link16.set_unit_alive(unit_id, is_alive)
    if Link16.participants[unit_id] then
        Link16.participants[unit_id].alive = is_alive
    end
end

return Link16
