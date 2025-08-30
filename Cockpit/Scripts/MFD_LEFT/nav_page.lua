dofile(LockOn_Options.script_path.."MFD_LEFT/definitions.lua")
dofile(LockOn_Options.script_path.."fonts.lua")
dofile(LockOn_Options.script_path.."materials.lua")
SetScale(FOV)

local function vertices(object, height, half_or_double)
    local width = height
    
    if half_or_double == true then --
        width = 0.025
    end

    if half_or_double == false then
        width = height * 2
    end

    local half_width = width / 2
    local half_height = height / 2
    local x_positive = half_width
    local x_negative = half_width * -1.0
    local y_positive = half_height
    local y_negative = half_height * -1.0

    object.vertices =
    {
        {x_negative, y_positive},
        {x_positive, y_positive},
        {x_positive, y_negative},
        {x_negative, y_negative}
    }

    object.indices = {0, 1, 2, 2, 3, 0}

    object.tex_coords =
    {
        {0, 0},
        {1, 0},
        {1, 1},
        {0, 1}
    }
end

default_x = 2000
default_y = 2000

function w_h_verticies(width, height)
    return {{(0 - width) / 2 / default_x , (0 + height) / 2 / default_y},
    {(0 + width) / 2 / default_x , (0 + height) / 2 / default_y},
    {(0 + width) / 2 / default_x , (0 - height) / 2 / default_y},
    {(0 - width) / 2 / default_x , (0 - height) / 2 / default_y},}
end

function tex_coord_gen(x_dis,y_dis,width,height,size_X,size_Y)
    return {{x_dis / size_X , y_dis / size_Y},
			{(x_dis + width) / size_X , y_dis / size_Y},
			{(x_dis + width) / size_X , (y_dis + height) / size_Y},
			{x_dis / size_X , (y_dis + height) / size_Y},}
end


local IndicationTexturesPath = LockOn_Options.script_path.."../IndicationTextures/"--I dont think this is correct might have to add scripts.
local BlackColor  			= {0, 0, 0, 255}--RGBA
local WhiteColor 			= {255, 255, 255, 255}--RGBA
local MainColor 			= {255, 255, 255, 255}--RGBA
local GreenColor 		    = {0, 255, 0, 255}--RGBA
local YellowColor 			= {255, 255, 0, 255}--RGBA
local OrangeColor           = {255, 102, 0, 255}--RGBA
local RedColor 				= {255, 0, 0, 255}--RGBA
local ScreenColor			= {3, 3, 3, 255}--RGBA DO NOT TOUCH 3-3-12-255 is good for on screen
local ADIbottom				= {8, 8, 8, 255}--RGBA
local TealColor				= {0, 255, 255, 255}--RGBA
local TrimColor				= {255, 255, 255, 255}--RGBA
local BOXColor				= {10, 10, 10, 255}--RGBA
local BlueColor				= {0, 0, 150, 255}--RGBA
local CircleColor			= {0, 56, 218, 255}
--------------------------------------------------------------------------------------------------------------------------------------------
local ADI_PAGE       = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mfd_adi.dds", ScreenColor)--SYSTEM TEST
local ADI_PAGE_DRK   = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mfd_adi.dds", ADIbottom)--SYSTEM TEST
local ADI_LAD_TOP    = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mfd_lad_top.dds", WhiteColor)--SYSTEM TEST
local ADI_LAD_BOT    = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mfd_lad_bot.dds", WhiteColor)--SYSTEM TEST
local MFD_LINE       = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mfd_line.dds", WhiteColor)--SYSTEM TEST
local MFD_LINE_M     = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mfd_line.dds", BlackColor)--SYSTEM TEST

local MFD_RING       = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mfd_ring.dds", WhiteColor)--SYSTEM TEST
local MFD_BOXES       = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mfd_boxes.dds", WhiteColor)--SYSTEM TEST

local MFD_VV        = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mfd_vv.dds", WhiteColor)--SYSTEM TEST
local MFD_VV_M       = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mfd_vv.dds", BlackColor)--SYSTEM TEST

