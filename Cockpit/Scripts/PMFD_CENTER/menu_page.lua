dofile(LockOn_Options.script_path.."PMFD_CENTER/definitions.lua")
dofile(LockOn_Options.script_path.."fonts.lua")
dofile(LockOn_Options.script_path.."materials.lua")
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

local BGColor  				= {255, 255, 255, 180}--RGBA
local MainColor 			= {255, 255, 255, 255}--RGBA
local GreenColor 		    = {0, 255, 0, 255}--RGBA
local WhiteColor 			= {255, 255, 255, 255}--RGBA
local RedColor 				= {255, 0, 0, 255}--RGBA
local ScreenColor			= {3, 3, 3, 255}--RGBA 5-5-5
local LogoColor				= {12, 12, 12, 255}

--------------------------------------------------------------------------------------------------------------------------------------------
local MASK_BOX	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mask_box.dds", ScreenColor)
local MFD_LOGO 		= MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/22_logo.dds", LogoColor)
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
total_field_of_view.init_rot        = { 0, 0,0} -- degree NOT rad
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
BGROUND.element_params 		= {"MFD_OPACITY","PMFD_MENU_PAGE"}--this may not be bneeded check when more pages done for backlight on page 7 SMS fc3 bs
BGROUND.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}--MENU PAGE = 1
BGROUND.level 				= 2
BGROUND.h_clip_relation     = h_clip_relations.COMPARE
vertices(BGROUND,3)
Add(BGROUND)
----------------------------------------------------------------------------------------------------------------
--[[

MENU 					    = CreateElement "ceStringPoly"
MENU.name 				    = "MENU"
MENU.material 			    = UFD_YEL
MENU.value 				    = "MENU"
MENU.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
MENU.alignment 			    = "CenterCenter"
MENU.formats 			    = {"%s"}
MENU.h_clip_relation         = h_clip_relations.COMPARE
MENU.level 				    = 2
MENU.init_pos 			    = {0.01,-0.975, 0}
MENU.init_rot 			    = {0, 0, 0}
MENU.element_params 	        = {"MFD_OPACITY","PMFD_MENU_PAGE"}
MENU.controllers		        =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(MENU)

]]
----------------------------------------------------------------------------------------------------------------
CLOCKTXT				    = CreateElement "ceStringPoly"
CLOCKTXT.name				= "CLOCKTXT"
CLOCKTXT.material			= UFD_YEL
CLOCKTXT.init_pos			= {0.12,-0.975, 0}
CLOCKTXT.alignment			= "RightCenter"
CLOCKTXT.stringdefs		= {0.0050, 0.0050, 0, 0.0} --either 004 or 005
CLOCKTXT.additive_alpha	= true
CLOCKTXT.collimated		= false
CLOCKTXT.isdraw			= true	
CLOCKTXT.use_mipfilter		= true
CLOCKTXT.h_clip_relation	= h_clip_relations.COMPARE
CLOCKTXT.level				= 2
CLOCKTXT.element_params	= {"MFD_OPACITY","CLOCK","PMFD_MENU_PAGE"}
CLOCKTXT.formats			= {"%s"}--= {"%02.0f"}
CLOCKTXT.controllers		=   {
                                        {"opacity_using_parameter",0},
                                        {"text_using_parameter",1,0},
                                        {"parameter_in_range",2,0.9,1.1}
                                    }                            
Add(CLOCKTXT)



