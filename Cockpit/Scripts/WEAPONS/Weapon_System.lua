local dev = GetSelf()
local weapon_system = GetSelf()

dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")

local update_time_step = 0.006
make_default_activity(update_time_step)

local sensor_data		= get_base_data()

	local parameters =
		{

			APU_POWER			= get_param_handle("APU_POWER"),
			BATTERY_POWER		= get_param_handle("BATTERY_POWER"),
			MAIN_POWER			= get_param_handle("MAIN_POWER"),
			BAY_OPTION			= get_param_handle("BAY_OPTION"),
			ARM_STATUS			= get_param_handle("ARM_STATUS"), 
			GROUND_ORIDE        = get_param_handle("GROUND_ORIDE"),
			ORIDE_X				= get_param_handle("ORIDE_X"),
			ORIDE_TEXT			= get_param_handle("ORIDE_TEXT"),
			BAY_L_ARG			= get_param_handle("BAY_L_ARG"),
			BAY_R_ARG			= get_param_handle("BAY_R_ARG"),
			BAY_C_ARG			= get_param_handle("BAY_C_ARG"),
			LMFD_PAGE           = get_param_handle("LMFD_PAGE"),
			BAY_STATION         = get_param_handle("BAY_STATION"),
			AIR_ORIDE			= get_param_handle("AIR_ORIDE"),
			MASTER_ARM			= get_param_handle("MASTER_ARM"),
			DOGFIGHT			= get_param_handle("DOGFIGHT"),
			HUD_MODE			= get_param_handle("HUD_MODE"),
			GROUND_POWER		= get_param_handle("GROUND_POWER"),
			WoW				    = get_param_handle("WoW"),
			DETENT				= get_param_handle("DETENT"),
			PICKLE				= get_param_handle("PICKLE"),
			CANNON_ACTIVE		= get_param_handle("CANNON_ACTIVE"),
			WoW					= get_param_handle("WoW"),
			L_BAY	  			= get_param_handle("L_BAY"),			
			C_BAY	  			= get_param_handle("C_BAY"),			
			R_BAY	  			= get_param_handle("R_BAY"),		

		}



--[[
--avSimpleWeaponSystem--
drop_chaff 
drop_flare 
emergency_jettison 
emergency_jettison_rack 
get_chaff_count 
get_ECM_status 
get_flare_count 
get_station_info 
get_target_range 
get_target_span 
get_weapon_count 
launch_station 
select_station 
set_ECM_status 
set_target_range 
set_target_span 
]]



-- local PickleON 						= Keys.PlanePickleOn
-- local PickleOFF 						= Keys.PlanePickleOff
local PickleON 							= 350
local PickleOFF 						= 351

local PlaneFire							= Keys.PlaneFire
local PlaneFireOff						= Keys.PlaneFireOff



local PlaneChangeWeapon 				= Keys.PlaneChangeWeapon --D keybind
local PlaneModeCannon					= 113-- C Keybind
--modes
local PlaneModeNAV 						= Keys.PlaneModeNAV	--1						
local PlaneModeBVR 						= Keys.PlaneModeBVR	--2						
local PlaneModeVS 						= Keys.PlaneModeVS --3								
local PlaneModeBore 					= Keys.PlaneModeBore --4
local PlaneModeFI0 						= Keys.PlaneModeFI0 --6
--rwr
-- local PlaneThreatWarnSoundVolumeDown 	= 409
-- local PlaneThreatWarnSoundVolumeUp 		= 410
--jettison
local PlaneJettisonWeapons 				= Keys.PlaneJettisonWeapons
local PlaneJettisonFuelTanks 			= Keys.PlaneJettisonFuelTanks




-- weapon_system:listen_command(PlaneThreatWarnSoundVolumeDown)
-- weapon_system:listen_command(PlaneThreatWarnSoundVolumeUp)
-- weapon_system:listen_command(L_OSB_7)
-- weapon_system:listen_command(10000)--Left Bay Select
-- weapon_system:listen_command(10001)--Right Bay Select
-- weapon_system:listen_command(10002)--Center Bay Select
-- weapon_system:listen_command(10003)--All Bay Select
-- weapon_system:listen_command(10004)--Step Select

