dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")

local dev = GetSelf()
local sensor_data		= get_base_data()

local update_time_step = 0.006 --0.006
make_default_activity(update_time_step)

local parameters = {

    APU_POWER			    = get_param_handle("APU_POWER"),
    APU_RPM_STATE		    = get_param_handle("APU_RPM_STATE"),
    BATTERY_POWER		    = get_param_handle("BATTERY_POWER"),
    MAIN_POWER			    = get_param_handle("MAIN_POWER"),
    WoW			            = get_param_handle("WoW"),
    RADAR_MODE			    = get_param_handle("RADAR_MODE"),
    RADAR_PWR   			= get_param_handle("RADAR_PWR"),
	HUD_OPACITY				= get_param_handle("HUD_OPACITY"),
    ICP_OPACITY             = get_param_handle("ICP_OPACITY"),
	ICP_INPUT				= get_param_handle("ICP_INPUT"),
	ICP_COM1_MENU			= get_param_handle("ICP_COM1_MENU"),
	ICP_COM2_MENU			= get_param_handle("ICP_COM2_MENU"),
	ICP_NAV_MENU			= get_param_handle("ICP_NAV_MENU"),
	ICP_STPT_MENU			= get_param_handle("ICP_STPT_MENU"),
	ICP_ALT_MENU			= get_param_handle("ICP_ALT_MENU"),
    ICP_HUD_MENU            = get_param_handle("ICP_HUD_MENU"),
    ICP_OTHER_MENU          = get_param_handle("ICP_OTHER_MENU"),
    ICP_AP_MENU             = get_param_handle("ICP_AP_MENU"),	
	ICP_COM1_TITLE			= get_param_handle("ICP_COM1_TITLE"),
	ICP_COM2_TITLE			= get_param_handle("ICP_COM2_TITLE"),
	ICP_NAV_TITLE			= get_param_handle("ICP_NAV_TITLE"),
	ICP_STPT_TITLE			= get_param_handle("ICP_STPT_TITLE"),
	ICP_ALT_TITLE			= get_param_handle("ICP_ALT_TITLE"),
    ICP_HUD_TITLE            = get_param_handle("ICP_HUD_TITLE"),
    ICP_OTHER_TITLE          = get_param_handle("ICP_OTHER_TITLE"),
    ICP_AP_TITLE             = get_param_handle("ICP_AP_TITLE"),
    UPDATE_BINGO             = get_param_handle("UPDATE_BINGO"),
    ICP_BINGO_MENU             = get_param_handle("ICP_BINGO_MENU"),
	BINGO_VAL			  	  = get_param_handle("BINGO_VAL"),

}

 local   COM1               = device_commands.Button_1
 local   COM2               = device_commands.Button_2
 local   NAV                = device_commands.Button_3
 local   STP                = device_commands.Button_4
 local   ALT                = device_commands.Button_5
 local   HUD                = device_commands.Button_6
 local   OTHR               = device_commands.Button_7
 local   OP1                = device_commands.Button_8
 local   OP2                = device_commands.Button_9
 local   OP3                = device_commands.Button_10
 local   OP4                = device_commands.Button_11
 local   OP5                = device_commands.Button_12
 local   UP                 = device_commands.Button_13
 local   DWN                = device_commands.Button_14
 local   AP                 = device_commands.Button_15
 local   MRK                = device_commands.Button_16
 local   N1                 = device_commands.Button_17
 local   N2                 = device_commands.Button_18
 local   N3                 = device_commands.Button_19
 local   N4                 = device_commands.Button_20
 local   N5                 = device_commands.Button_21
 local   N6                 = device_commands.Button_22
 local   N7                 = device_commands.Button_23
 local   N8                 = device_commands.Button_24
 local   N9                 = device_commands.Button_25
 local   CKE                = device_commands.Button_26
 local   N0                 = device_commands.Button_27
 local   UNDO               = device_commands.Button_28
 local HUD_KNOB_mouse   	= device_commands.Button_29	 --HUD
 local   KNEE_NEXT          = device_commands.Button_31
 local   KNEE_PREV          = device_commands.Button_32

    --local PlaneFuelOn 					= Keys.PlaneFuelOn --fuel dump
--modes
local PlaneModeNAV 						= Keys.PlaneModeNAV	--1						
local PlaneModeBVR 						= Keys.PlaneModeBVR	--2						
local PlaneModeVS 						= Keys.PlaneModeVS --3								
local PlaneModeBore 					= Keys.PlaneModeBore --4
local PlaneModeFI0 						= Keys.PlaneModeFI0 --6


