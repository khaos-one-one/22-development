dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")

local dev = GetSelf()
local sensor_data		= get_base_data()

local update_time_step = 0.006 --0.006
make_default_activity(update_time_step)

local LMFD = {
    L_OSB_1           = device_commands.Button_1, 
    L_OSB_2           = device_commands.Button_2, 
    L_OSB_3           = device_commands.Button_3, 
    L_OSB_4           = device_commands.Button_4, 
    L_OSB_5           = device_commands.Button_5, 
    L_OSB_6           = device_commands.Button_6, 
    L_OSB_7           = device_commands.Button_7, 
    L_OSB_8           = device_commands.Button_8, 
    L_OSB_9           = device_commands.Button_9,
    L_OSB_10          = device_commands.Button_10, 
    L_OSB_11          = device_commands.Button_11, 
    L_OSB_12          = device_commands.Button_12, 
    L_OSB_13          = device_commands.Button_13,
    L_OSB_14          = device_commands.Button_14, 
    L_OSB_15          = device_commands.Button_15, 
    L_OSB_16          = device_commands.Button_16, 
    L_OSB_17          = device_commands.Button_17, 
    L_OSB_18          = device_commands.Button_18,
    L_OSB_19          = device_commands.Button_19,
    L_OSB_20          = device_commands.Button_20,
}
local RMFD = {
    R_OSB_1           = device_commands.Button_21, 
    R_OSB_2           = device_commands.Button_22, 
    R_OSB_3           = device_commands.Button_23, 
    R_OSB_4           = device_commands.Button_24, 
    R_OSB_5           = device_commands.Button_25, 
    R_OSB_6           = device_commands.Button_26, 
    R_OSB_7           = device_commands.Button_27, 
    R_OSB_8           = device_commands.Button_28, 
    R_OSB_9           = device_commands.Button_29,
    R_OSB_10          = device_commands.Button_30, 
    R_OSB_11          = device_commands.Button_31, 
    R_OSB_12          = device_commands.Button_32, 
    R_OSB_13          = device_commands.Button_33,
    R_OSB_14          = device_commands.Button_34, 
    R_OSB_15          = device_commands.Button_35, 
    R_OSB_16          = device_commands.Button_36, 
    R_OSB_17          = device_commands.Button_37, 
    R_OSB_18          = device_commands.Button_38,
    R_OSB_19          = device_commands.Button_39,
    R_OSB_20          = device_commands.Button_40,
}
local CMFD = {
    C_OSB_1           = device_commands.Button_41, 
    C_OSB_2           = device_commands.Button_42, 
    C_OSB_3           = device_commands.Button_43, 
    C_OSB_4           = device_commands.Button_44, 
    C_OSB_5           = device_commands.Button_45, 
    C_OSB_6           = device_commands.Button_46, 
    C_OSB_7           = device_commands.Button_47, 
    C_OSB_8           = device_commands.Button_48, 
    C_OSB_9           = device_commands.Button_49,
    C_OSB_10          = device_commands.Button_50, 
    C_OSB_11          = device_commands.Button_51, 
    C_OSB_12          = device_commands.Button_52, 
    C_OSB_13          = device_commands.Button_53,
    C_OSB_14          = device_commands.Button_54, 
    C_OSB_15          = device_commands.Button_55, 
    C_OSB_16          = device_commands.Button_56, 
    C_OSB_17          = device_commands.Button_57, 
    C_OSB_18          = device_commands.Button_58,
    C_OSB_19          = device_commands.Button_59,
    C_OSB_20          = device_commands.Button_60,
}
local parameters = {
    APU_RPM_STATE		      = get_param_handle("APU_RPM_STATE"),
    MAIN_POWER		          = get_param_handle("MAIN_POWER"),
    MFD_OPACITY		          = get_param_handle("MFD_OPACITY"),
    GROUND_ORIDE              = get_param_handle("GROUND_ORIDE"),
	AIR_ORIDE				  = get_param_handle("AIR_ORIDE"),
    BAY_OPTION                = get_param_handle("BAY_OPTION"),
	L_BAY	  				  = get_param_handle("L_BAY"),			
	C_BAY	  				  = get_param_handle("C_BAY"),			
	R_BAY	  				  = get_param_handle("R_BAY"),			
	WoW						  = get_param_handle("WoW"),
    RPM_L                     = get_param_handle("RPM_L"),
    COORD                     = get_param_handle("COORD"),
    RPM_R                     = get_param_handle("RPM_R"),
    EGT_L                     = get_param_handle("EGT_L"),
    EGT_R                     = get_param_handle("EGT_R"),
    OIL_L                     = get_param_handle("OIL_L"),
    OIL_R                     = get_param_handle("OIL_R"),
    ADI_PITCH                 = get_param_handle("ADI_PITCH"),
    FPM                       = get_param_handle("FPM"),
    FUELT                     = get_param_handle("FUELT"),
    FUEL                      = get_param_handle("FUEL"),
    TANK_OPACITY              = get_param_handle("TANK_OPACITY"),
    FCS_RA                    = get_param_handle("FCS_RA"),
    FCS_LA                    = get_param_handle("FCS_LA"),
    FCS_RR                    = get_param_handle("FCS_RR"),
    FCS_LR                    = get_param_handle("FCS_LR"),
    FCS_RE                    = get_param_handle("FCS_RE"),
    FCS_LE                    = get_param_handle("FCS_LE"),
    FCS_LF                    = get_param_handle("FCS_LF"),
    FCS_RF                    = get_param_handle("FCS_RF"),
    FCS_SB                    = get_param_handle("FCS_SB"),
    FCS_LEF                   = get_param_handle("FCS_LEF"),
    FCS_LEF_SELECT            = get_param_handle("FCS_LEF_SELECT"),
    FCS_FLAP_SELECT           = get_param_handle("FCS_FLAP_SELECT"),
	FCS_TVC					  = get_param_handle("FCS_TVC"),
	LANDING_BRAKE_ASSIST	  = get_param_handle("LANDING_BRAKE_ASSIST"),
	CENT_BAY_ARG			  = get_param_handle("CENT_BAY_ARG"),
	LEFT_BAY_ARG			  = get_param_handle("LEFT_BAY_ARG"),
	RIGHT_BAY_ARG			  = get_param_handle("RIGHT_BAY_ARG"),
    ILSN_VIS                  = get_param_handle("ILSN_VIS"),
    NAV_VIS                   = get_param_handle("NAV_VIS"),
    ILS_FLAG                  = get_param_handle("ILS_FLAG"), 
    ILS_VERT                  = get_param_handle("ILS_VERT"),
    ILS_HORIZON               = get_param_handle("ILS_HORIZON"),
    HSI_COMPASS               = get_param_handle("HSI_COMPASS"),
    HSI_CRS_POINTER           = get_param_handle("HSI_CRS_POINTER"),
    HSI_DEVIATION             = get_param_handle("HSI_DEVIATION"),
    HSI_WP_POINTER            = get_param_handle("HSI_WP_POINTER"),
    ILS_NAV                   = get_param_handle("ILS_NAV"),
    MILE_1                    = get_param_handle("MILE_1"),
    MILE_2                    = get_param_handle("MILE_2"),
    MILE_3                    = get_param_handle("MILE_3"),
    MILE_4                    = get_param_handle("MILE_4"),
    COURSE_1                  = get_param_handle("COURSE_1"),
    COURSE_2                  = get_param_handle("COURSE_2"), 
    COURSE_3                  = get_param_handle("COURSE_3"),
    TO_FROM                   = get_param_handle("TO_FROM"),  
    R_EGT_COLOR               = get_param_handle("R_EGT_COLOR"),
    R_RPM_COLOR               = get_param_handle("R_RPM_COLOR"),
    R_OIL_COLOR               = get_param_handle("R_OIL_COLOR"),
    R_HYD_COLOR               = get_param_handle("R_HYD_COLOR"),
    R_FF_VALUE                = get_param_handle("R_FF_VALUE"),
    R_HYD_VALUE               = get_param_handle("R_HYD_VALUE"),
    R_NOZZLE_POS              = get_param_handle("R_NOZZLE_POS"),
    L_EGT_COLOR               = get_param_handle("L_EGT_COLOR"),
    L_RPM_COLOR               = get_param_handle("L_RPM_COLOR"),
    L_OIL_COLOR               = get_param_handle("L_OIL_COLOR"),
    L_HYD_COLOR               = get_param_handle("L_HYD_COLOR"),
    L_FF_VALUE                = get_param_handle("L_FF_VALUE"),
    L_NOZZLE_POS              = get_param_handle("L_NOZZLE_POS"),
    L_HYD_VALUE               = get_param_handle("L_HYD_VALUE"),
    LMFD_ENG_PAGE             = get_param_handle("LMFD_ENG_PAGE"),
    LMFD_MENU_PAGE            = get_param_handle("LMFD_MENU_PAGE"),
    LMFD_FCS_PAGE             = get_param_handle("LMFD_FCS_PAGE"),
    LMFD_FUEL_PAGE            = get_param_handle("LMFD_FUEL_PAGE"),
    LMFD_NAV_PAGE             = get_param_handle("LMFD_NAV_PAGE"),
    LMFD_BAY_PAGE             = get_param_handle("LMFD_BAY_PAGE"),
    LMFD_CHECKLIST_PAGE       = get_param_handle("LMFD_CHECKLIST_PAGE"),
    LMFD_SMS_PAGE             = get_param_handle("LMFD_SMS_PAGE"),
    LMFD_HSI_PAGE             = get_param_handle("LMFD_HSI_PAGE"),
    LMFD_STARTUP_PAGE             = get_param_handle("LMFD_STARTUP_PAGE"),
    LMFD_IRST_PAGE             = get_param_handle("LMFD_IRST_PAGE"),
    LMFD_PAGE                 = get_param_handle("LMFD_PAGE"),
    RMFD_ENG_PAGE             = get_param_handle("RMFD_ENG_PAGE"),
    RMFD_MENU_PAGE            = get_param_handle("RMFD_MENU_PAGE"),
    RMFD_FCS_PAGE             = get_param_handle("RMFD_FCS_PAGE"),
    RMFD_FUEL_PAGE            = get_param_handle("RMFD_FUEL_PAGE"),
    RMFD_NAV_PAGE             = get_param_handle("RMFD_NAV_PAGE"),
    RMFD_BAY_PAGE             = get_param_handle("RMFD_BAY_PAGE"),
    RMFD_CHECKLIST_PAGE       = get_param_handle("RMFD_CHECKLIST_PAGE"),
    RMFD_RWR_PAGE             = get_param_handle("RMFD_RWR_PAGE"),
    RMFD_HSI_PAGE             = get_param_handle("RMFD_HSI_PAGE"),
    RMFD_ECMS_PAGE             = get_param_handle("RMFD_ECMS_PAGE"),
    RMFD_PAGE                 = get_param_handle("RMFD_PAGE"),
    CMFD_PAGE                 = get_param_handle("CMFD_PAGE"),
    LMFD_MASK                 = get_param_handle("LMFD_MASK"),
    RMFD_MASK                 = get_param_handle("RMFD_MASK"),
    CMFD_MASK                 = get_param_handle("CMFD_MASK"),
    BAY_STATION               = get_param_handle("BAY_STATION"),
    CMFD_ENG_PAGE             = get_param_handle("CMFD_ENG_PAGE"),
    CMFD_MENU_PAGE            = get_param_handle("CMFD_MENU_PAGE"),
    CMFD_FCS_PAGE             = get_param_handle("CMFD_FCS_PAGE"),
    CMFD_FUEL_PAGE            = get_param_handle("CMFD_FUEL_PAGE"),
    CMFD_NAV_PAGE             = get_param_handle("CMFD_NAV_PAGE"),
    CMFD_BAY_PAGE             = get_param_handle("CMFD_BAY_PAGE"),
    CMFD_CHECKLIST_PAGE       = get_param_handle("CMFD_CHECKLIST_PAGE"),
    CMFD_HSI_PAGE             = get_param_handle("CMFD_HSI_PAGE"),
    DOGFIGHT			      = get_param_handle("DOGFIGHT"),
    CABINPRESS			      = get_param_handle("CABINPRESS"),
    HUD_MODE			      = get_param_handle("HUD_MODE"),
    FCS_AUTO                  = get_param_handle("FCS_AUTO"),
    FCS_MODE                  = get_param_handle("FCS_MODE"),
    FCS_STATE                 = get_param_handle("FCS_STATE"),
    DAY_NIGHT	              = get_param_handle("DAY_NIGHT"),
	RWR_POWER				  = get_param_handle("RWR_POWER"),
	ECMS_POWER				  = get_param_handle("ECMS_POWER"),
	JAMMER_POWER			  = get_param_handle("JAMMER_POWER"),
	CMDS_PRGM_1				  = get_param_handle("CMDS_PRGM_1"),
	CMDS_PRGM_2				  = get_param_handle("CMDS_PRGM_2"),
	CMDS_PRGM_3				  = get_param_handle("CMDS_PRGM_3"),
	CMDS_PRGM_4				  = get_param_handle("CMDS_PRGM_4"),
	CMDS_PRGM_5				  = get_param_handle("CMDS_PRGM_5"),
	CMDS_PRGM_6				  = get_param_handle("CMDS_PRGM_6"),
	CMDS_PRGM_VAL			  = get_param_handle("CMDS_PRGM_VAL"),
	BINGO_VAL			  	  = get_param_handle("BINGO_VAL"),
	UPDATE_BINGO              = get_param_handle("UPDATE_BINGO"),
	DUMP_FUEL			 	  = get_param_handle("DUMP_FUEL"),
	HMD_POWER				  = get_param_handle("HMD_POWER"),

}