weapon_system:listen_command(PickleON)
weapon_system:listen_command(PickleOFF)
weapon_system:listen_command(PlaneFire)
weapon_system:listen_command(PlaneFireOff)
weapon_system:listen_command(PlaneChangeWeapon)
weapon_system:listen_command(PlaneModeNAV)
weapon_system:listen_command(PlaneModeBVR)
weapon_system:listen_command(PlaneModeVS)
weapon_system:listen_command(PlaneModeBore)
weapon_system:listen_command(PlaneModeFI0)
weapon_system:listen_command(PlaneModeCannon) --113
weapon_system:listen_command(PlaneJettisonWeapons)
weapon_system:listen_command(PlaneJettisonFuelTanks)




weapon_system:listen_command(10006)--Weapon Bay Air Override
weapon_system:listen_command(10024)--Weapon Bay Air Override
weapon_system:listen_command(10007)--Master Arm
weapon_system:listen_command(10008)--Master Arm Toggle
weapon_system:listen_command(10021)--First Detent
weapon_system:listen_command(10022)--Second Detent
weapon_system:listen_command(10026)--PICKLE
weapon_system:listen_command(10161)--Cannon Select





local master_arm_switch = device_commands.Button_1 --track mouse clicks
weapon_system:listen_command(master_arm_switch)
local emer_jet = device_commands.Button_2 --track mouse clicks
weapon_system:listen_command(emer_jet)


local weapon_release_state 	= 0 --track if you press weapon release
local master_arm_state		= 0 --track if master arm switch is ON
local mode_state 			= 0 --default NAV mode
--local ground_override		= 0

local bay_air_state			= 0
local dogfight_mode			= 0
local first_state		    = 0
local fire_z_weapons 		= 0
local air_oride				= 0
local detent_pos			= 0
local pickle_pos			= 0
local cannon_select			= 0
local fox2_select			= 0
local fox3_select			= 0


------------------------------------------------------------------FUNCTION-POSTINIT---------------------------------------------------------------------------------------------------

function post_initialize()

	
	local bay_option_state = get_aircraft_property("BAY_DOOR_OPTION")--ME Option Box
	local birth = LockOn_Options.init_conditions.birth_place
		
	if birth == "GROUND_COLD" then
		master_arm_state = 0
		parameters.BAY_OPTION:set(bay_option_state) -- Unchecked = 0 Checked = 1	
	elseif birth == "GROUND_HOT" or birth == "AIR_HOT" then
		master_arm_state = 0
		parameters.BAY_OPTION:set(1)
	end
	
	--Bay Arg Preset
	if bay_option_state == 0 then
		--parameters.GROUND_ORIDE:set(1)
		set_aircraft_draw_argument_value(600,1)
		set_aircraft_draw_argument_value(601,1)
		set_aircraft_draw_argument_value(602,1)
	elseif bay_option_state == 1 then
		parameters.GROUND_ORIDE:set(0)
		set_aircraft_draw_argument_value(600,0)
		set_aircraft_draw_argument_value(601,0)
		set_aircraft_draw_argument_value(602,0)
	end
	
end
------------------------------------------------------------------FUNCTION-SETCOMMAND---------------------------------------------------------------------------------------------------
function SetCommand(command,value)

	

	--WEP JET
	if command == PlaneJettisonFuelTanks and parameters.WoW:get() == 0 then
					weapon_system:emergency_jettison()
		end
