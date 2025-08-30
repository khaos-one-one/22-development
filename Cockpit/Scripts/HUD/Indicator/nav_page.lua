-- Scripts/HUD/nav_page.lua
dofile(LockOn_Options.script_path.."HUD/Device/device_defs.lua")
dofile(LockOn_Options.script_path.."HUD/Indicator/base_page.lua")

SHOW_MASKS = true

local half_width = GetScale()
local half_height = GetAspect() * half_width
local aspect = GetAspect()

-- Clipping Polygon for Main HUD Display
HUD_MAIN_CLIP = CreateElement "ceMeshPoly"
HUD_MAIN_CLIP.name = "HUD_MAIN_CLIP"
HUD_MAIN_CLIP.primitivetype = "triangles"
HUD_MAIN_CLIP.vertices = {{6, 6 * aspect}, {6, -6 * aspect}, {-6, -6 * aspect}, {-6, 6 * aspect}}
HUD_MAIN_CLIP.indices = {0, 1, 2, 0, 2, 3}
HUD_MAIN_CLIP.init_pos = {0, -0.25, 0.0} --0.09
HUD_MAIN_CLIP.material = "DBG_GREEN"
HUD_MAIN_CLIP.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
HUD_MAIN_CLIP.level = HUD_DEFAULT_NOCLIP_LEVEL + 1
HUD_MAIN_CLIP.isdraw = true
HUD_MAIN_CLIP.change_opacity = true
HUD_MAIN_CLIP.collimated = true
HUD_MAIN_CLIP.element_params = {"MAIN_POWER"}
HUD_MAIN_CLIP.controllers = {{"parameter_compare_with_number", 0, 1}}
HUD_MAIN_CLIP.isvisible = false
Add(HUD_MAIN_CLIP)

-- Roll Container
HUD_ROLL = CreateElement "ceSimple"
HUD_ROLL.name = "HUD_ROLL"
HUD_ROLL.init_pos = {0, 0, 0}
HUD_ROLL.element_params = {"ADIROLL"}
HUD_ROLL.controllers = {{"rotate_using_parameter", 0, 1}}
HUD_ROLL.collimated = true
HUD_ROLL.use_mipfilter = true
HUD_ROLL.additive_alpha = true
HUD_ROLL.h_clip_relation = h_clip_relations.COMPARE
HUD_ROLL.level = HUD_DEFAULT_NOCLIP_LEVEL + 1
HUD_ROLL.parent_element = "HUD_MAIN_CLIP"
HUD_ROLL.isvisible = false
Add(HUD_ROLL)


-- Roll Angle Container 
HUD_ROLL_ANGLE = CreateElement "ceSimple"
HUD_ROLL_ANGLE.name = "HUD_ROLL_ANGLE"
HUD_ROLL_ANGLE.init_pos = {0.0, -0.2, 0}
HUD_ROLL_ANGLE.element_params = {"ADIROLL"}
HUD_ROLL_ANGLE.controllers = {{"rotate_using_parameter", 0, 1}}
HUD_ROLL_ANGLE.collimated = true
HUD_ROLL_ANGLE.use_mipfilter = true
HUD_ROLL_ANGLE.additive_alpha = true
HUD_ROLL_ANGLE.blend_mode = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
HUD_ROLL_ANGLE.h_clip_relation = h_clip_relations.COMPARE
HUD_ROLL_ANGLE.level = HUD_DEFAULT_NOCLIP_LEVEL + 1
HUD_ROLL_ANGLE.parent_element = "HUD_MAIN_CLIP"
HUD_ROLL_ANGLE.isvisible = false
Add(HUD_ROLL_ANGLE)

-- Static Roll Container
HUD_ROLL_STC = CreateElement "ceSimple"
HUD_ROLL_STC.name = "HUD_ROLL_STC"
HUD_ROLL_STC.init_pos = {0, 0, 0}
HUD_ROLL_STC.element_params = {"ADIROLL"}
HUD_ROLL_STC.controllers = {{"rotate_using_parameter", 0, 0}}
HUD_ROLL_STC.collimated = true
HUD_ROLL_STC.use_mipfilter = true
HUD_ROLL_STC.additive_alpha = true
HUD_ROLL_STC.h_clip_relation = h_clip_relations.COMPARE
HUD_ROLL_STC.level = HUD_DEFAULT_NOCLIP_LEVEL + 1
HUD_ROLL_STC.parent_element = "HUD_MAIN_CLIP"
HUD_ROLL_STC.isvisible = false
Add(HUD_ROLL_STC)

-- Bank Angle (Stationary Scale)
local hud_bank = CreateElement "ceTexPoly"
hud_bank.vertices = hud_vert_gen(6400, 4000) --36
hud_bank.indices = {0, 1, 2, 2, 3, 0}
hud_bank.tex_coords = tex_coord_gen(0, 0, 2048, 2048, 2048, 2048)
hud_bank.material = HUD_ANGLES
hud_bank.name = create_guid_string()
hud_bank.init_pos = {-0.0065, -0.495, 0}  
hud_bank.element_params = {"MAIN_POWER", "HUD_OPACITY"}
hud_bank.controllers = {{"parameter_compare_with_number", 0, 1},{"opacity_using_parameter",1},} 
hud_bank.collimated = true
hud_bank.use_mipfilter = true
hud_bank.additive_alpha = true
hud_bank.blend_mode = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
hud_bank.h_clip_relation = h_clip_relations.COMPARE
hud_bank.level = HUD_DEFAULT_NOCLIP_LEVEL + 2
hud_bank.parent_element = "HUD_ROLL_STC"  
Add(hud_bank)

-- Bank Indicator Rotation Container
local hud_bank_ind_rot = CreateElement "ceSimple"
hud_bank_ind_rot.name = create_guid_string()
hud_bank_ind_rot.init_pos = {-0.002, -0.25, 0} 
hud_bank_ind_rot.element_params = {"MAIN_POWER", "ROLL_IND"}
hud_bank_ind_rot.controllers = {
    {"parameter_compare_with_number", 0, 1}, 
    {"rotate_using_parameter", 1, 1}
}
hud_bank_ind_rot.collimated = true
hud_bank_ind_rot.use_mipfilter = true
hud_bank_ind_rot.additive_alpha = true
hud_bank_ind_rot.h_clip_relation = h_clip_relations.COMPARE
hud_bank_ind_rot.level = HUD_DEFAULT_NOCLIP_LEVEL + 1
hud_bank_ind_rot.parent_element = "HUD_ROLL_STC"
Add(hud_bank_ind_rot)

-- Bank Indicator 
local hud_bank_ind = CreateElement "ceTexPoly"
hud_bank_ind.vertices = hud_vert_gen(2200, 2200) -- 11
hud_bank_ind.indices = {0, 1, 2, 2, 3, 0}
hud_bank_ind.tex_coords = tex_coord_gen(0, 0, 2048, 2048, 2048, 2048)
hud_bank_ind.material = HUD_ROLL_CUE
hud_bank_ind.name = create_guid_string()
hud_bank_ind.init_pos = {-0.0046, -0.93, 0}
hud_bank_ind.init_rot = {0, 0, 0}
hud_bank_ind.collimated = true
hud_bank_ind.use_mipfilter = true
hud_bank_ind.additive_alpha = true
hud_bank_ind.blend_mode = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
hud_bank_ind.h_clip_relation = h_clip_relations.COMPARE
hud_bank_ind.level = HUD_DEFAULT_NOCLIP_LEVEL + 2
hud_bank_ind.parent_element = hud_bank_ind_rot.name
hud_bank_ind.element_params = {"ROLL_IND", "HUD_OPACITY"}
hud_bank_ind.controllers = {{"opacity_using_parameter",1},} 
Add(hud_bank_ind)

