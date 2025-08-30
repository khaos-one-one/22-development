local dev = GetSelf()
local sensor_data = get_base_data()

dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")

local update_rate = 0.006 --0.006
make_default_activity(update_rate)

local parameters =
{

	--fixing stall and G warning
	RAW_AOA        = get_param_handle("RAW_AOA"),
	
	-- Engine
	APU_POWER			 = get_param_handle("APU_POWER"),
	APU_RPM_STATE		 = get_param_handle("APU_RPM_STATE"),
	BATTERY_POWER		 = get_param_handle("BATTERY_POWER"),
	MAIN_POWER		     = get_param_handle("MAIN_POWER"),
	L_GEN_POWER			 = get_param_handle ("L_GEN_POWER"),
	R_GEN_POWER			 = get_param_handle ("R_GEN_POWER"),
	CANNON_ACTIVE		= get_param_handle("CANNON_ACTIVE"),

	-- Indicator
	UFD_OPACITY		     = get_param_handle("UFD_OPACITY"),
	MFD_OPACITY		     = get_param_handle("MFD_OPACITY"),
	ICP_OPACITY		     = get_param_handle("ICP_OPACITY"),
	R_ADI_OPACITY     	 = get_param_handle("R_ADI_OPACITY"),
	RUFD_BLANK_PAGE      = get_param_handle("RUFD_BLANK_PAGE"),
	LUFD_BASE_PAGE 	 	 = get_param_handle("LUFD_BASE_PAGE"),
	LUFD_ALERT_PAGE 	 = get_param_handle("LUFD_ALERT_PAGE"),
	LUFD_STATUS_PAGE 	 = get_param_handle("LUFD_STATUS_PAGE"),
	CHECK_ENGINE_LIGHT	 = get_param_handle("CHECK_ENGINE_LIGHT"),
	AAR              	 = get_param_handle("AAR"),
	HUD_OPACITY			 = get_param_handle("HUD_OPACITY"),
	TAS				     = get_param_handle("TAS"),
	IAS				     = get_param_handle("IAS"),
	GFORCE			     = get_param_handle("GFORCE"),
	AOA			     	 = get_param_handle("AOA"),
	VV			     	 = get_param_handle("VV"),
	ADI_PITCH 		     = get_param_handle("ADIPITCH"),
	ADI_ROLL			 = get_param_handle("ADIROLL"),
	SLIP				 = get_param_handle("SLIP"),
	YAW				     = get_param_handle("YAW"),
	ROLLRATE			 = get_param_handle("ROLLRATE"),
	NAV                  = get_param_handle("NAV"),
	BARO 				 = get_param_handle("BAROALT"),
	RADALT			     = get_param_handle("RADALT"),
	RPM_L                = get_param_handle("RPM_L"),
	RPM_R                = get_param_handle("RPM_R"),
	EGT_L                = get_param_handle("EGT_L"),
	EGT_R                = get_param_handle("EGT_R"),
	FUELL                = get_param_handle("FUELL"),
	FUEL                 = get_param_handle("FUEL"),
	FUELT                = get_param_handle("FUELT"),
	FUELTANK             = get_param_handle("FUELTANK"),
	FLOOD_LIGHT 		 = get_param_handle("FLOOD_LIGHT"),
	PANEL_LIGHT 		 = get_param_handle("PANEL_LIGHT"),	
	CANOPY_LIGHT 		 = get_param_handle("CANOPY_LIGHT"),	
	CHAFF_LIGHT   	     = get_param_handle("CHAFF_LIGHT"),	
	FLARE_LIGHT   	     = get_param_handle("FLARE_LIGHT"),	
	SPD_BRK_LIGHT 	     = get_param_handle("SPD_BRK_LIGHT"),	
	BINGO_LIGHT   	     = get_param_handle("BINGO_LIGHT"),	
	FLAPS_MOVE 		     = get_param_handle("FLAPS_MOVE"),	
	FLAPS_DOWN		     = get_param_handle("FLAPS_DOWN"),	
	AAR_LIGHT 		     = get_param_handle("AAR_LIGHT"),	
	L_FIRE_LIGHT 		 = get_param_handle("L_FIRE_LIGHT"),	
	R_FIRE_LIGHT 		 = get_param_handle("R_FIRE_LIGHT"),	
	L_GEN_OUT 		     = get_param_handle("L_GEN_OUT"),	
	R_GEN_OUT 		     = get_param_handle("R_GEN_OUT"),	
	HYD_LIGHT 		     = get_param_handle("HYD_LIGHT"),	
	CAUTION_LIGHT		 = get_param_handle("CAUTION_LIGHT"),	
	OIL_LIGHT			 = get_param_handle("OIL_LIGHT"),
	APU_READY			 = get_param_handle("APU_READY"),
	APU_SPOOL			 = get_param_handle("APU_SPOOL"),
	L_OIL_COLOR	     	 = get_param_handle("L_OIL_COLOR"),
	R_OIL_COLOR	     	 = get_param_handle("R_OIL_COLOR"),
	L_HYD_COLOR			 = get_param_handle("L_HYD_COLOR"),
	R_HYD_COLOR			 = get_param_handle("R_HYD_COLOR"),
	LMFD_ENG_PAGE        = get_param_handle("LMFD_ENG_PAGE"),
	LMFD_MENU_PAGE       = get_param_handle("LMFD_MENU_PAGE"),
	LMFD_FCS_PAGE        = get_param_handle("LMFD_FCS_PAGE"),
	LMFD_FUEL_PAGE       = get_param_handle("LMFD_FUEL_PAGE"),
	LMFD_NAV_PAGE        = get_param_handle("LMFD_NAV_PAGE"),
	LMFD_BAY_PAGE        = get_param_handle("LMFD_BAY_PAGE"),
	LMFD_STARTUP_PAGE        = get_param_handle("LMFD_STARTUP_PAGE"),
	LMFD_CHECKLIST_PAGE  = get_param_handle("LMFD_CHECKLIST_PAGE"),
	LMFD_SMS_PAGE        = get_param_handle("LMFD_SMS_PAGE"),
	LMFD_HSI_PAGE        = get_param_handle("LMFD_HSI_PAGE"),
 	LMFD_PAGE            = get_param_handle("LMFD_PAGE"),
	LMFD_MASK            = get_param_handle("LMFD_MASK"),
	RMFD_MASK            = get_param_handle("RMFD_MASK"),
	PMFD_MASK            = get_param_handle("PMFD_MASK"),
	LMFD_BLANK_PAGE		 = get_param_handle("LMFD_BLANK_PAGE"),
	RMFD_BLANK_PAGE  	 = get_param_handle("RMFD_BLANK_PAGE"),
	CMFD_BLANK_PAGE      = get_param_handle("CMFD_BLANK_PAGE"),
	DAY_NIGHT	         = get_param_handle("DAY_NIGHT"),
	MACH	         	 = get_param_handle("MACH"),
	PITCHRATE	         = get_param_handle("PITCHRATE"),
	YAWRATE	         	 = get_param_handle("YAWRATE"),
	TRUE_AOA			 = get_param_handle("TRUE_AOA"),
	FPA					 = get_param_handle("FPA"),
	RAD_ALT_RATE		 = get_param_handle("RAD_ALT_RATE"),
	SMOOTH_ALT           = get_param_handle("SMOOTH_ALT"),
	SMOOTH_RAD_ALT		 = get_param_handle("SMOOTH_RAD_ALT"),
	ALT_TH				 = get_param_handle("ALT_TH"),
	ALT_FT				 = get_param_handle("ALT_FT"),
	ROLL_DEG			 = get_param_handle("ROLL_DEG"),
	ROLL_IND			 = get_param_handle("ROLL_IND"),
	GEAR_DOWN			 = get_param_handle("GEAR_DOWN"),
	WOW_STATE			 = get_param_handle("WOW_STATE"),
	VertV				 = get_param_handle("VertV"),
	MAG_HEADING			 = get_param_handle("MAG_HEADING"),
	TRUE_HEADING		 = get_param_handle("TRUE_HEADING"),
	TIME_HOURS 			 = get_param_handle("TIME_HOURS"),
	TIME_MINS 			 = get_param_handle("TIME_MINS"),
	TIME_SEC		 	 = get_param_handle("TIME_SEC"),
	CLOCK				 = get_param_handle("CLOCK"),
	DATE				 = get_param_handle("DATE"),
	LONGITUDE			 = get_param_handle("LONGITUDE"),
	LATITUDE			 = get_param_handle("LATITUDE"),
	GUN_PIPER_X 		 = get_param_handle("GUN_PIPER_X"),
    GUN_PIPER_Y 		 = get_param_handle("GUN_PIPER_Y"),
	SUNRISE_TIME 		 = get_param_handle("SUNRISE_TIME"),
    SUNSET_TIME 		 = get_param_handle("SUNSET_TIME"),
	BINGO_VAL			 = get_param_handle("BINGO_VAL"),
	B_PRESSURE			 = get_param_handle("B_PRESSURE"),
	TEMP			 	 = get_param_handle("TEMP"),
	WIND_SPEED			 = get_param_handle("WIND_SPEED"),
	WIND_DIRECTION		 = get_param_handle("WIND_DIRECTION"),
	GPS_ENABLED			 = get_param_handle("GPS_ENABLED"),
	HMD_HUDVIEW	 		 = get_param_handle("HMD_HUDVIEW"),
	HMD_HORIZONTAL	 	 = get_param_handle("HMD_HORIZONTAL"),
	HMD_HEADING			 = get_param_handle("HMD_HEADING"),
	SLIP2				 = get_param_handle("SLIP2")
}