--[[
	if command == iCommandPlaneJettisonFuelTanks then
		for i=1, num_stations, 1 do
			local station = WeaponSystem:get_station_info(i-1)
			
			if station.count > 0 and station.weapon.level3 == wsType_FuelTank then
				WeaponSystem:emergency_jettison(i-1)
			end
        end
	end
]]	

	
	--Air Override
	if (command == 10006 or command == 10024) and air_oride == 0 and parameters.MAIN_POWER:get() == 1 then
		air_oride = 1
	elseif (command == 10006 or command == 10024) and air_oride == 1 and parameters.MAIN_POWER:get() == 1 then
		air_oride = 0
	end





	--[[
	--Mode States
	if command == PlaneModeNAV then
		mode_state = 1
		--print_message_to_user("NAV MODE")
	elseif command == PlaneModeBVR then
		mode_state = 2
		--print_message_to_user("BVR MODE")
	elseif command == PlaneModeVS then
		mode_state = 3
		--print_message_to_user("VS MODE")
	elseif command == PlaneModeBore then
		mode_state = 4
		--print_message_to_user("BORE MODE")
	elseif command == PlaneModeFI0 then
		mode_state = 6
		--print_message_to_user("FLOOD MODE")
	end					
]]

	--Master Arm JOYSTICK/KEYBOARD BINDS
	if (command == 10007 or command == 10008 or command == master_arm_switch) and master_arm_state == 0 and parameters.WoW:get() == 0 then
		master_arm_state = 1
		--print_message_to_user("MASTER ARM ON")
	elseif (command == 10007 or command == 10008 or command == master_arm_switch) and master_arm_state == 1 then
		master_arm_state = 0
		cannon_select = 0
		--print_message_to_user("MASTER ARM OFF")
	end		
	-- --Bay Doors Open Close
	-- if command == PickleON and weapon_release_state == 0 then
	-- 	weapon_release_state = 1
	-- 	--print_message_to_user("COMMAND DEPRESS")
	-- elseif command == PickleOFF and weapon_release_state == 1 then
	-- 	weapon_release_state = 0
	-- 	--print_message_to_user("COMMAND RELEASE")
	-- end	
	
	--Bay Doors Open Close
	if command == 10026 and master_arm_state == 0 and pickle_pos < 1 then
		pickle_pos = 1
		--print_message_to_user("button moves in Doesnt fire")
	elseif command == 10026 and master_arm_state == 0 and pickle_pos > 0  then
		pickle_pos = 0
		--print_message_to_user("button moves out Doesnt fire")
	elseif command == 10026 and weapon_release_state == 0 and master_arm_state == 1 then
		weapon_release_state = 1
		pickle_pos = 1
		dispatch_action(nil,PickleON)
		--print_message_to_user("COMMAND DEPRESS")
	elseif command == 10026 and weapon_release_state == 1 then
		weapon_release_state = 0
		pickle_pos = 0
		dispatch_action(nil,PickleOFF)
		--print_message_to_user("COMMAND RELEASE")
	end	

	--Dogfight Mode
	-- if command == 10005 and dogfight_mode == 0 then
	-- 	dogfight_mode = 1
	-- 	print_message_to_user("DOGFIGHT MODE ON")
	-- elseif command == 10005 and dogfight_mode == 1 then
	-- 	dogfight_mode = 0
	-- 	print_message_to_user("DOGFIGHT MODE OFF")
	-- end	

	--Weapon Select
	if (command == 10161 or command == 10005) and master_arm_state == 1 then
		cannon_select = 1
	end

--Cannon Fire Logic

	if cannon_select == 1 then
		--First Trigger Detent
		if command == 10021 and first_state == 0 and parameters.MAIN_POWER:get() == 1 and master_arm_state == 1 then
			first_state = 1
			detent_pos = 0.50
			--print_message_to_user("FIRST DETENT")
		elseif command == 10021 and first_state == 1 and parameters.MAIN_POWER:get() == 1 and master_arm_state == 1 then
			first_state = 0
			detent_pos = 0
		end
		--Second Trigger Detent
		if command == 10022 and fire_z_weapons == 0 and parameters.MAIN_POWER:get() == 1 and master_arm_state == 1 then
			fire_z_weapons = 1
			detent_pos = 1
			dispatch_action(nil,PlaneFire)
			--print_message_to_user("FIRE CANNON")
		elseif command == 10022 and fire_z_weapons == 1 and parameters.MAIN_POWER:get() == 1 and master_arm_state == 1 then
			fire_z_weapons = 0
			detent_pos = 0.50
			dispatch_action(nil,PlaneFireOff)

		end	
	end



end

------------------------------------------------------------------FUNCTION-UPDATE---------------------------------------------------------------------------------------------------
function update()

