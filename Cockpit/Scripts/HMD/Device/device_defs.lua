dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."materials.lua")

HMD_IND_TEX_PATH                = LockOn_Options.script_path.."../Textures/HMD/"

SetScale(FOV)

DEGREE_TO_MRAD = 17.4532925199433
DEGREE_TO_RAD = 0.0174532925199433
RAD_TO_DEGREE = 57.29577951308233
MRAD_TO_DEGREE = 0.05729577951308233

HMD_ASPECT_HEIGHT =  GetAspect()

HMD_DEFAULT_LEVEL = 10
HMD_DEFAULT_NOCLIP_LEVEL = HMD_DEFAULT_LEVEL - 1

local BlackColor  			= {0, 0, 0, 255}--RGBA
local WhiteColor 			= {255, 255, 255, 255}--RGBA
local MainColor 			= {255, 255, 255, 255}--RGBA
local GreenColor 		    = {  8, 252,   15, 255}
local YellowColor 			= {255, 255, 0, 255}--RGBA
local OrangeColor           = {255, 180, 0, 255}--RGBA
local RedColor 				= {255, 0, 0, 255}--RGBA
local TealColor 			= {0, 255, 255, 255}--RGBA
local HMDScreen             = {255,255,255,200}
local HMD_ladder_color      = {210,150,230,255}

HMD_CROSS           = MakeMaterial(HMD_IND_TEX_PATH.."cross.dds", GreenColor)
HMD_HEADING_TAPE    = MakeMaterial(HMD_IND_TEX_PATH.."Heading_tape.dds", GreenColor)
HMD_HEADING_BOX  	= MakeMaterial(HMD_IND_TEX_PATH.."Heading_Box.dds", GreenColor)


default_HMD_x = 6000
default_HMD_y = 6000

function AddElement(object)
	object.h_clip_relation  = h_clip_relations.COMPARE	
	object.level  		 	= HUD_DEFAULT_LEVEL 
	object.collimated 		= true
    Add(object)
end

function HMD_vert_gen(width, height)
    return {{(0 - width) / 2 / default_HMD_x , (0 + height) / 2 / default_HMD_y},
    {(0 + width) / 2 / default_HMD_x , (0 + height) / 2 / default_HMD_y},
    {(0 + width) / 2 / default_HMD_x , (0 - height) / 2 / default_HMD_y},
    {(0 - width) / 2 / default_HMD_x , (0 - height) / 2 / default_HMD_y},}
end

function HMD_duo_vert_gen(width, total_height, not_include_height)
    return {
        {(0 - width) / 2 / default_HMD_x , (0 + total_height) / 2 / default_HMD_y},
        {(0 + width) / 2 / default_HMD_x , (0 + total_height) / 2 / default_HMD_y},
        {(0 + width) / 2 / default_HMD_x , (0 + not_include_height) / 2 / default_HMD_y},
        {(0 - width) / 2 / default_HMD_x , (0 + not_include_height) / 2 / default_HMD_y},
        {(0 + width) / 2 / default_HMD_x , (0 - not_include_height) / 2 / default_HMD_y},
        {(0 - width) / 2 / default_HMD_x , (0 - not_include_height) / 2 / default_HMD_y},
        {(0 + width) / 2 / default_HMD_x , (0 - total_height) / 2 / default_HMD_y},
        {(0 - width) / 2 / default_HMD_x , (0 - total_height) / 2 / default_HMD_y},
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

function calculateCircle(object, rHMDus, init_x, init_y, point_num)
	local verts = {}
    multiplier = math.rad(360.0/point_num)
    verts[1] = {init_x / default_HMD_x, init_y / default_HMD_y}
	for i = 2, point_num do
	  verts[i] = {(init_x + rHMDus * math.cos(i * multiplier)) / default_HMD_x, (init_y + rHMDus * math.sin(i * multiplier)) / default_HMD_y}
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

function Add_Object_Text_(object, objectname, objectparent, objectmaterial, objectalignment, format_value, stringdefs_value, initpixelposx, initpixelposy, objectelementparams, objectcontrollers)
	local object           = CreateElement "ceStringPoly"
	object.name            = objectname
	object.material        = objectmaterial
	object.element_params = objectelementparams
	object.controllers = objectcontrollers
	object.init_pos = {initpixelposx+stringdefs_value[3], initpixelposy+stringdefs_value[4]}
	object.alignment		= objectalignment
	if format_value ~= nil then
		if type(format_value) == "table" then
			object.formats = format_value
		else
			object.value = format_value
		end
	end
	object.stringdefs		= stringdefs_value--VerticalSize, HorizontalSize, HorizontalSpacing, VerticalSpacing
    object.use_mipfilter    = true
	object.additive_alpha   = true
	object.collimated		= false
	object.h_clip_relation  = h_clip_relations.COMPARE
	object.level			= DISPLAY_DEFAULT_LEVEL
	object.parent_element = objectparent
    Add(object)
end


function add_text(text, posx, posy, pparent, font_mat, stringdefs, valign)

	local rec_parent       		= CreateElement "ceSimple"
	rec_parent.name				= create_guid_string()
	rec_parent.init_pos       	= {posx, posy}
	if pparent ~= nil then
		rec_parent.parent_element	= pparent.name
	end
	AddElement(rec_parent)
	-------------------
	if valign == nil then
		valign = "CenterCenter"
	end
	vfont_mat = fonts["F22_HUD"]
	if font_mat ~= nil then
		vfont_mat = fonts[font_mat]
	end
	if stringdefs == nil then
		stringdefs = HUD_strdefs_text
	end		
	-------------------
	if text ~= nil then
		local parent          = CreateElement "ceStringPoly"
		parent.name           = create_guid_string()
		parent.material       = vfont_mat
		parent.init_pos       = {0, 0}
		parent.stringdefs     = stringdefs
		parent.alignment	  = valign
		parent.value  	      = text
		parent.parent_element = rec_parent.name
		AddElement(parent)
	end
	-------------------
	return rec_parent
end

function add_text_param(posx, posy, element_parm, tformat, pparent, stringdefs, font_mat, talignment)
	if tformat == nil then
		tformat = "%.0f"
	end
	if talignment == nil then
		talignment = "CenterCenter"
	end
	vfont_mat = fonts["F22_HUD"]
	if font_mat ~= nil then
		vfont_mat = fonts[font_mat]
	end	
	if stringdefs == nil then
		stringdefs = HUD_strdefs_text
	end	
	
	local parent          = CreateElement "ceStringPoly"
	parent.name           = create_guid_string()
	parent.material       = vfont_mat
	parent.init_pos       = {posx, posy}
	parent.stringdefs     = stringdefs
	parent.alignment	  = talignment
	if pparent ~= nil then
		parent.parent_element = pparent.name
	end
	parent.formats           = {tformat} 
	parent.element_params    = {element_parm,"%s"}
	parent.controllers       = {{"text_using_parameter",0},}
	AddElement(parent)
	-------------------
	return parent
end
