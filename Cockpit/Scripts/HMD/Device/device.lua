dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."Systems/electrical_system.lua")


local hmd_system = GetSelf()

local update_time_step = 0.02
make_default_activity(update_time_step)

local parameters = 
{
    HMD = get_param_handle("HMD")
}

local HMD_Mode = 1





local sensor_data = get_base_data()
local ias_conversion_to_knots = 1.9504132
local ias_conversion_to_kmh = 3.6
local DEGREE_TO_RAD  = 0.0174532925199433
local RAD_TO_DEGREE  = 57.29577951308233
local METER_TO_FEET = 3.28084

       

function post_initialize()

end

    


function SetCommand(command,value)
    --[[
    if command == Keys.PlaneModeHelmet and HMD_Mode == 0 then
        HMD_Mode = 1
        -- print_message_to_user(HMD_Mode)
    elseif command == Keys.PlaneModeNAV and HMD_Mode == 1 then
        HMD_Mode = 0
        -- print_message_to_user(HMD_Mode)
    elseif command == Keys.PlaneModeBVR and HMD_Mode == 1 then
        HMD_Mode = 0
        -- print_message_to_user(HMD_Mode) 
    elseif command == Keys.PlaneModeVS and HMD_Mode == 1 then
        HMD_Mode = 0
        -- print_message_to_user(HMD_Mode)
    elseif command == Keys.PlaneModeBore and HMD_Mode == 1 then
        HMD_Mode = 0
        -- print_message_to_user(HMD_Mode)
    elseif command == Keys.PlaneModeFI0 and HMD_Mode == 1 then
        HMD_Mode = 0
        -- print_message_to_user(HMD_Mode)
    elseif command == Keys.PlaneModeGround and HMD_Mode == 1 then
        HMD_Mode = 0
        -- print_message_to_user(HMD_Mode)
    -- elseif command == Keys.PlaneModeCannon and HMD_Mode == 1 then
    --     HMD_Mode = 0
    end

    -- if command == iCommandHUDBrightnessDown then
    --     HUD_STATE = value
    --     HUD_REFERENCE = 0
    -- else command == iCommandHUDBrightnessUp then 
    --     HUD_STATE = value 
    --     HUD_REFERENCE = 1
    -- else 
]]
end

function update()

end

need_to_be_closed = false