local ADI_SLIP_MASK      = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mfd_trim_mask.dds", BlackColor)--SYSTEM TEST
local ADI_SLIP_MASK_GLOW      = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mfd_trim_mask.dds", ScreenColor)--SYSTEM TEST
local SLIP_BALL	    = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mask_box.dds", WhiteColor)--SYSTEM TEST
local ADI_MASK      = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mfd_adi.dds", BlackColor)--SYSTEM TEST
local MASK_BOX	    = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mask_box.dds", ScreenColor)--SYSTEM TEST
local MASK_BOX1	    = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mask_box.dds", ADIbottom)--SYSTEM TEST
local ADI_TOP	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/adi_half.dds", 	BlueColor)
local ADI_BOT	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/adi_half.dds", 	ADIbottom)
local ADI_LINE	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/adi_line.dds", 	WhiteColor)
local TEST		 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/test.dds", WhiteColor)

local ILS_H	    = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mask_box.dds", YellowColor)--SYSTEM TEST
local ILS_V	    = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mask_box.dds", YellowColor)--SYSTEM TEST

local CENTER_ICON			= MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/map_center.dds", WhiteColor)
local CIRCLE				= MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/circle.dds", CircleColor)
local COMP_ROSE_NUM		= MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/compass_rose_num.dds", CircleColor)
local HEADING_BOX		= MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/Heading_Box.dds", CircleColor)
local HEAD_BOX_VERT_LINE = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/vert_line.dds", CircleColor)

--------------------------------------------------------------------------------------------------------------------------------------------
local ClippingPlaneSize = 1.1 --Clipping Masks
local ClippingWidth 	= 1.1 --Clipping Masks
local PFD_MASK_BASE1 	= MakeMaterial(nil,{255,0,0,255})--Clipping Masks
local PFD_MASK_BASE2 	= MakeMaterial(nil,{0,255,0,255})--Clipping Masks
--Clipping Masks
local total_field_of_view           = CreateElement "ceMeshPoly"
total_field_of_view.name            = "total_field_of_view"
total_field_of_view.primitivetype   = "triangles"
total_field_of_view.vertices        = {
										{-1 * ClippingWidth,-1 * ClippingPlaneSize},
										{1 * ClippingWidth,-1 * ClippingPlaneSize},
										{1 * ClippingWidth,1 * ClippingPlaneSize},
										{-1 * ClippingWidth,1 * ClippingPlaneSize},										
									}
total_field_of_view.material        = PFD_MASK_BASE1
total_field_of_view.indices         = {0,1,2,2,3,0}
total_field_of_view.init_pos        = {0, 0, 0}
total_field_of_view.init_rot        = { 0, 0, 0} -- degree NOT rad
total_field_of_view.h_clip_relation = h_clip_relations.REWRITE_LEVEL
total_field_of_view.level           = 10
total_field_of_view.collimated      = false
total_field_of_view.isvisible       = false
Add(total_field_of_view)
--Clipping Masks
local clipPoly               = CreateElement "ceMeshPoly"
clipPoly.name                = "clipPoly-1"
clipPoly.primitivetype       = "triangles"
clipPoly.init_pos            = {0, 0, 0}
clipPoly.init_rot            = { 0, 0 , 0} -- degree NOT rad
clipPoly.vertices            = {
								{-1 * ClippingWidth,-1 * ClippingPlaneSize},
								{1 * ClippingWidth,-1 * ClippingPlaneSize},
								{1 * ClippingWidth,1 * ClippingPlaneSize},
								{-1 * ClippingWidth,1 * ClippingPlaneSize},										
									}