dev:listen_command(10000)--Left Bay Select
dev:listen_command(10001)--Right Bay Select
dev:listen_command(10002)--Center Bay Select
dev:listen_command(10003)--All Bay Select
dev:listen_command(10004)--Step Select
dev:listen_command(10005)--Dogfight Mode

dev:listen_command(10061)--LMFD_OSB_01
dev:listen_command(10062)--LMFD_OSB_02
dev:listen_command(10063)--LMFD_OSB_03
dev:listen_command(10064)--LMFD_OSB_04
dev:listen_command(10065)--LMFD_OSB_05
dev:listen_command(10066)--LMFD_OSB_06
dev:listen_command(10067)--LMFD_OSB_07
dev:listen_command(10068)--LMFD_OSB_08
dev:listen_command(10069)--LMFD_OSB_09
dev:listen_command(10070)--LMFD_OSB_10
dev:listen_command(10071)--LMFD_OSB_11
dev:listen_command(10072)--LMFD_OSB_12
dev:listen_command(10073)--LMFD_OSB_13
dev:listen_command(10074)--LMFD_OSB_14
dev:listen_command(10075)--LMFD_OSB_15
dev:listen_command(10076)--LMFD_OSB_16
dev:listen_command(10077)--LMFD_OSB_17
dev:listen_command(10078)--LMFD_OSB_18
dev:listen_command(10079)--LMFD_OSB_19
dev:listen_command(10080)--LMFD_OSB_20

dev:listen_command(10091) --RMFD_OSB_01
dev:listen_command(10092) --RMFD_OSB_02
dev:listen_command(10093) --RMFD_OSB_03
dev:listen_command(10094) --RMFD_OSB_04
dev:listen_command(10095) --RMFD_OSB_05
dev:listen_command(10096) --RMFD_OSB_06
dev:listen_command(10097) --RMFD_OSB_07
dev:listen_command(10098) --RMFD_OSB_08
dev:listen_command(10099) --RMFD_OSB_09
dev:listen_command(10100) --RMFD_OSB_10
dev:listen_command(10101) --RMFD_OSB_11
dev:listen_command(10102) --RMFD_OSB_12
dev:listen_command(10103) --RMFD_OSB_13
dev:listen_command(10104) --RMFD_OSB_14
dev:listen_command(10105) --RMFD_OSB_15
dev:listen_command(10106) --RMFD_OSB_16
dev:listen_command(10107) --RMFD_OSB_17
dev:listen_command(10108) --RMFD_OSB_18
dev:listen_command(10109) --RMFD_OSB_19
dev:listen_command(10110) --RMFD_OSB_20

dev:listen_command(10111)--CMFD_OSB_01
dev:listen_command(10112)--CMFD_OSB_02
dev:listen_command(10113)--CMFD_OSB_03
dev:listen_command(10114)--CMFD_OSB_04
dev:listen_command(10115)--CMFD_OSB_05
dev:listen_command(10116)--CMFD_OSB_06
dev:listen_command(10117)--CMFD_OSB_07
dev:listen_command(10118)--CMFD_OSB_08
dev:listen_command(10119)--CMFD_OSB_09
dev:listen_command(10120)--CMFD_OSB_10
dev:listen_command(10121)--CMFD_OSB_11
dev:listen_command(10122)--CMFD_OSB_12
dev:listen_command(10123)--CMFD_OSB_13
dev:listen_command(10124)--CMFD_OSB_14
dev:listen_command(10125)--CMFD_OSB_15
dev:listen_command(10126)--CMFD_OSB_16
dev:listen_command(10127)--CMFD_OSB_17
dev:listen_command(10128)--CMFD_OSB_18
dev:listen_command(10129)--CMFD_OSB_19
dev:listen_command(10130)--CMFD_OSB_20

dev:listen_command(PlaneJettisonFuelTanks)
dev:listen_command(Keys.PlaneFonar)

local canopy_toggle			= Keys.PlaneFonar
local PlaneJettisonFuelTanks 			= Keys.PlaneJettisonFuelTanks
local PlaneModeNAV 			= Keys.PlaneModeNAV	--1						
local PlaneModeBVR 			= Keys.PlaneModeBVR	--2						
local PlaneModeVS 			= Keys.PlaneModeVS --3								
local PlaneModeBore 		= Keys.PlaneModeBore --4
local PlaneModeFI0 			= Keys.PlaneModeFI0 --6
local NextSteer			 	= Keys.PlaneChangeTarget--steer point up
local PrevSteer 			= 1315--steer point prev
--local ChangeRWRMode         = 286
local PlaneRadarOnOff       = 86
local lmfd_current_page = 0 -- 0=MENU, 1=ENG, 2=FCS, 3=FUEL, 4=ADI, 5=BAY, 6=CHKLIST, 7=SMS, 8=HSI, 10 =STARTUP
local rmfd_current_page = 0 -- 0=MENU, 1=ENG, 2=FCS, 3=FUEL, 4=ADI, 5=BAY, 6=CHKLIST, 7=SMS, 8=HSI, 10=ECMS
local cmfd_current_page = 0 -- 0=MENU, 1=ENG, 2=FCS, 3=FUEL, 4=ADI, 5=BAY, 6=CHKLIST, 7=SMS, 8=HSI

local l_hyd_value           = 0--eng page
local r_hyd_value           = 0--eng page
local ground_oride_state    = 1 --open 0 --closed
local bay_select			= 0 -- 1-left 2-center 3-right 4-all
local move_l_bay			= 0 -- 0 closed, 1 open
local move_c_bay			= 0 -- 0 closed, 1 open
local move_r_bay			= 0 -- 0 closed, 1 open
local air_oride				= 0
local forgot_override       = 0
local left_select_mode      = 0
local right_select_mode     = 0 
local rwr_pwr = 0
local ecms_pwr = 0
local jammer_pwr = 0
local cmds_prgm1 = 0
local cmds_prgm2 = 0
local cmds_prgm3 = 0
local cmds_prgm4 = 0
local cmds_prgm5 = 0
local cmds_prgm6 = 0
local cmds_prgm_val = 0
local starting_bingo = 2500
local bingo_update = 0
local dump_fuel = 0
local fcs_flap_select = 1
local fcs_lef_select = 0
local hmd_power = 0



------------------------------------------------------------------FUNCTION-POST-INIT---------------------------------------------------------------------------------------------------
function post_initialize()

    local bay_option_state = get_aircraft_property("BAY_DOOR_OPTION")--ME Option Box
    local birth_place = LockOn_Options.init_conditions.birth_place

    if birth_place == "GROUND_COLD" then
		lmfd_current_page = 10
        parameters.BAY_OPTION:set(bay_option_state)
		bay_select = 4
        parameters.L_HYD_VALUE:set(0)
        parameters.R_HYD_VALUE:set(0)
		parameters.RWR_POWER:set(0)
		parameters.ECMS_POWER:set(0)
		parameters.JAMMER_POWER:set(0)
		if bay_option_state == 0 then
            move_l_bay = 1 -- Keep bays open
            move_c_bay = 1
            move_r_bay = 1
        else
            move_l_bay = 0
            move_c_bay = 0
            move_r_bay = 0
        end
    elseif birth_place == "GROUND_HOT" then
		l_hyd_value = 3950
		r_hyd_value = 3950
        ground_oride_state = 0
        set_aircraft_draw_argument_value(600,0)
		set_aircraft_draw_argument_value(601,0)
		set_aircraft_draw_argument_value(602,0)
		parameters.RWR_POWER:set(0)
		parameters.ECMS_POWER:set(0)
		parameters.JAMMER_POWER:set(0)
		lmfd_current_page = 1
		cmfd_current_page = 3
		rmfd_current_page = 4		
	elseif birth_place == "AIR_HOT" then
        l_hyd_value = 3950
		r_hyd_value = 3950
		ground_oride_state = 0
        set_aircraft_draw_argument_value(600,0)
		set_aircraft_draw_argument_value(601,0)
		set_aircraft_draw_argument_value(602,0)
		parameters.RWR_POWER:set(1)
		parameters.ECMS_POWER:set(1)
		parameters.JAMMER_POWER:set(0)
		lmfd_current_page = 1
		cmfd_current_page = 3
		rmfd_current_page = 7
	
    end
    --Option Checkbox
    if bay_option_state == 1 then
        ground_oride_state = 0
	elseif bay_option_state == 0 then
		bay_select = 4
		--move_l_bay = 1
        --move_c_bay = 1
        --move_r_bay = 1
	end
	parameters.BINGO_VAL:set(starting_bingo)
	parameters.DUMP_FUEL:set(dump_fuel)
end
------------------------------------------------------------------FUNCTION-SETCOMMAND---------------------------------------------------------------------------------------------------
function SetCommand(command,value)
    -- 0=MENU, 1=ENG, 2=FCS, 3=FUEL, 4=ADI/NAV, 5=BAY, 6=CHKLIST, 7=SMS/RWR, 8=HSI
