dofile(LockOn_Options.common_script_path.."elements_defs.lua")
SetScale(FOV)

RWR_DEFAULT_LEVEL = 2
RWR_DEFAULT_NOCLIP_LEVEL  = RWR_DEFAULT_LEVEL - 1
RWR_SCALE = 1

function AddElement(object)
    object.use_mipfilter    = true
	object.additive_alpha   = true
	object.h_clip_relation  = h_clip_relations.COMPARE
	object.level			= RWR_DEFAULT_LEVEL
    Add(object)
end




----Colors--------------------------------
	BG_BLACK_COLOR		= {30, 30, 30, 255}
	TEXT_GREEN_COLOR 	= {0, 255, 20, 255}
	TEXT_BLACK_COLOR 	= BG_BLACK_COLOR--{2, 2, 2, 255}
------------------------------------------


MATERIAL_BLACK   	= MakeMaterial(nil,{25,25,25,255})
RWR_BG_BLACK		= MakeMaterial(nil,BG_BLACK_COLOR)           --{20,20,20,255})			
RWR_SOLID_BLACK   	= MakeMaterial(nil,{0,0,0,255,255})

MFCD_GREEN			= MakeMaterial(nil,{0, 255, 5, 255})         -- Circle in the middle of rwr.
MFCD_GREEN_SOFT		= MakeMaterial(nil,{0, 255, 5, 255})         -- second circle of rwr
MFCD_BLUE			= MakeMaterial(nil,{0, 255, 20, 255})        -- These are the outward Circles.
MFCD_ORANGE			= MakeMaterial(nil,{255, 255, 0})            -- RWR Contacts color curently set to yellow.
RWR_CIRCLE			= MakeMaterial(nil,{0, 56, 218, 255}) -- F-22 Color


-------FONTS------------------------------------------------------------------------------

HUD_FONT 	    = MakeFont({used_DXUnicodeFontData = "font_arial_17"},TEXT_GREEN_COLOR)		    --5 "font_arial_17"  is good 
HUD_FONT_INV    = MakeFont({used_DXUnicodeFontData = "font_arial_17"},TEXT_BLACK_COLOR)
HUD_FONT_ORANGE = MakeFont({used_DXUnicodeFontData = "font_arial_17"},{255, 165, 0, 255})		--5 "font_arial_17"  is good 

FONT_SCALE = 1 

local font_size 					= 0.015					    * FONT_SCALE --08
local default_char_height  			= font_size or 0.004		* FONT_SCALE
local default_char_width   			= 0.3 * default_char_height	* FONT_SCALE
local default_char_vert_spaceing 	= -0.001							--must be adjustet manualy to scale (scale 0.8   	-0.001

txt_box_stringdefs 	= 	{default_char_height		, default_char_width		,0, default_char_vert_spaceing} 
txt_head_stringdefs = 	{default_char_height * 1.3 	, default_char_width * 1.3	,0, -0.0025} 

txt_wpt_stringdefs 	= 	{default_char_height * 1.2 	, default_char_width * 1.2	,0, default_char_vert_spaceing} 

txt_stringdefs 	= 	{default_char_height * 1		, default_char_width * 1		,0, default_char_vert_spaceing} 
txt_s_stringdefs= 	{default_char_height * 1 * 0.5	, default_char_width * 1 * 0.5	,0, default_char_vert_spaceing} 
txt_m_stringdefs= 	{default_char_height * 1 * 0.75	, default_char_width * 1 * 0.75	,0, default_char_vert_spaceing} 
txt_1_stringdefs= 	{default_char_height * 1		, default_char_width * 1 ,-0.00051, default_char_vert_spaceing}
-----------------------------------------------------------------------------------------
