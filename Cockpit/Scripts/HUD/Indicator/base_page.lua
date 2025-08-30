-- Scripts/HUD/base_page.lua
dofile(LockOn_Options.script_path.."HUD/device/device_defs.lua")



local half_width = GetScale()
local half_height = GetAspect() * half_width
local aspect = GetAspect()

HUD_base_clip = CreateElement "ceMeshPoly"
HUD_base_clip.name = "HUD_base_clip"
HUD_base_clip.primitivetype = "triangles"
HUD_base_clip.vertices = {
    {0, 0}, 
    {0, 0.84 * aspect}, 
    {0.45, 0.835}, 
    {0.67, 0.58}, 
    {0.80, 0.28},
    {0.87, 0},
    {0.87, -0.38}, 
    {0.85, -0.68},
    {0.70, -1.14},
    {0, -1.14 * aspect}, 
    {-0.70, -1.14},
    {-0.85, -0.68},
    {-0.87, -0.38}, 
    {-0.87, 0},
    {-0.80, 0.28},
    {-0.67, 0.58},
    {-0.45, 0.835}
}
HUD_base_clip.indices = {0,1,2, 0,2,3, 0,3,4, 0,4,5, 0,5,6, 0,6,7, 0,7,8, 0,8,9, 0,9,10, 0,10,11, 0,11,12, 0,12,13, 0,13,14, 0,14,15, 0,15,16, 0,1,16}
HUD_base_clip.init_pos = {0.0, -0.95, -2.25} 
HUD_base_clip.init_rot = {0, 0, -15}
HUD_base_clip.material = "HUD_COLLIMATOR"
HUD_base_clip.h_clip_relation = h_clip_relations.REWRITE_LEVEL
HUD_base_clip.level = HUD_DEFAULT_NOCLIP_LEVEL + 1
HUD_base_clip.isdraw = true
HUD_base_clip.change_opacity = true
HUD_base_clip.element_params = {"MAIN_POWER"}
HUD_base_clip.controllers = {{"parameter_compare_with_number", 0, 1}}
HUD_base_clip.isvisible = false
HUD_base_clip.collimated = false
Add(HUD_base_clip)

function update()

end