-- Pitch Ladder (Positive)
for i = 1, 20 do
    local sign_number = i * 5
    local vertical_distance = 0.5025 * i 
    local hud_pitch_positive = CreateElement "ceTexPoly"
    hud_pitch_positive.vertices = hud_vert_gen(2400, 3000)
    hud_pitch_positive.indices = {0, 1, 2, 2, 3, 0}
    hud_pitch_positive.tex_coords = tex_coord_gen(0, 0, 2048, 2048, 2048, 2048)
    hud_pitch_positive.material = HUD_PITCH_LAD
    hud_pitch_positive.name = create_guid_string()
    hud_pitch_positive.init_pos = {-0.00, vertical_distance - 0.12, 0}
	hud_pitch_positive.element_params = {"MAIN_POWER", "HUD_OPACITY"}
	hud_pitch_positive.controllers = {{"parameter_compare_with_number", 0, 1},{"opacity_using_parameter",1},} 
    hud_pitch_positive.collimated = true
    hud_pitch_positive.use_mipfilter = true
    hud_pitch_positive.additive_alpha = true
	hud_pitch_positive.blend_mode = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
    hud_pitch_positive.h_clip_relation = h_clip_relations.COMPARE
    hud_pitch_positive.level = HUD_DEFAULT_NOCLIP_LEVEL + 2
    hud_pitch_positive.parent_element = "HUD_PITCH"
    Add(hud_pitch_positive)

    local hud_pitch_number = CreateElement "ceStringPoly"
    hud_pitch_number.material = "F22_HUD"
    hud_pitch_number.init_pos = {-0.25, vertical_distance - 0.055, 0}
    hud_pitch_number.alignment = "LeftCenter"
    hud_pitch_number.stringdefs = {0.00650, 0.00650, 0.0006, 0}
    hud_pitch_number.formats = {tostring(sign_number), "%s"}
	--hud_pitch_number.element_params = {"MAIN_POWER", "HUD_OPACITY"}
	--hud_pitch_number.controllers = {{"parameter_compare_with_number", 0, 1},{"opacity_using_parameter",1},} 
    hud_pitch_number.collimated = true
    hud_pitch_number.use_mipfilter = true
    hud_pitch_number.additive_alpha = true
	hud_pitch_number.blend_mode = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
    hud_pitch_number.h_clip_relation = h_clip_relations.COMPARE
    hud_pitch_number.level = HUD_DEFAULT_NOCLIP_LEVEL + 2
    hud_pitch_number.parent_element = "HUD_PITCH"
    Add(hud_pitch_number)
end

-- Pitch Ladder (Negative)
for i = 1, 20 do
    local sign_number = i * -5
    local vertical_distance = 0.513 * i 
    local hud_pitch_negative = CreateElement "ceTexPoly"
    hud_pitch_negative.vertices = hud_vert_gen(2400, 3000) --13  18
    hud_pitch_negative.indices = {0, 1, 2, 2, 3, 0}
    hud_pitch_negative.tex_coords = tex_coord_gen(0, 0, 2048, 2048, 2048, 2048)
    hud_pitch_negative.material = HUD_PITCH_NEG 
    hud_pitch_negative.name = create_guid_string()
    hud_pitch_negative.init_pos = {-0.00, -vertical_distance + 0.06, 0}
	hud_pitch_negative.element_params = {"MAIN_POWER", "HUD_OPACITY"}
	hud_pitch_negative.controllers = {{"parameter_compare_with_number", 0, 1},{"opacity_using_parameter",1},} 
    hud_pitch_negative.collimated = true
    hud_pitch_negative.use_mipfilter = true
    hud_pitch_negative.additive_alpha = true
	hud_pitch_negative.blend_mode = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
    hud_pitch_negative.h_clip_relation = h_clip_relations.COMPARE
    hud_pitch_negative.level = HUD_DEFAULT_NOCLIP_LEVEL + 2
    hud_pitch_negative.parent_element = "HUD_PITCH"
    Add(hud_pitch_negative)

    local hud_pitch_number = CreateElement "ceStringPoly"
    hud_pitch_number.material = "F22_HUD"
    hud_pitch_number.init_pos = {-0.25, -vertical_distance + 0.065, 0}
    hud_pitch_number.alignment = "LeftCenter"
    hud_pitch_number.stringdefs = {0.0130, 0.0130, 0.0000, 0}
    hud_pitch_number.formats = {tostring(sign_number), "%s"}
    hud_pitch_number.element_params = {"MAIN_POWER", "HUD_OPACITY"}
    hud_pitch_number.controllers = {{"parameter_compare_with_number", 0, 1},{"opacity_using_parameter",1},} 
    hud_pitch_number.collimated = true
    hud_pitch_number.use_mipfilter = true
    hud_pitch_number.additive_alpha = true
	hud_pitch_number.blend_mode = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
    hud_pitch_number.h_clip_relation = h_clip_relations.COMPARE
    hud_pitch_number.level = HUD_DEFAULT_NOCLIP_LEVEL + 2
    hud_pitch_number.parent_element = "HUD_PITCH"
    Add(hud_pitch_number)
end

-- Pitch Container
HUD_PITCH = CreateElement "ceSimple"
HUD_PITCH.name = "HUD_PITCH"
HUD_PITCH.init_pos = {0, 0.225, 0} -- -0.02
HUD_PITCH.element_params = {"ADIPITCH"}
HUD_PITCH.controllers = {{"move_up_down_using_parameter", 0, -0.6}} 
HUD_PITCH.collimated = true
HUD_PITCH.use_mipfilter = true
HUD_PITCH.additive_alpha = true
HUD_PITCH.h_clip_relation = h_clip_relations.COMPARE
HUD_PITCH.level = HUD_DEFAULT_NOCLIP_LEVEL + 1
HUD_PITCH.parent_element = "HUD_ROLL"
HUD_PITCH.isvisible = false
Add(HUD_PITCH)