--NAV
local NextSteer			 	= Keys.PlaneChangeTarget --steer point up
local PrevSteer 			= 1315 --steer point prev
--AP
local AutoAttHold 		    = 62
local AutoAltHold 		    = 389
local AutoCancel 		    = 408
local PlaneShowKneeboard    = 1587
local Kneeboard_Next        = 3001
local Kneeboard_Prev        = 3002
local Kneeboard_Mark        = 3003
local Radio_Menu            = 179
local Rearm_Menu            = 1560

--ICP
local ICP_COM1         = 10041
local ICP_COM2         = 10042
local ICP_NAV          = 10043
local ICP_STPT         = 10044
local ICP_ALT          = 10045
local ICP_HUD          = 10046
local ICP_AP           = 10047
local ICP_OP1          = 10048
local ICP_OP2          = 10049
local ICP_OP3          = 10050
local ICP_OP4          = 10051
local ICP_OP5          = 10052
local ICP_OTHR         = 10053

dev:listen_command(ICP_COM1)
dev:listen_command(ICP_COM2)
dev:listen_command(ICP_NAV)
dev:listen_command(ICP_ALT)
dev:listen_command(ICP_HUD)
dev:listen_command(ICP_AP)
dev:listen_command(ICP_OTHR)
dev:listen_command(ICP_OP1)
dev:listen_command(ICP_OP2)
dev:listen_command(ICP_OP3)
dev:listen_command(ICP_OP4)
dev:listen_command(ICP_OP5)
dev:listen_command(HUD_KNOB_mouse)

dev:listen_command(N0)
dev:listen_command(N1)
dev:listen_command(N2)
dev:listen_command(N3)
dev:listen_command(N4)
dev:listen_command(N5)
dev:listen_command(N6)
dev:listen_command(N7)
dev:listen_command(N8)
dev:listen_command(N9)
dev:listen_command(CKE)
dev:listen_command(UNDO)


dev:listen_command(COM1)
dev:listen_command(COM2)
dev:listen_command(NAV)
dev:listen_command(STP)
dev:listen_command(ALT)
dev:listen_command(HUD)
dev:listen_command(OTHR)
dev:listen_command(OP1)
dev:listen_command(OP2)
dev:listen_command(OP3)
dev:listen_command(OP4)
dev:listen_command(OP5)
dev:listen_command(UP)
dev:listen_command(DWN)
dev:listen_command(AP)
dev:listen_command(MRK)

dev:listen_command(PlaneModeNAV)
dev:listen_command(PlaneModeBVR)
dev:listen_command(PlaneModeVS)
dev:listen_command(PlaneModeBore)
dev:listen_command(PlaneModeFI0)
dev:listen_command(PlaneThreatWarnSoundVolumeDown)
dev:listen_command(PlaneThreatWarnSoundVolumeUp)
dev:listen_command(NextSteer)
dev:listen_command(PrevSteer)
dev:listen_command(AutoAttHold)
dev:listen_command(AutoAltHold)
dev:listen_command(AutoCancel)
dev:listen_command(PlaneShowKneeboard)

dev:listen_command(Kneeboard_Mark)


local icp_com1_page = 0
local icp_com2_page = 0
local icp_nav_page = 0
local icp_stpt_page = 0
local icp_alt_page = 0
local icp_hud_page = 0
local icp_other_page = 0
local icp_ap_page = 0
local icp_com1_title = 0
local icp_com2_title = 0
local icp_nav_title = 0
local icp_stpt_title = 0
local icp_alt_title = 0
local icp_hud_title = 0
local icp_other_title = 0
local icp_ap_title = 0
local icp_bingo_menu = 0

local update_val = 0



local icp_input_string = ""
local allow_input = 0


