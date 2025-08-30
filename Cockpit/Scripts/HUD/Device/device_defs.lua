dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."materials.lua")
dofile(LockOn_Options.script_path.."fonts.lua")

HUD_IND_TEX_PATH = LockOn_Options.script_path.."../Textures/HUD/"

SetScale(FOV)

DEGREE_TO_MRAD = 17.4532925199433
DEGREE_TO_RAD = 0.0174532925199433
RAD_TO_DEGREE = 57.29577951308233
MRAD_TO_DEGREE = 0.05729577951308233

CockpitScaleFac = 2.191
CockpitPosFac = 0.382

HUD_ASPECT_HEIGHT = GetAspect()

GLASS_LEVEL = 10
HUD_DEFAULT_LEVEL = GLASS_LEVEL + 1
HUD_DEFAULT_NOCLIP_LEVEL = HUD_DEFAULT_LEVEL - 1

local BlackColor  			= {0, 0, 0, 255}--RGBA
local WhiteColor 			= {255, 255, 255, 255}--RGBA
local MainColor 			= {255, 255, 255, 255}--RGBA
local GreenColor 		    = {  8, 252,   15, 255}
local YellowColor 			= {255, 255, 0, 255}--RGBA
local OrangeColor           = {255, 180, 0, 255}--RGBA
local RedColor 				= {255, 0, 0, 255}--RGBA
local TealColor 			= {0, 255, 255, 255}--RGBA
local HUDScreen             = {255,0,255,255}
local HUD_ladder_color      = {210,150,230,255}

HUD_DOTTED_CIRCLE   = MakeMaterial(HUD_IND_TEX_PATH.."DOTTED_CIRCLE.dds", GreenColor)
HUD_FPV             = MakeMaterial(HUD_IND_TEX_PATH.."vector.dds", GreenColor)
HUD_HORIZON         = MakeMaterial(HUD_IND_TEX_PATH.."horizon_line.dds", GreenColor)
HUD_PITCH_LAD		= MakeMaterial(HUD_IND_TEX_PATH.."Pitch.dds", GreenColor)
HUD_PITCH_NEG		= MakeMaterial(HUD_IND_TEX_PATH.."Neg_Pitch.dds", GreenColor)
HUD_ANGLES         	= MakeMaterial(HUD_IND_TEX_PATH.."Angles.dds", GreenColor)
HUD_HEAD_CUE        = MakeMaterial(HUD_IND_TEX_PATH.."HeadingCue.dds", GreenColor)
HUD_ROLL_CUE		= MakeMaterial(HUD_IND_TEX_PATH.."Roll_Cue.dds", GreenColor)
HUD_HEADING_TAPE     = MakeMaterial(HUD_IND_TEX_PATH.."Heading_tape.dds", GreenColor)
HUD_HEADING_BOX   = MakeMaterial(HUD_IND_TEX_PATH.."Heading_Box.dds", GreenColor)
HUD_E_BRACKET		= MakeMaterial(HUD_IND_TEX_PATH.."e.dds", GreenColor)
HUD_GUN_PIPER		= MakeMaterial(HUD_IND_TEX_PATH.."gun_piper.dds", GreenColor)
HUD_Green           = MakeMaterial({  0, 255,   0, 255})

default_hud_x = 2000
default_hud_y = 2000

function hud_vert_gen(width, height)
    return {{(0 - width) / 2 / default_hud_x , (0 + height) / 2 / default_hud_y},
    {(0 + width) / 2 / default_hud_x , (0 + height) / 2 / default_hud_y},
    {(0 + width) / 2 / default_hud_x , (0 - height) / 2 / default_hud_y},
    {(0 - width) / 2 / default_hud_x , (0 - height) / 2 / default_hud_y},}
end

function hud_duo_vert_gen(width, total_height, not_include_height)
    return {
        {(0 - width) / 2 / default_hud_x , (0 + total_height) / 2 / default_hud_y},
        {(0 + width) / 2 / default_hud_x , (0 + total_height) / 2 / default_hud_y},
        {(0 + width) / 2 / default_hud_x , (0 + not_include_height) / 2 / default_hud_y},
        {(0 - width) / 2 / default_hud_x , (0 + not_include_height) / 2 / default_hud_y},
        {(0 + width) / 2 / default_hud_x , (0 - not_include_height) / 2 / default_hud_y},
        {(0 - width) / 2 / default_hud_x , (0 - not_include_height) / 2 / default_hud_y},
        {(0 + width) / 2 / default_hud_x , (0 - total_height) / 2 / default_hud_y},
        {(0 - width) / 2 / default_hud_x , (0 - total_height) / 2 / default_hud_y},
    }
end

function tex_coord_gen(x_dis,y_dis,width,height,size_X,size_Y)
    return {{x_dis / size_X , y_dis / size_Y},
			{(x_dis + width) / size_X , y_dis / size_Y},
			{(x_dis + width) / size_X , (y_dis + height) / size_Y},
			{x_dis / size_X , (y_dis + height) / size_Y},}
end

function mirror_tex_coord_gen(x_dis,y_dis,width,height,size_X,size_Y)
    return {{(x_dis + width) / size_X , y_dis / size_Y},
			{x_dis / size_X , y_dis / size_Y},
			{x_dis / size_X , (y_dis + height) / size_Y},
			{(x_dis + width) / size_X , (y_dis + height) / size_Y},}
end

function calculateCircle(object, radius, init_x, init_y, point_num)
	local verts = {}
    multiplier = math.rad(360.0/point_num)
    verts[1] = {init_x / default_hud_x, init_y / default_hud_y}
	for i = 2, point_num do
	  verts[i] = {(init_x + radius * math.cos(i * multiplier)) / default_hud_x, (init_y + radius * math.sin(i * multiplier)) / default_hud_y}
    end
    local indices = {}
	for i = 0, point_num - 3 do
	  indices[i * 3 + 1] = 0
	  indices[i * 3 + 2] = i + 1
	  indices[i * 3 + 3] = i + 2
    end
    indices[(point_num - 2) * 3 + 1] = 0
    indices[(point_num - 2) * 3 + 2] = 1
    indices[(point_num - 2) * 3 + 3] = point_num - 1
	object.vertices = verts
	object.indices  = indices
end