-- Pitch Ladder Labels 
for i = 1, 20 do
    local pitch_angle = i * 5  
    local vertical_distance = 0.5025 * i - 0.08  

    -- Right-side label
    local HUD_PITCH_LABEL_RIGHT = CreateElement "ceStringPoly"
    HUD_PITCH_LABEL_RIGHT.material = "F22_HUD"
    HUD_PITCH_LABEL_RIGHT.init_pos = {-0.36, vertical_distance + 0.01, 0}  
    HUD_PITCH_LABEL_RIGHT.alignment = "RightCenter"
    HUD_PITCH_LABEL_RIGHT.stringdefs = {0.007, 0.007, 0.000, 0.0}
    HUD_PITCH_LABEL_RIGHT.value = tostring(pitch_angle)
    HUD_PITCH_LABEL_RIGHT.name = create_guid_string()
    HUD_PITCH_LABEL_RIGHT.collimated = true
    HUD_PITCH_LABEL_RIGHT.use_mipfilter = true
    HUD_PITCH_LABEL_RIGHT.additive_alpha = true
	HUD_PITCH_LABEL_RIGHT.element_params = {"MAIN_POWER", "HUD_OPACITY"}
	HUD_PITCH_LABEL_RIGHT.controllers = {{"parameter_compare_with_number", 0, 1},{"opacity_using_parameter",1},} 
	HUD_PITCH_LABEL_RIGHT.blend_mode = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
    HUD_PITCH_LABEL_RIGHT.h_clip_relation = h_clip_relations.COMPARE
    HUD_PITCH_LABEL_RIGHT.level = HUD_DEFAULT_NOCLIP_LEVEL + 2
    HUD_PITCH_LABEL_RIGHT.parent_element = "HUD_PITCH"
    Add(HUD_PITCH_LABEL_RIGHT)

    -- Left-side label (mirrored)
    local HUD_PITCH_LABEL_LEFT = CreateElement "ceStringPoly"
    HUD_PITCH_LABEL_LEFT.material = "F22_HUD"
    HUD_PITCH_LABEL_LEFT.init_pos = {0.36, vertical_distance + 0.01, 0}  
    HUD_PITCH_LABEL_LEFT.alignment = "LeftCenter"
    HUD_PITCH_LABEL_LEFT.stringdefs = {0.007, 0.007, 0.0000, 0.0}
    HUD_PITCH_LABEL_LEFT.value = tostring(pitch_angle)
    HUD_PITCH_LABEL_LEFT.name = create_guid_string()
    HUD_PITCH_LABEL_LEFT.collimated = true
    HUD_PITCH_LABEL_LEFT.use_mipfilter = true
    HUD_PITCH_LABEL_LEFT.additive_alpha = true
	HUD_PITCH_LABEL_LEFT.element_params = {"MAIN_POWER", "HUD_OPACITY"}
	HUD_PITCH_LABEL_LEFT.controllers = {{"parameter_compare_with_number", 0, 1},{"opacity_using_parameter",1},} 
	HUD_PITCH_LABEL_LEFT.blend_mode = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
    HUD_PITCH_LABEL_LEFT.h_clip_relation = h_clip_relations.COMPARE
    HUD_PITCH_LABEL_LEFT.level = HUD_DEFAULT_NOCLIP_LEVEL + 2
    HUD_PITCH_LABEL_LEFT.parent_element = "HUD_PITCH"
    Add(HUD_PITCH_LABEL_LEFT)
end

-- Pitch Ladder Labels Negative
for i = 1, 20 do
    local pitch_angle = i * 5
    local vertical_distance = -0.513 * i - 0.12 

    -- Right-side label
    local HUD_PITCH_LABEL_RIGHT = CreateElement "ceStringPoly"
    HUD_PITCH_LABEL_RIGHT.material = "F22_HUD"
    HUD_PITCH_LABEL_RIGHT.init_pos = {-0.36, vertical_distance + 0.075, 0}
    HUD_PITCH_LABEL_RIGHT.alignment = "RightCenter"
    HUD_PITCH_LABEL_RIGHT.stringdefs = {0.007, 0.007, 0.0000, 0.0} --
    HUD_PITCH_LABEL_RIGHT.value = tostring(pitch_angle)
    HUD_PITCH_LABEL_RIGHT.name = create_guid_string()
    HUD_PITCH_LABEL_RIGHT.collimated = true
    HUD_PITCH_LABEL_RIGHT.use_mipfilter = true
    HUD_PITCH_LABEL_RIGHT.additive_alpha = true
	HUD_PITCH_LABEL_RIGHT.element_params = {"MAIN_POWER", "HUD_OPACITY"}
	HUD_PITCH_LABEL_RIGHT.controllers = {{"parameter_compare_with_number", 0, 1},{"opacity_using_parameter",1},} 
	HUD_PITCH_LABEL_RIGHT.blend_mode = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
    HUD_PITCH_LABEL_RIGHT.h_clip_relation = h_clip_relations.COMPARE
    HUD_PITCH_LABEL_RIGHT.level = HUD_DEFAULT_NOCLIP_LEVEL + 2
    HUD_PITCH_LABEL_RIGHT.parent_element = "HUD_PITCH"
    Add(HUD_PITCH_LABEL_RIGHT)

    -- Left-side label (mirrored)
    local HUD_PITCH_LABEL_LEFT = CreateElement "ceStringPoly"
    HUD_PITCH_LABEL_LEFT.material = "F22_HUD"
    HUD_PITCH_LABEL_LEFT.init_pos = {0.36, vertical_distance + 0.075, 0}
    HUD_PITCH_LABEL_LEFT.alignment = "LeftCenter"
    HUD_PITCH_LABEL_LEFT.stringdefs = {0.007, 0.007, 0.000, 0.0}
    HUD_PITCH_LABEL_LEFT.value = tostring(pitch_angle)
    HUD_PITCH_LABEL_LEFT.name = create_guid_string()
    HUD_PITCH_LABEL_LEFT.collimated = true
    HUD_PITCH_LABEL_LEFT.use_mipfilter = true
    HUD_PITCH_LABEL_LEFT.additive_alpha = true
	HUD_PITCH_LABEL_LEFT.element_params = {"MAIN_POWER", "HUD_OPACITY"}
	HUD_PITCH_LABEL_LEFT.controllers = {{"parameter_compare_with_number", 0, 1},{"opacity_using_parameter",1},} 
	HUD_PITCH_LABEL_LEFT.blend_mode = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
    HUD_PITCH_LABEL_LEFT.h_clip_relation = h_clip_relations.COMPARE
    HUD_PITCH_LABEL_LEFT.level = HUD_DEFAULT_NOCLIP_LEVEL + 2
    HUD_PITCH_LABEL_LEFT.parent_element = "HUD_PITCH"
    Add(HUD_PITCH_LABEL_LEFT)
end





-- Horizon Line
local hud_horizon = CreateElement "ceTexPoly"
hud_horizon.vertices = hud_vert_gen(3000, 1500) --
hud_horizon.indices = {0, 1, 2, 2, 3, 0}
hud_horizon.tex_coords = tex_coord_gen(0, 0, 2048, 2048, 2048, 2048)
hud_horizon.material = HUD_HORIZON
hud_horizon.name = create_guid_string()
hud_horizon.init_pos = {0, 0.0, 0} 
hud_horizon.collimated = true
hud_horizon.use_mipfilter = true
hud_horizon.h_clip_relation = h_clip_relations.COMPARE
hud_horizon.level = HUD_DEFAULT_NOCLIP_LEVEL + 2
hud_horizon.parent_element = "HUD_PITCH"
hud_horizon.additive_alpha = true
hud_horizon.blend_mode = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
hud_horizon.element_params = {"MAIN_POWER", "HUD_OPACITY"}
hud_horizon.controllers = {{"parameter_compare_with_number", 0, 1},{"opacity_using_parameter",1},} 
Add(hud_horizon)

