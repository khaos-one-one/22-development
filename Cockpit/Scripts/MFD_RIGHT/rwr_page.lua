dofile(LockOn_Options.script_path.."MFD_RIGHT/definitions.lua")
dofile(LockOn_Options.script_path.."fonts.lua")
dofile(LockOn_Options.script_path.."materials.lua")
dofile(LockOn_Options.script_path.."RWR/Indicator/definitions.lua")
SetScale(FOV)

local function vertices(object, height, half_or_double)
    local width = height
    
    if half_or_double == true then --
        width = height / 2
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
local IndicationTexturesPath = LockOn_Options.script_path.."../IndicationTextures/"--I dont think this is correct might have to add scripts.
local BlackColor  			= {0, 0, 0, 255}--RGBA
local WhiteColor 			= {255, 255, 255, 255}--RGBA
local MainColor 			= {255, 255, 255, 255}--RGBA
local GreenColor 		    = {0, 255, 0, 255}--RGBA
local YellowColor 			= {255, 255, 0, 255}--RGBA
local OrangeColor           = {255, 102, 0, 255}--RGBA
local RedColor 				= {255, 0, 0, 255}--RGBA
local ScreenColor			= {3, 3, 3, 255}--RGBA DO NOT TOUCH 3-3-12-255 is good for on screen
local CircleColor			= {0, 56, 218, 255}
local RWRColor				= {255, 165, 0, 255}
--------------------------------------------------------------------------------------------------------------------------------------------
local CENTER_ICON			= MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/map_center.dds", WhiteColor)
local CIRCLE				= MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/circle.dds", CircleColor)
local COMP_ROSE		= MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/compass_rose.dds", CircleColor)
local HEADING_BOX		= MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/Heading_Box.dds", CircleColor)
local RWR_DIAMOND		= MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/diamond.dds", RWRColor)
local MASK_BOX	    = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mask_box.dds", ScreenColor)--SYSTEM TEST
local IND_BOX	    = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/ind_box.dds", WhiteColor)
--------------------------------------------------------------------------------------------------------------------------------------------
local ClippingPlaneSize = 1.1 --Clipping Masks
local ClippingWidth 	= 1.1--Clipping Masks
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
total_field_of_view.level           = 1
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
clipPoly.level               = 1
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
BGROUND.element_params 		= {"MFD_OPACITY","RMFD_RWR_PAGE"}--this may not be bneeded check when more pages done for backlight on page 7 SMS fc3 bs
BGROUND.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}--MENU PAGE = 1
BGROUND.level 				= 2
BGROUND.h_clip_relation     = h_clip_relations.COMPARE
vertices(BGROUND,3)
Add(BGROUND)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

MENUTEXT 					    = CreateElement "ceStringPoly"
MENUTEXT.name 				    = "MENUTEXT"
MENUTEXT.material 			    = UFD_FONT 
MENUTEXT.value 				    = "MENU"
MENUTEXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
MENUTEXT.alignment 			    = "CenterCenter"
MENUTEXT.formats 			    = {"%s"}
MENUTEXT.h_clip_relation         = h_clip_relations.COMPARE
MENUTEXT.level 				    = 2
MENUTEXT.init_pos 			    = {-0.565, 0.92, 0}
MENUTEXT.init_rot 			    = {0, 0, 0}
MENUTEXT.element_params 	        = {"MFD_OPACITY","RMFD_RWR_PAGE"}
MENUTEXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(MENUTEXT)

ECMSTEXT 					    = CreateElement "ceStringPoly"
ECMSTEXT.name 				    = "ECMSTEXT"
ECMSTEXT.material 			    = UFD_FONT 
ECMSTEXT.value 				    = "ECMS"
ECMSTEXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
ECMSTEXT.alignment 			    = "CenterCenter"
ECMSTEXT.formats 			    = {"%s"}
ECMSTEXT.h_clip_relation         = h_clip_relations.COMPARE
ECMSTEXT.level 				    = 2
ECMSTEXT.init_pos 			    = {0.565, 0.92, 0}
ECMSTEXT.init_rot 			    = {0, 0, 0}
ECMSTEXT.element_params 	        = {"MFD_OPACITY","RMFD_RWR_PAGE"}
ECMSTEXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(ECMSTEXT)