function EnableICPInput(command)
    -- Apply 5-character limit only for bingo menu
    local can_append = true
    if icp_bingo_menu == 1 and string.len(icp_input_string) >= 5 then
        can_append = false
    end

    -- Append digits if allowed
    if can_append then
        if command == N0 then
            icp_input_string = icp_input_string .. "0"
        elseif command == N1 then
            icp_input_string = icp_input_string .. "1"
        elseif command == N2 then
            icp_input_string = icp_input_string .. "2"
        elseif command == N3 then
            icp_input_string = icp_input_string .. "3"
        elseif command == N4 then
            icp_input_string = icp_input_string .. "4"
        elseif command == N5 then
            icp_input_string = icp_input_string .. "5"
        elseif command == N6 then
            icp_input_string = icp_input_string .. "6"
        elseif command == N7 then
            icp_input_string = icp_input_string .. "7"
        elseif command == N8 then
            icp_input_string = icp_input_string .. "8"
        elseif command == N9 then
            icp_input_string = icp_input_string .. "9"
        end
    end

    -- Handle UNDO and CKE regardless of length
    if command == UNDO and icp_input_string ~= "" then
        icp_input_string = string.sub(icp_input_string, 1, -2)
    elseif command == CKE then
        icp_input_string = ""
    end
end

------------------------------------------------------------------FUNCTION-POST-INIT---------------------------------------------------------------------------------------------------
function post_initialize()

    local birth_place = LockOn_Options.init_conditions.birth_place

	if birth_place == "GROUND_COLD" then
		dev:performClickableAction(HUD_KNOB_mouse, 0, false)
		icp_com1_page = 1
		icp_com1_title = 1
	elseif birth_place == "GROUND_HOT" or birth_place == "AIR_HOT" then
		dev:performClickableAction(HUD_KNOB_mouse, 1, false)
		icp_com1_page = 1
		icp_com1_title = 1

	end
end
------------------------------------------------------------------FUNCTION-SETCOMMAND---------------------------------------------------------------------------------------------------
function SetCommand(command,value)

	--PAGE NAV LOGIC
