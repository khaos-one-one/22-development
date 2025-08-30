--[[
    Grinnelli Designs F-22A Raptor
    Copyright (C) 2024, Joseph Grinnelli
    
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    
    You should have received a copy of the GNU General Public License
    along with this program.  If not, see https://www.gnu.org/licenses.
	
	CONTRIBUTORS:

	Copyright (c) 2025: Branden Hooper
	Copyright (C) 2025, Ash blythe
	Copyright (c) 2025: David McMasters
--]]

-- ATC Mod Added for FlyingAlex ATC port for F-22A [21 Feb 2022]
-- Port from JAS39 Gripen Community Mod  Thanks for keeping open source! :)
-- See full instructions and credits on https://github.com/kingDevGit/DCS-F-22A-Auto-throttle-ATC
dofile(LockOn_Options.common_script_path .. "devices_defs.lua")
dofile(LockOn_Options.script_path .. "devices.lua")
dofile(LockOn_Options.script_path .. "command_defs.lua")
dofile(LockOn_Options.script_path .. "utils.lua")

local dev = GetSelf()
local sensor_data = get_base_data()
local degrees_per_radian = 57.2957795
local feet_per_meter_per_minute = 196.8
local meters_to_feet = 3.2808399
local GALLON_TO_KG = 3.785 * 0.8
local KG_TO_POUNDS = 2.20462
local MPS_TO_KNOTS = 1.94384
local RADIANS_TO_DEGREES = 57.2958

local update_time_step = 0.01
local AutoThrApproach = get_param_handle("ATC_APPROACH")
local AutoThrCruise = get_param_handle("ATC_CRUISE")
local CautionLight = get_param_handle("CAUTION_LIGHT")
make_default_activity(update_time_step)

local ThrottleAxis = 2004 -- FC3 Both Throttle Axis

local autothrottle_pid = PID(5, 0.02, 0.1, -0.85, 1.0, 1) -- Create the PID controller ( Kp, Ki, Kd, umin, umax, uscale )

dev:listen_command(10210) -- Toggle autothrottle

local AOA_MODE = 0 -- 1 Approach 0 Cruise
local AUTOTHROTTLE_STATE = 0
local speedHold = -100
local iasHold = -100
local throttle = 0
local THROTTLE_INPUT = 1
local tpos = 0

function SetCommand(command, value)
    local flapPos = sensor_data.getFlapsPos()
    if command == 10210 then

        -- Engage and disengage AT
        if AUTOTHROTTLE_STATE == 0 then
            if flapPos == 1 then
                AutoThrApproach:set(1)
				AOA_MODE = 1
            elseif flapPos == 0 then
                AutoThrCruise:set(1)
				AOA_MODE = 0

            end
            AUTOTHROTTLE_STATE = 1
            tpos = THROTTLE_INPUT
            speedHold = sensor_data.getTrueAirSpeed()
            iasHold = sensor_data.getIndicatedAirSpeed()

        elseif AUTOTHROTTLE_STATE == 1 then
            AUTOTHROTTLE_STATE = 0
            speedHold = -100
			iasHold = -100
            AutoThrApproach:set(0)
			AutoThrCruise:set(0)
        end
    end

end

function update_autothrottle() -- Autothrottle function

    if AUTOTHROTTLE_STATE == 1 then
        tas = -math.sqrt(sensor_data.getTrueAirSpeed())
        tastarget = -math.sqrt(speedHold)
        throttle = autothrottle_pid:run(tastarget, tas)
        dispatch_action(nil, ThrottleAxis, (throttle * 0.999))
    end
end


function update_autothrottle_approach() -- AoA landing mode function
    local aoadeg
    local aoa_target

    if AUTOTHROTTLE_STATE == 1 then
        aoadeg = math.deg(sensor_data.getAngleOfAttack())
        aoa_target = 144 -- (12^2)	Keep 12 degrees of AoA	
        throttle = autothrottle_pid:run(aoa_target, aoadeg * aoadeg)
        dispatch_action(nil, ThrottleAxis, (throttle * 0.999))
    end
end

function throttle_axis()
        dispatch_action(nil, ThrottleAxis, THROTTLE_INPUT)
end

function throttle_override()
    if AUTOTHROTTLE_STATE == 1 and (tpos - THROTTLE_INPUT) > 0.2 then
        dispatch_action(nil, 10210)
    elseif AUTOTHROTTLE_STATE == 1 and (THROTTLE_INPUT - tpos) > 0.2 then
        dispatch_action(nil, 10210)
    end
end

function update()

    local ias = sensor_data.getIndicatedAirSpeed() * 1.944 -- IAS in kts
	local wow_l = sensor_data.getWOW_LeftMainLandingGear() -- Left main gear weight on wheels 
	local wow_r = sensor_data.getWOW_RightMainLandingGear()	
    local flapPos = sensor_data.getFlapsPos()

    if AUTOTHROTTLE_STATE == 1 then
        if AOA_MODE == 1 then
            update_autothrottle_approach()
            throttle_override()

            if flapPos == 0 then -- Disengage on flap position changed
                throttle_axis()	
                if AUTOTHROTTLE_STATE == 1 then
                    dispatch_action(nil,10210)
                end 
            end
            
        elseif AOA_MODE == 0 then
            update_autothrottle()
            throttle_override()

            if flapPos == 1 then -- Disengage on flap position changed
                throttle_axis()	
                if AUTOTHROTTLE_STATE == 1 then
                    dispatch_action(nil,10210)
                end 
            end

        end
    end

    -- Disengage when landed
	if (wow_l == 1 or wow_r == 1) and AUTOTHROTTLE_STATE == 1 then
		throttle_axis()	
        dispatch_action(nil,10210)
	end

    -- Disengage when master caution light on
    if(CautionLight:get()>0 and AUTOTHROTTLE_STATE == 1) then
        throttle_axis()	
        dispatch_action(nil,10210)
	end
end

need_to_be_closed = false