CHAFFTXT 					    = CreateElement "ceStringPoly"
CHAFFTXT.name 				    = "CHAFFTXT"
CHAFFTXT.material 			    = UFD_YEL 
CHAFFTXT.value 				    = "CHAFF:"
CHAFFTXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
CHAFFTXT.alignment 			    = "CenterCenter"
CHAFFTXT.formats 			    = {"%s"}
CHAFFTXT.h_clip_relation         = h_clip_relations.COMPARE
CHAFFTXT.level 				    = 2
CHAFFTXT.init_pos 			    = {0.65,-0.72, 0}
CHAFFTXT.init_rot 			    = {0, 0, 0}
CHAFFTXT.element_params 	        = {"MFD_OPACITY","RMFD_RWR_PAGE"}
CHAFFTXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(CHAFFTXT)

FLARETEXT 					    = CreateElement "ceStringPoly"
FLARETEXT.name 				    = "FLARETEXT"
FLARETEXT.material 			    = UFD_YEL 
FLARETEXT.value 				    = "FLARE:"
FLARETEXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
FLARETEXT.alignment 			    = "CenterCenter"
FLARETEXT.formats 			    = {"%s"}
FLARETEXT.h_clip_relation         = h_clip_relations.COMPARE
FLARETEXT.level 				    = 2
FLARETEXT.init_pos 			    = {0.65,-0.8, 0}
FLARETEXT.init_rot 			    = {0, 0, 0}
FLARETEXT.element_params 	        = {"MFD_OPACITY","RMFD_RWR_PAGE"}
FLARETEXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(FLARETEXT)

PROGRAMTEXT 					    = CreateElement "ceStringPoly"
PROGRAMTEXT.name 				    = "PROGRAMTEXT"
PROGRAMTEXT.material 			    = UFD_YEL 
PROGRAMTEXT.value 				    = "PROGRAM:"
PROGRAMTEXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
PROGRAMTEXT.alignment 			    = "CenterCenter"
PROGRAMTEXT.formats 			    = {"%s"}
PROGRAMTEXT.h_clip_relation         = h_clip_relations.COMPARE
PROGRAMTEXT.level 				    = 2
PROGRAMTEXT.init_pos 			    = {0.69,-0.88, 0}
PROGRAMTEXT.init_rot 			    = {0, 0, 0}
PROGRAMTEXT.element_params 	        = {"MFD_OPACITY","RMFD_RWR_PAGE"}
PROGRAMTEXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(PROGRAMTEXT)

CHAFFVAL				    = CreateElement "ceStringPoly"
CHAFFVAL.name				= "CHAFFVAL"
CHAFFVAL.material			= UFD_YEL
CHAFFVAL.init_pos			= {0.90, -0.72, 0} --L-R,U-D,F-B
CHAFFVAL.alignment			= "RightCenter"
CHAFFVAL.stringdefs		= {0.005, 0.005, 0, 0.0} --either 004 or 005
CHAFFVAL.additive_alpha	= true
CHAFFVAL.collimated		= false
CHAFFVAL.isdraw			= true	
CHAFFVAL.use_mipfilter		= true
CHAFFVAL.h_clip_relation	= h_clip_relations.COMPARE
CHAFFVAL.level				= 2
CHAFFVAL.element_params	= {"MFD_OPACITY","CHAFF_COUNT","RMFD_RWR_PAGE"}
CHAFFVAL.formats			= {"%01.0f"}
CHAFFVAL.controllers		=   {
                                        {"opacity_using_parameter",0},
                                        {"text_using_parameter",1,0},
                                        {"parameter_in_range",2,0.9,1.1}
                                    }                            
Add(CHAFFVAL)

