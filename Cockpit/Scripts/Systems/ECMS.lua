dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")

local ecms = GetSelf()
local sensor_data = get_base_data()

local update_time_step = 0.006
make_default_activity(update_time_step)

local parameters = {
    MAIN_POWER      = get_param_handle("MAIN_POWER"),
    ECM_ARG         = get_param_handle("ECM_ARG"),
    ECMS_POWER      = get_param_handle("ECMS_POWER"),
	JAMMER_POWER	= get_param_handle("JAMMER_POWER"),
    MASTER_ARM      = get_param_handle("MASTER_ARM"),
    WoW             = get_param_handle("WoW"),
    CHAFF_COUNT     = get_param_handle("CHAFF_COUNT"),
    FLARE_COUNT     = get_param_handle("FLARE_COUNT"),
    CHAFF_DISPENSING = get_param_handle("CHAFF_DISPENSING"),
    FLARE_DISPENSING = get_param_handle("FLARE_DISPENSING"),
    CMDS_PRGM_1     = get_param_handle("CMDS_PRGM_1"),
    CMDS_PRGM_2     = get_param_handle("CMDS_PRGM_2"),
    CMDS_PRGM_3     = get_param_handle("CMDS_PRGM_3"),
    CMDS_PRGM_4     = get_param_handle("CMDS_PRGM_4"),
    CMDS_PRGM_5     = get_param_handle("CMDS_PRGM_5"),
    CMDS_PRGM_6     = get_param_handle("CMDS_PRGM_6"),
}

local chaff_count = 0
local flare_count = 0
local cm_bank1_chaff_count = 0
local cm_bank1_flare_count = 0
local cm_bank2_chaff_count = 0
local cm_bank2_flare_count = 0
local cm_banksel = "both"
local cm_power = 0
local chaff_dispensing = 0
local flare_dispensing = 0
local command_active = 0
local ecms_bank1_pos = 1
local ecms_bank2_pos = 2
local active_program = 1
local last_drop_time = 0
local light_duration = 0.3

local last_bank_used = "bank_1"
local salvo_active = false
local salvo_count = 0
local salvo_type = nil
local salvo_interval = 0.5
local last_salvo_time = 0
local burst_active = false
local burst_count = 0
local burst_type = nil
local burst_interval = 0.133
local last_burst_time = 0
local combo_active = false
local combo_chaff_count = 0
local combo_flare_count = 0
local combo_interval = 0.5
local last_combo_time = 0

local cm_bank1_Xx = get_param_handle("CM_BANK1_Xx")
local cm_bank1_xX = get_param_handle("CM_BANK1_xX")
local cm_bank2_Xx = get_param_handle("CM_BANK2_Xx")
local cm_bank2_xX = get_param_handle("CM_BANK2_xX")

ecms:listen_command(10164) -- Chaff
ecms:listen_command(10165) -- Flare
ecms:listen_command(10166) -- Jammer
ecms:listen_command(iCommandPlaneDropFlareOnce)
ecms:listen_command(iCommandPlaneDropChaffOnce)
ecms:listen_event("WeaponRearmComplete")
ecms:listen_event("UnlimitedWeaponStationRestore")

function cm_draw_bank1(chaff_count, flare_count)
    local total = chaff_count + flare_count
    local tens = math.floor(total/10 + 0.02)
    local ones = math.floor(total%10 + 0.02)
    cm_bank1_Xx:set(tens/10)
    cm_bank1_xX:set(ones/10)
end

function cm_draw_bank2(chaff_count, flare_count)
    local total = chaff_count + flare_count
    local tens = math.floor(total/10 + 0.02)
    local ones = math.floor(total%10 + 0.02)
    cm_bank2_Xx:set(tens/10)
    cm_bank2_xX:set(ones/10)
end

function update_countermeasures_display()
    cm_draw_bank1(cm_bank1_chaff_count, cm_bank1_flare_count)
    cm_draw_bank2(cm_bank2_chaff_count, cm_bank2_flare_count)
end