if parameters.MAIN_POWER:get() == 1 then
        if command == COM1 or command == ICP_COM1 then
            icp_input_string = ""
            allow_input = 0
            icp_bingo_menu = 0
            parameters.UPDATE_BINGO:set(0)
            icp_com1_page = 1
            icp_com1_title = 1
            icp_com2_page = 0
            icp_com2_title = 0
            icp_nav_page = 0
            icp_nav_title = 0
            icp_stpt_page = 0
            icp_stpt_title = 0
            icp_alt_page = 0
            icp_alt_title = 0
            icp_hud_page = 0
            icp_hud_title = 0
            icp_other_page = 0
            icp_other_title = 0
            icp_ap_page = 0
            icp_ap_title = 0
        elseif command == COM2 or command == ICP_COM2 then
            icp_input_string = ""
            allow_input = 0
            icp_bingo_menu = 0
            parameters.UPDATE_BINGO:set(0)
            icp_com1_page = 0
            icp_com1_title = 0
            icp_com2_page = 1
            icp_com2_title = 1
            icp_nav_page = 0
            icp_nav_title = 0
            icp_stpt_page = 0
            icp_stpt_title = 0
            icp_alt_page = 0
            icp_alt_title = 0
            icp_hud_page = 0
            icp_hud_title = 0
            icp_other_page = 0
            icp_other_title = 0
            icp_ap_page = 0
            icp_ap_title = 0
        elseif command == NAV or command == ICP_NAV then
            icp_input_string = ""
            allow_input = 0
            icp_bingo_menu = 0
            parameters.UPDATE_BINGO:set(0)
            icp_com1_page = 0
            icp_com1_title = 0
            icp_com2_page = 0
            icp_com2_title = 0
            icp_nav_page = 1
            icp_nav_title = 1
            icp_stpt_page = 0
            icp_stpt_title = 0
            icp_alt_page = 0
            icp_alt_title = 0
            icp_hud_page = 0
            icp_hud_title = 0
            icp_other_page = 0
            icp_other_title = 0
            icp_ap_page = 0
            icp_ap_title = 0
        elseif command == STP or command == ICP_STPT then
            icp_input_string = ""
            allow_input = 0
            icp_bingo_menu = 0
            parameters.UPDATE_BINGO:set(0)
            icp_com1_page = 0
            icp_com1_title = 0
            icp_com2_page = 0
            icp_com2_title = 0
            icp_nav_page = 0
            icp_nav_title = 0
            icp_stpt_page = 1
            icp_stpt_title = 1
            icp_alt_page = 0
            icp_alt_title = 0
            icp_hud_page = 0
            icp_hud_title = 0
            icp_other_page = 0
            icp_other_title = 0
            icp_ap_page = 0
            icp_ap_title = 0
        elseif command == ALT or command == ICP_ALT then
            icp_input_string = ""
            allow_input = 0
            icp_bingo_menu = 0
            parameters.UPDATE_BINGO:set(0)
            icp_com1_page = 0
            icp_com1_title = 0
            icp_com2_page = 0
            icp_com2_title = 0
            icp_nav_page = 0
            icp_nav_title = 0
            icp_stpt_page = 0
            icp_stpt_title = 0
            icp_alt_page = 1
            icp_alt_title = 1
            icp_hud_page = 0
            icp_hud_title = 0
            icp_other_page = 0
            icp_other_title = 0
            icp_ap_page = 0
            icp_ap_title = 0
        elseif command == HUD or command == ICP_HUD then
            icp_input_string = ""
            allow_input = 0
            icp_bingo_menu = 0
            parameters.UPDATE_BINGO:set(0)
            icp_com1_page = 0
            icp_com1_title = 0
            icp_com2_page = 0
            icp_com2_title = 0
            icp_nav_page = 0
            icp_nav_title = 0
            icp_stpt_page = 0
            icp_stpt_title = 0
            icp_alt_page = 0
            icp_alt_title = 0
            icp_hud_page = 1
            icp_hud_title = 1
            icp_other_page = 0
            icp_other_title = 0
            icp_ap_page = 0
            icp_ap_title = 0
        elseif command == OTHR or command == ICP_OTHR then
            icp_input_string = ""
            allow_input = 0
            icp_bingo_menu = 0
            parameters.UPDATE_BINGO:set(0)
            icp_com1_page = 0
            icp_com1_title = 0
            icp_com2_page = 0
            icp_com2_title = 0
            icp_nav_page = 0
            icp_nav_title = 0
            icp_stpt_page = 0
            icp_stpt_title = 0
            icp_alt_page = 0
            icp_alt_title = 0
            icp_hud_page = 0
            icp_hud_title = 0
            icp_other_page = 1
            icp_other_title = 1
            icp_ap_page = 0
            icp_ap_title = 0
        elseif command == AP or command == ICP_AP then
            icp_input_string = ""
            allow_input = 0
            icp_bingo_menu = 0
            parameters.UPDATE_BINGO:set(0)
            icp_com1_page = 0
            icp_com1_title = 0
            icp_com2_page = 0
            icp_com2_title = 0
            icp_nav_page = 0
            icp_nav_title = 0
            icp_stpt_page = 0
            icp_stpt_title = 0
            icp_alt_page = 0
            icp_alt_title = 0
            icp_hud_page = 0
            icp_hud_title = 0
            icp_other_page = 0
            icp_other_title = 0
            icp_ap_page = 1
            icp_ap_title = 1
        end
    end



	--PAGE 1 LOGIC
	if parameters.MAIN_POWER:get() == 1 and icp_com1_page == 1 then
        if command == OP2 or command == ICP_OP2 then
            icp_com1_title = 0
			allow_input = 1
        elseif command == OP3 then

        elseif command == OP4 then

        elseif command == OP5 then
            dispatch_action(nil, Rearm_Menu)

        end
    end
	
	--PAGE 2 LOGIC
	if parameters.MAIN_POWER:get() == 1 and icp_com2_page == 1 then	
		if command == OP2 or command == ICP_OP2 then
            icp_com2_title = 0
			allow_input = 1
		elseif command == OP2 then
		
		elseif command == OP3 then
		
		elseif command == OP4 then
		
		elseif command == OP5 then
			dispatch_action(nil, Rearm_Menu)
		end	
	end
		
	--PAGE 3 LOGIC
	if parameters.MAIN_POWER:get() == 1 and icp_nav_page == 1 then	
		if command == OP1 then
		
		elseif command == OP2 then
		
		elseif command == OP3 then
		
		elseif command == OP4 then
		
		elseif command == OP5 then
		
		end	
	end

	--PAGE 4 LOGIC
	if parameters.MAIN_POWER:get() == 1 and icp_stpt_page == 1 then	
		if command == OP1 then
		
		elseif command == OP2 then
		
		elseif command == OP3 then
		
		elseif command == OP4 then
		
		elseif command == OP5 then
		
		end	
	end

	--PAGE 5 LOGIC
	if parameters.MAIN_POWER:get() == 1 and icp_alt_page == 1 then	
		if command == OP1 then
		
		elseif command == OP2 then
		
		elseif command == OP3 then
		
		elseif command == OP4 then
		
		elseif command == OP5 then
		
		end	
	end
		
	--PAGE 6 LOGIC
	if parameters.MAIN_POWER:get() == 1 and icp_hud_page == 1 then	
		if command == OP1 then
		
		elseif command == OP2 then
		
		elseif command == OP3 then
		
		elseif command == OP4 then
		
		elseif command == OP5 then
		
		end	
	end
	
	--PAGE 7 LOGIC
	if parameters.MAIN_POWER:get() == 1 and icp_other_page == 1 then	
		if command == OP1 then
		
		elseif command == OP2 then
		
		elseif command == OP3 then
		
		elseif command == OP4 then
		
		elseif command == OP5 then
		
		end	
	end
	
	--PAGE 8 LOGIC
	if parameters.MAIN_POWER:get() == 1 and icp_ap_page == 1 then	
		if command == OP1 then
		
		elseif command == OP2 then
		
		elseif command == OP3 then
		
		elseif command == OP4 then
		
		elseif command == OP5 then
		
		end	
	end
	
	if parameters.MAIN_POWER:get() == 1 and icp_bingo_menu == 1 then
		allow_input = 1
		EnableICPInput(command)
	end
		