FLAREVAL				    = CreateElement "ceStringPoly"
FLAREVAL.name				= "FLAREVAL"
FLAREVAL.material			= UFD_YEL
FLAREVAL.init_pos			= {0.90, -0.8, 0} --L-R,U-D,F-B
FLAREVAL.alignment			= "RightCenter"
FLAREVAL.stringdefs		= {0.005, 0.005, 0, 0.0} --either 004 or 005
FLAREVAL.additive_alpha	= true
FLAREVAL.collimated		= false
FLAREVAL.isdraw			= true	
FLAREVAL.use_mipfilter		= true
FLAREVAL.h_clip_relation	= h_clip_relations.COMPARE
FLAREVAL.level				= 2
FLAREVAL.element_params	= {"MFD_OPACITY","FLARE_COUNT","RMFD_RWR_PAGE"}
FLAREVAL.formats			= {"%01.0f"}
FLAREVAL.controllers		=   {
                                        {"opacity_using_parameter",0},
                                        {"text_using_parameter",1,0},
                                        {"parameter_in_range",2,0.9,1.1}
                                    }                            
Add(FLAREVAL)

PRGMVAL				    = CreateElement "ceStringPoly"
PRGMVAL.name				= "PRGMVAL"
PRGMVAL.material			= UFD_YEL
PRGMVAL.init_pos			= {0.90, -0.88, 0} --L-R,U-D,F-B
PRGMVAL.alignment			= "RightCenter"
PRGMVAL.stringdefs		= {0.005, 0.005, 0, 0.0} --either 004 or 005
PRGMVAL.additive_alpha	= true
PRGMVAL.collimated		= false
PRGMVAL.isdraw			= true	
PRGMVAL.use_mipfilter		= true
PRGMVAL.h_clip_relation	= h_clip_relations.COMPARE
PRGMVAL.level				= 2
PRGMVAL.element_params	= {"MFD_OPACITY","CMDS_PRGM_VAL","RMFD_RWR_PAGE","CMDS_PRGM_VAL"}
PRGMVAL.formats			= {"%01.0f"}
PRGMVAL.controllers		=   {
                                        {"opacity_using_parameter",0},
                                        {"text_using_parameter",1,0},
                                        {"parameter_in_range",2,0.9,1.1},
										{"parameter_in_range",3,0.9,6.1}
                                    }                            
Add(PRGMVAL)



RWRPWR 					    = CreateElement "ceStringPoly"
RWRPWR.name 				    = "RWRPWR"
RWRPWR.material 			    = UFD_FONT --UFD_YEL
RWRPWR.value 				    = "POWER"
RWRPWR.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
RWRPWR.alignment 			    = "CenterCenter"
RWRPWR.formats 			    = {"%s"}
RWRPWR.h_clip_relation         = h_clip_relations.COMPARE
RWRPWR.level 				    = 2
RWRPWR.init_pos 			    = {-0.55,-0.92, 0}
RWRPWR.init_rot 			    = {0, 0, 0}
RWRPWR.element_params 	        = {"MFD_OPACITY","RMFD_RWR_PAGE"}
RWRPWR.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(RWRPWR)


RWRPWRBOX 					    = CreateElement "ceTexPoly"
RWRPWRBOX.name 				    = "RWRPWR"
RWRPWRBOX.material 			    = IND_BOX 
RWRPWRBOX.change_opacity 	= false
RWRPWRBOX.collimated 		= false
RWRPWRBOX.isvisible 			= true
RWRPWRBOX.init_pos 			= {-0.54, -0.88, 0} --L-R,U-D,F-B
RWRPWRBOX.init_rot 			= {0, 0, 0}
RWRPWRBOX.element_params 		= {"MFD_OPACITY","RMFD_RWR_PAGE","RWR_POWER"}--this may not be bneeded check when more pages done for backlight on page 7 SMS fc3 bs
RWRPWRBOX.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.9,1.1},}--MENU PAGE = 1
RWRPWRBOX.level 				= 2
RWRPWRBOX.h_clip_relation     = h_clip_relations.COMPARE
vertices(RWRPWRBOX, 2.2)
Add(RWRPWRBOX)