function release_countermeasure(type, quantity, use_bank1, use_bank2)
    if parameters.ECMS_POWER:get() == 0 then
        return false
    end
    local dispensed = false

    if use_bank1 then
        if type == "chaff" and cm_bank1_chaff_count >= quantity then
            ecms:drop_chaff(quantity, ecms_bank1_pos)
            chaff_dispensing = 1
            last_drop_time = get_absolute_model_time()
            cm_bank1_chaff_count = cm_bank1_chaff_count - quantity
            dispensed = true
        elseif type == "flare" and cm_bank1_flare_count >= quantity then
            ecms:drop_flare(quantity, ecms_bank1_pos)
            flare_dispensing = 1
            last_drop_time = get_absolute_model_time()
            cm_bank1_flare_count = cm_bank1_flare_count - quantity
            dispensed = true
        else
        end
    end

    if use_bank2 then
        if type == "chaff" and cm_bank2_chaff_count >= quantity then
            ecms:drop_chaff(quantity, ecms_bank2_pos)
            chaff_dispensing = 1
            last_drop_time = get_absolute_model_time()
            cm_bank2_chaff_count = cm_bank2_chaff_count - quantity
            dispensed = true
        elseif type == "flare" and cm_bank2_flare_count >= quantity then
            ecms:drop_flare(quantity, ecms_bank2_pos)
            flare_dispensing = 1
            last_drop_time = get_absolute_model_time()
            cm_bank2_flare_count = cm_bank2_flare_count - quantity
            dispensed = true
        else
        end
    end

        update_countermeasure_quantity()


    return dispensed
end

function update_countermeasure_quantity()
    chaff_count = ecms:get_chaff_count()
    flare_count = ecms:get_flare_count()

    cm_bank1_chaff_count = math.min(math.floor(chaff_count / 2), 60)
    cm_bank1_flare_count = math.min(math.floor(flare_count / 2), 60)
    cm_bank2_chaff_count = math.min(chaff_count - cm_bank1_chaff_count, 60)
    cm_bank2_flare_count = math.min(flare_count - cm_bank1_flare_count, 60)

    if chaff_count > 0 and cm_bank1_chaff_count == 0 then
        cm_bank1_chaff_count = math.min(chaff_count, 60)
        cm_bank2_chaff_count = math.min(chaff_count - cm_bank1_chaff_count, 60)
    end
    if flare_count > 0 and cm_bank1_flare_count == 0 then
        cm_bank1_flare_count = math.min(flare_count, 60)
        cm_bank2_flare_count = math.min(flare_count - cm_bank1_flare_count, 60)
    end

end

--[[
--Function for auto ecm deployment--to do

function missile_warning_check()
    -- check for message from rwr
    if rwr_status:get() == 3 then
        missile_threat_state = 1

        -- if threat state is new
        if missile_threat_state ~= previous_threat_state and cm_auto_mode then
            cms_dispense = true
            -- start 30 second counter between start of auto sequence
            auto_mode_ticker = time_ticker
        end

        -- restart sequence if auto mode interval has passed and missile threat is still present
        if (time_ticker - auto_mode_ticker) > AUTO_MODE_MIN_INTERVAL and cm_auto_mode then
            cms_dispense = true
            -- start 30 second counter between start of auto sequence
            auto_mode_ticker = time_ticker
        end
    else
        missile_threat_state = 0
    end
end
]]



function post_initialize()
    cm_banksel = "both"
    last_bank_used = "bank_1"
    update_countermeasure_quantity()
    active_program = 1
end