--Dogfight Mode 
    if command == 10005 and parameters.MAIN_POWER:get() == 1 then
        lmfd_current_page = 7
        rmfd_current_page = 7
        cmfd_current_page = 5

    end
--RWR/ECMS Page Logic
    if (command == RMFD.R_OSB_15 or command == 10075) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 7 and rwr_pwr == 0 then 
        rwr_pwr = 1
	elseif	(command == RMFD.R_OSB_15 or command == 10075) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 7 and rwr_pwr == 1 then
		rwr_pwr = 0
		jammer_pwr = 0
		cmds_prgm6 = 0
	elseif (command == RMFD.R_OSB_5 or command == 10095) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 7 then
		rmfd_current_page = 10
	elseif (command == RMFD.R_OSB_15 or command == 10075) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 10 and ecms_pwr == 0 then
		ecms_pwr = 1
		cmds_prgm1 = 1
	elseif (command == RMFD.R_OSB_15 or command == 10075) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 10 and ecms_pwr == 1 then
		ecms_pwr = 0
		cmds_prgm1 = 0
		cmds_prgm2 = 0 
		cmds_prgm3 = 0 
		cmds_prgm4 = 0 
		cmds_prgm5 = 0 
		cmds_prgm6 = 0
	elseif (command == RMFD.R_OSB_5 or command == 10095) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 10 then
		rmfd_current_page = 7
	end
	
	if (command == RMFD.R_OSB_20 or command == 10080) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 10 and ecms_pwr == 1 then
		cmds_prgm1 = 1
		cmds_prgm2 = 0 
		cmds_prgm3 = 0 
		cmds_prgm4 = 0 
		cmds_prgm5 = 0 
		cmds_prgm6 = 0
	elseif (command == RMFD.R_OSB_18 or command == 10078) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 10 and ecms_pwr == 1 then
		cmds_prgm1 = 0
		cmds_prgm2 = 1 
		cmds_prgm3 = 0 
		cmds_prgm4 = 0 
		cmds_prgm5 = 0 
		cmds_prgm6 = 0
	elseif (command == RMFD.R_OSB_16 or command == 10076) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 10 and ecms_pwr == 1 then
		cmds_prgm1 = 0
		cmds_prgm2 = 0 
		cmds_prgm3 = 1 
		cmds_prgm4 = 0 
		cmds_prgm5 = 0 
		cmds_prgm6 = 0
	elseif (command == RMFD.R_OSB_6 or command == 10066) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 10 and ecms_pwr == 1 then
		cmds_prgm1 = 0
		cmds_prgm2 = 0 
		cmds_prgm3 = 0 
		cmds_prgm4 = 1 
		cmds_prgm5 = 0 
		cmds_prgm6 = 0
	elseif (command == RMFD.R_OSB_8 or command == 10068) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 10 and ecms_pwr == 1 then
		cmds_prgm1 = 0
		cmds_prgm2 = 0 
		cmds_prgm3 = 0 
		cmds_prgm4 = 0 
		cmds_prgm5 = 1 
		cmds_prgm6 = 0
	elseif (command == RMFD.R_OSB_10 or command == 10070) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 10 and ecms_pwr == 1 and rwr_pwr == 1 then
		cmds_prgm1 = 0
		cmds_prgm2 = 0 
		cmds_prgm3 = 0 
		cmds_prgm4 = 0 
		cmds_prgm5 = 0 
		cmds_prgm6 = 1
	end 

	if	(command == RMFD.R_OSB_11 or command == 10101) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 10 and ecms_pwr == 1 and rwr_pwr == 1 and jammer_pwr == 0 then
		jammer_pwr = 1
	elseif (command == RMFD.R_OSB_11 or command == 10101) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 10 and ecms_pwr == 1 and rwr_pwr == 1 and jammer_pwr == 1 then
		jammer_pwr = 0
	end
		
-----------------------------------------------------------------------------------------------------LEFT MFD PAGE LOGIC---------------------------------------------------------------------------------------------------
    if (command == LMFD.L_OSB_1 or command == 10061) and parameters.MAIN_POWER:get() == 1 then
		lmfd_current_page = 0
	elseif (command == LMFD.L_OSB_3 or command == 10063) and parameters.MAIN_POWER:get() == 1 and lmfd_current_page == 0 then
        lmfd_current_page = 6-- SET CHECKLIST PAGE
    elseif (command == LMFD.L_OSB_6 or command == 10066) and parameters.MAIN_POWER:get() == 1 and lmfd_current_page == 0 then
        lmfd_current_page = 8-- SET HSI PAGE
    elseif (command == LMFD.L_OSB_8 or command == 10068) and parameters.MAIN_POWER:get() == 1 and lmfd_current_page == 0 then
        lmfd_current_page = 2-- SET FCS PAGE
    elseif (command == LMFD.L_OSB_10 or command == 10070) and parameters.MAIN_POWER:get() == 1 and lmfd_current_page == 0 then
        lmfd_current_page = 3-- SET FUEL PAGE
    elseif (command == LMFD.L_OSB_15 or command == 10075) and parameters.MAIN_POWER:get() == 1 and lmfd_current_page == 0 then
        lmfd_current_page = 5-- SET BAY PAGE             
    elseif (command == LMFD.L_OSB_18 or command == 10078) and parameters.MAIN_POWER:get() == 1 and lmfd_current_page == 0 then
        lmfd_current_page = 1-- SET ENGINE PAGE
    elseif (command == LMFD.L_OSB_20 or command == 10080) and parameters.MAIN_POWER:get() == 1 and lmfd_current_page == 0 then
        lmfd_current_page = 4-- SET ADI PAGE
	elseif (command == LMFD.L_OSB_16 or command == 10076) and parameters.MAIN_POWER:get() == 1 and lmfd_current_page == 0 then
        lmfd_current_page = 7
	elseif (command == LMFD.L_OSB_5 or command == 10065) and parameters.MAIN_POWER:get() == 1 and lmfd_current_page == 0 then
		lmfd_current_page = 10
    end
--END LEFT MFD
-----------------------------------------------------------------------------------------------------RIGHT MFD PAGE LOGIC---------------------------------------------------------------------------------------------------

	if (command == RMFD.R_OSB_1 or command == 10091) and parameters.MAIN_POWER:get() == 1 then
		rmfd_current_page = 0
	elseif (command == RMFD.R_OSB_3 or command == 10093) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 0 then
        rmfd_current_page = 6-- SET CHECKLIST PAGE
    elseif (command == RMFD.R_OSB_6 or command == 10096) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 0 then
        rmfd_current_page = 8-- SET HSI PAGE
    elseif (command == RMFD.R_OSB_8 or command == 10098) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 0 then
        rmfd_current_page = 2-- SET FCS PAGE
    elseif (command == RMFD.R_OSB_10 or command == 10100) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 0 then
        rmfd_current_page = 3-- SET FUEL PAGE
    elseif (command == RMFD.R_OSB_15 or command == 10105) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 0 then
        rmfd_current_page = 5-- SET BAY PAGE             
    elseif (command == RMFD.R_OSB_18 or command == 10108) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 0 then
        rmfd_current_page = 1-- SET ENGINE PAGE
    elseif (command == RMFD.R_OSB_20 or command == 10110) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 0 then
        rmfd_current_page = 4-- SET ADI PAGE
	elseif (command == RMFD.R_OSB_16 or command == 10106) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 0 then
        rmfd_current_page = 7
    end
    -- 0=MENU, 1=ENG, 2=FCS, 3=FUEL, 4=ADI, 5=BAY, 6=CHKLIST, 7=SMS, 8=HSI

--END RIGHT MFD
-----------------------------------------------------------------------------------------------------CENTER MFD PAGE LOGIC---------------------------------------------------------------------------------------------------

	if (command == CMFD.C_OSB_1 or command == 10111) and parameters.MAIN_POWER:get() == 1 then
		cmfd_current_page = 0
	elseif (command == CMFD.C_OSB_3 or command == 10113) and parameters.MAIN_POWER:get() == 1 and cmfd_current_page == 0 then
        cmfd_current_page = 6-- SET CHECKLIST PAGE
    elseif (command == CMFD.C_OSB_6 or command == 10116) and parameters.MAIN_POWER:get() == 1 and cmfd_current_page == 0 then
        cmfd_current_page = 8-- SET HSI PAGE
    elseif (command == CMFD.C_OSB_8 or command == 10118) and parameters.MAIN_POWER:get() == 1 and cmfd_current_page == 0 then
        cmfd_current_page = 2-- SET FCS PAGE
    elseif (command == CMFD.C_OSB_10 or command == 10120) and parameters.MAIN_POWER:get() == 1 and cmfd_current_page == 0 then
        cmfd_current_page = 3-- SET FUEL PAGE
    elseif (command == CMFD.C_OSB_16 or command == 10126) and parameters.MAIN_POWER:get() == 1 and cmfd_current_page == 0 then
        cmfd_current_page = 5-- SET BAY PAGE             
    elseif (command == CMFD.C_OSB_18 or command == 10128) and parameters.MAIN_POWER:get() == 1 and cmfd_current_page == 0 then
        cmfd_current_page = 1-- SET ENGINE PAGE
    elseif (command == CMFD.C_OSB_20 or command == 10130) and parameters.MAIN_POWER:get() == 1 and cmfd_current_page == 0 then
        cmfd_current_page = 4-- SET ADI PAGE
    end
-- 0=MENU, 1=ENG, 2=FCS, 3=FUEL, 4=ADI, 5=BAY, 6=CHKLIST, 7=SMS, 8=HSI
--END RIGHT MFD
-----------------------------------------------------------------------------------------------HSI-LOGIC------------------------------------------------------    
    -- 0=MENU, 1=ENG, 2=FCS, 3=FUEL, 4=ADI, 5=BAY, 6=CHKLIST, 7=SMS, 8=HSI
    --HSI PAGE NAV-ILS-NEXT-PREV
    if (command == LMFD.L_OSB_15 or command == 10075) and parameters.MAIN_POWER:get() == 1 and lmfd_current_page == 8 then
        dispatch_action(nil,PlaneModeNAV)--FC3 Keybind press 1
    elseif (command == LMFD.L_OSB_19 or command == 10079) and parameters.MAIN_POWER:get() == 1 and lmfd_current_page == 8 then
        dispatch_action(nil,PrevSteer)--FC3 Keybind press L Shift ~
    elseif (command == LMFD.L_OSB_20 or command == 10080) and parameters.MAIN_POWER:get() == 1 and lmfd_current_page == 8 then
        dispatch_action(nil,NextSteer)--FC3 Keybind press L CTRL ~
    elseif (command == RMFD.R_OSB_15 or command == 10105) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 8 then
        dispatch_action(nil,PlaneModeNAV)--FC3 Keybind press 1
    elseif (command == RMFD.R_OSB_19 or command == 10109) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 8 then
        dispatch_action(nil,PrevSteer)--FC3 Keybind press L Shift ~
    elseif (command == RMFD.R_OSB_20 or command == 10110) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 8 then
        dispatch_action(nil,NextSteer)--FC3 Keybind press L CTRL ~
    elseif (command == CMFD.C_OSB_15 or command == 10125) and parameters.MAIN_POWER:get() == 1 and cmfd_current_page == 8 then
        dispatch_action(nil,PlaneModeNAV)--FC3 Keybind press 1
    elseif (command == CMFD.C_OSB_19 or command == 10129) and parameters.MAIN_POWER:get() == 1 and cmfd_current_page == 8 then
        dispatch_action(nil,PrevSteer)--FC3 Keybind press L Shift ~
    elseif (command == CMFD.C_OSB_20 or command == 10130) and parameters.MAIN_POWER:get() == 1 and cmfd_current_page == 8 then
        dispatch_action(nil,NextSteer)--FC3 Keybind press L CTRL ~
    end
	