local day_night = 0

-- Clickable data
local MFD_KNOB_mouse   = device_commands.Button_3 -- Track mouse scroll
local UFD_KNOB_mouse   = device_commands.Button_4  -- Track mouse scroll
local HUD_KNOB_mouse   	= device_commands.Button_29	
--local HUD_KNOB_mouse_down   = device_commands.Button_30	
local day_night_switch = device_commands.Button_8  -- Track mouse clicks
local right_UFD_swap   = device_commands.Button_9  -- Track mouse clicks
local left_UFD_swap    = device_commands.Button_10 -- Track mouse clicks
local eject_handle     = device_commands.Button_11 -- Track mouse clicks
local UFDL_OSB2			= device_commands.Button_12
local UFDL_OSB3			= device_commands.Button_13
local UFDL_OSB4			= device_commands.Button_14
local UFDR_OSB2			= device_commands.Button_15
local UFDR_OSB3			= device_commands.Button_16
local UFDR_OSB4			= device_commands.Button_17
local lufd_current_page = 0 --0 base, 1 status, 2 comms
local prev_rad_alt = 0
local prev_time = 0
local rad_alt_rate = 0
local prev_fpa = 0
local smoothing_factor = 0.1
local Terrain = require('terrain')
local alert_count = 0
local check_engine_light = 0