-- Flight Path Container
HUD_FPC = CreateElement "ceSimple"
HUD_FPC.name = "HUD_FPC"
HUD_FPC.init_pos = {0, 0, 0} 
HUD_FPC.element_params = {"FPA", "ADIPITCH", "SLIP"}
HUD_FPC.controllers = {
    {"move_up_down_using_parameter", 0, 0.01026},
    {"move_up_down_using_parameter", 1, -0.01026},
    {"move_left_right_using_parameter", 2, -0.01},
}
HUD_FPC.collimated = true
HUD_FPC.use_mipfilter = true
HUD_FPC.additive_alpha = true
HUD_FPC.h_clip_relation = h_clip_relations.COMPARE
HUD_FPC.level = HUD_DEFAULT_NOCLIP_LEVEL + 1
HUD_FPC.parent_element = "HUD_PITCH"
HUD_FPC.isvisible = true
Add(HUD_FPC)

-- Velocity Vector Graphic
local hud_vectorv_real = CreateElement "ceTexPoly"
hud_vectorv_real.vertices = hud_vert_gen(2600, 2600) --
hud_vectorv_real.indices = {0, 1, 2, 2, 3, 0}
hud_vectorv_real.tex_coords = tex_coord_gen(0, 0, 2048, 2048, 2048, 2048)
hud_vectorv_real.material = HUD_FPV
hud_vectorv_real.name = create_guid_string()
hud_vectorv_real.init_pos = {0, -0.03, 0}
hud_vectorv_real.element_params = {"MAIN_POWER","HUD_OPACITY"}
hud_vectorv_real.controllers = {{"parameter_compare_with_number", 0, 1},{"opacity_using_parameter",1},}
hud_vectorv_real.collimated = true
hud_vectorv_real.use_mipfilter = true
hud_vectorv_real.additive_alpha = true
hud_vectorv_real.blend_mode = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
hud_vectorv_real.h_clip_relation = h_clip_relations.COMPARE
hud_vectorv_real.level = HUD_DEFAULT_NOCLIP_LEVEL + 2
hud_vectorv_real.parent_element = "HUD_FPC"
Add(hud_vectorv_real)


-- Static α prefix
local hud_aoa_label = CreateElement "ceStringPoly"
hud_aoa_label.material = "F22_HUD"
hud_aoa_label.init_pos = {-0.85, -0.59, 0}
hud_aoa_label.alignment = "RightCenter"
hud_aoa_label.stringdefs = {0.011, 0.011, 0.000000, 0.0}
hud_aoa_label.value = "#" 
hud_aoa_label.collimated = true
hud_aoa_label.use_mipfilter = true
hud_aoa_label.additive_alpha = true
hud_aoa_label.element_params = {"MAIN_POWER", "HUD_OPACITY"}
hud_aoa_label.controllers = {{"parameter_compare_with_number", 0, 1},{"opacity_using_parameter",1},} 
hud_aoa_label.blend_mode = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
hud_aoa_label.h_clip_relation = h_clip_relations.COMPARE
hud_aoa_label.level = HUD_DEFAULT_NOCLIP_LEVEL + 2
hud_aoa_label.parent_element = "HUD_ROLL_STC"
Add(hud_aoa_label)

--Current alpha
local hud_current_alpha = CreateElement "ceStringPoly"
hud_current_alpha.material = "F22_HUD"
hud_current_alpha.init_pos = {-0.63, -0.585, 0} --.43
hud_current_alpha.alignment = "RightCenter"
hud_current_alpha.stringdefs = {0.0080, 0.0080, 0.00000, 0.0}
hud_current_alpha.formats = {"%.1f", "%s"}
hud_current_alpha.element_params = {"AOA","HUD_OPACITY"}
hud_current_alpha.controllers = {{"text_using_parameter", 0},{"opacity_using_parameter",1},}
hud_current_alpha.collimated = true
hud_current_alpha.use_mipfilter = true
hud_current_alpha.additive_alpha = true
hud_current_alpha.blend_mode = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
hud_current_alpha.h_clip_relation = h_clip_relations.COMPARE
hud_current_alpha.level = HUD_DEFAULT_NOCLIP_LEVEL + 2
hud_current_alpha.parent_element = "HUD_ROLL_STC"
Add(hud_current_alpha)

-- Static mach prefix
local hud_mach_label = CreateElement "ceStringPoly"
hud_mach_label.material = "F22_HUD"
hud_mach_label.init_pos = {-0.87, -0.39, 0}
hud_mach_label.alignment = "RightCenter"
hud_mach_label.stringdefs = {0.0080, 0.0080, 0.00000, 0.0}
hud_mach_label.value = "M" 
hud_mach_label.collimated = true
hud_mach_label.use_mipfilter = true
hud_mach_label.additive_alpha = true
hud_mach_label.element_params = {"MAIN_POWER", "HUD_OPACITY"}
hud_mach_label.controllers = {{"parameter_compare_with_number", 0, 1},{"opacity_using_parameter",1},} 
hud_mach_label.blend_mode = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
hud_mach_label.h_clip_relation = h_clip_relations.COMPARE
hud_mach_label.level = HUD_DEFAULT_NOCLIP_LEVEL + 2
hud_mach_label.parent_element = "HUD_ROLL_STC"
Add(hud_mach_label)

--Current mach
local hud_current_mach = CreateElement "ceStringPoly"
hud_current_mach.material = "F22_HUD"
hud_current_mach.init_pos = {-0.63, -0.39, 0}
hud_current_mach.alignment = "RightCenter"
hud_current_mach.stringdefs = {0.0080, 0.0080, 0.00000, 0.0}
hud_current_mach.formats = {"%.2f", "%s"}
hud_current_mach.element_params = {"MACH","HUD_OPACITY"}
hud_current_mach.controllers = {{"text_using_parameter", 0},{"opacity_using_parameter",1},}
hud_current_mach.collimated = true
hud_current_mach.use_mipfilter = true
hud_current_mach.additive_alpha = true
hud_current_mach.blend_mode = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
hud_current_mach.h_clip_relation = h_clip_relations.COMPARE
hud_current_mach.level = HUD_DEFAULT_NOCLIP_LEVEL + 2
hud_current_mach.parent_element = "HUD_ROLL_STC"
Add(hud_current_mach)

-- Static "G" prefix
local hud_g_label = CreateElement "ceStringPoly"
hud_g_label.material = "F22_HUD"
hud_g_label.init_pos = {-0.87, -0.49, 0}
hud_g_label.alignment = "RightCenter" 
hud_g_label.stringdefs = {0.0080, 0.00800, 0.00000, 0.0}
hud_g_label.value = "G" 
hud_g_label.collimated = true
hud_g_label.use_mipfilter = true
hud_g_label.additive_alpha = true
hud_g_label.element_params = {"MAIN_POWER", "HUD_OPACITY"}
hud_g_label.controllers = {{"parameter_compare_with_number", 0, 1},{"opacity_using_parameter",1},} 
hud_g_label.blend_mode = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
hud_g_label.h_clip_relation = h_clip_relations.COMPARE
hud_g_label.level = HUD_DEFAULT_NOCLIP_LEVEL + 2
hud_g_label.parent_element = "HUD_ROLL_STC"
Add(hud_g_label)