ICON                      = CreateElement "ceTexPoly"
ICON.name    			  = "Jet_Icon"
ICON.material			  = CENTER_ICON
ICON.change_opacity 	= false
ICON.collimated 		= false
ICON.isvisible 			= true
ICON.init_pos 			= {0, 0, 0} --L-R,U-D,F-B
ICON.init_rot 			= {0, 0, 0}
ICON.element_params 		= {"MFD_OPACITY","RMFD_RWR_PAGE"}--this may not be bneeded check when more pages done for backlight on page 7 SMS fc3 bs
ICON.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}--MENU PAGE = 1
ICON.level 				= 2
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
CIRCLE1.element_params 		= {"MFD_OPACITY","RMFD_RWR_PAGE"}--this may not be bneeded check when more pages done for backlight on page 7 SMS fc3 bs
CIRCLE1.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}--MENU PAGE = 1
CIRCLE1.level 				= 2
CIRCLE1.h_clip_relation     = h_clip_relations.COMPARE
vertices(CIRCLE1, 1.5)
Add(CIRCLE1)

COMPASS_ROSE                     = CreateElement "ceTexPoly"
COMPASS_ROSE.name    			= "COMPASS_ROSE"
COMPASS_ROSE.material			= COMP_ROSE
COMPASS_ROSE.change_opacity 		= false
COMPASS_ROSE.collimated 			= false
COMPASS_ROSE.isvisible 			= true
COMPASS_ROSE.init_pos 			= {0, 0, 0} --L-R,U-D,F-B
COMPASS_ROSE.init_rot 			= {0, 0, 0}
COMPASS_ROSE.element_params 		= {"MFD_OPACITY","RMFD_RWR_PAGE","TRUE_HEADING"}--this may not be bneeded check when more pages done for backlight on page 7 SMS fc3 bs
COMPASS_ROSE.controllers			= {
	{"opacity_using_parameter",0},
	{"parameter_in_range",1,0.9,1.1},
	{"rotate_using_parameter", 2, 0.01745}
}
COMPASS_ROSE.level 				= 2
COMPASS_ROSE.h_clip_relation     = h_clip_relations.COMPARE
vertices(COMPASS_ROSE, 2.35)
Add(COMPASS_ROSE)

HEAD_BOX                     = CreateElement "ceTexPoly"
HEAD_BOX.name    			= "HEADING_BOX"
HEAD_BOX.material			= HEADING_BOX
HEAD_BOX.change_opacity 		= false
HEAD_BOX.collimated 			= false
HEAD_BOX.isvisible 			= true
HEAD_BOX.init_pos 			= {0, 0.86, 0} --L-R,U-D,F-B
HEAD_BOX.init_rot 			= {0, 0, 0}
HEAD_BOX.element_params 		= {"MFD_OPACITY","RMFD_RWR_PAGE"}--this may not be bneeded check when more pages done for backlight on page 7 SMS fc3 bs
HEAD_BOX.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}--MENU PAGE = 1
HEAD_BOX.level 				= 2
HEAD_BOX.h_clip_relation     = h_clip_relations.COMPARE
vertices(HEAD_BOX, 1.3)
HEAD_BOX.indices = {0, 1, 2, 2, 3, 0}
Add(HEAD_BOX)


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
HEAD_VAL.level				= 2
HEAD_VAL.element_params	= {"MFD_OPACITY","TRUE_HEADING","RMFD_RWR_PAGE"}
HEAD_VAL.formats			= {"%03.0f"}
HEAD_VAL.controllers		=   {
                                        {"opacity_using_parameter",0},
                                        {"text_using_parameter",1,0},
                                        {"parameter_in_range",2,0.9,1.1}
                                    }                            
Add(HEAD_VAL)


--RWR INFO

RS = RWR_SCALE / 20

ud_scale 	= 0.00001 * 0.9		* RS
lr_scale 	= 0.095	  * 0.9	*2	* RS
life_time 	= 2			--1

contact_scale = 0.065