--[[
UFDL_OSB2		  = 10155
UFDL_OSB3		  = 10156
UFDL_OSB4		  = 10157
UFDR_OSB2		  = 10158
UFDR_OSB3		  = 10159
UFDR_OSB4		  = 10160
]]


dev:listen_command(UFD_KNOB_mouse)
dev:listen_command(day_night_switch)
dev:listen_command(right_UFD_swap)
dev:listen_command(left_UFD_swap)
dev:listen_command(83)

dev:listen_command(10017)--DAY NIGHT
dev:listen_command(10018)--DAY NIGHT T

dev:listen_command(10027)--swap bind ufd

dev:listen_command(10155) --UFD Left OSB 2
dev:listen_command(10156) --UFD Left OSB 3
dev:listen_command(10157) --UFD Left OSB 4
dev:listen_command(10158) --UFD Right OSB 2
dev:listen_command(10159) --UFD Right OSB 3
dev:listen_command(10160) --UFD Right OSB 4

dev:listen_command(2142) --Horizontal 
dev:listen_command(2143) --Vertical
local hmd_horizontal = 0
local hmd_vertical = 0
local hmd_heading = 0



local function dmsToDecimal(dms)
    if type(dms) ~= "string" then
        return tonumber(dms) or 0 -- Return as number if not a string
    end
    -- Extract components using pattern: degrees, minutes, seconds, direction
    local deg, min, sec, dir = dms:match("(%d+)d(%d+)e([%d%.]+)f([NSEW])")
    deg = tonumber(deg) or 0
    min = tonumber(min) or 0
    sec = tonumber(sec) or 0
    local decimal = deg + min / 60 + sec / 3600
    if dir == "S" or dir == "W" then
        decimal = -decimal
    end
    return decimal
end


local function round_to_two_decimals(value)
    return math.floor(value * 100 + 0.5) / 100
end

function decimalToDMS(decimal, isLatitude)
    local sign = decimal >= 0 and 1 or -1
    local absDecimal = math.abs(decimal)
    local degrees = math.floor(absDecimal)
    local minutes = math.floor((absDecimal - degrees) * 60)
    local seconds = ((absDecimal - degrees) * 60 - minutes) * 60
    local direction = isLatitude and (sign == 1 and "N" or "S") or (sign == 1 and "E" or "W")
    return string.format("%dd%de%.2ff%s", degrees, minutes, seconds, direction)
end


function post_initialize()

		
	local birth_place = LockOn_Options.init_conditions.birth_place

	if birth_place == "GROUND_COLD" then
		dev:performClickableAction(UFD_KNOB_mouse, 1, false)--remove for release?
		dev:performClickableAction(MFD_KNOB_mouse, 1, false)--remove for release?

		
	elseif birth_place == "GROUND_HOT" or birth_place == "AIR_HOT" then
		dev:performClickableAction(UFD_KNOB_mouse, 1, false)
		dev:performClickableAction(MFD_KNOB_mouse, 1, false)
		dev:performClickableAction(device_commands.Button_5, 0.25, false)
        dev:performClickableAction(device_commands.Button_6, 0.3, false)
        --parameters.LUFD_BASE_PAGE:set(1)
		lufd_current_page = 0
	end
	

	
end

local R_UFD_ADI = 0
local rufd_blank_page = 0

function SetCommand(command, value)
    -- Existing logic
    if command == eject_handle then
        dispatch_action(nil, 83)
        print_message_to_user("EJECT!!!")
    end
    if command == day_night_switch or command == 10017 or command == 10018 then
        if day_night == 0 then
            day_night = 1
        else
            day_night = 0
        end
    end

	if (command == UFDL_OSB2 or command == 10155) and parameters.MAIN_POWER:get() == 1  then
		lufd_current_page = 0
	elseif (command == UFDL_OSB3 or command == 10156) and (parameters.MAIN_POWER:get() == 1 or parameters.APU_RPM_STATE:get() >= 2) then
		lufd_current_page = 1
	elseif (command == UFDL_OSB4 or command == 10157) and (parameters.MAIN_POWER:get() == 1 or parameters.APU_RPM_STATE:get() >= 2) and parameters.CHECK_ENGINE_LIGHT:get() == 1 then
        lufd_current_page = 2	
	end
	
	if command == 2142 then
		hmd_horizontal = value
	end
	if command == 2143 then
		hmd_vertical = value
	end
	
end