--Current G
local hud_current_g = CreateElement "ceStringPoly"
hud_current_g.material = "F22_HUD"
hud_current_g.init_pos = {-0.63, -0.485, 0} 
hud_current_g.alignment = "RightCenter"
hud_current_g.stringdefs = {0.0080, 0.00800, 0.000002, 0.0} 
hud_current_g.formats = {"%.1f", "%s"}
hud_current_g.element_params = {"GFORCE","HUD_OPACITY"}
hud_current_g.controllers = {{"text_using_parameter", 0},{"opacity_using_parameter",1},}
hud_current_g.collimated = true
hud_current_g.use_mipfilter = true
hud_current_g.additive_alpha = true
hud_current_g.blend_mode = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
hud_current_g.h_clip_relation = h_clip_relations.COMPARE
hud_current_g.level = HUD_DEFAULT_NOCLIP_LEVEL + 2
hud_current_g.parent_element = "HUD_ROLL_STC"
Add(hud_current_g)

-- Static "GS"
local hud_gs_label = CreateElement "ceStringPoly"
hud_gs_label.material = "F22_HUD"
hud_gs_label.init_pos = {-0.85, -0.28, 0}
hud_gs_label.alignment = "RightCenter" 
hud_gs_label.stringdefs = {0.00850, 0.00850, 0.000002, 0.0} 
hud_gs_label.value = "GS" 
hud_gs_label.collimated = true
hud_gs_label.use_mipfilter = true
hud_gs_label.additive_alpha = true
hud_gs_label.element_params = {"MAIN_POWER", "HUD_OPACITY"}
hud_gs_label.controllers = {{"parameter_compare_with_number", 0, 1},{"opacity_using_parameter",1},} 
hud_gs_label.blend_mode = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
hud_gs_label.h_clip_relation = h_clip_relations.COMPARE
hud_gs_label.level = HUD_DEFAULT_NOCLIP_LEVEL + 2
hud_gs_label.parent_element = "HUD_ROLL_STC"
Add(hud_gs_label)

--Current GS
local hud_grnd_spd = CreateElement "ceStringPoly"
hud_grnd_spd.material = "F22_HUD"
hud_grnd_spd.init_pos = {-0.63, -0.28, 0} 
hud_grnd_spd.alignment = "RightCenter"
hud_grnd_spd.stringdefs = {0.00850, 0.00850, 0.000002, 0.0} 
hud_grnd_spd.formats = {"%.0f", "%s"}
hud_grnd_spd.element_params = {"TAS","HUD_OPACITY"}
hud_grnd_spd.controllers = {{"text_using_parameter", 0},{"opacity_using_parameter",1},}
hud_grnd_spd.collimated = true
hud_grnd_spd.use_mipfilter = true
hud_grnd_spd.additive_alpha = true
hud_grnd_spd.blend_mode = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
hud_grnd_spd.h_clip_relation = h_clip_relations.COMPARE
hud_grnd_spd.level = HUD_DEFAULT_NOCLIP_LEVEL + 2
hud_grnd_spd.parent_element = "HUD_ROLL_STC"
Add(hud_grnd_spd)



-- Airspeed Display
local HUD_SPEED = CreateElement "ceStringPoly"
HUD_SPEED.material = "F22_HUD"
HUD_SPEED.init_pos = {-0.66, -0.05, 0} 
HUD_SPEED.alignment = "RightCenter"
HUD_SPEED.stringdefs = {0.0110, 0.01100, 0.00000, 0.0}
HUD_SPEED.formats = {"%.0f", "%s"}
HUD_SPEED.element_params = {"IAS","HUD_OPACITY"}
HUD_SPEED.controllers = {{"text_using_parameter", 0},{"opacity_using_parameter",1},}
HUD_SPEED.collimated = true
HUD_SPEED.use_mipfilter = true
HUD_SPEED.additive_alpha = true
HUD_SPEED.blend_mode = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
HUD_SPEED.h_clip_relation = h_clip_relations.COMPARE
HUD_SPEED.level = HUD_DEFAULT_NOCLIP_LEVEL + 2
HUD_SPEED.parent_element = "HUD_ROLL_STC"
Add(HUD_SPEED)

-- Speed Circle
local HUD_Circle_Speed = CreateElement "ceTexPoly"
HUD_Circle_Speed.vertices = hud_vert_gen(800, 630) 
HUD_Circle_Speed.indices = {0, 1, 2, 2, 3, 0}
HUD_Circle_Speed.tex_coords = tex_coord_gen(0, 0, 2048, 2048, 2048, 2048)
HUD_Circle_Speed.material = HUD_DOTTED_CIRCLE
HUD_Circle_Speed.name = create_guid_string()
HUD_Circle_Speed.init_pos = {-0.76, -0.05, 0}
HUD_Circle_Speed.element_params = {"MAIN_POWER","HUD_OPACITY"}
HUD_Circle_Speed.controllers = {{"parameter_compare_with_number", 0, 1},{"opacity_using_parameter",1},}
HUD_Circle_Speed.collimated = true
HUD_Circle_Speed.use_mipfilter = true
HUD_Circle_Speed.additive_alpha = true
HUD_Circle_Speed.blend_mode = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
HUD_Circle_Speed.h_clip_relation = h_clip_relations.COMPARE
HUD_Circle_Speed.level = HUD_DEFAULT_NOCLIP_LEVEL + 2
HUD_Circle_Speed.parent_element = "HUD_ROLL_STC"
Add(HUD_Circle_Speed)



-- Altitude Display
local HUD_ALT_DIS = CreateElement "ceStringPoly"
HUD_ALT_DIS.material = "F22_HUD"
HUD_ALT_DIS.init_pos = {0.89, -0.05, 0}
HUD_ALT_DIS.alignment = "RightCenter"
HUD_ALT_DIS.stringdefs = {0.00900, 0.0090, 0.00000, 0.0} 
HUD_ALT_DIS.formats = {"%03.0f", "%s"} 
HUD_ALT_DIS.element_params = {"ALT_FT","HUD_OPACITY"}
HUD_ALT_DIS.controllers = {{"text_using_parameter", 0, 0, "%03.0f", 0, 1000},{"opacity_using_parameter",1},} 
HUD_ALT_DIS.collimated = true
HUD_ALT_DIS.use_mipfilter = true
HUD_ALT_DIS.additive_alpha = true
HUD_ALT_DIS.h_clip_relation = h_clip_relations.COMPARE
HUD_ALT_DIS.level = HUD_DEFAULT_NOCLIP_LEVEL + 2
HUD_ALT_DIS.parent_element = "HUD_ROLL_STC"
Add(HUD_ALT_DIS)