INFOTEXT 					    = CreateElement "ceStringPoly"
INFOTEXT.name 				    = "INFOTEXT"
INFOTEXT.material 			    = UFD_FONT
INFOTEXT.value 				    = "INFO"
INFOTEXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
INFOTEXT.alignment 			    = "CenterCenter"
INFOTEXT.formats 			    = {"%s"}
INFOTEXT.h_clip_relation         = h_clip_relations.COMPARE
INFOTEXT.level 				    = 2
INFOTEXT.init_pos 			    = {0.62,-0.975, 0}
INFOTEXT.init_rot 			    = {0, 0, 0}
INFOTEXT.element_params 	        = {"MFD_OPACITY","PMFD_MENU_PAGE"}
INFOTEXT.controllers		        =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(INFOTEXT)
----------------------------------------------------------------------------------------------------------------
TSD 					    = CreateElement "ceStringPoly"
TSD.name 				    = "TSD"
TSD.material 			    = UFD_FONT -- 
TSD.value 				    = "TSD"
TSD.stringdefs 		    = {0.0050, 0.0050, 0.0004, 0.001}
TSD.alignment 			    = "CenterCenter"
TSD.formats 			    = {"%s"}
TSD.h_clip_relation        = h_clip_relations.COMPARE
TSD.level 				    = 2
TSD.init_pos 			    = {-0.61,-0.975, 0}
TSD.init_rot 			    = {0, 0, 0}
TSD.element_params 	        = {"MFD_OPACITY","PMFD_MENU_PAGE"}
TSD.controllers		        =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(TSD)
----------------------------------------------------------------------------------------------------------------
NAVTXT 					    = CreateElement "ceStringPoly"
NAVTXT.name 				    = "menu"
NAVTXT.material 			    = UFD_FONT
NAVTXT.value 				    = "NAV" 
NAVTXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
NAVTXT.alignment 			    = "CenterCenter"
NAVTXT.formats 			    = {"%s"}
NAVTXT.h_clip_relation         = h_clip_relations.COMPARE
NAVTXT.level 				    = 2
NAVTXT.init_pos 			    = {-0.30,-0.975, 0}
NAVTXT.init_rot 			    = {0, 0, 0}
NAVTXT.element_params 	        = {"MFD_OPACITY","PMFD_MENU_PAGE"}
NAVTXT.controllers		        =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(NAVTXT)
----------------------------------------------------------------------------------------------------------------
SYSTEXT 					    = CreateElement "ceStringPoly"
SYSTEXT.name 				    = "menu"
SYSTEXT.material 			    = UFD_FONT
SYSTEXT.value 				    = "SYS"
SYSTEXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
SYSTEXT.alignment 			    = "CenterCenter"
SYSTEXT.formats 			    = {"%s"}
SYSTEXT.h_clip_relation         = h_clip_relations.COMPARE
SYSTEXT.level 				    = 2
SYSTEXT.init_pos 			    = {0.31,-0.975, 0}
SYSTEXT.init_rot 			    = {0, 0, 0}
SYSTEXT.element_params 	        = {"MFD_OPACITY","PMFD_MENU_PAGE"}
SYSTEXT.controllers		        =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(SYSTEXT)
-------------------------------------------------------------------------------------------------------------------
CONFIG_TXT 					        = CreateElement "ceStringPoly"
CONFIG_TXT.name 				    = "menu"
CONFIG_TXT.material 			    = UFD_FONT
CONFIG_TXT.value 				    = "CONFIG"
CONFIG_TXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
CONFIG_TXT.alignment 			    = "CenterCenter"
CONFIG_TXT.formats 			        = {"%s"}
CONFIG_TXT.h_clip_relation          = h_clip_relations.COMPARE
CONFIG_TXT.level 				    = 2
CONFIG_TXT.init_pos 			    = {-0.92,-0.70, 0}
CONFIG_TXT.init_rot 			    = {0, 0, 0}
CONFIG_TXT.element_params 	        = {"MFD_OPACITY","PMFD_MENU_PAGE"}
CONFIG_TXT.controllers		        =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(CONFIG_TXT)


ENG_TXT 					        = CreateElement "ceStringPoly"
ENG_TXT.name 				    = "ENG_TXT"
ENG_TXT.material 			    = UFD_FONT
ENG_TXT.value 				    = "ENG"
ENG_TXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
ENG_TXT.alignment 			    = "CenterCenter"
ENG_TXT.formats 			        = {"%s"}
ENG_TXT.h_clip_relation          = h_clip_relations.COMPARE
ENG_TXT.level 				    = 2
ENG_TXT.init_pos 			    = {-0.97, 0.54, 0}
ENG_TXT.init_rot 			    = {0, 0, 0}
ENG_TXT.element_params 	        = {"MFD_OPACITY","PMFD_MENU_PAGE"}
ENG_TXT.controllers		        =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(ENG_TXT)