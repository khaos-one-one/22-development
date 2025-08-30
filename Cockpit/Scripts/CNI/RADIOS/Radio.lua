-- Radio.lua
-- F-22A Radio Communication Suite (UHF, VHF, Guard, Presets, EMCON, UFC/ICP Integration + IFF/Link16 Sync + SRS-ready)

local Link16 = require("Avionics.CNI.Link16")
local Navigation = require("Avionics.CNI.NAV_COMPUTER")

local Radio = {
    uhf = { freq = 305.00, preset = 1, display = "305.000", volume = 1.0 },
    vhf = { freq = 124.00, preset = 1, display = "124.000", volume = 1.0 },
    guard_freqs = { 243.00, 121.50 },
    presets = {
        uhf = { [1] = 305.00, [2] = 306.00, [3] = 307.00 },
        vhf = { [1] = 124.00, [2] = 125.00, [3] = 126.00 }
    },
    emcon = false,
    last_rx = {},
    last_tx = {},
    own_id = "F22A1"
}

function Radio.set_frequency(band, freq)
    if Radio.emcon then return end
    if band == "uhf" or band == "vhf" then
        Radio[band].freq = freq
        Radio[band].preset = nil
        Radio[band].display = string.format("%.3f", freq)
    end
end

function Radio.set_volume(band, volume)
    if Radio[band] then
        Radio[band].volume = math.max(0.0, math.min(1.0, volume))
    end
end

function Radio.select_preset(band, preset)
    if Radio.emcon then return end
    if Radio.presets[band] and Radio.presets[band][preset] then
        Radio[band].preset = preset
        Radio[band].freq = Radio.presets[band][preset]
        Radio[band].display = string.format("%.3f", Radio[band].freq)
    end
end

function Radio.receive(from_id, freq, message, source_type, distance)
    if Radio.emcon then return false end

    local noise = ""
    if distance and distance > 100000 then
        noise = "[STATIC] "
    end

    for _, guard in ipairs(Radio.guard_freqs) do
        if math.abs(freq - guard) < 0.01 then
            Radio.last_rx[freq] = { from = from_id, msg = noise .. message, time = os.clock(), source = source_type or "Unknown" }
            SensorAPI.report_signal_contact(from_id, freq, message, source_type)
            return true
        end
    end

    if math.abs(freq - Radio.uhf.freq) < 0.01 or math.abs(freq - Radio.vhf.freq) < 0.01 then
        Radio.last_rx[freq] = { from = from_id, msg = noise .. message, time = os.clock(), source = source_type or "Unknown" }
        SensorAPI.report_signal_contact(from_id, freq, message, source_type)
        return true
    end

    return false
end

function Radio.transmit(freq, message, unit_id, unit_type)
    if Radio.emcon then return false end
    Radio.last_tx[freq] = { to = "ALL", msg = message, time = os.clock(), source_type = unit_type or "F-22A" }

    return true
end

function Radio.set_emcon(state)
    Radio.emcon = state
end

function Radio.get_state()
    return {
        uhf = Radio.uhf,
        vhf = Radio.vhf,
        emcon = Radio.emcon,
        last_rx = Radio.last_rx,
        last_tx = Radio.last_tx
    }
end

function Radio.export_comm_plan()
    return {
        uhf_presets = Radio.presets.uhf,
        vhf_presets = Radio.presets.vhf
    }
end

function Radio.export_for_HUD()
    return {
        uhf = Radio.uhf.freq,
        vhf = Radio.vhf.freq,
        emcon = Radio.emcon
    }
end

function Radio.export_for_SRS()
    return {
        uhf = Radio.uhf.freq,
        vhf = Radio.vhf.freq,
        volume_uhf = Radio.uhf.volume,
        volume_vhf = Radio.vhf.volume
    }
end

function Radio.export_for_UFC()
    return {
        uhf = Radio.uhf,
        vhf = Radio.vhf,
        presets = Radio.presets,
        emcon = Radio.emcon,
        display = {
            uhf = Radio.uhf.display,
            vhf = Radio.vhf.display,
            emcon = Radio.emcon and "EMCON" or "RADIO"
        }
    }
end

function Radio.handle_ufc_input(input)
    local band, cmd = input.band, input.cmd
    if cmd.type == "preset" then
        Radio.select_preset(band, tonumber(cmd.value))
    elseif cmd.type == "freq" then
        Radio.set_frequency(band, tonumber(cmd.value))
    elseif cmd.type == "emcon" then
        Radio.set_emcon(cmd.value == true)
    elseif cmd.type == "volume" then
        Radio.set_volume(band, tonumber(cmd.value))
    elseif band == "tacan" and cmd.type == "channel" then
        Navigation.select_tacan_channel(cmd.value)
    elseif band == "ils" and cmd.type == "station" then
        Navigation.select_ils_station(cmd.value)
    elseif band == "ndb" and cmd.type == "freq" then
        Navigation.select_ndb_frequency(cmd.value)
    end
end

return Radio