local x_size = 0.01
local y_size = 0.01

for ia = 1, 20 do
    if ia < 10 then
        i = "_0" .. ia .. "_"
    else
        i = "_" .. ia .. "_"
    end

    -- RWR Contact (positioning base)
    local RWR_contact = CreateElement "ceSimple"
    RWR_contact.name = "RWR_contact_" .. i .. "_name"
    RWR_contact.primitivetype = "triangles"
    RWR_contact.h_clip_relation = h_clip_relations.COMPARE
    RWR_contact.level = RWR_DEFAULT_LEVEL
    RWR_contact.controllers = {
        {"rotate_using_parameter", 0, 1},
        {"move_up_down_using_parameter", 1, contact_scale},
        {"parameter_in_range", 1, 0.1, 1.09},
        {"parameter_in_range", 2, 0.9, 1.1},
    }
    RWR_contact.element_params = {
        "RWR_CONTACT" .. i .. "AZIMUTH",
        "RWR_CONTACT" .. i .. "POWER_SYM",
        "RMFD_RWR_PAGE",
    }
    RWR_contact.parent_element = "mfd_base_rwr"
    Add(RWR_contact)

    -- RWR Type (text displaying unit number, e.g., "27")
    local RWR_type = CreateElement "ceStringPoly"
    RWR_type.name = "RWR_type_" .. i .. "_name"
    RWR_type.material = HUD_FONT_ORANGE
    RWR_type.stringdefs = txt_s_stringdefs
    RWR_type.alignment = "CenterCenter"
    RWR_type.formats = {"%.0f"}
    RWR_type.UseBackground = false
    RWR_type.use_mipfilter = true
    RWR_type.h_clip_relation = h_clip_relations.COMPARE
    RWR_type.level = RWR_DEFAULT_LEVEL
    RWR_type.element_params = {
        "RWR_CONTACT" .. i .. "UNIT_TYPE_SYM",
        "RWR_CONTACT" .. i .. "AZIMUTH",
        "RMFD_RWR_PAGE",
    }
    RWR_type.controllers = {
        {"text_using_parameter", 0, 0},
        {"rotate_using_parameter", 1, -1},
        {"parameter_in_range", 2, 0.9, 1.1},
    }
    RWR_type.parent_element = "RWR_contact_" .. i .. "_name"
    Add(RWR_type)

    -- NEW: RWR Box (outline around the text)
    local RWR_box = CreateElement "ceTexPoly"
    RWR_box.name = "RWR_box_" .. i .. "_name"
    --RWR_box.primitivetype = "triangles"
    RWR_box.material = RWR_DIAMOND -- Same color as lock/plane for consistency
    RWR_box.h_clip_relation = h_clip_relations.COMPARE
    RWR_box.level = RWR_DEFAULT_LEVEL
    RWR_box.use_mipfilter = true
    RWR_box.element_params = {
        "RWR_CONTACT" .. i .. "UNIT_TYPE_SYM",
        "RWR_CONTACT" .. i .. "AZIMUTH",
        "RMFD_RWR_PAGE",
    }
    RWR_box.controllers = {
        {"parameter_in_range", 0, 0.1, 999}, -- Ensure box is visible when text is
        {"rotate_using_parameter", 1, -1},
        {"parameter_in_range", 2, 0.9, 1.1},
    }
    RWR_box.parent_element = "RWR_contact_" .. i .. "_name"
    vertices(RWR_box, 0.25) -- Adjust size to fit around text
    Add(RWR_box)

    -- Existing RWR_lock and RWR_plane elements (unchanged)
    x_size = 0.065 * RS
    y_size = x_size
    wmul = 0.88
    local RWR_lock = CreateElement "ceStringPoly"
    -- ... (rest of RWR_lock code unchanged)
    Add(RWR_lock)

    x_size = 0.051 * RS
    y_size = x_size
    wmul = 0.76
    local RWR_plane = CreateElement "ceStringPoly"
    -- ... (rest of RWR_plane code unchanged)
    Add(RWR_plane)
end