--[[
--RADIO/REARM/KNEEBOARD
    if command == COM1 or command == ICP_COM1 then
        dispatch_action(nil,Radio_Menu)
    elseif command == COM2 or command == ICP_COM2 then
        dispatch_action(nil,Rearm_Menu)
    elseif command == STP or command == ICP_STPT then
        dispatch_action(nil,PlaneShowKneeboard)
    end
	]]

--ICP COMMANDS

	if command == MRK and icp_bingo_menu == 1 then
		--set new param based on existing page from ICP_INPUT value, clear ICP_INPUT, set allow_input to 0. 
		update_val = parameters.ICP_INPUT:get()
		parameters.BINGO_VAL:set(update_val)
		parameters.UPDATE_BINGO:set(0)
        icp_input_string = ""
		icp_bingo_menu = 0
        allow_input = 0
		icp_com1_page = 1
		icp_com1_title = 1
    end

--ICP INPUT
	if parameters.MAIN_POWER:get() == 1 and icp_com1_page == 1 and allow_input == 1 then
	
            EnableICPInput(command)
    end
		
end

------------------------------------------------------------------FUNCTION-UPDATE---------------------------------------------------------------------------------------------------
function update()

	parameters.ICP_COM1_MENU:set(icp_com1_page)
	parameters.ICP_COM2_MENU:set(icp_com2_page)
	parameters.ICP_NAV_MENU:set(icp_nav_page)
	parameters.ICP_STPT_MENU:set(icp_stpt_page)
	parameters.ICP_ALT_MENU:set(icp_alt_page)
	parameters.ICP_HUD_MENU:set(icp_hud_page)
	parameters.ICP_OTHER_MENU:set(icp_other_page)
	parameters.ICP_AP_MENU:set(icp_ap_page)
	parameters.ICP_COM1_TITLE:set(icp_com1_title)
	parameters.ICP_COM2_TITLE:set(icp_com2_title)
	parameters.ICP_NAV_TITLE:set(icp_nav_title)
	parameters.ICP_STPT_TITLE:set(icp_stpt_title)
	parameters.ICP_ALT_TITLE:set(icp_alt_title)
	parameters.ICP_HUD_TITLE:set(icp_hud_title)
	parameters.ICP_OTHER_TITLE:set(icp_other_title)
	parameters.ICP_AP_TITLE:set(icp_ap_title)
	parameters.ICP_BINGO_MENU:set(icp_bingo_menu)

	if icp_input_string == "" then
        parameters.ICP_INPUT:set(0) 
    else
        local input_number = tonumber(icp_input_string) or 0 
        parameters.ICP_INPUT:set(input_number)
    end
	
	if parameters.UPDATE_BINGO:get() == 1 then
		icp_bingo_menu = 1
		icp_com1_page = 0
		icp_com1_title = 0
		icp_com2_page = 0
		icp_com2_title = 0
		icp_nav_page = 0
		icp_nav_title = 0
		icp_stpt_page = 0
		icp_stpt_title = 0
		icp_alt_page = 0
		icp_alt_title = 0
		icp_hud_page = 0
		icp_hud_title = 0
		icp_other_page = 0
		icp_other_title = 0
		icp_ap_page = 0
		icp_ap_title = 0
	end

--ICP OPACITY
    if parameters.MAIN_POWER:get() == 1 then
        parameters.ICP_OPACITY:set(1)
    else
       parameters.ICP_OPACITY:set(0)
    end
--SET PARAMS




end



need_to_be_closed = false


