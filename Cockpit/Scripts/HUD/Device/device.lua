
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."systems/avionics.lua")

local dev = GetSelf()

local update_time_step = 0.006
make_default_activity(update_time_step)

function post_initialize()


    local birth = LockOn_Options.init_conditions.birth_place

    if birth == "GROUND_HOT" or birth == "GROUND_COLD" then

    elseif birth == "AIR_HOT"  then

    end
end

function SetCommand(command, value)
    
end


function update()

end

need_to_be_closed = false