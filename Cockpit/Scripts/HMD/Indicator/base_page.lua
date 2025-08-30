-- Scripts/HUD/base_page.lua
dofile(LockOn_Options.script_path.."HMD/device/device_defs.lua")



local half_width = GetScale()
local half_height = GetAspect() * half_width
local aspect = GetAspect()


SHOW_MASKS = true

local half_width = GetScale()
local half_height = GetAspect() * half_width
local aspect = GetAspect()

HMD_base_clip                   = CreateElement "ceMeshPoly"
HMD_base_clip.name              = "HMD_base_clip"
HMD_base_clip.primitivetype     = "triangles"
HMD_base_clip.vertices          = { {5 * aspect, 5 * aspect}, { 5 * aspect,-5 * aspect}, { -5 * aspect,-5 * aspect}, {-5 * aspect, 5 * aspect},}
HMD_base_clip.indices           = {0,1,2,0,2,3}
HMD_base_clip.init_pos          = {0, 0, 0}
HMD_base_clip.init_rot          = {0, 0, 0}
HMD_base_clip.material          = MakeMaterial(nil,{0, 255, 0, 20})
HMD_base_clip.h_clip_relation   = h_clip_relations.REWRITE_LEVEL
HMD_base_clip.level             = HMD_DEFAULT_NOCLIP_LEVEL +1
HMD_base_clip.isdraw            = true
HMD_base_clip.change_opacity    = true
HMD_base_clip.element_params    = {"HMD_POWER"}
HMD_base_clip.controllers       = {{"parameter_compare_with_number",0,1}}
HMD_base_clip.isvisible         = false
Add(HMD_base_clip)


HMD_PITCH                                = CreateElement "ceSimple"
HMD_PITCH.name                           = "HMD_PITCH"
HMD_PITCH.init_pos                       = {0, 0.00, 0}
HMD_PITCH.init_rot                       = {0, 0, 0}
HMD_PITCH.material                       = MakeMaterial(nil,{0, 255, 0, 20})
HMD_PITCH.element_params                 = {"ADIPITCH"}--"HMD_FD_Y"
HMD_PITCH.controllers                    = {{"move_up_down_using_parameter",0,0.0025}}
HMD_PITCH.collimated                     = true
HMD_PITCH.use_mipfilter                  = true
HMD_PITCH.additive_alpha                 = false
HMD_PITCH.h_clip_relation                = h_clip_relations.COMPARE
HMD_PITCH.level                          = HMD_DEFAULT_NOCLIP_LEVEL +1
HMD_PITCH.parent_element                 = "HMD_base_clip"
HMD_PITCH.isvisible                      = true
Add(HMD_PITCH)

HMD_Cross                    	= CreateElement "ceTexPoly"
HMD_Cross.vertices              = HMD_vert_gen(3000,3000)
HMD_Cross.indices               = {0,1,2,2,3,0}
HMD_Cross.tex_coords            = tex_coord_gen(0,0,1024,1024,1024,1024)
HMD_Cross.material              = HMD_CROSS
HMD_Cross.name                  = create_guid_string()
HMD_Cross.init_pos              = {0.0, 0, 0}
HMD_Cross.init_rot              = {0, 0, 0}
HMD_Cross.collimated            = true
HMD_Cross.use_mipfilter         = true
HMD_Cross.additive_alpha 		= true
HMD_Cross.blend_mode 			= blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
HMD_Cross.h_clip_relation       = h_clip_relations.COMPARE
HMD_Cross.level                 = HMD_DEFAULT_NOCLIP_LEVEL +1
HMD_Cross.parent_element        = "HMD_base_clip"
HMD_Cross.element_params        = {"HUD_OPACITY","HMD_HUDVIEW","HMD_POWER"}
HMD_Cross.controllers           = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.9,1.1}}
HMD_Cross.isvisible             = true
Add(HMD_Cross)