-----------------------------------------------------------------------------------------------FUEL-LOGIC------------------------------------------------------ 
	
	if ((command == LMFD.L_OSB_7 or command == 10067) and (lmfd_current_page == 3)) or ((command == CMFD.C_OSB_7 or command == 10117) and (cmfd_current_page == 3)) or ((command == RMFD.R_OSB_7 or command == 10097) and (rmfd_current_page == 3)) then
		dispatch_action(nil,PlaneJettisonFuelTanks)
	end

	if ((command == LMFD.L_OSB_6 or command == 10066) and (lmfd_current_page == 3)) or ((command == CMFD.C_OSB_6 or command == 10116) and (cmfd_current_page == 3)) or ((command == RMFD.R_OSB_6 or command == 10096) and (rmfd_current_page == 3)) then
		bingo_update = 1
		parameters.UPDATE_BINGO:set(bingo_update)
	end
	if ((command == LMFD.L_OSB_20 or command == 10080) and lmfd_current_page == 3 or
			(command == CMFD.C_OSB_20 or command == 10130) and cmfd_current_page == 3 or
			(command == RMFD.R_OSB_20 or command == 10110) and rmfd_current_page == 3) and
			dump_fuel == 0 and parameters.WoW:get() == 0 then
		dump_fuel = 1
		parameters.DUMP_FUEL:set(dump_fuel)
	elseif ((command == LMFD.L_OSB_20 or command == 10080) and lmfd_current_page == 3 or
			(command == CMFD.C_OSB_20 or command == 10130) and cmfd_current_page == 3 or
			(command == RMFD.R_OSB_20 or command == 10110) and rmfd_current_page == 3) and
			dump_fuel == 1 and parameters.WoW:get() == 0 then
		dump_fuel = 0
		parameters.DUMP_FUEL:set(dump_fuel)
	end


-----------------------------------------------------------------------------------------------FCS-LOGIC------------------------------------------------------ 
-----------------------------------------------------------------------------------------------STARTUP-LOGIC------------------------------------------------------ 
	if (command == LMFD.L_OSB_10 or command == 10070) and parameters.MAIN_POWER:get() == 1 and lmfd_current_page == 10 and hmd_power == 0 then
		hmd_power = 1
	elseif (command == LMFD.L_OSB_10 or command == 10070) and parameters.MAIN_POWER:get() == 1 and lmfd_current_page == 10 and hmd_power == 1 then
		hmd_power = 0
	elseif (command == LMFD.L_OSB_16 or command == 10076) and lmfd_current_page == 10 then
		dispatch_action(nil,canopy_toggle) 
	end


-----------------------------------------------------------------------------------------------BAY-LOGIC------------------------------------------------------ 
    --BAY SELECT LFMD
	if (command == LMFD.L_OSB_8 or command == 10068) and parameters.MAIN_POWER:get() == 1 and lmfd_current_page == 5 and (parameters.WoW:get() == 1 or parameters.AIR_ORIDE:get() == 1) then
		bay_select = 1
	elseif (command == LMFD.L_OSB_10 or command == 10070) and parameters.MAIN_POWER:get() == 1 and lmfd_current_page == 5 and (parameters.WoW:get() == 1 or parameters.AIR_ORIDE:get() == 1) then
		bay_select = 2
	elseif (command == LMFD.L_OSB_9 or command == 10069) and parameters.MAIN_POWER:get() == 1 and lmfd_current_page == 5 and (parameters.WoW:get() == 1 or parameters.AIR_ORIDE:get() == 1) then
		bay_select = 3
	elseif (command == LMFD.L_OSB_13 or command == 10073) and parameters.MAIN_POWER:get() == 1 and lmfd_current_page == 5 and (parameters.WoW:get() == 1 or parameters.AIR_ORIDE:get() == 1) then
		bay_select = 4
	end
		
	--BAY SELECT CENTER
	if (command == CMFD.C_OSB_8 or command == 10118) and parameters.MAIN_POWER:get() == 1 and cmfd_current_page == 5 and (parameters.WoW:get() == 1 or parameters.AIR_ORIDE:get() == 1) then
		bay_select = 1
	elseif (command == CMFD.C_OSB_10 or command == 10120) and parameters.MAIN_POWER:get() == 1 and cmfd_current_page == 5 and (parameters.WoW:get() == 1 or parameters.AIR_ORIDE:get() == 1) then
		bay_select = 2
	elseif (command == CMFD.C_OSB_9 or command == 10119) and parameters.MAIN_POWER:get() == 1 and cmfd_current_page == 5 and (parameters.WoW:get() == 1 or parameters.AIR_ORIDE:get() == 1) then
		bay_select = 3
	elseif (command == CMFD.C_OSB_13 or command == 10123) and parameters.MAIN_POWER:get() == 1 and cmfd_current_page == 5 and (parameters.WoW:get() == 1 or parameters.AIR_ORIDE:get() == 1) then
		bay_select = 4
	end
	
	--BAY SELECT RIGHT
	if (command == RMFD.R_OSB_8 or command == 10098) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 5 and (parameters.WoW:get() == 1 or parameters.AIR_ORIDE:get() == 1) then
		bay_select = 1
	elseif (command == RMFD.R_OSB_10 or command == 10100) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 5 and (parameters.WoW:get() == 1 or parameters.AIR_ORIDE:get() == 1) then
		bay_select = 2
	elseif (command == RMFD.R_OSB_9 or command == 10099) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 5 and (parameters.WoW:get() == 1 or parameters.AIR_ORIDE:get() == 1) then
		bay_select = 3
	elseif (command == RMFD.R_OSB_13 or command == 10103) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 5 and (parameters.WoW:get() == 1 or parameters.AIR_ORIDE:get() == 1) then
		bay_select = 4
	end
	
	--Open/Close Bays
	--left MFD
		if (command == LMFD.L_OSB_16 or command == 10076) and parameters.MAIN_POWER:get() == 1 and lmfd_current_page == 5 and (parameters.WoW:get() == 1 or parameters.AIR_ORIDE:get() == 1) and bay_select == 1 and move_l_bay == 0 then
        move_l_bay = 1
    elseif (command == LMFD.L_OSB_16 or command == 10076) and parameters.MAIN_POWER:get() == 1 and lmfd_current_page == 5 and (parameters.WoW:get() == 1 or parameters.AIR_ORIDE:get() == 1) and bay_select == 1 and move_l_bay == 1  then
        move_l_bay = 0
	elseif (command == LMFD.L_OSB_16 or command == 10076) and parameters.MAIN_POWER:get() == 1 and lmfd_current_page == 5 and (parameters.WoW:get() == 1 or parameters.AIR_ORIDE:get() == 1) and bay_select == 2 and move_c_bay == 0 then
        move_c_bay = 1
    elseif (command == LMFD.L_OSB_16 or command == 10076) and parameters.MAIN_POWER:get() == 1 and lmfd_current_page == 5 and (parameters.WoW:get() == 1 or parameters.AIR_ORIDE:get() == 1) and bay_select == 2 and move_c_bay == 1  then
        move_c_bay = 0
	elseif (command == LMFD.L_OSB_16 or command == 10076) and parameters.MAIN_POWER:get() == 1 and lmfd_current_page == 5 and (parameters.WoW:get() == 1 or parameters.AIR_ORIDE:get() == 1) and bay_select == 3 and move_r_bay == 0 then
        move_r_bay = 1
    elseif (command == LMFD.L_OSB_16 or command == 10076) and parameters.MAIN_POWER:get() == 1 and lmfd_current_page == 5 and (parameters.WoW:get() == 1 or parameters.AIR_ORIDE:get() == 1) and bay_select == 3 and move_r_bay == 1  then
        move_r_bay = 0
	elseif (command == LMFD.L_OSB_16 or command == 10076) and parameters.MAIN_POWER:get() == 1 and lmfd_current_page == 5 and (parameters.WoW:get() == 1 or parameters.AIR_ORIDE:get() == 1) and bay_select == 4 and move_l_bay == 0 and move_c_bay == 0 and move_r_bay == 0 then
        move_l_bay = 1
        move_c_bay = 1
        move_r_bay = 1
    elseif (command == LMFD.L_OSB_16 or command == 10076) and parameters.MAIN_POWER:get() == 1 and lmfd_current_page == 5 and (parameters.WoW:get() == 1 or parameters.AIR_ORIDE:get() == 1) and bay_select == 4 and move_l_bay == 1 and move_c_bay == 1 and move_r_bay == 1 then
        move_l_bay = 0
        move_c_bay = 0
        move_r_bay = 0
	end
	
	--Center MFD
		if (command == CMFD.C_OSB_16 or command == 10126) and parameters.MAIN_POWER:get() == 1 and cmfd_current_page == 5 and (parameters.WoW:get() == 1 or parameters.AIR_ORIDE:get() == 1) and bay_select == 1 and move_l_bay == 0 then
        move_l_bay = 1
    elseif (command == CMFD.C_OSB_16 or command == 10126) and parameters.MAIN_POWER:get() == 1 and cmfd_current_page == 5 and (parameters.WoW:get() == 1 or parameters.AIR_ORIDE:get() == 1) and bay_select == 1 and move_l_bay == 1  then
        move_l_bay = 0
	elseif (command == CMFD.C_OSB_16 or command == 10126) and parameters.MAIN_POWER:get() == 1 and cmfd_current_page == 5 and (parameters.WoW:get() == 1 or parameters.AIR_ORIDE:get() == 1) and bay_select == 2 and move_c_bay == 0 then
        move_c_bay = 1
    elseif (command == CMFD.C_OSB_16 or command == 10126) and parameters.MAIN_POWER:get() == 1 and cmfd_current_page == 5 and (parameters.WoW:get() == 1 or parameters.AIR_ORIDE:get() == 1) and bay_select == 2 and move_c_bay == 1  then
        move_c_bay = 0
	elseif (command == CMFD.C_OSB_16 or command == 10126) and parameters.MAIN_POWER:get() == 1 and cmfd_current_page == 5 and (parameters.WoW:get() == 1 or parameters.AIR_ORIDE:get() == 1) and bay_select == 3 and move_r_bay == 0 then
        move_r_bay = 1
    elseif (command == CMFD.C_OSB_16 or command == 10126) and parameters.MAIN_POWER:get() == 1 and cmfd_current_page == 5 and (parameters.WoW:get() == 1 or parameters.AIR_ORIDE:get() == 1) and bay_select == 3 and move_r_bay == 1  then
        move_r_bay = 0
	elseif (command == CMFD.C_OSB_16 or command == 10126) and parameters.MAIN_POWER:get() == 1 and cmfd_current_page == 5 and (parameters.WoW:get() == 1 or parameters.AIR_ORIDE:get() == 1) and bay_select == 4 and move_l_bay == 0 and move_c_bay == 0 and move_r_bay == 0 then
        move_l_bay = 1
        move_c_bay = 1
        move_r_bay = 1
    elseif (command == CMFD.C_OSB_16 or command == 10126) and parameters.MAIN_POWER:get() == 1 and cmfd_current_page == 5 and (parameters.WoW:get() == 1 or parameters.AIR_ORIDE:get() == 1) and bay_select == 4 and move_l_bay == 1 and move_c_bay == 1 and move_r_bay == 1 then
        move_l_bay = 0
        move_c_bay = 0
        move_r_bay = 0
	end
	
	--Right MFD
	if (command == RMFD.R_OSB_16 or command == 10106) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 5 and (parameters.WoW:get() == 1 or parameters.AIR_ORIDE:get() == 1) and bay_select == 1 and move_l_bay == 0 then
        move_l_bay = 1
    elseif (command == RMFD.R_OSB_16 or command == 10106) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 5 and (parameters.WoW:get() == 1 or parameters.AIR_ORIDE:get() == 1) and bay_select == 1 and move_l_bay == 1  then
        move_l_bay = 0
	elseif (command == RMFD.R_OSB_16 or command == 10106) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 5 and (parameters.WoW:get() == 1 or parameters.AIR_ORIDE:get() == 1) and bay_select == 2 and move_c_bay == 0 then
        move_c_bay = 1
    elseif (command == RMFD.R_OSB_16 or command == 10106) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 5 and (parameters.WoW:get() == 1 or parameters.AIR_ORIDE:get() == 1) and bay_select == 2 and move_c_bay == 1  then
        move_c_bay = 0
	elseif (command == RMFD.R_OSB_16 or command == 10106) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 5 and (parameters.WoW:get() == 1 or parameters.AIR_ORIDE:get() == 1) and bay_select == 3 and move_r_bay == 0 then
        move_r_bay = 1
    elseif (command == RMFD.R_OSB_16 or command == 10106) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 5 and (parameters.WoW:get() == 1 or parameters.AIR_ORIDE:get() == 1) and bay_select == 3 and move_r_bay == 1  then
        move_r_bay = 0
	elseif (command == RMFD.R_OSB_16 or command == 10106) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 5 and (parameters.WoW:get() == 1 or parameters.AIR_ORIDE:get() == 1) and bay_select == 4 and move_l_bay == 0 and move_c_bay == 0 and move_r_bay == 0 then
        move_l_bay = 1
        move_c_bay = 1
        move_r_bay = 1
    elseif (command == RMFD.R_OSB_16 or command == 10106) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 5 and (parameters.WoW:get() == 1 or parameters.AIR_ORIDE:get() == 1) and bay_select == 4 and move_l_bay == 1 and move_c_bay == 1 and move_r_bay == 1 then
        move_l_bay = 0
        move_c_bay = 0
        move_r_bay = 0
	end

	if (command == RMFD.R_OSB_17 or command == 10107) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 5 and parameters.WoW:get() == 0 and air_oride == 0 then
		air_oride = 1
	elseif (command == LMFD.L_OSB_17 or command == 10077) and parameters.MAIN_POWER:get() == 1 and lmfd_current_page == 5 and parameters.WoW:get() == 0 and air_oride == 0 then
		air_oride = 1
	elseif (command == CMFD.C_OSB_17 or command == 10127) and parameters.MAIN_POWER:get() == 1 and cmfd_current_page == 5 and parameters.WoW:get() == 0 and air_oride == 0 then
		air_oride = 1
	elseif (command == RMFD.R_OSB_17 or command == 10107) and parameters.MAIN_POWER:get() == 1 and rmfd_current_page == 5 and parameters.WoW:get() == 0 and air_oride == 1 then
		air_oride = 0
	elseif (command == LMFD.L_OSB_17 or command == 10077) and parameters.MAIN_POWER:get() == 1 and lmfd_current_page == 5 and parameters.WoW:get() == 0 and air_oride == 1 then
		air_oride = 0
	elseif (command == CMFD.C_OSB_17 or command == 10127) and parameters.MAIN_POWER:get() == 1 and cmfd_current_page == 5 and parameters.WoW:get() == 0 and air_oride == 1 then
		air_oride = 0
	end
		
		
		
		
		
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end
------------------------------------------------------------------FUNCTION-UPDATE---------------------------------------------------------------------------------------------------
function update()
----- NOTES -----
parameters.L_BAY:set(move_l_bay)
parameters.C_BAY:set(move_c_bay)
parameters.R_BAY:set(move_r_bay)
parameters.AIR_ORIDE:set(air_oride)
parameters.HMD_POWER:set(hmd_power)