function update()


	
	

	WOW_STATE = sensor_data.getWOW_LeftMainLandingGear()
	parameters.WOW_STATE:set(WOW_STATE)
	local GEAR_DOWN = sensor_data.getNoseLandingGearDown()
	parameters.GEAR_DOWN :set(GEAR_DOWN)


	
	
	--Clock
	local abstime = get_absolute_model_time() or 0
    local hours = math.floor(abstime / 3600) % 24
    local remaining_secs = abstime % 3600
    local minutes = math.floor(remaining_secs / 60)
    local seconds = math.floor(remaining_secs % 60)
    parameters.TIME_HOURS:set(hours)
    parameters.TIME_MINS:set(minutes)
    parameters.TIME_SEC:set(seconds)
	parameters.CLOCK:set(string.format("%02d:%02d:%02d", hours, minutes, seconds))
	
    -- Optional debug
    --print_message_to_user(parameters.CLOCK:get())
	--DATE
	local current_year = LockOn_Options.date.year
	local current_month = LockOn_Options.date.month
	local current_day = LockOn_Options.date.day
	parameters.DATE:set(string.format("%02d/%02d/%02d", current_month, current_day, current_year))
	--print_message_to_user(current_year)
	
	if current_year < 1987 then
		parameters.GPS_ENABLED:set(0)
	else
		parameters.GPS_ENABLED:set(1)
	end
	
	--Position
	local curx, cury, curz = sensor_data.getSelfCoordinates()
	local current_lat, current_long = Terrain.convertMetersToLatLon(curx, curz)
	parameters.LATITUDE:set(decimalToDMS(current_lat, true))
	parameters.LONGITUDE:set(decimalToDMS(current_long, false))
	--print_message_to_user(parameters.LATITUDE:get())
	--print_message_to_user(parameters.LONGITUDE:get())



	--Fix for flaps down light
	local flapPosL = get_aircraft_draw_argument_value(10)
	local flapPosR = get_aircraft_draw_argument_value(9)
	if ((flapPosL + flapPosR) > 1.98) then
		parameters.FLAPS_DOWN:set(1)	
	else
		parameters.FLAPS_DOWN:set(0)	
	end

	-- Fuel state
	if parameters.FUELT:get() <= 0 then
		parameters.FUELTANK:set(0)
	else
		parameters.FUELTANK:set(sensor_data.getTotalFuelWeight() * 2.20462 - 18078) -- Working, don't chage: 0.36622 
	end
	
	local MFD_KNOB          = get_cockpit_draw_argument_value(704)
	local UFD_KNOB          = get_cockpit_draw_argument_value(705)
	local CONSOLE_KNOB      = get_cockpit_draw_argument_value(706)
	local FLOOD_KNOB        = get_cockpit_draw_argument_value(707)
	local CANOPY_ARG        = get_cockpit_draw_argument_value(181)
	local CHAFF_ARG         = get_cockpit_draw_argument_value(254)
	local FLARE_ARG         = get_cockpit_draw_argument_value(255)
	local SPD_BRK_ARG       = (sensor_data.getSpeedBrakePos())
	local BINGO_ARG         = 0
	local FLAPS_MOVE_ARG    = get_cockpit_draw_argument_value(42)
	local FLAPS_DOWN_ARG    = get_cockpit_draw_argument_value(43)
	local AAR_ARG           = parameters.AAR:get()
	local L_FIRE_ARG        = get_cockpit_draw_argument_value(126)
	local R_FIRE_ARG        = get_cockpit_draw_argument_value(256)
	local L_GEN_ARG         = get_cockpit_draw_argument_value(207)
	local R_GEN_ARG         = get_cockpit_draw_argument_value(219)
	local HYD_ARG           = get_cockpit_draw_argument_value(208) 
	local CAUTION_ARG       = get_cockpit_draw_argument_value(117)       
	local OIL_ARG           = get_cockpit_draw_argument_value(220)


	

	parameters.TAS	        :set(sensor_data.getTrueAirSpeed() * 1.944)
	parameters.IAS	        :set(sensor_data.getIndicatedAirSpeed() * 1.944)
	
	parameters.GFORCE       :set(sensor_data.getVerticalAcceleration())
	local Smooth_G = (sensor_data.getVerticalAcceleration())	
	round_to_two_decimals(Smooth_G)

	parameters.GFORCE:set(Smooth_G)

	
	
	parameters.ADI_PITCH    :set(sensor_data.getPitch() )
	parameters.ADI_ROLL     :set(sensor_data.getRoll() )
	parameters.SLIP			:set(sensor_data.getAngleOfSlide() )
	parameters.YAW          :set(sensor_data.getRateOfYaw() )

	parameters.ROLLRATE     :set(math.floor(sensor_data.getRateOfRoll()/math.pi*180 * 10) / 10) -- Testing
	parameters.PITCHRATE    :set(math.floor(sensor_data.getRateOfPitch()/math.pi*180 * 10) / 10) -- Testing
	
	local ROLL_DEG = (sensor_data.getRoll() * 52.2957795)
	local ROLL_RAD = (sensor_data.getRoll())
	parameters.ROLL_DEG:set(ROLL_DEG)
	parameters.ROLL_IND:set(math.min(math.max(ROLL_RAD, -0.5236), 0.5236)) -- cap at 30 degrees
	
	--print_message_to_user(parameters.ROLL_IND:get())

	
	
	parameters.YAWRATE      :set(sensor_data.getRateOfYaw()/math.pi*180)-- Testing
	local Smooth_AOA = (sensor_data.getAngleOfAttack()/math.pi*180)	
	round_to_two_decimals(Smooth_AOA)
	--Smooth_AOA = math.floor(Smooth_AOA / 10 + 0.5) * 10
	parameters.AOA:set(Smooth_AOA)