function update()

    if parameters.CMDS_PRGM_1:get() == 1 then
        active_program = 1
        cm_banksel = "both"
    elseif parameters.CMDS_PRGM_2:get() == 1 then
        active_program = 2
        cm_banksel = "both"
    elseif parameters.CMDS_PRGM_3:get() == 1 then
        active_program = 3
        cm_banksel = "both"
    elseif parameters.CMDS_PRGM_4:get() == 1 then
        active_program = 4
        cm_banksel = "both"
    elseif parameters.CMDS_PRGM_5:get() == 1 then
        active_program = 5
        cm_banksel = "both"
    end

    if chaff_dispensing == 1 or flare_dispensing == 1 then
        local current_time = get_absolute_model_time()
        if current_time - last_drop_time >= light_duration then
            chaff_dispensing = 0
            flare_dispensing = 0
        end
    end

    if salvo_active and parameters.ECMS_POWER:get() == 1 then
        local current_time = get_absolute_model_time()
        if current_time - last_salvo_time >= salvo_interval then
            if salvo_count < 10 and release_countermeasure(salvo_type, 1, true, true) then
                salvo_count = salvo_count + 1
                last_salvo_time = current_time
            else
                salvo_active = false
                salvo_count = 0
                salvo_type = nil
                cm_banksel = "both"
            end
        end
    end

    if burst_active and parameters.ECMS_POWER:get() == 1 then
        local current_time = get_absolute_model_time()
        if current_time - last_burst_time >= burst_interval then
            if burst_count < 15 and release_countermeasure(burst_type, 1, true, true) then
                burst_count = burst_count + 1
                last_burst_time = current_time
            else
                burst_active = false
                burst_count = 0
                burst_type = nil
                cm_banksel = "both"
            end
        end
    end

    if combo_active and parameters.ECMS_POWER:get() == 1 then
        local current_time = get_absolute_model_time()
        if current_time - last_combo_time >= combo_interval then
            update_countermeasure_quantity()
            local chaff_ok = combo_chaff_count < 10 and release_countermeasure("chaff", 1, true, true)
            local flare_ok = combo_flare_count < 10 and release_countermeasure("flare", 1, true, true)
            if chaff_ok then
                combo_chaff_count = combo_chaff_count + 1
            end
            if flare_ok then
                combo_flare_count = combo_flare_count + 1
            end
            last_combo_time = current_time
            if combo_chaff_count >= 10 and combo_flare_count >= 10 then
                combo_active = false
                combo_chaff_count = 0
                combo_flare_count = 0
                cm_banksel = "both"
                last_bank_used = "bank_1"
                update_countermeasure_quantity()
            end
        end
    end

    if parameters.ECMS_POWER:get() == 1 then
        update_countermeasures_display()
    end

    parameters.CHAFF_COUNT:set(chaff_count)
    parameters.FLARE_COUNT:set(flare_count)
    parameters.CHAFF_DISPENSING:set(chaff_dispensing)
    parameters.FLARE_DISPENSING:set(flare_dispensing)
	
	if parameters.JAMMER_POWER:get() == 1 then
		ecms:set_ECM_status(true)
	else
		ecms:set_ECM_status(false)
	end
	
end

function SetCommand(command, value)
    if parameters.ECMS_POWER:get() == 0 then return end

    if command == 10165 and command_active == 0 then -- Chaff
        command_active = 1
        if active_program == 1 then
            release_countermeasure("chaff", 1, true, true)
        elseif active_program == 2 then
            local use_bank1 = last_bank_used == "bank_2"
            local use_bank2 = last_bank_used == "bank_1"
            if release_countermeasure("chaff", 1, use_bank1, use_bank2) then
                last_bank_used = use_bank1 and "bank_1" or "bank_2"
            end
        elseif active_program == 3 then
            if not salvo_active then
                salvo_active = true
                salvo_count = 0
                salvo_type = "chaff"
                last_salvo_time = get_absolute_model_time()
            end
        elseif active_program == 4 then
            if not burst_active then
                burst_active = true
                burst_count = 0
                burst_type = "chaff"
                last_burst_time = get_absolute_model_time()
            end
        elseif active_program == 5 then
            if not combo_active then
                combo_active = true
                combo_chaff_count = 0
                combo_flare_count = 0
                last_combo_time = get_absolute_model_time()
                cm_banksel = "both"
                update_countermeasure_quantity()
            end
        end
    elseif command == 10165 and command_active == 1 then
        command_active = 0
    elseif command == 10164 and command_active == 0 then -- Flare
        command_active = 1
        if active_program == 1 then
            release_countermeasure("flare", 1, true, true)
        elseif active_program == 2 then
            local use_bank1 = last_bank_used == "bank_2"
            local use_bank2 = last_bank_used == "bank_1"
            if release_countermeasure("flare", 1, use_bank1, use_bank2) then
                last_bank_used = use_bank1 and "bank_1" or "bank_2"
            end
        elseif active_program == 3 then
            if not salvo_active then
                salvo_active = true
                salvo_count = 0
                salvo_type = "flare"
                last_salvo_time = get_absolute_model_time()
            end
        elseif active_program == 4 then
            if not burst_active then
                burst_active = true
                burst_count = 0
                burst_type = "flare"
                last_burst_time = get_absolute_model_time()
            end
        elseif active_program == 5 then
            if not combo_active then
                combo_active = true
                combo_chaff_count = 0
                combo_flare_count = 0
                last_combo_time = get_absolute_model_time()
                cm_banksel = "both"
                update_countermeasure_quantity()
            end
        end
    elseif command == 10164 and command_active == 1 then
        command_active = 0
    end

end

function CockpitEvent(event, val)
    if event == "WeaponRearmComplete" or event == "UnlimitedWeaponStationRestore" then
        update_countermeasure_quantity()
        cm_banksel = "both"
        last_bank_used = "bank_1"
    end
end

need_to_be_closed = false