-- Master Arm
local MASTER_ARM = CreateElement "ceStringPoly"
MASTER_ARM.material = "F22_HUD"
MASTER_ARM.init_pos = {2.5,-2,0}
MASTER_ARM.alignment = "RightCenter" 
MASTER_ARM.stringdefs = {0.020, 0.020, 0.0000, 0.0} 
MASTER_ARM.value = "ARMED" 
MASTER_ARM.collimated = true
MASTER_ARM.use_mipfilter = true
MASTER_ARM.additive_alpha = false
MASTER_ARM.element_params = {"HMD_HUDVIEW","HUD_OPACITY", "MASTER_ARM","HMD_POWER"}
MASTER_ARM.controllers = {{"parameter_compare_with_number", 0, 1},{"opacity_using_parameter",1},{"parameter_compare_with_number", 2, 1},{"parameter_in_range",3,0.9,1.1}} 
MASTER_ARM.h_clip_relation = h_clip_relations.COMPARE
MASTER_ARM.level = HMD_DEFAULT_NOCLIP_LEVEL + 1
MASTER_ARM.parent_element = "HMD_base_clip"
Add(MASTER_ARM)

-- Master Safe
local MASTER_SAFE = CreateElement "ceStringPoly"
MASTER_SAFE.material = "F22_HUD"
MASTER_SAFE.init_pos = {2.5,-2,0}
MASTER_SAFE.alignment = "RightCenter" 
MASTER_SAFE.stringdefs = {0.020, 0.020, 0.0000, 0.0} 
MASTER_SAFE.value = "SAFE" 
MASTER_SAFE.collimated = true
MASTER_SAFE.use_mipfilter = true
MASTER_SAFE.additive_alpha = false
MASTER_SAFE.element_params = {"HMD_HUDVIEW","HUD_OPACITY", "MASTER_ARM","HMD_POWER"}
MASTER_SAFE.controllers = {{"parameter_compare_with_number", 0, 1},{"opacity_using_parameter",1},{"parameter_compare_with_number", 2, 0},{"parameter_in_range",3,0.9,1.1}} 
MASTER_SAFE.h_clip_relation = h_clip_relations.COMPARE
MASTER_SAFE.level = HMD_DEFAULT_NOCLIP_LEVEL + 1
MASTER_SAFE.parent_element = "HMD_base_clip"
Add(MASTER_SAFE)

local HMD_ALT_RAD = CreateElement "ceStringPoly"
HMD_ALT_RAD.material = "F22_HUD"
HMD_ALT_RAD.init_pos = {3, 0, 0} 
HMD_ALT_RAD.alignment = "RightCenter"
HMD_ALT_RAD.stringdefs = {0.0200, 0.0200, 0.00000, 0.0} 
HMD_ALT_RAD.formats = {"%.0f", "%s"}
HMD_ALT_RAD.element_params = {"SMOOTH_ALT","HUD_OPACITY","HMD_HUDVIEW","HMD_POWER"}
HMD_ALT_RAD.controllers = {{"text_using_parameter", 0},{"opacity_using_parameter",1},{"parameter_in_range",2,0.9,1.1},{"parameter_in_range",3,0.9,1.1}} 
HMD_ALT_RAD.collimated = true
HMD_ALT_RAD.use_mipfilter = true
HMD_ALT_RAD.additive_alpha = false
HMD_ALT_RAD.h_clip_relation = h_clip_relations.COMPARE
HMD_ALT_RAD.level = HMD_DEFAULT_NOCLIP_LEVEL + 1
HMD_ALT_RAD.parent_element = "HMD_base_clip"
Add(HMD_ALT_RAD)