clipPoly.indices             = {0,1,2,2,3,0}
clipPoly.material            = PFD_MASK_BASE2
clipPoly.h_clip_relation     = h_clip_relations.INCREASE_IF_LEVEL
clipPoly.level               = 10
clipPoly.collimated          = false
clipPoly.isvisible           = false
Add(clipPoly)
------------------------------------------------------------------------------------------------CLIPPING-END----------------------------------------------------------------------------------------------
BGROUND                    = CreateElement "ceTexPoly"
BGROUND.name    			= "BG"
BGROUND.material			= MASK_BOX
BGROUND.change_opacity 		= false
BGROUND.collimated 			= false
BGROUND.isvisible 			= true
BGROUND.init_pos 			= {0, 0, 0} --L-R,U-D,F-B
BGROUND.init_rot 			= {0, 0, 0}
BGROUND.element_params 		= {"MFD_OPACITY","LMFD_NAV_PAGE"}--this may not be bneeded check when more pages done for backlight on page 7 SMS fc3 bs
BGROUND.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}--MENU PAGE = 1
BGROUND.level 				= 11
BGROUND.h_clip_relation     = h_clip_relations.COMPARE
vertices(BGROUND,3)
Add(BGROUND)
------------------------------------------------------------
ICON                      = CreateElement "ceTexPoly"
ICON.name    			  = "Jet Icon"
ICON.material			  = CENTER_ICON
ICON.change_opacity 	= false
ICON.collimated 			= false
ICON.isvisible 			= true
ICON.init_pos 			= {0, 0, 0} --L-R,U-D,F-B
ICON.init_rot 			= {0, 0, 0}
ICON.element_params 		= {"MFD_OPACITY","LMFD_NAV_PAGE"}--this may not be bneeded check when more pages done for backlight on page 7 SMS fc3 bs
ICON.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}--MENU PAGE = 1
ICON.level 				= 11
ICON.h_clip_relation     = h_clip_relations.COMPARE
vertices(ICON, 0.16)
Add(ICON)

CIRCLE1                     = CreateElement "ceTexPoly"
CIRCLE1.name    			= "CIRCLE1"
CIRCLE1.material			= CIRCLE
CIRCLE1.change_opacity 		= false
CIRCLE1.collimated 			= false
CIRCLE1.isvisible 			= true
CIRCLE1.init_pos 			= {0, 0, 0} --L-R,U-D,F-B
CIRCLE1.init_rot 			= {0, 0, 0}
CIRCLE1.element_params 		= {"MFD_OPACITY","LMFD_NAV_PAGE"}--this may not be bneeded check when more pages done for backlight on page 7 SMS fc3 bs
CIRCLE1.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}--MENU PAGE = 1
CIRCLE1.level 				= 11
CIRCLE1.h_clip_relation     = h_clip_relations.COMPARE
vertices(CIRCLE1, 1.5)
Add(CIRCLE1)

COMPASS_ROSE_NUM                     = CreateElement "ceTexPoly"
COMPASS_ROSE_NUM.name    			= "COMPASS_ROSE_NUM"
COMPASS_ROSE_NUM.material			= COMP_ROSE_NUM
COMPASS_ROSE_NUM.change_opacity 		= false
COMPASS_ROSE_NUM.collimated 			= false
COMPASS_ROSE_NUM.isvisible 			= true
COMPASS_ROSE_NUM.init_pos 			= {0, 0, 0} --L-R,U-D,F-B
COMPASS_ROSE_NUM.init_rot 			= {0, 0, 0}
COMPASS_ROSE_NUM.element_params 		= {"MFD_OPACITY","LMFD_NAV_PAGE","TRUE_HEADING"}--this may not be bneeded check when more pages done for backlight on page 7 SMS fc3 bs
COMPASS_ROSE_NUM.controllers			= {
	{"opacity_using_parameter",0},
	{"parameter_in_range",1,0.9,1.1},
	{"rotate_using_parameter", 2, 0.01745}
}
COMPASS_ROSE_NUM.level 				= 11
COMPASS_ROSE_NUM.h_clip_relation     = h_clip_relations.COMPARE
vertices(COMPASS_ROSE_NUM, 2.35)
Add(COMPASS_ROSE_NUM)

HEAD_BOX                     = CreateElement "ceTexPoly"
HEAD_BOX.name    			= "HEADING_BOX"
HEAD_BOX.material			= HEADING_BOX
HEAD_BOX.change_opacity 		= false
HEAD_BOX.collimated 			= false
HEAD_BOX.isvisible 			= true
HEAD_BOX.init_pos 			= {0, 0.86, 0} --L-R,U-D,F-B
HEAD_BOX.init_rot 			= {0, 0, 0}
HEAD_BOX.element_params 		= {"MFD_OPACITY","LMFD_NAV_PAGE"}--this may not be bneeded check when more pages done for backlight on page 7 SMS fc3 bs
HEAD_BOX.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}--MENU PAGE = 1
HEAD_BOX.level 				= 11
HEAD_BOX.h_clip_relation     = h_clip_relations.COMPARE
vertices(HEAD_BOX, 1.3)
HEAD_BOX.indices = {0, 1, 2, 2, 3, 0}
Add(HEAD_BOX)