-- Altitude Thousands Display
local HUD_ALT_THOUSANDS = CreateElement "ceStringPoly"
HUD_ALT_THOUSANDS.material = "F22_HUD"
HUD_ALT_THOUSANDS.init_pos = {0.745, -0.05, 0} 
HUD_ALT_THOUSANDS.alignment = "RightCenter"
HUD_ALT_THOUSANDS.stringdefs = {0.01100, 0.01100, 0.0000, 0.0} 
HUD_ALT_THOUSANDS.formats = {"%.0f", "%s"} 
HUD_ALT_THOUSANDS.element_params = {"ALT_TH","HUD_OPACITY"}
HUD_ALT_THOUSANDS.controllers = {
    {"text_using_parameter", 0, 0, "%.0f", 0, 0, 1000}, 
    {"parameter_in_range", 0, 0.9, 99},
	{"opacity_using_parameter",1},	
}
HUD_ALT_THOUSANDS.collimated = true
HUD_ALT_THOUSANDS.use_mipfilter = true
HUD_ALT_THOUSANDS.additive_alpha = true
HUD_ALT_THOUSANDS.h_clip_relation = h_clip_relations.COMPARE
HUD_ALT_THOUSANDS.level = HUD_DEFAULT_NOCLIP_LEVEL + 2
HUD_ALT_THOUSANDS.parent_element = "HUD_ROLL_STC"
Add(HUD_ALT_THOUSANDS)

-- Altitude Circle
local HUD_Circle = CreateElement "ceTexPoly"
HUD_Circle.vertices = hud_vert_gen(800, 630)
HUD_Circle.indices = {0, 1, 2, 2, 3, 0}
HUD_Circle.tex_coords = tex_coord_gen(0, 0, 2048, 2048, 2048, 2048)
HUD_Circle.material = HUD_DOTTED_CIRCLE
HUD_Circle.name = create_guid_string()
HUD_Circle.init_pos = {0.76, -0.05, 0}
HUD_Circle.element_params = {"MAIN_POWER","HUD_OPACITY"}
HUD_Circle.controllers = {{"parameter_compare_with_number", 0, 1},{"opacity_using_parameter",1},}
HUD_Circle.collimated = true
HUD_Circle.use_mipfilter = true
HUD_Circle.additive_alpha = true
HUD_Circle.h_clip_relation = h_clip_relations.COMPARE
HUD_Circle.level = HUD_DEFAULT_NOCLIP_LEVEL + 2
HUD_Circle.parent_element = "HUD_ROLL_STC"
Add(HUD_Circle)

-- Static R for Radar Alt
local hud_R_label = CreateElement "ceStringPoly"
hud_R_label.material = "F22_HUD"
hud_R_label.init_pos = {0.69, -0.39, 0}
hud_R_label.alignment = "RightCenter" 
hud_R_label.stringdefs = {0.0080, 0.0080, 0.0000, 0.0}
hud_R_label.value = "R" 
hud_R_label.collimated = true
hud_R_label.use_mipfilter = true
hud_R_label.additive_alpha = true
hud_R_label.element_params = {"MAIN_POWER","HUD_OPACITY"}
hud_R_label.controllers = {{"parameter_compare_with_number", 0, 1},{"opacity_using_parameter",1},} 
hud_R_label.h_clip_relation = h_clip_relations.COMPARE
hud_R_label.level = HUD_DEFAULT_NOCLIP_LEVEL + 2
hud_R_label.parent_element = "HUD_ROLL_STC"
Add(hud_R_label)

local HUD_ALT_RAD = CreateElement "ceStringPoly"
HUD_ALT_RAD.material = "F22_HUD"
HUD_ALT_RAD.init_pos = {0.95, -0.39, 0} 
HUD_ALT_RAD.alignment = "RightCenter"
HUD_ALT_RAD.stringdefs = {0.00800, 0.00800, 0.00000, 0.0} 
HUD_ALT_RAD.formats = {"%.0f", "%s"}
HUD_ALT_RAD.element_params = {"SMOOTH_RAD_ALT","HUD_OPACITY"}
HUD_ALT_RAD.controllers = {{"text_using_parameter", 0},{"opacity_using_parameter",1},} 
HUD_ALT_RAD.collimated = true
HUD_ALT_RAD.use_mipfilter = true
HUD_ALT_RAD.additive_alpha = true
HUD_ALT_RAD.h_clip_relation = h_clip_relations.COMPARE
HUD_ALT_RAD.level = HUD_DEFAULT_NOCLIP_LEVEL + 2
HUD_ALT_RAD.parent_element = "HUD_ROLL_STC"
Add(HUD_ALT_RAD)

-- Master Arm
local MASTER_ARM = CreateElement "ceStringPoly"
MASTER_ARM.material = "F22_HUD"
MASTER_ARM.init_pos = {0.90, -0.585, 0}
MASTER_ARM.alignment = "RightCenter" 
MASTER_ARM.stringdefs = {0.0090, 0.0090, 0.0000, 0.0} 
MASTER_ARM.value = "ARMED" 
MASTER_ARM.collimated = true
MASTER_ARM.use_mipfilter = true
MASTER_ARM.additive_alpha = true
MASTER_ARM.element_params = {"MAIN_POWER","HUD_OPACITY", "MASTER_ARM"}
MASTER_ARM.controllers = {{"parameter_compare_with_number", 0, 1},{"opacity_using_parameter",1},{"parameter_compare_with_number", 2, 1},} 
MASTER_ARM.h_clip_relation = h_clip_relations.COMPARE
MASTER_ARM.level = HUD_DEFAULT_NOCLIP_LEVEL + 2
MASTER_ARM.parent_element = "HUD_ROLL_STC"
Add(MASTER_ARM)

-- Master Safe
local MASTER_SAFE = CreateElement "ceStringPoly"
MASTER_SAFE.material = "F22_HUD"
MASTER_SAFE.init_pos = {0.85, -0.585, 0}
MASTER_SAFE.alignment = "RightCenter" 
MASTER_SAFE.stringdefs = {0.0090, 0.0090, 0.0000, 0.0} 
MASTER_SAFE.value = "SAFE" 
MASTER_SAFE.collimated = true
MASTER_SAFE.use_mipfilter = true
MASTER_SAFE.additive_alpha = true
MASTER_SAFE.element_params = {"MAIN_POWER","HUD_OPACITY", "MASTER_ARM"}
MASTER_SAFE.controllers = {{"parameter_compare_with_number", 0, 1},{"opacity_using_parameter",1},{"parameter_compare_with_number", 2, 0},} 
MASTER_SAFE.h_clip_relation = h_clip_relations.COMPARE
MASTER_SAFE.level = HUD_DEFAULT_NOCLIP_LEVEL + 2
MASTER_SAFE.parent_element = "HUD_ROLL_STC"
Add(MASTER_SAFE)


-- E Bracket
local HUD_E_IND = CreateElement "ceTexPoly"
HUD_E_IND.vertices = hud_vert_gen(500, 600)
HUD_E_IND.indices = {0, 1, 2, 2, 3, 0}
HUD_E_IND.tex_coords = tex_coord_gen(0, 0, 2048, 2048, 2048, 2048)
HUD_E_IND.material = HUD_E_BRACKET
HUD_E_IND.init_pos = {-0.2, -0.11, 0} 
HUD_E_IND.element_params = {"MAIN_POWER", "GEAR_DOWN", "RAW_AOA","HUD_OPACITY"}
HUD_E_IND.controllers = {
    {"parameter_compare_with_number", 0, 1}, 
    {"parameter_compare_with_number", 1, 1},
    {"move_up_down_using_parameter", 2, -0.007, 4},
	{"opacity_using_parameter",3},
}
HUD_E_IND.collimated = true
HUD_E_IND.use_mipfilter = true
HUD_E_IND.additive_alpha = true
HUD_E_IND.blend_mode = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
HUD_E_IND.h_clip_relation = h_clip_relations.COMPARE
HUD_E_IND.level = HUD_DEFAULT_NOCLIP_LEVEL + 2
HUD_E_IND.parent_element = "HUD_ROLL_STC"
Add(HUD_E_IND)