--Current GS
local hmd_spd = CreateElement "ceStringPoly"
hmd_spd.material = "F22_HUD"
hmd_spd.init_pos = {-3,0,0} 
hmd_spd.alignment = "RightCenter"
hmd_spd.stringdefs = {0.0200, 0.0200, 0.00000, 0.0} 
hmd_spd.formats = {"%.0f", "%s"}
hmd_spd.element_params = {"IAS","HUD_OPACITY","HMD_HUDVIEW","HMD_POWER"}
hmd_spd.controllers = {{"text_using_parameter", 0},{"opacity_using_parameter",1},{"parameter_in_range",2,0.9,1.1},{"parameter_in_range",3,0.9,1.1}} 
hmd_spd.collimated = true
hmd_spd.use_mipfilter = true
hmd_spd.additive_alpha = true
hmd_spd.blend_mode = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
hmd_spd.h_clip_relation = h_clip_relations.COMPARE
hmd_spd.level = HMD_DEFAULT_NOCLIP_LEVEL + 1
hmd_spd.parent_element = "HMD_base_clip"
Add(hmd_spd)


--Current heading
local hmd_curr_head = CreateElement "ceStringPoly"
hmd_curr_head.material = "F22_HUD"
hmd_curr_head.init_pos = {0,4.25,0} 
hmd_curr_head.alignment = "RightCenter"
hmd_curr_head.stringdefs = {0.0200, 0.0200, 0.00000, 0.0} 
hmd_curr_head.formats = {"%.0f", "%s"}
hmd_curr_head.element_params = {"HMD_HEADING","HUD_OPACITY","HMD_HUDVIEW","HMD_POWER"}
hmd_curr_head.controllers = {{"text_using_parameter", 0},{"opacity_using_parameter",1},{"parameter_in_range",2,0.9,1.1},{"parameter_in_range",3,0.9,1.1}} 
hmd_curr_head.collimated = true
hmd_curr_head.use_mipfilter = true
hmd_curr_head.additive_alpha = true
hmd_curr_head.blend_mode = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
hmd_curr_head.h_clip_relation = h_clip_relations.COMPARE
hmd_curr_head.level = HMD_DEFAULT_NOCLIP_LEVEL + 1
hmd_curr_head.parent_element = "HMD_base_clip"
Add(hmd_curr_head)


-- Heading Tape Container (Primary)
local HMD_HEAD_TAPE = CreateElement "ceSimple"
HMD_HEAD_TAPE.name = create_guid_string()
HMD_HEAD_TAPE.init_pos = {0.0, 2.0, 0} 
HMD_HEAD_TAPE.collimated = true
HMD_HEAD_TAPE.use_mipfilter = true
HMD_HEAD_TAPE.additive_alpha = false
HMD_HEAD_TAPE.h_clip_relation = h_clip_relations.COMPARE
HMD_HEAD_TAPE.level = HMD_DEFAULT_NOCLIP_LEVEL + 1
HMD_HEAD_TAPE.parent_element = "HMD_base_clip"
HMD_HEAD_TAPE.element_params = {"HMD_HEADING", "HMD_POWER","HMD_HUDVIEW"}
HMD_HEAD_TAPE.controllers = {
    {"move_left_right_using_parameter", 0, -0.01005}, 
    {"parameter_compare_with_number", 1, 1},
	{"parameter_in_range",2,0.9,1.1}
} 
HMD_HEAD_TAPE.isvisible = false
Add(HMD_HEAD_TAPE)

-- Heading Tape Container (Secondary, for wrapping)
local HMD_HEAD_TAPE2 = CreateElement "ceSimple"
HMD_HEAD_TAPE2.name = create_guid_string()
HMD_HEAD_TAPE2.init_pos = {0.0, 2.0, 0}
HMD_HEAD_TAPE2.init_rot = {0, 0, 0} 
HMD_HEAD_TAPE2.collimated = true
HMD_HEAD_TAPE2.use_mipfilter = true
HMD_HEAD_TAPE2.additive_alpha = false
HMD_HEAD_TAPE2.h_clip_relation = h_clip_relations.COMPARE
HMD_HEAD_TAPE2.level = HMD_DEFAULT_NOCLIP_LEVEL + 1
HMD_HEAD_TAPE2.parent_element = "HMD_base_clip"
HMD_HEAD_TAPE2.element_params = {"HMD_HEADING", "HMD_POWER","HMD_HUDVIEW"}
HMD_HEAD_TAPE2.controllers = {
    {"move_left_right_using_parameter", 0, -0.01005}, 
    {"parameter_compare_with_number", 1, 1},
	{"parameter_in_range",2,0.9,1.1}
}
HMD_HEAD_TAPE2.isvisible = false
Add(HMD_HEAD_TAPE2)