--BAY DOOR LOGIC

	local center_door_pos   = get_aircraft_draw_argument_value(600)
	local left_door_pos  = get_aircraft_draw_argument_value(601)
	local right_door_pos = get_aircraft_draw_argument_value(602)
	local canon_door_pos = get_aircraft_draw_argument_value(614)
	local canon_rotate   = get_aircraft_draw_argument_value(615)

	local left_door_pos_gpu  = get_aircraft_draw_argument_value(601)
	--LEFT BAY Ground Power
	--[[
	if parameters.GROUND_POWER:get() == 1 and left_door_pos_gpu <= 1 and parameters.GROUND_ORIDE:get() == 0 and parameters.WoW:get() == 1 then
		left_door_pos_gpu = left_door_pos_gpu + 0.005
		set_aircraft_draw_argument_value(601, left_door_pos_gpu)
	elseif parameters.GROUND_POWER:get() == 0 and left_door_pos_gpu >= 0 and parameters.GROUND_ORIDE:get() == 0 and parameters.WoW:get() == 1 then
		left_door_pos_gpu = left_door_pos_gpu - 0.005
		set_aircraft_draw_argument_value(601, left_door_pos_gpu)
	end
]]
---------BAY LOGIC

	--On Ground
	if parameters.WoW:get() == 1 and parameters.MAIN_POWER:get() == 1 then
        -- Left Bay
        if parameters.L_BAY:get() == 1 and left_door_pos < 1 then
            left_door_pos = left_door_pos + 0.000681818 -- ~1s animation
        elseif parameters.L_BAY:get() == 0 and left_door_pos > 0 then
            left_door_pos = left_door_pos - 0.000681818
        end
        -- Right Bay
        if parameters.R_BAY:get() == 1 and right_door_pos < 1 then
            right_door_pos = right_door_pos + 0.000681818
        elseif parameters.R_BAY:get() == 0 and right_door_pos > 0 then
            right_door_pos = right_door_pos - 0.000681818
        end
        -- Center Bay
        if parameters.C_BAY:get() == 1 and center_door_pos < 1 then
            center_door_pos = center_door_pos + 0.000902
        elseif parameters.C_BAY:get() == 0 and center_door_pos > 0 then
            center_door_pos = center_door_pos - 0.000902
        end
    end

	--Air Override
	if parameters.WoW:get() == 0 and parameters.MAIN_POWER:get() == 1 and parameters.AIR_ORIDE:get() == 1 then
        -- Left Bay
        if parameters.L_BAY:get() == 1 and left_door_pos < 1 then
            left_door_pos = left_door_pos + 0.000681818 -- ~1s animation
        elseif parameters.L_BAY:get() == 0 and left_door_pos > 0 then
            left_door_pos = left_door_pos - 0.000681818
        end
        -- Right Bay
        if parameters.R_BAY:get() == 1 and right_door_pos < 1 then
            right_door_pos = right_door_pos + 0.000681818
        elseif parameters.R_BAY:get() == 0 and right_door_pos > 0 then
            right_door_pos = right_door_pos - 0.000681818
        end
        -- Center Bay
        if parameters.C_BAY:get() == 1 and center_door_pos < 1 then
            center_door_pos = center_door_pos + 0.000902
        elseif parameters.C_BAY:get() == 0 and center_door_pos > 0 then
            center_door_pos = center_door_pos - 0.000902
        end
    end


	center_door_pos = math.max(0, math.min(1, center_door_pos))
    left_door_pos = math.max(0, math.min(1, left_door_pos))
    right_door_pos = math.max(0, math.min(1, right_door_pos))
    
    set_aircraft_draw_argument_value(600, center_door_pos)
    set_aircraft_draw_argument_value(601, left_door_pos)
    set_aircraft_draw_argument_value(602, right_door_pos)

    parameters.BAY_C_ARG:set(center_door_pos)
    parameters.BAY_L_ARG:set(left_door_pos)
    parameters.BAY_R_ARG:set(right_door_pos)

	

	--ORIDE TEXT
	if parameters.WoW:get() == 0 and parameters.AIR_ORIDE:get() == 0 then
		parameters.ORIDE_TEXT:set(0)
	elseif parameters.WoW:get() == 0 and parameters.AIR_ORIDE:get() == 1 then
		parameters.ORIDE_TEXT:set(1)
	end

	
	
	-- ARMED TEXT
	if parameters.WoW:get() == 1 then
		parameters.ARM_STATUS:set(2)
	elseif master_arm_state == 1 and parameters.WoW:get() == 0 then
		parameters.ARM_STATUS:set(1)
	elseif master_arm_state == 0 and parameters.WoW:get() == 0 then
		parameters.ARM_STATUS:set(0)
	end
	
	
	
	
	--FIX THIS
	--[[
	--WEAPON BAY FIRE ANIMATIONS BAY STATION 1-left 2-center 3-right 4-all
		--ALL BAY ORIDE
		if air_oride == 1 and parameters.BAY_STATION:get() == 4 and master_arm_state == 1 and center_door_pos <= 1 and parameters.MAIN_POWER:get() == 1 and parameters.WoW:get() == 0 then
			left_door_pos = left_door_pos + 0.05
			right_door_pos = right_door_pos + 0.05
			center_door_pos = center_door_pos + 0.05
			set_aircraft_draw_argument_value(600, center_door_pos)
			set_aircraft_draw_argument_value(601, left_door_pos)
			set_aircraft_draw_argument_value(602, right_door_pos)
		end
		--ALL BAY
		if weapon_release_state == 1 and air_oride == 0 and parameters.BAY_STATION:get() == 4 and master_arm_state == 1 and right_door_pos <= 1 and parameters.MAIN_POWER:get() == 1 and parameters.WoW:get() == 0 then
			left_door_pos = left_door_pos + 0.05
			right_door_pos = right_door_pos + 0.05
			center_door_pos = center_door_pos + 0.05
			set_aircraft_draw_argument_value(600, center_door_pos)
			set_aircraft_draw_argument_value(601, left_door_pos)
			set_aircraft_draw_argument_value(602, right_door_pos)
		end
		--CENTER BAY AIR ORIDE
		if air_oride == 1 and parameters.BAY_STATION:get() == 2 and master_arm_state == 1 and center_door_pos <= 1 and parameters.MAIN_POWER:get() == 1 and parameters.WoW:get() == 0 then
			center_door_pos = center_door_pos + 0.05
			set_aircraft_draw_argument_value(600, center_door_pos)
		elseif air_oride == 0 and parameters.MAIN_POWER:get() == 1 and center_door_pos >= 0 and parameters.WoW:get() == 0 then
			center_door_pos = center_door_pos
			set_aircraft_draw_argument_value(600, center_door_pos)
		end
		--CENTER BAY
		if weapon_release_state == 1 and air_oride == 0 and parameters.BAY_STATION:get() == 2 and master_arm_state == 1 and center_door_pos <= 1 and parameters.MAIN_POWER:get() == 1 and parameters.WoW:get() == 0 then
			center_door_pos = center_door_pos + 0.05
			set_aircraft_draw_argument_value(600, center_door_pos)
		elseif weapon_release_state == 0 and air_oride == 0 and parameters.MAIN_POWER:get() == 1 and center_door_pos >= 0 and parameters.WoW:get() == 0 then
			center_door_pos = center_door_pos - 0.05
			set_aircraft_draw_argument_value(600, center_door_pos)
		end
		--LEFT BAY ORIDE
		if air_oride == 1 and parameters.BAY_STATION:get() == 1 and master_arm_state == 1 and left_door_pos <= 1 and parameters.MAIN_POWER:get() == 1 and parameters.WoW:get() then
			left_door_pos = left_door_pos + 0.05
			set_aircraft_draw_argument_value(601, left_door_pos)
		elseif air_oride == 0 and parameters.MAIN_POWER:get() == 1 and left_door_pos >= 0 and parameters.WoW:get() == 0 and parameters.GROUND_POWER:get() == 0 then
			left_door_pos = left_door_pos
			set_aircraft_draw_argument_value(601, left_door_pos)
		end
		--LEFT BAY
		if weapon_release_state == 1 and air_oride == 0 and parameters.BAY_STATION:get() == 1 and master_arm_state == 1 and left_door_pos <= 1 and parameters.MAIN_POWER:get() == 1 and parameters.WoW:get() == 0 then
			left_door_pos = left_door_pos + 0.05
			set_aircraft_draw_argument_value(601, left_door_pos)
		elseif weapon_release_state == 0 and air_oride == 0 and parameters.MAIN_POWER:get() == 1 and left_door_pos >= 0 and parameters.WoW:get() == 0 then
			left_door_pos = left_door_pos - 0.05
			set_aircraft_draw_argument_value(601, left_door_pos)
		end
		--RIGHT BAY ORIDE
		if air_oride == 1 and parameters.BAY_STATION:get() == 3 and master_arm_state == 1 and right_door_pos <= 1 and parameters.MAIN_POWER:get() == 1 and parameters.WoW:get() == 0 then
			right_door_pos = right_door_pos + 0.05
			set_aircraft_draw_argument_value(602, right_door_pos)
		elseif air_oride == 0 and parameters.MAIN_POWER:get() == 1 and right_door_pos >= 0 and parameters.WoW:get() == 0 then
			right_door_pos = right_door_pos
			set_aircraft_draw_argument_value(602, right_door_pos)
		end
		--RIGHT BAY
		if weapon_release_state == 1 and air_oride == 0 and parameters.BAY_STATION:get() == 3 and master_arm_state == 1 and right_door_pos <= 1 and parameters.MAIN_POWER:get() == 1 and parameters.WoW:get() == 0 then
			right_door_pos = right_door_pos + 0.05
			set_aircraft_draw_argument_value(602, right_door_pos)
		elseif weapon_release_state == 0 and air_oride == 0 and parameters.MAIN_POWER:get() == 1 and right_door_pos >= 0 and parameters.WoW:get() == 0 then
			right_door_pos = right_door_pos - 0.05
			set_aircraft_draw_argument_value(602, right_door_pos)
		end
	
]]
		--First Detent CAnon Door
		if first_state == 1 and master_arm_state == 1 and canon_door_pos <= 1 and parameters.MAIN_POWER:get() == 1 and parameters.WoW:get() == 0 then
			canon_door_pos = canon_door_pos + 0.0900
			set_aircraft_draw_argument_value(614, canon_door_pos)
		elseif first_state == 0 and master_arm_state == 1 and canon_door_pos >= 0 and parameters.MAIN_POWER:get() == 1 and parameters.WoW:get() == 0 then
			canon_door_pos = canon_door_pos - 0.0900
			set_aircraft_draw_argument_value(614, canon_door_pos)
		end
		if fire_z_weapons == 1 and master_arm_state == 1 and canon_door_pos <= 1 and parameters.MAIN_POWER:get() == 1 and parameters.WoW:get() == 0 then
			canon_door_pos = canon_door_pos + 1--0.0900
			set_aircraft_draw_argument_value(614, canon_door_pos)

		end
		--Canon Timer
		if first_state == 1 and master_arm_state == 1 and parameters.MAIN_POWER:get() == 1 and canon_rotate < 1 then
			canon_rotate = (canon_rotate + update_time_step * 2)
			set_aircraft_draw_argument_value(615, canon_rotate)
		elseif first_state == 1 and master_arm_state == 1 and parameters.MAIN_POWER:get() == 1 and canon_rotate > 1 then
			canon_rotate = 0
			set_aircraft_draw_argument_value(615, canon_rotate)
		elseif fire_z_weapons == 1 and master_arm_state == 1 and parameters.MAIN_POWER:get() == 1 and canon_rotate < 1 then
			canon_rotate = (canon_rotate + update_time_step * 2)
			set_aircraft_draw_argument_value(615, canon_rotate)
		elseif fire_z_weapons == 1 and master_arm_state == 1 and parameters.MAIN_POWER:get() == 1 and canon_rotate > 1 then
			canon_rotate = 0
			set_aircraft_draw_argument_value(615, canon_rotate)
		end
		--CANON FIRE
		--if fire_z_weapons == 1 and master_arm_state == 1 then
		--	dispatch_action(nil,PlaneFire)
		--end