--RWR Page Updates
	parameters.RWR_POWER:set(rwr_pwr)
	parameters.ECMS_POWER:set(ecms_pwr)
	parameters.CMDS_PRGM_1:set(cmds_prgm1)
	parameters.CMDS_PRGM_2:set(cmds_prgm2)
	parameters.CMDS_PRGM_3:set(cmds_prgm3)
	parameters.CMDS_PRGM_4:set(cmds_prgm4)
	parameters.CMDS_PRGM_5:set(cmds_prgm5)
	parameters.CMDS_PRGM_6:set(cmds_prgm6)
	
	if cmds_prgm1 == 1 then
		cmds_prgm_val = 1
	elseif cmds_prgm2 == 1 then
		cmds_prgm_val = 2
	elseif cmds_prgm3 == 1 then
		cmds_prgm_val = 3
	elseif cmds_prgm4 == 1 then
		cmds_prgm_val = 4
	elseif cmds_prgm5 == 1 then
		cmds_prgm_val = 5
	elseif cmds_prgm6 == 1 then
		cmds_prgm_val = 6
	else 
		cmds_prgm_val = 0
	end
	
	parameters.CMDS_PRGM_VAL:set(cmds_prgm_val)
	parameters.JAMMER_POWER:set(jammer_pwr)

	
	
------------------------------------------------------------------ENGINE PAGE UPDATE---------------------------------------------------------------------------------------------------
    local hyd_light      = get_cockpit_draw_argument_value(208)
    local cabin_pressure = get_cockpit_draw_argument_value(114)

    local nozzle_pos_l = sensor_data.getEngineLeftRPM() * 100
	local left_nozzle = 50 + (nozzle_pos_l - 67) * (50 / 33)
		if left_nozzle > 100 then
		left_nozzle = 100
		elseif left_nozzle < 50 then
		left_nozzle = 50
	end
	parameters.L_NOZZLE_POS:set(left_nozzle)
	
	local nozzle_pos_r = sensor_data.getEngineRightRPM() * 100
	local right_nozzle = 50 + (nozzle_pos_r - 67) * (50 / 33)
		if right_nozzle > 100 then
		right_nozzle = 100
		elseif right_nozzle < 50 then
		right_nozzle = 50
	end
	parameters.R_NOZZLE_POS:set(right_nozzle)

    parameters.GROUND_ORIDE:set(ground_oride_state)
    parameters.BAY_STATION:set(bay_select)
    parameters.CABINPRESS:set(cabin_pressure)
    parameters.L_HYD_VALUE:set(l_hyd_value)
    parameters.R_HYD_VALUE:set(r_hyd_value)

    parameters.OIL_L:set(sensor_data.getEngineLeftRPM()*270)
    parameters.OIL_R:set(sensor_data.getEngineRightRPM()*270)
	parameters.RPM_L:set(sensor_data.getEngineLeftRPM()*100)
	parameters.RPM_R:set(sensor_data.getEngineRightRPM()*100)

    parameters.L_HYD_COLOR:set(0)
    parameters.R_HYD_COLOR:set(0)
    parameters.R_FF_VALUE:set(sensor_data.getEngineRightFuelConsumption()*2.20462*3600)
    parameters.L_FF_VALUE:set(sensor_data.getEngineLeftFuelConsumption()*2.20462*3600)
    parameters.LMFD_PAGE:set(lmfd_current_page)
    parameters.RMFD_PAGE:set(rmfd_current_page)
    parameters.CMFD_PAGE:set(cmfd_current_page)
------------------------------------------------------------------FCS PAGE UPDATE---------------------------------------------------------------------------------------------------
    local right_flap                = get_aircraft_draw_argument_value(9)
    local left_flap                 = get_aircraft_draw_argument_value(10)
    local right_aileron             = get_aircraft_draw_argument_value(11)
    local left_aileron              = get_aircraft_draw_argument_value(12)
    local right_elevator            = get_aircraft_draw_argument_value(15)
    local left_elevator             = get_aircraft_draw_argument_value(16)
    local right_rudder              = get_aircraft_draw_argument_value(17)
    local left_rudder               = get_aircraft_draw_argument_value(18)
    local speed_brake               = get_aircraft_draw_argument_value(182)
	local center_bay				= get_aircraft_draw_argument_value(600)
	local left_bay					= get_aircraft_draw_argument_value(601)
	local right_bay					= get_aircraft_draw_argument_value(602)
    local lef                       = get_aircraft_draw_argument_value(603)
	local tvc						= get_aircraft_draw_argument_value(622)


	if parameters.LANDING_BRAKE_ASSIST:get() == 1 then
		right_rudder = 0
		left_rudder = 0
	end

    parameters.FCS_RA:set(right_aileron)
    parameters.FCS_LA:set(left_aileron)
    parameters.FCS_RE:set(right_elevator)
    parameters.FCS_LE:set(left_elevator)
    parameters.FCS_RR:set(right_rudder)
    parameters.FCS_LR:set(left_rudder)
    parameters.FCS_RF:set(right_flap)
    parameters.FCS_LF:set(left_flap)
    parameters.FCS_SB:set(speed_brake)
    parameters.FCS_LEF:set(lef)
    parameters.FCS_TVC:set(tvc)
    parameters.FCS_LEF_SELECT:set(fcs_lef_select)
    parameters.FCS_FLAP_SELECT:set(fcs_flap_select)
    parameters.CENT_BAY_ARG:set(center_bay)
    parameters.LEFT_BAY_ARG:set(left_bay)
    parameters.RIGHT_BAY_ARG:set(right_bay)
	

	