-- velocity vector calcs
local VertV = (sensor_data.getVerticalVelocity() * 3.28084) * 60
--round_to_two_decimals(VertV)
VertV = math.floor(VertV / 10 + 0.5) * 10
parameters.VertV:set(VertV)
parameters.VV:set(VertV)


local tas_ms = sensor_data.getTrueAirSpeed() or 0 -- m/s
    local vert_vel_ms = sensor_data.getVerticalVelocity() or 0 -- Assume m/s
    local pitch_deg = (sensor_data.getPitch() or 0) * 57.2957795
    local aoa_deg = (sensor_data.getAngleOfAttack() or 0) * 57.2957795
    local pitch_rate = parameters.PITCHRATE:get() or 0
    local FPA_Calc
    if tas_ms < 2.572 or sensor_data.getWOW_LeftMainLandingGear() == 1 then
        FPA_Calc = 0
    else
        -- Convert to feet per second
        local tas_fps = tas_ms * 3.28084 -- m/s to ft/s
        local vert_vel_fps = vert_vel_ms * 3.28084 -- m/s to ft/s (try vert_vel_ms / 60 if ft/min)
        -- Compute horizontal velocity
        local horiz_vel_fps = math.sqrt(math.max(tas_fps * tas_fps - vert_vel_fps * vert_vel_fps, 0.01))
        -- Velocity-based FPA
        local FPA_velocity = math.atan(vert_vel_fps / horiz_vel_fps) * 57.2957795
        -- Pitch - AOA FPA
        local FPA_aoa = pitch_deg - aoa_deg
        -- Blend
        FPA_Calc = 0.7 * FPA_velocity + 0.3 * FPA_aoa
        if FPA_Calc ~= FPA_Calc then FPA_Calc = 0 end
        FPA_Calc = math.min(math.max(FPA_Calc, -90), 90)
    end
    -- Smooth FPA
    local dynamic_smoothing = smoothing_factor * (1 + math.abs(pitch_rate) / 20)
    dynamic_smoothing = math.min(dynamic_smoothing, 0.5)
    prev_fpa = prev_fpa + (FPA_Calc - prev_fpa) * dynamic_smoothing
    prev_fpa = round_to_two_decimals(prev_fpa)
    parameters.FPA:set(prev_fpa)


--print_message_to_user(prev_fpa)
--print_message_to_user(FPA_Calc)
--print_message_to_user(parameters.WOW_STATE:get())



