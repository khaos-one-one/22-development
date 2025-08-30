dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."Systems/Electrical_System_API.lua")
dofile(LockOn_Options.script_path.."devices.lua")

local electric_system = GetSelf()
local dt = 0.006
make_default_activity(dt)

local sensor_data = get_base_data()
local parameters =
{
	MAIN_POWER 				= get_param_handle("MAIN_POWER"),
	RWR_POWER				= get_param_handle("RWR_POWER"),
	ECMS_POWER				= get_param_handle("ECMS_POWER"),
	JAMMER_POWER			= get_param_handle("JAMMER_POWER"),
	HMD_POWER				= get_param_handle("HMD_POWER"),
	
}


function update_elec_state()
    if parameters.MAIN_POWER:get() == 1 then
        electric_system:AC_Generator_1_on(true)
        electric_system:AC_Generator_2_on(true)
        electric_system:DC_Battery_on(true)
    else
        electric_system:AC_Generator_1_on(false)
        electric_system:AC_Generator_2_on(false)
        electric_system:DC_Battery_on(false)
    end
end

function post_initialize()
    update_elec_state()
end

function SetCommand(command, value)

end

function update()

    update_elec_state()
    
	if parameters.MAIN_POWER:get() == 0 then
		parameters.RWR_POWER:set(0)
		parameters.ECMS_POWER:set(0)
		parameters.JAMMER_POWER:set(0)
		parameters.HMD_POWER:set(0)
	end
	
    --print_message_to_user(electric_system:get_AC_Bus_1_voltage())

end

need_to_be_closed = false