------------------------------------------------------------------FUEL PAGE UPDATE---------------------------------------------------------------------------------------------------
------------------------------------------------------------------ADI PAGE UPDATE---------------------------------------------------------------------------------------------------
------------------------------------------------------------------HSI PAGE UPDATE----------------------------------------------------------------------------------------------------
    

    
       local ils_vert                  = get_cockpit_draw_argument_value(28)--up + down -
       local ils_horizon               = get_cockpit_draw_argument_value(27)--left - right +
       local hsi_compass               = get_cockpit_draw_argument_value(32)
       local hsi_course_pointer        = get_cockpit_draw_argument_value(35)
       local hsi_deviation             = get_cockpit_draw_argument_value(36)
       local hsi_wp_pointer            = get_cockpit_draw_argument_value(140)
       local ils_flag                  = get_cockpit_draw_argument_value(141)
       local mile_4                    = get_cockpit_draw_argument_value(267)
       local mile_3                    = get_cockpit_draw_argument_value(268)
       local mile_2                    = get_cockpit_draw_argument_value(269)
       local mile_1                    = get_cockpit_draw_argument_value(270)
       local course_1                  = get_cockpit_draw_argument_value(275)
       local course_2                  = get_cockpit_draw_argument_value(276)
       local course_3                  = get_cockpit_draw_argument_value(277)
       local to_from                   = get_cockpit_draw_argument_value(278)
       local ils_nav                   = get_cockpit_draw_argument_value(501)
    --print_message_to_user(ils_horizon)

    parameters.ILS_VERT:set(ils_vert)  --up + down -
    parameters.ILS_HORIZON:set(ils_horizon)--left - right +
    parameters.HSI_COMPASS:set(hsi_compass)
    parameters.HSI_CRS_POINTER:set(hsi_course_pointer)
    parameters.HSI_DEVIATION:set(hsi_deviation)  
    parameters.HSI_WP_POINTER:set(hsi_wp_pointer)
    parameters.ILS_FLAG:set(ils_flag) 
    parameters.ILS_NAV:set(ils_nav)       
    parameters.MILE_1:set(mile_1)         
    parameters.MILE_2:set(mile_2)         
    parameters.MILE_3:set(mile_3)         
    parameters.MILE_4:set(mile_4)        
    parameters.COURSE_1:set(course_1)       
    parameters.COURSE_2:set(course_2)       
    parameters.COURSE_3:set(course_3)       
    parameters.TO_FROM:set(to_from)
    
    if parameters.ILS_NAV:get() >= 0.1 then
        parameters.ILSN_VIS:set(1)
        parameters.NAV_VIS:set(0)
    elseif parameters.ILS_NAV:get() <= 0.09 then
        parameters.ILSN_VIS:set(0)
        parameters.NAV_VIS:set(1)
    end
        
------------------------------------------------------------------ENGINE PAGE LOGIC---------------------------------------------------------------------------------------------------
    --ENGINE PAGE EGT R COLOR CHANGE
    if sensor_data.getEngineRightTemperatureBeforeTurbine() <= 729 then
        parameters.R_EGT_COLOR:set(0)--get green
    elseif sensor_data.getEngineRightTemperatureBeforeTurbine() >= 730 and sensor_data.getEngineRightTemperatureBeforeTurbine() <= 849 then
        parameters.R_EGT_COLOR:set(0.5)--set yellow
    elseif sensor_data.getEngineRightTemperatureBeforeTurbine() >= 850 then
        parameters.R_EGT_COLOR:set(1) --set red
    end
    --ENGINE PAGE EGT L COLOR CHANGE
    if sensor_data.getEngineLeftTemperatureBeforeTurbine() <= 729 then
        parameters.L_EGT_COLOR:set(0)--get green
    elseif sensor_data.getEngineLeftTemperatureBeforeTurbine() >= 730 and sensor_data.getEngineLeftTemperatureBeforeTurbine() <= 849 then
        parameters.L_EGT_COLOR:set(0.5)--set yellow
    elseif sensor_data.getEngineLeftTemperatureBeforeTurbine() >= 850 then
        parameters.L_EGT_COLOR:set(1) --set red
    end
    --ENGINE PAGE RPM COLOR CHANGE R
    if sensor_data.getEngineRightRPM() <= 1.04 then
        parameters.R_RPM_COLOR:set(0.5)-- set yellow
    elseif sensor_data.getEngineRightRPM() >= 1.04 then
        parameters.R_RPM_COLOR:set(1)-- set orange
    end
    --ENGINE PAGE RPM COLOR CHANGE L
    if sensor_data.getEngineLeftRPM() <= 1.04 then
        parameters.L_RPM_COLOR:set(0.5)-- set yellow
    elseif sensor_data.getEngineLeftRPM() >= 1.04 then
        parameters.L_RPM_COLOR:set(1)-- set orange
    end
    --ENGINE PAGE OIL COLOR CHANGE R
    if sensor_data.getEngineRightRPM() <= .66 then
        parameters.R_OIL_COLOR:set(1)
    elseif sensor_data.getEngineRightRPM() >= .67 then
        parameters.R_OIL_COLOR:set(0)
    end
    --ENGINE PAGE OIL COLOR CHANGE L
    if sensor_data.getEngineLeftRPM() <= .66 then
        parameters.L_OIL_COLOR:set(1)
    elseif sensor_data.getEngineLeftRPM() >= .67 then
        parameters.L_OIL_COLOR:set(0)
    end 
    --HYD ENGINE RIGHT
    if sensor_data.getEngineRightRPM() >= .30 and r_hyd_value <= 3945 then
        r_hyd_value = r_hyd_value + 5
    elseif (sensor_data.getEngineRightRPM() <= .44 or hyd_light == 1) and r_hyd_value >= 0.1 then
        r_hyd_value = r_hyd_value - 5
    end
    --HYD ENGINE LEFT
    if sensor_data.getEngineLeftRPM() >= .30 and hyd_light ~= 1 and l_hyd_value <= 3945 then
        l_hyd_value = l_hyd_value + 5
    elseif (sensor_data.getEngineLeftRPM() <= .44 or hyd_light == 1) and l_hyd_value >= 0.1 then
        l_hyd_value = l_hyd_value - 5
    end
    --HYD COLOR CHANGE RIGHT
    if r_hyd_value >= 1001 then
        parameters.R_HYD_COLOR:set(0)
    elseif r_hyd_value <= 1000 then
        parameters.R_HYD_COLOR:set(1)
    end
    --HYD COLOR CHANGE LEFT
    if l_hyd_value >= 1001 then
        parameters.L_HYD_COLOR:set(0)
    elseif l_hyd_value <= 1000 then
        parameters.L_HYD_COLOR:set(1)
    end
------------------------------------------------------------------FCS PAGE LOGIC---------------------------------------------------------------------------------------------------------

    if parameters.FUEL:get() >= 13456 then
        parameters.TANK_OPACITY:set(1)
    else
        parameters.TANK_OPACITY:set(0)
    end
------------------------------------------------------------------FUEL PAGE LOGIC--------------------------------------------------------------------------------------------------------
------------------------------------------------------------------ADI PAGE LOGIC---------------------------------------------------------------------------------------------------------
------------------------------------------------------------------HSI PAGE LOGIC---------------------------------------------------------------------------------------------------------
------------------------------------------------------------------BAY PAGE LOGIC---------------------------------------------------------------------------------------------------------





-------------------------------------------------------------------------------------PAGE-UPDATE-----------------------------------------------------------------------------------------
--LEFT MFD
    -- 0=MENU, 1=ENG, 2=FCS, 3=FUEL, 4=ADI, 5=BAY, 6=CHKLIST, 7=SMS, 8=HSI    
    if lmfd_current_page == 0 and parameters.MAIN_POWER:get() == 1 then --MENU PAGE
        parameters.LMFD_MENU_PAGE:set(1)
        parameters.LMFD_MASK:set(0)
        parameters.LMFD_ENG_PAGE:set(0)
        parameters.LMFD_NAV_PAGE:set(0)
        parameters.LMFD_BAY_PAGE:set(0)
        parameters.LMFD_CHECKLIST_PAGE:set(0)
        parameters.LMFD_FCS_PAGE:set(0)
        parameters.LMFD_SMS_PAGE:set(0)
        parameters.LMFD_HSI_PAGE:set(0)
        parameters.LMFD_FUEL_PAGE:set(0)
        parameters.LMFD_STARTUP_PAGE:set(0)
    elseif lmfd_current_page == 1 and parameters.MAIN_POWER:get() == 1 then --ENGINE PAGE
        parameters.LMFD_MENU_PAGE:set(0)
        parameters.LMFD_MASK:set(0) 
        parameters.LMFD_ENG_PAGE:set(1)
        parameters.LMFD_NAV_PAGE:set(0)
        parameters.LMFD_BAY_PAGE:set(0)
        parameters.LMFD_CHECKLIST_PAGE:set(0)
        parameters.LMFD_FCS_PAGE:set(0)
        parameters.LMFD_SMS_PAGE:set(0)
        parameters.LMFD_HSI_PAGE:set(0)
        parameters.LMFD_FUEL_PAGE:set(0)
		parameters.LMFD_STARTUP_PAGE:set(0)
    elseif lmfd_current_page == 2 and parameters.MAIN_POWER:get() == 1 then --FCS PAGE
        parameters.LMFD_MENU_PAGE:set(0)
        parameters.LMFD_MASK:set(0)
        parameters.LMFD_ENG_PAGE:set(0)
        parameters.LMFD_NAV_PAGE:set(0)
        parameters.LMFD_BAY_PAGE:set(0)
        parameters.LMFD_CHECKLIST_PAGE:set(0)
        parameters.LMFD_FCS_PAGE:set(1)
        parameters.LMFD_SMS_PAGE:set(0)
        parameters.LMFD_HSI_PAGE:set(0)
        parameters.LMFD_FUEL_PAGE:set(0)
		parameters.LMFD_STARTUP_PAGE:set(0)
    elseif lmfd_current_page == 3 and parameters.MAIN_POWER:get() == 1 then --FUEL PAGE
        parameters.LMFD_MENU_PAGE:set(0)
        parameters.LMFD_MASK:set(0)
        parameters.LMFD_ENG_PAGE:set(0)
        parameters.LMFD_NAV_PAGE:set(0)
        parameters.LMFD_BAY_PAGE:set(0)
        parameters.LMFD_CHECKLIST_PAGE:set(0)
        parameters.LMFD_FCS_PAGE:set(0)
        parameters.LMFD_SMS_PAGE:set(0)
        parameters.LMFD_HSI_PAGE:set(0)
        parameters.LMFD_FUEL_PAGE:set(1)
		parameters.LMFD_STARTUP_PAGE:set(0)
    elseif lmfd_current_page == 4 and parameters.MAIN_POWER:get() == 1 then --ADI PAGE
        parameters.LMFD_MENU_PAGE:set(0)
        parameters.LMFD_MASK:set(0)
        parameters.LMFD_ENG_PAGE:set(0)
        parameters.LMFD_NAV_PAGE:set(1)
        parameters.LMFD_BAY_PAGE:set(0)
        parameters.LMFD_CHECKLIST_PAGE:set(0)
        parameters.LMFD_FCS_PAGE:set(0)
        parameters.LMFD_SMS_PAGE:set(0)
        parameters.LMFD_HSI_PAGE:set(0)
        parameters.LMFD_FUEL_PAGE:set(0)
		parameters.LMFD_STARTUP_PAGE:set(0)
    elseif lmfd_current_page == 5 and parameters.MAIN_POWER:get() == 1 then --BAY PAGE
        parameters.LMFD_MENU_PAGE:set(0)
        parameters.LMFD_MASK:set(0)
        parameters.LMFD_ENG_PAGE:set(0)
        parameters.LMFD_NAV_PAGE:set(0)
        parameters.LMFD_BAY_PAGE:set(1)
        parameters.LMFD_CHECKLIST_PAGE:set(0)
        parameters.LMFD_FCS_PAGE:set(0)
        parameters.LMFD_SMS_PAGE:set(0)
        parameters.LMFD_HSI_PAGE:set(0)
        parameters.LMFD_FUEL_PAGE:set(0)
		parameters.LMFD_STARTUP_PAGE:set(0)
    elseif lmfd_current_page == 6 and parameters.MAIN_POWER:get() == 1 then --CHECKLIST PAGE
        parameters.LMFD_MENU_PAGE:set(0)
        parameters.LMFD_MASK:set(0)
        parameters.LMFD_ENG_PAGE:set(0)
        parameters.LMFD_NAV_PAGE:set(0)
        parameters.LMFD_BAY_PAGE:set(0)
        parameters.LMFD_CHECKLIST_PAGE:set(1)
        parameters.LMFD_FCS_PAGE:set(0)
        parameters.LMFD_SMS_PAGE:set(0)
        parameters.LMFD_HSI_PAGE:set(0)
        parameters.LMFD_FUEL_PAGE:set(0)
		parameters.LMFD_STARTUP_PAGE:set(0)
    elseif lmfd_current_page == 7 and parameters.MAIN_POWER:get() == 1 then --SMS PAGE
        parameters.LMFD_MENU_PAGE:set(0)
        parameters.LMFD_MASK:set(1)
        parameters.LMFD_ENG_PAGE:set(0)
        parameters.LMFD_NAV_PAGE:set(0)
        parameters.LMFD_BAY_PAGE:set(0)
        parameters.LMFD_CHECKLIST_PAGE:set(0)
        parameters.LMFD_FCS_PAGE:set(0)
        parameters.LMFD_SMS_PAGE:set(1)
        parameters.LMFD_HSI_PAGE:set(0)
        parameters.LMFD_FUEL_PAGE:set(0)
		parameters.LMFD_STARTUP_PAGE:set(0)
    elseif lmfd_current_page == 8 and parameters.MAIN_POWER:get() == 1 then --HSI PAGE
        parameters.LMFD_MENU_PAGE:set(0)
        parameters.LMFD_MASK:set(0)
        parameters.LMFD_ENG_PAGE:set(0)
        parameters.LMFD_NAV_PAGE:set(0)
        parameters.LMFD_BAY_PAGE:set(0)
        parameters.LMFD_CHECKLIST_PAGE:set(0)
        parameters.LMFD_FCS_PAGE:set(0)
        parameters.LMFD_SMS_PAGE:set(0)
        parameters.LMFD_HSI_PAGE:set(1)
        parameters.LMFD_FUEL_PAGE:set(0)
		parameters.LMFD_STARTUP_PAGE:set(0)
	elseif lmfd_current_page == 10 and parameters.MAIN_POWER:get() == 1 then --STARTUP PAGE
		parameters.LMFD_MENU_PAGE:set(0)
		parameters.LMFD_MASK:set(0)
		parameters.LMFD_ENG_PAGE:set(0)
		parameters.LMFD_NAV_PAGE:set(0)
		parameters.LMFD_BAY_PAGE:set(0)
		parameters.LMFD_CHECKLIST_PAGE:set(0)
		parameters.LMFD_FCS_PAGE:set(0)
		parameters.LMFD_SMS_PAGE:set(0)
		parameters.LMFD_HSI_PAGE:set(0)
		parameters.LMFD_FUEL_PAGE:set(0)
		parameters.LMFD_STARTUP_PAGE:set(1)
	elseif lmfd_current_page >= 0 and parameters.APU_RPM_STATE:get() >= 2 and parameters.MAIN_POWER:get() == 0 then	
		parameters.LMFD_MENU_PAGE:set(0)
		parameters.LMFD_MASK:set(0)
		parameters.LMFD_ENG_PAGE:set(0)
		parameters.LMFD_NAV_PAGE:set(0)
		parameters.LMFD_BAY_PAGE:set(0)
		parameters.LMFD_CHECKLIST_PAGE:set(0)
		parameters.LMFD_FCS_PAGE:set(0)
		parameters.LMFD_SMS_PAGE:set(0)
		parameters.LMFD_HSI_PAGE:set(0)
		parameters.LMFD_FUEL_PAGE:set(0)
		parameters.LMFD_STARTUP_PAGE:set(1)
	elseif lmfd_current_page >= 0 and parameters.MAIN_POWER:get() == 0 then --MAIN POWER OFF SET ENG PAGE FOR APU
		parameters.LMFD_MENU_PAGE:set(0)
		parameters.LMFD_MASK:set(1)
		parameters.LMFD_ENG_PAGE:set(0)
		parameters.LMFD_NAV_PAGE:set(0)
		parameters.LMFD_BAY_PAGE:set(0)
		parameters.LMFD_CHECKLIST_PAGE:set(0)
		parameters.LMFD_FCS_PAGE:set(0)
		parameters.LMFD_SMS_PAGE:set(0)
		parameters.LMFD_HSI_PAGE:set(0)
		parameters.LMFD_FUEL_PAGE:set(0)
		parameters.LMFD_STARTUP_PAGE:set(0)