--print_message_to_user(parameters.FPA:get())



	
local SLIP2 = sensor_data.getAngleOfSlide()
parameters.SLIP2:set(math.deg(SLIP2))	

	parameters.MACH			:set(sensor_data.getMachNumber())
	--parameters.NAV          :set(360 - sensor_data.getHeading()/math.pi*180) -- Working, don't change
	
	
	local true_heading = (360 - sensor_data.getHeading() * 57.2957795)
	local NAV = true_heading
	parameters.NAV:set(true_heading)
	parameters.TRUE_HEADING:set(true_heading)
	
	local mag_heading = (sensor_data.getMagneticHeading() * 57.2957795)
	parameters.MAG_HEADING:set(mag_heading)
	
	


	--parameters.NAV			:set(sensor_data.getMagneticHeading()/math.pi*180)
	parameters.RADALT       :set(sensor_data.getRadarAltitude() ) -- Working, don't change
	parameters.BARO         :set(sensor_data.getBarometricAltitude() * 3.28084 ) -- Working, don't change	
	parameters.RPM_L        :set(sensor_data.getEngineLeftRPM() * 100)-- Needs to be tested (might not need to multiply by 2750 cause that was from fixed prop? maybe)
	parameters.RPM_R        :set(sensor_data.getEngineRightRPM() * 100)
	parameters.FUELL        :set(sensor_data.getTotalFuelWeight() * 0.01 ) -- Working, don't change: 0.36622 
	parameters.FUEL         :set(sensor_data.getTotalFuelWeight() * 2.20462 ) -- Working, don't change: 0.36622
	parameters.FUELT        :set(sensor_data.getTotalFuelWeight() * 2.20462 - 18078) -- Working, don't change: 0.36622 **25725 - 17500 = 8225**
	parameters.EGT_L        :set(sensor_data.getEngineLeftTemperatureBeforeTurbine())
	parameters.EGT_R        :set(sensor_data.getEngineRightTemperatureBeforeTurbine())
	
	
	if parameters.BINGO_VAL:get() >= parameters.FUEL:get()  then
		BINGO_ARG = 1
	else
		BINGO_ARG = 0
	end

	--print_message_to_user(parameters.BARO:get())
	--print_message_to_user(sensor_data.getBarometricAltitude())
	--HUD Params
	local ALT_FEET = sensor_data.getBarometricAltitude() * 3.28084
	ALT_FEET = math.floor(ALT_FEET / 10 + 0.5) * 10
	parameters.ALT_FT:set(ALT_FEET % 1000)
    parameters.SMOOTH_ALT:set(ALT_FEET)
	parameters.ALT_TH:set(math.floor(ALT_FEET / 1000))
	parameters.ALT_FT:set(ALT_FEET % 1000)
	local SMOOTH_RAD_ALT = sensor_data.getRadarAltitude() * 3.28084 
	SMOOTH_RAD_ALT = math.floor(SMOOTH_RAD_ALT / 10 + 0.5) * 10
	parameters.SMOOTH_RAD_ALT:set(SMOOTH_RAD_ALT)




    -- Existing code...
    
    -- Calculate radar altitude rate of change
    local current_rad_alt = parameters.SMOOTH_RAD_ALT:get() or 0
    local current_time = get_absolute_model_time() -- Simulator time in seconds
    local delta_time = current_time - prev_time
    
    if delta_time > 0 then -- Avoid division by zero
        -- Calculate rate (feet per second)
        local raw_rate = (current_rad_alt - prev_rad_alt) / delta_time
        -- Smooth the rate to reduce jitter
        local smoothing_factor = 0.2 -- Adjust between 0.1 (smoother) and 0.5 (more responsive)
        rad_alt_rate = rad_alt_rate + (raw_rate - rad_alt_rate) * smoothing_factor
    end
    
    -- Set parameter (negative when descending)
    parameters.RAD_ALT_RATE:set(rad_alt_rate)
    
    -- Update previous values
    prev_rad_alt = current_rad_alt
    prev_time = current_time
	
	

	

	parameters.RAW_AOA:set(sensor_data.getAngleOfAttack() * 57.2957795) 

	
	

	parameters.CANOPY_LIGHT :set(CANOPY_ARG)
	parameters.CHAFF_LIGHT  :set(CHAFF_ARG)
	parameters.FLARE_LIGHT  :set(FLARE_ARG)
	parameters.SPD_BRK_LIGHT:set(SPD_BRK_ARG)	
	parameters.BINGO_LIGHT  :set(BINGO_ARG)	
	parameters.FLAPS_MOVE   :set(FLAPS_MOVE_ARG)	
	parameters.AAR_LIGHT    :set(AAR_ARG)	
	parameters.L_FIRE_LIGHT :set(L_FIRE_ARG)	
	parameters.R_FIRE_LIGHT :set(R_FIRE_ARG)	
	parameters.L_GEN_OUT    :set(L_GEN_ARG)	
	parameters.R_GEN_OUT    :set(R_GEN_ARG)
	parameters.CAUTION_LIGHT:set(CAUTION_ARG)
	parameters.OIL_LIGHT    :set(OIL_ARG)
	parameters.HYD_LIGHT    :set(HYD_ARG)
	parameters.DAY_NIGHT    :set(day_night)
	

	if parameters.APU_RPM_STATE:get() >= 2 and parameters.MAIN_POWER:get() == 0 then
		parameters.LMFD_BLANK_PAGE:set(0)
		parameters.LMFD_STARTUP_PAGE:set(1)      
		parameters.RMFD_BLANK_PAGE:set(1)     
		parameters.CMFD_BLANK_PAGE:set(1)
		parameters.RUFD_BLANK_PAGE:set(1)
	elseif parameters.APU_RPM_STATE:get() >= 2 and parameters.MAIN_POWER:get() == 1 then
		parameters.LMFD_BLANK_PAGE:set(0)      
		parameters.RMFD_BLANK_PAGE:set(0)     
		parameters.CMFD_BLANK_PAGE:set(0)
		parameters.RUFD_BLANK_PAGE:set(0)
	elseif parameters.MAIN_POWER:get() == 0 then
		parameters.LMFD_BLANK_PAGE:set(0)     
		parameters.RMFD_BLANK_PAGE:set(0)     
		parameters.CMFD_BLANK_PAGE:set(0)
		parameters.RUFD_BLANK_PAGE:set(0)
	end

--UFD SCREEN LOGIC
	if lufd_current_page == 0 and parameters.MAIN_POWER:get() == 1 then --MENU PAGE
        parameters.LUFD_BASE_PAGE:set(1)
        parameters.LUFD_ALERT_PAGE:set(0)
        parameters.LUFD_STATUS_PAGE:set(0)
	elseif lufd_current_page == 1 and (parameters.MAIN_POWER:get() == 1 or parameters.APU_RPM_STATE:get() >= 2) then
		parameters.LUFD_BASE_PAGE:set(0)
        parameters.LUFD_STATUS_PAGE:set(1)
		parameters.LUFD_ALERT_PAGE:set(0)
	elseif lufd_current_page == 2 and (parameters.MAIN_POWER:get() == 1 or parameters.APU_RPM_STATE:get() >= 2) then
		parameters.LUFD_BASE_PAGE:set(0)
        parameters.LUFD_STATUS_PAGE:set(0)
		parameters.LUFD_ALERT_PAGE:set(1)
