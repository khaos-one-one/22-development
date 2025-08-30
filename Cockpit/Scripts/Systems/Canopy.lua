dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")

local dev = GetSelf()

local update_time_step = 0.04 
make_default_activity(update_time_step)

local sensor_data = get_base_data()

local CANOPY_STATE	= get_param_handle("CANOPY_STATE")
local BATTERY_POWER		= get_param_handle ("BATTERY_POWER")


local canopy_int_anim_arg = 181
local canopy_ext_anim_arg = 38


--Creating local variables
local initial_canopy = get_aircraft_draw_argument_value(canopy_ext_anim_arg)
local CANOPY_COMMAND = 0.01   -- 0 closing, 1 opening, 2 jettisoned
if (initial_canopy > 0) then
    CANOPY_COMMAND = 1
end

dev:listen_command(Keys.PlaneFonar)


function SetCommand(command,value)


	if (command == Keys.PlaneFonar) and BATTERY_POWER:get() == 1 and (sensor_data.getTrueAirSpeed() * 1.944) < 15 then
        if CANOPY_COMMAND <= 1 then -- only toggle while not jettisoned
            CANOPY_COMMAND = 1-CANOPY_COMMAND --toggle
        end
	end
end

local prev_canopy_val = -1
local canopy_warning = 0

local sndhost
local canopy_snd
local canopy_move_snd

function post_initialize()

    local birth = LockOn_Options.init_conditions.birth_place
    if birth == "GROUND_COLD" then
        CANOPY_COMMAND = 1
    else
        CANOPY_COMMAND = 0
    end
    sndhost = create_sound_host("COCKPIT_CANOPY","HEADPHONES",0,0,0)
    canopy_snd = sndhost:create_sound("Aircrafts/F-22A/Canopy")
    canopy_move_snd = sndhost:create_sound("Aircrafts/F-22A/CanopyMove")
end

function update()



    local current_canopy_position = get_aircraft_draw_argument_value(canopy_ext_anim_arg)
    if current_canopy_position > 0.95 then
        CANOPY_COMMAND = 2 -- canopy was jettisoned
    end
	if (CANOPY_COMMAND == 0 and current_canopy_position > 0) then
		-- lower canopy in increments of 0.01 (50x per second)
        if current_canopy_position > 0.89 then 
            canopy_move_snd:play_once()
        end
        current_canopy_position = current_canopy_position - 0.01
	elseif (CANOPY_COMMAND == 1 and current_canopy_position <= 0.89) then
        -- raise canopy in increment of 0.01 (50x per second)
        if current_canopy_position == 0 then 
            canopy_snd:play_once() 
            canopy_move_snd:play_once()
        end
		current_canopy_position = current_canopy_position + 0.01
    elseif current_canopy_position < 0 then current_canopy_position = 0
        canopy_snd:play_once()
        canopy_move_snd:stop()
    elseif current_canopy_position >= 0.89 and current_canopy_position < 0.95 then current_canopy_position = 0.9
        canopy_move_snd:stop()
    end
    set_aircraft_draw_argument_value(canopy_ext_anim_arg, current_canopy_position)
	CANOPY_STATE:set(current_canopy_position)

end

function CockpitEvent(event, val)
    if event == "repair" then
        CANOPY_COMMAND = 1 -- reset canopy from jettison state to open state
    end
end

need_to_be_closed = false -- close lua state after initialization