end
--END LEFT MFD
--RIGHT MFD
    if rmfd_current_page == 0 and parameters.MAIN_POWER:get() == 1 then --MENU PAGE
        parameters.RMFD_MENU_PAGE:set(1)
        parameters.RMFD_MASK:set(0)
        parameters.RMFD_ENG_PAGE:set(0)
        parameters.RMFD_NAV_PAGE:set(0)
        parameters.RMFD_BAY_PAGE:set(0)
        parameters.RMFD_CHECKLIST_PAGE:set(0)
        parameters.RMFD_FCS_PAGE:set(0)
        parameters.RMFD_RWR_PAGE:set(0)
        parameters.RMFD_HSI_PAGE:set(0)
        parameters.RMFD_FUEL_PAGE:set(0)
		parameters.RMFD_ECMS_PAGE:set(0)
    elseif rmfd_current_page == 1 and parameters.MAIN_POWER:get() == 1 then --ENGINE PAGE
        parameters.RMFD_MENU_PAGE:set(0)
        parameters.RMFD_MASK:set(0) 
        parameters.RMFD_ENG_PAGE:set(1)
        parameters.RMFD_NAV_PAGE:set(0)
        parameters.RMFD_BAY_PAGE:set(0)
        parameters.RMFD_CHECKLIST_PAGE:set(0)
        parameters.RMFD_FCS_PAGE:set(0)
        parameters.RMFD_RWR_PAGE:set(0)
        parameters.RMFD_HSI_PAGE:set(0)
        parameters.RMFD_FUEL_PAGE:set(0)
		parameters.RMFD_ECMS_PAGE:set(0)
    elseif rmfd_current_page == 2 and parameters.MAIN_POWER:get() == 1 then --FCS PAGE
        parameters.RMFD_MENU_PAGE:set(0)
        parameters.RMFD_MASK:set(0)
        parameters.RMFD_ENG_PAGE:set(0)
        parameters.RMFD_NAV_PAGE:set(0)
        parameters.RMFD_BAY_PAGE:set(0)
        parameters.RMFD_CHECKLIST_PAGE:set(0)
        parameters.RMFD_FCS_PAGE:set(1)
        parameters.RMFD_RWR_PAGE:set(0)
        parameters.RMFD_HSI_PAGE:set(0)
        parameters.RMFD_FUEL_PAGE:set(0)
		parameters.RMFD_ECMS_PAGE:set(0)
    elseif rmfd_current_page == 3 and parameters.MAIN_POWER:get() == 1 then --FUEL PAGE
        parameters.RMFD_MENU_PAGE:set(0)
        parameters.RMFD_MASK:set(0)
        parameters.RMFD_ENG_PAGE:set(0)
        parameters.RMFD_NAV_PAGE:set(0)
        parameters.RMFD_BAY_PAGE:set(0)
        parameters.RMFD_CHECKLIST_PAGE:set(0)
        parameters.RMFD_FCS_PAGE:set(0)
        parameters.RMFD_RWR_PAGE:set(0)
        parameters.RMFD_HSI_PAGE:set(0)
        parameters.RMFD_FUEL_PAGE:set(1)
		parameters.RMFD_ECMS_PAGE:set(0)
    elseif rmfd_current_page == 4 and parameters.MAIN_POWER:get() == 1 then --ADI PAGE
        parameters.RMFD_MENU_PAGE:set(0)
        parameters.RMFD_MASK:set(0)
        parameters.RMFD_ENG_PAGE:set(0)
        parameters.RMFD_NAV_PAGE:set(1)
        parameters.RMFD_BAY_PAGE:set(0)
        parameters.RMFD_CHECKLIST_PAGE:set(0)
        parameters.RMFD_FCS_PAGE:set(0)
        parameters.RMFD_RWR_PAGE:set(0)
        parameters.RMFD_HSI_PAGE:set(0)
        parameters.RMFD_FUEL_PAGE:set(0)
		parameters.RMFD_ECMS_PAGE:set(0)
    elseif rmfd_current_page == 5 and parameters.MAIN_POWER:get() == 1 then --BAY PAGE
        parameters.RMFD_MENU_PAGE:set(0)
        parameters.RMFD_MASK:set(0)
        parameters.RMFD_ENG_PAGE:set(0)
        parameters.RMFD_NAV_PAGE:set(0)
        parameters.RMFD_BAY_PAGE:set(1)
        parameters.RMFD_CHECKLIST_PAGE:set(0)
        parameters.RMFD_FCS_PAGE:set(0)
        parameters.RMFD_RWR_PAGE:set(0)
        parameters.RMFD_HSI_PAGE:set(0)
        parameters.RMFD_FUEL_PAGE:set(0)
		parameters.RMFD_ECMS_PAGE:set(0)
    elseif rmfd_current_page == 6 and parameters.MAIN_POWER:get() == 1 then --CHECKLIST PAGE
        parameters.RMFD_MENU_PAGE:set(0)
        parameters.RMFD_MASK:set(0)
        parameters.RMFD_ENG_PAGE:set(0)
        parameters.RMFD_NAV_PAGE:set(0)
        parameters.RMFD_BAY_PAGE:set(0)
        parameters.RMFD_CHECKLIST_PAGE:set(1)
        parameters.RMFD_FCS_PAGE:set(0)
        parameters.RMFD_RWR_PAGE:set(0)
        parameters.RMFD_HSI_PAGE:set(0)
        parameters.RMFD_FUEL_PAGE:set(0)
		parameters.RMFD_ECMS_PAGE:set(0)
    elseif rmfd_current_page == 7 and parameters.MAIN_POWER:get() == 1 then --RWR PAGE
        parameters.RMFD_MENU_PAGE:set(0)
        parameters.RMFD_MASK:set(0) --1
        parameters.RMFD_ENG_PAGE:set(0)
        parameters.RMFD_NAV_PAGE:set(0)
        parameters.RMFD_BAY_PAGE:set(0)
        parameters.RMFD_CHECKLIST_PAGE:set(0)
        parameters.RMFD_FCS_PAGE:set(0)
        parameters.RMFD_RWR_PAGE:set(1)
        parameters.RMFD_HSI_PAGE:set(0)
        parameters.RMFD_FUEL_PAGE:set(0)
		parameters.RMFD_ECMS_PAGE:set(0)
    elseif rmfd_current_page == 8 and parameters.MAIN_POWER:get() == 1 then --HSI PAGE
        parameters.RMFD_MENU_PAGE:set(0)
        parameters.RMFD_MASK:set(0)
        parameters.RMFD_ENG_PAGE:set(0)
        parameters.RMFD_NAV_PAGE:set(0)
        parameters.RMFD_BAY_PAGE:set(0)
        parameters.RMFD_CHECKLIST_PAGE:set(0)
        parameters.RMFD_FCS_PAGE:set(0)
        parameters.RMFD_RWR_PAGE:set(0)
        parameters.RMFD_HSI_PAGE:set(1)
        parameters.RMFD_FUEL_PAGE:set(0)
		parameters.RMFD_ECMS_PAGE:set(0)
	elseif rmfd_current_page == 10 and parameters.MAIN_POWER:get() == 1 then --HSI PAGE
        parameters.RMFD_MENU_PAGE:set(0)
        parameters.RMFD_MASK:set(0)
        parameters.RMFD_ENG_PAGE:set(0)
        parameters.RMFD_NAV_PAGE:set(0)
        parameters.RMFD_BAY_PAGE:set(0)
        parameters.RMFD_CHECKLIST_PAGE:set(0)
        parameters.RMFD_FCS_PAGE:set(0)
        parameters.RMFD_RWR_PAGE:set(0)
        parameters.RMFD_HSI_PAGE:set(0)
        parameters.RMFD_FUEL_PAGE:set(0)
		parameters.RMFD_ECMS_PAGE:set(1)
    elseif parameters.APU_RPM_STATE:get() >= 2 and parameters.MAIN_POWER:get() == 0 then --and parameters.DAY_NIGHT:get() == 1
        parameters.RMFD_MENU_PAGE:set(0)
        parameters.RMFD_MASK:set(0)
        parameters.RMFD_ENG_PAGE:set(0)
        parameters.RMFD_NAV_PAGE:set(0)
        parameters.RMFD_BAY_PAGE:set(0)
        parameters.RMFD_CHECKLIST_PAGE:set(0)
        parameters.RMFD_FCS_PAGE:set(0)
        parameters.RMFD_RWR_PAGE:set(0)
        parameters.RMFD_HSI_PAGE:set(0)
        parameters.RMFD_FUEL_PAGE:set(0)
		parameters.RMFD_ECMS_PAGE:set(0)		
    end