--Vertical Velocity
local HUD_Vert_V = CreateElement "ceStringPoly"
HUD_Vert_V.material = "F22_HUD"
HUD_Vert_V.init_pos = {0.95, -0.281, 0} 
HUD_Vert_V.alignment = "RightCenter"
HUD_Vert_V.stringdefs = {0.00800, 0.00800, 0.00000, 0.0}
HUD_Vert_V.formats = {"%.0f", "%s"}
HUD_Vert_V.element_params = {"VertV", "WOW_STATE","HUD_OPACITY"}
HUD_Vert_V.controllers = {
			{"text_using_parameter", 0},
			{"parameter_compare_with_number", 1, 0},
			{"opacity_using_parameter", 2},
}
HUD_Vert_V.collimated = true
HUD_Vert_V.use_mipfilter = true
HUD_Vert_V.additive_alpha = true
HUD_Vert_V.blend_mode = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
HUD_Vert_V.h_clip_relation = h_clip_relations.COMPARE
HUD_Vert_V.level = HUD_DEFAULT_NOCLIP_LEVEL + 2
HUD_Vert_V.parent_element = "HUD_ROLL_STC"
Add(HUD_Vert_V)

-- Static VV
local hud_VV_label = CreateElement "ceStringPoly"
hud_VV_label.material = "F22_HUD"
hud_VV_label.init_pos = {0.69, -0.28, 0}
hud_VV_label.alignment = "RightCenter" 
hud_VV_label.stringdefs = {0.0080, 0.0080, 0.00000, 0.0}
hud_VV_label.value = "VV" 
hud_VV_label.element_params = {"MAIN_POWER", "WOW_STATE","HUD_OPACITY"}
hud_VV_label.controllers = {
    {"parameter_compare_with_number", 0, 1},
	{"parameter_compare_with_number", 1, 0},
	{"opacity_using_parameter", 2},
}
hud_VV_label.collimated = true
hud_VV_label.use_mipfilter = true
hud_VV_label.additive_alpha = true
hud_VV_label.h_clip_relation = h_clip_relations.COMPARE
hud_VV_label.level = HUD_DEFAULT_NOCLIP_LEVEL + 2
hud_VV_label.parent_element = "HUD_ROLL_STC"
Add(hud_VV_label)


-- Heading Box
local HUD_Heading_Box = CreateElement "ceTexPoly"
HUD_Heading_Box.vertices = hud_vert_gen(3200, 1600)
HUD_Heading_Box.indices = {0, 1, 2, 2, 3, 0}
HUD_Heading_Box.tex_coords = tex_coord_gen(0, 0, 2048, 2048, 2048, 2048)
HUD_Heading_Box.material = HUD_HEADING_BOX
HUD_Heading_Box.name = create_guid_string()
HUD_Heading_Box.init_pos = {0.0, 0.82, 0}
HUD_Heading_Box.element_params = {"MAIN_POWER","HUD_OPACITY"}
HUD_Heading_Box.controllers = {{"parameter_compare_with_number", 0, 1},{"opacity_using_parameter", 1},}
HUD_Heading_Box.collimated = true
HUD_Heading_Box.use_mipfilter = true
HUD_Heading_Box.additive_alpha = true
HUD_Heading_Box.blend_mode = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
HUD_Heading_Box.h_clip_relation = h_clip_relations.COMPARE
HUD_Heading_Box.level = HUD_DEFAULT_NOCLIP_LEVEL + 2 
HUD_Heading_Box.parent_element = "HUD_MAIN_CLIP"
Add(HUD_Heading_Box)

-- Current Heading
local hud_current_heading = CreateElement "ceStringPoly"
hud_current_heading.material = "F22_HUD"
hud_current_heading.init_pos = {0.08, 0.84, 0}
hud_current_heading.alignment = "RightCenter"
hud_current_heading.stringdefs = {0.00950, 0.00950, 0.000, 0.0}
hud_current_heading.formats = {"%03.0f", "%s"}
hud_current_heading.element_params = {"NAV","HUD_OPACITY"}
hud_current_heading.controllers = {{"text_using_parameter", 0},{"opacity_using_parameter", 1},}
hud_current_heading.collimated = true
hud_current_heading.use_mipfilter = true
hud_current_heading.additive_alpha = true
hud_current_heading.blend_mode = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
hud_current_heading.h_clip_relation = h_clip_relations.COMPARE
hud_current_heading.level = HUD_DEFAULT_NOCLIP_LEVEL + 2 
hud_current_heading.parent_element = "HUD_MAIN_CLIP"
Add(hud_current_heading)

--Radar Alt Warning
local rad_alt_warn = CreateElement "ceStringPoly"
rad_alt_warn.material = "F22_HUD"
rad_alt_warn.init_pos = {0.3, -0.84, 0}
rad_alt_warn.alignment = "RightCenter"
rad_alt_warn.stringdefs = {0.0180, 0.0130, 0.000025, 0.0}
rad_alt_warn.value = "ALTITUDE" 
rad_alt_warn.collimated = true
rad_alt_warn.use_mipfilter = true
rad_alt_warn.additive_alpha = true
rad_alt_warn.blend_mode = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
rad_alt_warn.h_clip_relation = h_clip_relations.COMPARE
rad_alt_warn.level = HUD_DEFAULT_NOCLIP_LEVEL + 2
rad_alt_warn.element_params = {"MAIN_POWER", "SMOOTH_RAD_ALT", "GEAR_DOWN", "RAD_ALT_RATE","HUD_OPACITY"}
rad_alt_warn.controllers = {
    {"parameter_compare_with_number", 0, 1}, 
    {"parameter_in_range", 1, -9999, 1500},
	{"parameter_compare_with_number", 2, 0},
	{"parameter_in_range", 3, -9999, 0},
	{"opacity_using_parameter", 4},
}
rad_alt_warn.parent_element = "HUD_ROLL_STC"
Add(rad_alt_warn)






-- Heading Tape Container (Primary)
local HUD_HEAD_TAPE = CreateElement "ceSimple"
HUD_HEAD_TAPE.name = create_guid_string()
HUD_HEAD_TAPE.init_pos = {0.0, 0.40, 0} 
HUD_HEAD_TAPE.collimated = true
HUD_HEAD_TAPE.use_mipfilter = true
HUD_HEAD_TAPE.additive_alpha = true
HUD_HEAD_TAPE.h_clip_relation = h_clip_relations.COMPARE
HUD_HEAD_TAPE.level = HUD_DEFAULT_NOCLIP_LEVEL + 1
HUD_HEAD_TAPE.parent_element = "HUD_MAIN_CLIP"
HUD_HEAD_TAPE.element_params = {"TRUE_HEADING", "MAIN_POWER"}
HUD_HEAD_TAPE.controllers = {
    {"move_left_right_using_parameter", 0, -0.0032}, 
    {"parameter_compare_with_number", 1, 1} 
} 
HUD_HEAD_TAPE.isvisible = false
Add(HUD_HEAD_TAPE)