-----------------------------------------------------------------------
	parameters.BAY_C_ARG:set(center_door_pos)
	parameters.BAY_L_ARG:set(left_door_pos)
	parameters.BAY_R_ARG:set(right_door_pos)

	parameters.MASTER_ARM:set(master_arm_state)
	parameters.DOGFIGHT:set(dogfight_mode)
	--parameters.AIR_ORIDE:set(air_oride)
	parameters.HUD_MODE:set(mode_state)
	parameters.DETENT:set(detent_pos)
	parameters.PICKLE:set(pickle_pos)
	
	parameters.CANNON_ACTIVE:set(cannon_select)

end

need_to_be_closed = false

----Ref
--[[
getAngleOfAttack
getAngleOfSlide
getBarometricAltitude
getCanopyPos
getCanopyState
getEngineLeftFuelConsumption
getEngineLeftRPM
getEngineLeftTemperatureBeforeTurbine
getEngineRightFuelConsumption
getEngineRightRPM
getEngineRightTemperatureBeforeTurbine
getFlapsPos
getFlapsRetracted
getHeading
getHelicopterCollective
getHelicopterCorrection
getHorizontalAcceleration
getIndicatedAirSpeed
getLandingGearHandlePos
getLateralAcceleration
getLeftMainLandingGearDown
getLeftMainLandingGearUp
getMachNumber
getMagneticHeading
getNoseLandingGearDown
getNoseLandingGearUp
getPitch
getRadarAltitude
getRateOfPitch
getRateOfRoll
getRateOfYaw
getRightMainLandingGearDown
getRightMainLandingGearUp
getRoll
getRudderPosition
getSpeedBrakePos
getStickPitchPosition
getStickRollPosition
getThrottleLeftPosition
getThrottleRightPosition
getTotalFuelWeight
getTrueAirSpeed
getVerticalAcceleration
getVerticalVelocity
getWOW_LeftMainLandingGear
getWOW_NoseLandingGear
getWOW_RightMainLandingGear
]]