HEAD_BOX_LINE                     = CreateElement "ceTexPoly"
HEAD_BOX_LINE.name    			= "HEAD_BOX_LINE"
HEAD_BOX_LINE.material			= HEAD_BOX_VERT_LINE
HEAD_BOX_LINE.change_opacity 		= false
HEAD_BOX_LINE.collimated 			= false
HEAD_BOX_LINE.isvisible 			= true
HEAD_BOX_LINE.init_pos 			= {0, 0.837, 0} --L-R,U-D,F-B
HEAD_BOX_LINE.init_rot 			= {0, 0, 0}
HEAD_BOX_LINE.element_params 		= {"MFD_OPACITY","LMFD_NAV_PAGE"}--this may not be bneeded check when more pages done for backlight on page 7 SMS fc3 bs
HEAD_BOX_LINE.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}--MENU PAGE = 1
HEAD_BOX_LINE.level 				= 11
HEAD_BOX_LINE.h_clip_relation     = h_clip_relations.COMPARE
HEAD_BOX_LINE.additive_alpha = false
HEAD_BOX_LINE.blend_mode = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
HEAD_BOX_LINE.vertices = w_h_verticies(3000, 1700)
HEAD_BOX_LINE.tex_coords = tex_coord_gen(0, 0, 2048, 2048, 2048, 2048)
HEAD_BOX_LINE.indices = {0, 1, 2, 2, 3, 0}
--Add(HEAD_BOX_LINE)

HEAD_VAL				    = CreateElement "ceStringPoly"
HEAD_VAL.name				= "HEAD_VAL"
HEAD_VAL.material			= UFD_FONT
HEAD_VAL.init_pos			= {0.055, 0.92, 0} --L-R,U-D,F-B
HEAD_VAL.alignment			= "RightCenter"
HEAD_VAL.stringdefs		= {0.0055, 0.0055, 0, 0.0} --either 004 or 005
HEAD_VAL.additive_alpha	= true
HEAD_VAL.collimated		= false
HEAD_VAL.isdraw			= true	
HEAD_VAL.use_mipfilter		= true
HEAD_VAL.h_clip_relation	= h_clip_relations.COMPARE
HEAD_VAL.level				= 11
HEAD_VAL.element_params	= {"MFD_OPACITY","TRUE_HEADING","LMFD_NAV_PAGE"}
HEAD_VAL.formats			= {"%03.0f"}
HEAD_VAL.controllers		=   {
                                        {"opacity_using_parameter",0},
                                        {"text_using_parameter",1,0},
                                        {"parameter_in_range",2,0.9,1.1}
                                    }                            
Add(HEAD_VAL)

CLOCK				    = CreateElement "ceStringPoly"
CLOCK.name				= "CLOCK"
CLOCK.material			= UFD_GRN
CLOCK.init_pos			= {-0.7, 0.77, 0} --L-R,U-D,F-B
CLOCK.alignment			= "RightCenter"
CLOCK.stringdefs		= {0.0040, 0.0040, 0, 0.0} --either 004 or 005
CLOCK.additive_alpha	= true
CLOCK.collimated		= false
CLOCK.isdraw			= true	
CLOCK.use_mipfilter		= true
CLOCK.h_clip_relation	= h_clip_relations.COMPARE
CLOCK.level				= 11
CLOCK.element_params	= {"MFD_OPACITY","CLOCK","LMFD_NAV_PAGE"}
CLOCK.formats			= {"%s"}--= {"%02.0f"}
CLOCK.controllers		=   {
                                        {"opacity_using_parameter",0},
                                        {"text_using_parameter",1,0},
                                        {"parameter_in_range",2,0.9,1.1}
                                    }                            