--END RIGHT MFD
--CENTER MFD
    if cmfd_current_page == 0 and parameters.MAIN_POWER:get() == 1 then --MENU PAGE
        parameters.CMFD_MENU_PAGE:set(1)
        parameters.CMFD_ENG_PAGE:set(0)
        parameters.CMFD_NAV_PAGE:set(0)
        parameters.CMFD_BAY_PAGE:set(0)
        parameters.CMFD_CHECKLIST_PAGE:set(0)
        parameters.CMFD_FCS_PAGE:set(0)
        parameters.CMFD_HSI_PAGE:set(0)
        parameters.CMFD_FUEL_PAGE:set(0)
    elseif cmfd_current_page == 1 and parameters.MAIN_POWER:get() == 1 then --ENGINE PAGE
        parameters.CMFD_MENU_PAGE:set(0)
        parameters.CMFD_ENG_PAGE:set(1)
        parameters.CMFD_NAV_PAGE:set(0)
        parameters.CMFD_BAY_PAGE:set(0)
        parameters.CMFD_CHECKLIST_PAGE:set(0)
        parameters.CMFD_FCS_PAGE:set(0)
        parameters.CMFD_HSI_PAGE:set(0)
        parameters.CMFD_FUEL_PAGE:set(0)
    elseif cmfd_current_page == 2 and parameters.MAIN_POWER:get() == 1 then --FCS PAGE
        parameters.CMFD_MENU_PAGE:set(0)
        parameters.CMFD_ENG_PAGE:set(0)
        parameters.CMFD_NAV_PAGE:set(0)
        parameters.CMFD_BAY_PAGE:set(0)
        parameters.CMFD_CHECKLIST_PAGE:set(0)
        parameters.CMFD_FCS_PAGE:set(1)
        parameters.CMFD_HSI_PAGE:set(0)
        parameters.CMFD_FUEL_PAGE:set(0)
    elseif cmfd_current_page == 3 and parameters.MAIN_POWER:get() == 1 then --FUEL PAGE
        parameters.CMFD_MENU_PAGE:set(0)
        parameters.CMFD_ENG_PAGE:set(0)
        parameters.CMFD_NAV_PAGE:set(0)
        parameters.CMFD_BAY_PAGE:set(0)
        parameters.CMFD_CHECKLIST_PAGE:set(0)
        parameters.CMFD_FCS_PAGE:set(0)
        parameters.CMFD_HSI_PAGE:set(0)
        parameters.CMFD_FUEL_PAGE:set(1)
    elseif cmfd_current_page == 4 and parameters.MAIN_POWER:get() == 1 then --ADI PAGE
        parameters.CMFD_MENU_PAGE:set(0)
        parameters.CMFD_ENG_PAGE:set(0)
        parameters.CMFD_NAV_PAGE:set(1)
        parameters.CMFD_BAY_PAGE:set(0)
        parameters.CMFD_CHECKLIST_PAGE:set(0)
        parameters.CMFD_FCS_PAGE:set(0)
        parameters.CMFD_HSI_PAGE:set(0)
        parameters.CMFD_FUEL_PAGE:set(0)
    elseif cmfd_current_page == 5 and parameters.MAIN_POWER:get() == 1 then --BAY PAGE
        parameters.CMFD_MENU_PAGE:set(0)
        parameters.CMFD_ENG_PAGE:set(0)
        parameters.CMFD_NAV_PAGE:set(0)
        parameters.CMFD_BAY_PAGE:set(1)
        parameters.CMFD_CHECKLIST_PAGE:set(0)
        parameters.CMFD_FCS_PAGE:set(0)
        parameters.CMFD_HSI_PAGE:set(0)
        parameters.CMFD_FUEL_PAGE:set(0)
    elseif cmfd_current_page == 6 and parameters.MAIN_POWER:get() == 1 then --CHECKLIST PAGE
        parameters.CMFD_MENU_PAGE:set(0)
        parameters.CMFD_ENG_PAGE:set(0)
        parameters.CMFD_NAV_PAGE:set(0)
        parameters.CMFD_BAY_PAGE:set(0)
        parameters.CMFD_CHECKLIST_PAGE:set(1)
        parameters.CMFD_FCS_PAGE:set(0)
        parameters.CMFD_HSI_PAGE:set(0)
        parameters.CMFD_FUEL_PAGE:set(0)
    elseif cmfd_current_page == 8 and parameters.MAIN_POWER:get() == 1 then --HSI PAGE
        parameters.CMFD_MENU_PAGE:set(0)
        parameters.CMFD_ENG_PAGE:set(0)
        parameters.CMFD_NAV_PAGE:set(0)
        parameters.CMFD_BAY_PAGE:set(0)
        parameters.CMFD_CHECKLIST_PAGE:set(0)
        parameters.CMFD_FCS_PAGE:set(0)
        parameters.CMFD_HSI_PAGE:set(1)
        parameters.CMFD_FUEL_PAGE:set(0)
    elseif cmfd_current_page >= 0 and parameters.APU_RPM_STATE:get() >= 2 and parameters.MAIN_POWER:get() == 0 then -- and parameters.DAY_NIGHT:get() == 1
        parameters.CMFD_MENU_PAGE:set(0)
        parameters.CMFD_ENG_PAGE:set(0)
        parameters.CMFD_NAV_PAGE:set(0)
        parameters.CMFD_BAY_PAGE:set(0)
        parameters.CMFD_CHECKLIST_PAGE:set(0)
        parameters.CMFD_FCS_PAGE:set(0)
        parameters.CMFD_HSI_PAGE:set(0)
        parameters.CMFD_FUEL_PAGE:set(0)        
    end
--END CENTER MFD



end
need_to_be_closed = false
--Ref
    -- parameters.TAS	        :set(sensor_data.getTrueAirSpeed() * 1.944)
	-- parameters.IAS	        :set(sensor_data.getIndicatedAirSpeed() * 1.944)
	-- parameters.GFORCE       :set(sensor_data.getVerticalAcceleration())
	-- parameters.ADI_PITCH    :set(sensor_data.getPitch() )
	-- parameters.ADI_ROLL     :set(sensor_data.getRoll() )
	-- parameters.YAW          :set(sensor_data.getRateOfYaw() )
	-- parameters.ROLLRATE     :set(sensor_data.getRateOfRoll()/math.pi*180)-- Testing
	-- parameters.NAV          :set(360 - sensor_data.getHeading()/math.pi*180) -- Working, don't change
	-- parameters.RADALT       :set(sensor_data.getRadarAltitude() ) -- Working, don't change
	-- parameters.BARO         :set(sensor_data.getBarometricAltitude() * 3.28084 ) -- Working, don't change	
	-- parameters.RPM_L        :set(sensor_data.getEngineLeftRPM())-- Needs to be tested (might not need to multiply by 2750 cause that was from fixed prop? maybe)
	-- parameters.RPM_R        :set(sensor_data.getEngineRightRPM())
	-- parameters.FUELL        :set(sensor_data.getTotalFuelWeight() * 0.01 ) -- Working, don't change: 0.36622 
	-- parameters.FUEL         :set(sensor_data.getTotalFuelWeight() * 2.20462 ) -- Working, don't change: 0.36622
	-- parameters.FUELT        :set(sensor_data.getTotalFuelWeight() * 2.20462 - 13454 ) -- Working, don't change: 0.36622 
	-- parameters.EGT_L        :set(sensor_data.getEngineLeftTemperatureBeforeTurbine())
    -- parameters.EGT_R        :set(sensor_data.getEngineRightTemperatureBeforeTurbine())
    --getAngleOfAttack
    --getAngleOfSlide
    --getBarometricAltitude
    --getCanopyPos
    --getCanopyState
    --getEngineLeftFuelConsumption
    --getEngineLeftRPM
    --getEngineLeftTemperatureBeforeTurbine
    --getEngineRightFuelConsumption
    --getEngineRightRPM
    --getEngineRightTemperatureBeforeTurbine
    --getFlapsPos
    --getFlapsRetracted
    --getHeading
    --getHelicopterCollective
    --getHelicopterCorrection
    --getHorizontalAcceleration
    --getIndicatedAirSpeed
    --getLandingGearHandlePos
    --getLateralAcceleration
    --getLeftMainLandingGearDown
    --getLeftMainLandingGearUp
    --getMachNumber
    --getMagneticHeading
    --getNoseLandingGearDown
    --getNoseLandingGearUp
    --getPitch
    --getRadarAltitude
    --getRateOfPitch
    --getRateOfRoll
    --getRateOfYaw
    --getRightMainLandingGearDown
    --getRightMainLandingGearUp
    --getRoll
    --getRudderPosition
    --getSelfAirspeed
    --getSelfCoordinates
    --getSelfVelocity
    --getSpeedBrakePos
    --getStickPitchPosition
    --getStickRollPosition
    --getThrottleLeftPosition
    --getThrottleRightPosition
    --getTotalFuelWeight
    --getTrueAirSpeed
    --getVerticalAcceleration
    --getVerticalVelocity
    --getWOW_LeftMainLandingGear
    --getWOW_NoseLandingGear
    --getWOW_RightMainLandingGear