end

	if parameters.MAIN_POWER:get() == 1 then
		R_UFD_ADI = 1
	end
	parameters.R_ADI_OPACITY:set(R_UFD_ADI)

	-- ALL SCREEN OPACITY LOGIC WITH DAY NIGHT MODE
	--if parameters.MAIN_POWER:get() == 0 and parameters.APU_RPM_STATE:get() >= 2 then
	--	lufd_current_page = 2
	--end 
	if (parameters.MAIN_POWER:get() == 1 or parameters.APU_RPM_STATE:get() >= 2) and parameters.BATTERY_POWER:get() == 1 and day_night == 0 then
		--parameters.LUFD_BASE_PAGE:set(1)
		--parameters.R_ADI_OPACITY:set(R_UFD_ADI)
		parameters.UFD_OPACITY:set(UFD_KNOB)
		parameters.MFD_OPACITY:set(MFD_KNOB)
		parameters.FLOOD_LIGHT:set(FLOOD_KNOB)
		parameters.PANEL_LIGHT:set(CONSOLE_KNOB)     
	elseif (parameters.MAIN_POWER:get() == 1 or parameters.APU_RPM_STATE:get() >= 2) and parameters.BATTERY_POWER:get() == 1 and day_night == 1 then
		--parameters.LUFD_BASE_PAGE:set(1)
		--parameters.R_ADI_OPACITY:set(R_UFD_ADI)
		parameters.UFD_OPACITY:set(UFD_KNOB - 0.9)
		parameters.MFD_OPACITY:set(MFD_KNOB - 0.9)
		parameters.FLOOD_LIGHT:set(FLOOD_KNOB)
		parameters.PANEL_LIGHT:set(CONSOLE_KNOB)
	elseif parameters.MAIN_POWER:get() == 0 or parameters.APU_RPM_STATE:get() <= 1.9 then
		parameters.UFD_OPACITY:set(0)
		parameters.MFD_OPACITY:set(0)
		parameters.FLOOD_LIGHT:set(0)
		parameters.PANEL_LIGHT:set(0)
	end


	-- ADI page
	if  parameters.MAIN_POWER:get() == 0 then
		parameters.R_ADI_OPACITY:set(0)
		parameters.PMFD_MASK:set(0)
		parameters.LMFD_MASK:set(0)
		parameters.RMFD_MASK:set(0)
	end	


	--APU SPOOL
	if parameters.APU_POWER:get() == 0 and parameters.APU_RPM_STATE:get() > 0.10 and parameters.APU_RPM_STATE:get() < 3.80 then
		parameters.APU_SPOOL:set(1)
		parameters.APU_READY:set(0)
		--print_message_to_user("APU SPOOLING UP")
	elseif parameters.APU_POWER:get() == 1 and parameters.APU_RPM_STATE:get() > 0.10 and parameters.APU_RPM_STATE:get() < 3.80 then
		parameters.APU_SPOOL:set(1)
		parameters.APU_READY:set(0)
		--print_message_to_user("APU SPOOLING DOWN")			
	elseif parameters.APU_POWER:get() == 1 then
		parameters.APU_SPOOL:set(0)	
		parameters.APU_READY:set(1)
		--print_message_to_user("APU READY")
	else 
		parameters.APU_SPOOL:set(0)
		parameters.APU_READY:set(0)
	end
	--GEN OUT LIGHT FORCE
	if parameters.L_GEN_POWER:get() == 0 and parameters.RPM_L:get() >= 40 and sensor_data.getWOW_NoseLandingGear() == 1 then
		parameters.L_GEN_OUT:set(1)
		parameters.CAUTION_LIGHT:set(1)
	end
	--GEN OUT LIGHT FORCE
	if parameters.R_GEN_POWER:get() == 0 and parameters.RPM_R:get() >= 40 and sensor_data.getWOW_NoseLandingGear() == 1 then
		parameters.R_GEN_OUT:set(1)
		parameters.CAUTION_LIGHT:set(1)
	end
	--HYD LIGHT FORCE
	if parameters.L_HYD_COLOR:get() == 1 or parameters.R_HYD_COLOR:get() == 1 then
		parameters.HYD_LIGHT:set(1)
		parameters.CAUTION_LIGHT:set(1)
	end
	--OIL LIGHT FORCE
	if parameters.L_OIL_COLOR:get() == 1 or parameters.R_OIL_COLOR:get() == 1 then
		parameters.OIL_LIGHT:set(1)
		parameters.CAUTION_LIGHT:set(1)
	end
	--CANOPY MASTER CAUTION FORCE
	if parameters.CANOPY_LIGHT:get() == 1 then
		parameters.CAUTION_LIGHT:set(1)
	end
	
	--Switch to warning page
	if (parameters.BINGO_LIGHT:get() > 0 or parameters.L_FIRE_LIGHT:get() > 0 or parameters.R_FIRE_LIGHT:get() > 0 or parameters.L_GEN_OUT:get() > 0 or parameters.R_GEN_OUT:get() > 0 or parameters.CAUTION_LIGHT:get() > 0 or parameters.OIL_LIGHT:get() > 0 or parameters.HYD_LIGHT:get() > 0) then
		check_engine_light = 1
	else
		check_engine_light = 0
	end
	parameters.CHECK_ENGINE_LIGHT:set(check_engine_light)

	last_ufd_page = last_ufd_page or lufd_current_page or 0
	if check_engine_light == 1 then
		if alert_count == 0 then
			last_ufd_page = lufd_current_page
			lufd_current_page = 2
			alert_count = 1
		end
	else
		if lufd_current_page == 2 then
			lufd_current_page = last_ufd_page or 0
		end
		alert_count = 0
		last_ufd_page = nil
	end
	
	
	-- UFD power knob (used for opacity/brightness issues)
	if UFD_KNOB == 0 then

		parameters.R_ADI_OPACITY:set(0)
		parameters.CANOPY_LIGHT:set(0)
		parameters.CHAFF_LIGHT:set(0)
		parameters.FLARE_LIGHT:set(0)
		parameters.SPD_BRK_LIGHT:set(0)	
		parameters.BINGO_LIGHT:set(0)	
		parameters.FLAPS_DOWN:set(0)	
		parameters.FLAPS_MOVE:set(0)	
		parameters.AAR_LIGHT:set(0)	
		parameters.L_FIRE_LIGHT:set(0)	
		parameters.R_FIRE_LIGHT:set(0)	
		parameters.L_GEN_OUT:set(0)	
		parameters.R_GEN_OUT:set(0)
		parameters.CAUTION_LIGHT:set(0)
		parameters.OIL_LIGHT:set(0)
		parameters.HYD_LIGHT:set(0)	
		parameters.LUFD_BASE_PAGE:set(0)
        parameters.LUFD_STATUS_PAGE:set(0)
		parameters.LUFD_ALERT_PAGE:set(0)
	end
	if MFD_KNOB == 0 then
		parameters.LMFD_MASK:set(0)
		parameters.RMFD_MASK:set(0)
		parameters.PMFD_MASK:set(0)
	end
	if parameters.BATTERY_POWER:get() == 0 then
		parameters.R_ADI_OPACITY:set(0)
		parameters.UFD_OPACITY:set(0)
		parameters.MFD_OPACITY:set(0)
		parameters.FLOOD_LIGHT:set(0)
		parameters.PANEL_LIGHT:set(0)
		parameters.ICP_OPACITY:set(0)
		parameters.HUD_OPACITY:set(0)
	end
	
	local HUD_KNOB = get_cockpit_draw_argument_value(918)

	parameters.HUD_OPACITY:set(HUD_KNOB)
	parameters.ICP_OPACITY:set(HUD_KNOB)
	
	
	--HMD Logic
		
	local hmd_hudview = 1 

	if hmd_horizontal >= -12 and hmd_horizontal <= 12 and hmd_vertical <= 8 then
		hmd_hudview = 0
	end
	parameters.HMD_HUDVIEW:set(hmd_hudview)
	parameters.HMD_HORIZONTAL:set(hmd_horizontal)
	
	hmd_heading = (true_heading - hmd_horizontal) % 360
	parameters.HMD_HEADING:set(hmd_heading)
	
	
	--status page params

	
	local function calculateGunPiper()
    local muzzle_velocity = 1035 -- m/s for M61A2 Vulcan
    local g = 9.81 -- m/s²
    local tas_ms = sensor_data.getTrueAirSpeed() or 0 -- m/s
    local fpa_deg = parameters.FPA:get() or 0 -- Flight path angle in degrees
    local slip_deg = parameters.SLIP2:get() or 0 -- Sideslip in degrees
    local rad_alt_m = sensor_data.getRadarAltitude() or 100 -- meters
    local pitch_rate = parameters.PITCHRATE:get() or 0 -- Pitch rate in deg/s

    -- Default values
    local piper_x = 0
    local piper_y = 0

    -- Check if cannon is active and HUD is powered
    local function calculateGunPiper()
    local pitch_rate = parameters.PITCHRATE:get() or 0 -- Pitch rate in deg/s
    local slip_deg = parameters.SLIP2:get() or 0 -- Sideslip in degrees

    -- Default values
    local piper_x = 0
    local piper_y = 0

    -- Check if cannon is active and HUD is powered
    if parameters.CANNON_ACTIVE:get() == 1 and parameters.MAIN_POWER:get() == 1 then
        -- Piper Y: Move up/down based on pitch rate
        piper_y = -pitch_rate * 0.05 -- Negative to move up when pitching up

        -- Piper X: Move left/right based on slip
        piper_x = slip_deg * 0.05 -- Positive slip moves right

        -- Scale to HUD units (matches your 0.25 scaling in HUD)
        local hud_scale = 0.25 -- Matches HUD controller scaling
        piper_x = piper_x * hud_scale
        piper_y = piper_y * hud_scale
    end

    -- Set parameters
    parameters.GUN_PIPER_X:set(piper_x)
    parameters.GUN_PIPER_Y:set(piper_y)
end

    -- Set parameters
    parameters.GUN_PIPER_X:set(piper_x)
    parameters.GUN_PIPER_Y:set(piper_y)
end
	
	calculateGunPiper()

end



need_to_be_closed = false