-- Generate Heading Tape Ticks and Labels (Primary Container)
for i = -90, 90 do
    local heading = i * 5 -- Ticks every 5 degrees
    local x_pos = heading * 0.1--0.032 

    -- Tick Marks (Every 5 Degrees)
    local hmd_heading_tick = CreateElement "ceTexPoly"
    hmd_heading_tick.vertices = HMD_vert_gen(10000,10000) 
    hmd_heading_tick.indices = {0, 1, 2, 2, 3, 0}
    hmd_heading_tick.tex_coords = tex_coord_gen(0, 0, 2048, 2048, 2048, 2048)
    hmd_heading_tick.material = HMD_HEADING_TAPE
    hmd_heading_tick.name = create_guid_string()
    hmd_heading_tick.init_pos = {x_pos, 2.1, 0} 
	hmd_heading_tick.element_params = {"HMD_POWER", "HUD_OPACITY","HMD_HUDVIEW"}
	hmd_heading_tick.controllers = {{"parameter_compare_with_number", 0, 1},{"opacity_using_parameter",1},{"parameter_in_range",2,0.9,1.1}} 
    hmd_heading_tick.collimated = true
    hmd_heading_tick.use_mipfilter = true
    hmd_heading_tick.additive_alpha = true
    hmd_heading_tick.blend_mode = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
    hmd_heading_tick.h_clip_relation = h_clip_relations.COMPARE
    hmd_heading_tick.level = HMD_DEFAULT_NOCLIP_LEVEL + 1
    hmd_heading_tick.parent_element = HMD_HEAD_TAPE.name
    hmd_heading_tick.isvisible = true
    Add(hmd_heading_tick)

    -- Direction Labels (Every 10 Degrees)
    if i % 2 == 0 then -- Only at 10-degree intervals
        local display_heading = (heading + 360) % 360 -- Normalize to 0-359°
        local label_text
        if display_heading % 90 == 0 then
            -- Cardinal directions
            if display_heading == 0 then label_text = "N"
            elseif display_heading == 90 then label_text = "E"
            elseif display_heading == 180 then label_text = "S"
            elseif display_heading == 270 then label_text = "W"
            end
        else
            -- Numeric headings (e.g., "09" for 090°, "10" for 100°)
            label_text = string.format("%02d", math.floor(display_heading / 10))
        end

        local hmd_heading_label = CreateElement "ceStringPoly"
        hmd_heading_label.material = "F22_HUD"
        hmd_heading_label.init_pos = {x_pos, 2.0, 0} 
        hmd_heading_label.alignment = "CenterCenter"
        hmd_heading_label.stringdefs = {0.020, 0.020, 0.0000, 0.0}
        hmd_heading_label.value = label_text
        hmd_heading_label.element_params = {"HMD_POWER","HUD_OPACITY","HMD_HUDVIEW"}
        hmd_heading_label.controllers = {{"parameter_compare_with_number", 0, 1},{"opacity_using_parameter",1},{"parameter_in_range",2,0.9,1.1}}
        hmd_heading_label.collimated = true
        hmd_heading_label.use_mipfilter = true
        hmd_heading_label.additive_alpha = true
        hmd_heading_label.blend_mode = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
        hmd_heading_label.h_clip_relation = h_clip_relations.COMPARE
        hmd_heading_label.level = HMD_DEFAULT_NOCLIP_LEVEL + 1
        hmd_heading_label.parent_element = HMD_HEAD_TAPE.name
        hmd_heading_label.isvisible = true
        Add(hmd_heading_label)
    end
end




function update()
    local HMD_POWER = get_param_handle("HMD_POWER"):get()
end