-- Heading Tape Container (Secondary, for wrapping)
local HUD_HEAD_TAPE2 = CreateElement "ceSimple"
HUD_HEAD_TAPE2.name = create_guid_string()
HUD_HEAD_TAPE2.init_pos = {0.0, 0.40, 0}
HUD_HEAD_TAPE2.init_rot = {0, 0, 0} 
HUD_HEAD_TAPE2.collimated = true
HUD_HEAD_TAPE2.use_mipfilter = true
HUD_HEAD_TAPE2.additive_alpha = true
HUD_HEAD_TAPE2.h_clip_relation = h_clip_relations.COMPARE
HUD_HEAD_TAPE2.level = HUD_DEFAULT_NOCLIP_LEVEL + 1
HUD_HEAD_TAPE2.parent_element = "HUD_MAIN_CLIP"
HUD_HEAD_TAPE2.element_params = {"TRUE_HEADING", "MAIN_POWER"}
HUD_HEAD_TAPE2.controllers = {
    {"move_left_right_using_parameter", 0, 0.0032}, 
    {"parameter_compare_with_number", 1, 1}
}
HUD_HEAD_TAPE2.isvisible = false
Add(HUD_HEAD_TAPE2)

-- Generate Heading Tape Ticks and Labels (Primary Container)
for i = -74, 74 do
    local heading = i * 5 -- Ticks every 5 degrees
    local x_pos = heading * 0.032 

    -- Tick Marks (Every 5 Degrees)
    local hud_heading_tick = CreateElement "ceTexPoly"
    hud_heading_tick.vertices = hud_vert_gen(1500, 1900) 
    hud_heading_tick.indices = {0, 1, 2, 2, 3, 0}
    hud_heading_tick.tex_coords = tex_coord_gen(0, 0, 2048, 2048, 2048, 2048)
    hud_heading_tick.material = HUD_HEADING_TAPE
    hud_heading_tick.name = create_guid_string()
    hud_heading_tick.init_pos = {x_pos, 0.37, 0} 
	hud_heading_tick.element_params = {"MAIN_POWER", "HUD_OPACITY"}
	hud_heading_tick.controllers = {{"parameter_compare_with_number", 0, 1},{"opacity_using_parameter",1},} 
    hud_heading_tick.collimated = true
    hud_heading_tick.use_mipfilter = true
    hud_heading_tick.additive_alpha = true
    hud_heading_tick.blend_mode = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
    hud_heading_tick.h_clip_relation = h_clip_relations.COMPARE
    hud_heading_tick.level = HUD_DEFAULT_NOCLIP_LEVEL + 2
    hud_heading_tick.parent_element = HUD_HEAD_TAPE.name
    hud_heading_tick.isvisible = true
    Add(hud_heading_tick)

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

        local hud_heading_label = CreateElement "ceStringPoly"
        hud_heading_label.material = "F22_HUD"
        hud_heading_label.init_pos = {x_pos, 0.34, 0} 
        hud_heading_label.alignment = "CenterCenter"
        hud_heading_label.stringdefs = {0.0070, 0.0070, 0.0000, 0.0}
        hud_heading_label.value = label_text
        hud_heading_label.element_params = {"MAIN_POWER","HUD_OPACITY"}
        hud_heading_label.controllers = {{"parameter_compare_with_number", 0, 1},{"opacity_using_parameter",1},}
        hud_heading_label.collimated = true
        hud_heading_label.use_mipfilter = true
        hud_heading_label.additive_alpha = true
        hud_heading_label.blend_mode = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
        hud_heading_label.h_clip_relation = h_clip_relations.COMPARE
        hud_heading_label.level = HUD_DEFAULT_NOCLIP_LEVEL + 2
        hud_heading_label.parent_element = HUD_HEAD_TAPE.name
        hud_heading_label.isvisible = true
        Add(hud_heading_label)
    end
end

--Weapons/Radar


-- {"line_object_set_point_using_parameters", point_nr, param_x, param_y, gain_x, gain_y} -- applies to ceSimpleLineObject at least

-- Gun Piper
-- Gun Piper Container
local HUD_GUN_PIPER_CONTAINER = CreateElement "ceSimple"
HUD_GUN_PIPER_CONTAINER.name = create_guid_string()
HUD_GUN_PIPER_CONTAINER.init_pos = {0, 0, 0}
HUD_GUN_PIPER_CONTAINER.element_params = {"GUN_PIPER_X", "GUN_PIPER_Y"}
HUD_GUN_PIPER_CONTAINER.controllers = {
    {"move_left_right_using_parameter", 0, 0.4}, -- Scale 1 assumes HUD units
    {"move_up_down_using_parameter", 1, -0.022}    -- Scale 1 assumes HUD units
}
HUD_GUN_PIPER_CONTAINER.collimated = true
HUD_GUN_PIPER_CONTAINER.use_mipfilter = true
HUD_GUN_PIPER_CONTAINER.additive_alpha = true
HUD_GUN_PIPER_CONTAINER.h_clip_relation = h_clip_relations.COMPARE
HUD_GUN_PIPER_CONTAINER.level = HUD_DEFAULT_NOCLIP_LEVEL + 1
HUD_GUN_PIPER_CONTAINER.parent_element = "HUD_MAIN_CLIP" -- Parent to pitch container
HUD_GUN_PIPER_CONTAINER.isvisible = false
Add(HUD_GUN_PIPER_CONTAINER)

-- Gun Piper Graphic
local HUD_GunPiper = CreateElement "ceTexPoly"
HUD_GunPiper.vertices = hud_vert_gen(1000, 1000)
HUD_GunPiper.indices = {0, 1, 2, 2, 3, 0}
HUD_GunPiper.tex_coords = tex_coord_gen(0, 0, 2048, 2048, 2048, 2048)
HUD_GunPiper.material = HUD_GUN_PIPER -- Ensure this material exists
HUD_GunPiper.name = create_guid_string()
HUD_GunPiper.init_pos = {0.028, 0.28, 0} -- Centered in container
HUD_GunPiper.element_params = {"MAIN_POWER", "HUD_OPACITY", "CANNON_ACTIVE"}
HUD_GunPiper.controllers = {
    {"parameter_compare_with_number", 0, 1}, -- Main power on
    {"opacity_using_parameter", 1},         -- HUD opacity
    {"parameter_compare_with_number", 2, 1}  -- Cannon active
}
HUD_GunPiper.collimated = true
HUD_GunPiper.use_mipfilter = true
HUD_GunPiper.additive_alpha = true
HUD_GunPiper.blend_mode = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
HUD_GunPiper.h_clip_relation = h_clip_relations.COMPARE
HUD_GunPiper.level = HUD_DEFAULT_NOCLIP_LEVEL + 2
HUD_GunPiper.parent_element = HUD_GUN_PIPER_CONTAINER.name
Add(HUD_GunPiper)