Add(CLOCK)

DATE				    = CreateElement "ceStringPoly"
DATE.name				= "DATE"
DATE.material			= UFD_GRN
DATE.init_pos			= {-0.7, 0.83, 0} --L-R,U-D,F-B
DATE.alignment			= "RightCenter"
DATE.stringdefs		= {0.0040, 0.004, 0, 0.0} --either 004 or 005
DATE.additive_alpha	= true
DATE.collimated		= false
DATE.isdraw			= true	
DATE.use_mipfilter		= true
DATE.h_clip_relation	= h_clip_relations.COMPARE
DATE.level				= 11
DATE.element_params	= {"MFD_OPACITY","DATE","LMFD_NAV_PAGE"}
DATE.formats			= {"%s"}--= {"%02.0f"}
DATE.controllers		=   {
                                        {"opacity_using_parameter",0},
                                        {"text_using_parameter",1,0},
                                        {"parameter_in_range",2,0.9,1.1}
                                    }                            
Add(DATE)

LATITUDE				    = CreateElement "ceStringPoly"
LATITUDE.name				= "LATITUDE"
LATITUDE.material			= UFD_FONT
LATITUDE.init_pos			= {0.98, 0.83, 0} --L-R,U-D,F-B
LATITUDE.alignment			= "RightCenter"
LATITUDE.stringdefs		= {0.0040, 0.0040, 0, 0.0} --either 004 or 005
LATITUDE.additive_alpha	= true
LATITUDE.collimated		= false
LATITUDE.isdraw			= true	
LATITUDE.use_mipfilter		= true
LATITUDE.h_clip_relation	= h_clip_relations.COMPARE
LATITUDE.level				= 11
LATITUDE.element_params	= {"MFD_OPACITY","LATITUDE","LMFD_NAV_PAGE"}
LATITUDE.formats			= {"%s"}--= {"%02.0f"}
LATITUDE.controllers		=   {
                                        {"opacity_using_parameter",0},
                                        {"text_using_parameter",1,0},
                                        {"parameter_in_range",2,0.9,1.1}
                                    }                            
Add(LATITUDE)

LONGITUDE				    = CreateElement "ceStringPoly"
LONGITUDE.name				= "LONGITUDE"
LONGITUDE.material			= UFD_FONT
LONGITUDE.init_pos			= {0.98, 0.77, 0} --L-R,U-D,F-B
LONGITUDE.alignment			= "RightCenter"
LONGITUDE.stringdefs		= {0.0040, 0.0040, 0, 0.0} --either 004 or 005
LONGITUDE.additive_alpha	= true
LONGITUDE.collimated		= false
LONGITUDE.isdraw			= true	
LONGITUDE.use_mipfilter		= true
LONGITUDE.h_clip_relation	= h_clip_relations.COMPARE
LONGITUDE.level				= 11
LONGITUDE.element_params	= {"MFD_OPACITY","LONGITUDE","LMFD_NAV_PAGE"}
LONGITUDE.formats			= {"%s"}--= {"%02.0f"}
LONGITUDE.controllers		=   {
                                        {"opacity_using_parameter",0},
                                        {"text_using_parameter",1,0},
                                        {"parameter_in_range",2,0.9,1.1}
                                    }                            
Add(LONGITUDE)

--MENU TEXT - button 13
MENUTEXT 					    = CreateElement "ceStringPoly"
MENUTEXT.name 				    = "MENUTEXT"
MENUTEXT.material 			    = UFD_FONT --UFD_YEL
MENUTEXT.value 				    = "MENU"
MENUTEXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
MENUTEXT.alignment 			    = "CenterCenter"
MENUTEXT.formats 			    = {"%s"}
MENUTEXT.h_clip_relation         = h_clip_relations.COMPARE
MENUTEXT.level 				    = 11
MENUTEXT.init_pos 			    = {-0.565, 0.92, 0}
MENUTEXT.init_rot 			    = {0, 0, 0}
MENUTEXT.element_params 	        = {"MFD_OPACITY","LMFD_NAV_PAGE"}
MENUTEXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(MENUTEXT)