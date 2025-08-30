dofile(LockOn_Options.script_path.."MFD_RIGHT/definitions.lua")
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
local BlackColor  			= {0, 0, 0, 255}--RGBA
local WhiteColor 			= {255, 255, 255, 255}--RGBA
local MainColor 			= {255, 255, 255, 255}--RGBA
local GreenColor 		    = {0, 255, 0, 255}--RGBA
local YellowColor 			= {255, 255, 0, 255}--RGBA
local OrangeColor           = {255, 102, 0, 255}--RGBA
local RedColor 				= {255, 0, 0, 255}--RGBA
local ScreenColor			= {3, 3, 3, 255}--RGBA DO NOT TOUCH 3-3-12-255 is good for on screen
local LogoColor				= {12, 12, 12, 255}
--------------------------------------------------------------------------------------------------------------------------------------------
local MASK_BOX	    = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mask_box.dds", ScreenColor)--SYSTEM TEST
local MFD_LOGO 		= MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/22_logo.dds", LogoColor)
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
BGROUND.element_params 		= {"MFD_OPACITY","RMFD_MENU_PAGE"}--this may not be bneeded check when more pages done for backlight on page 7 SMS fc3 bs
BGROUND.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}--MENU PAGE = 1
BGROUND.level 				= 2
BGROUND.h_clip_relation     = h_clip_relations.COMPARE
vertices(BGROUND,3)
Add(BGROUND)
----------------------------------------------------------------------------------------------------------------ADI
--ADI TEXT - button 20
NAVTEXT 					    = CreateElement "ceStringPoly"
NAVTEXT.name 				    = "NAVTEXT"
NAVTEXT.material 			    = UFD_FONT
NAVTEXT.value 				    = "NAV"
NAVTEXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
NAVTEXT.alignment 			    = "CenterCenter"
NAVTEXT.formats 			    = {"%s"}
NAVTEXT.h_clip_relation         = h_clip_relations.COMPARE
NAVTEXT.level 				    = 2
NAVTEXT.init_pos 			    = {-0.9, 0.42, 0}
NAVTEXT.init_rot 			    = {0, 0, 0}
NAVTEXT.element_params 	        = {"MFD_OPACITY","RMFD_MENU_PAGE"}
NAVTEXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(NAVTEXT)
----------------------------------------------------------------------------------------------------------------ADI
--HSI TEXT - button 6
HSITEXT 					    = CreateElement "ceStringPoly"
HSITEXT.name 				    = "menu"
HSITEXT.material 			    = UFD_FONT
HSITEXT.value 				    = "HSI"
HSITEXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
HSITEXT.alignment 			    = "CenterCenter"
HSITEXT.formats 			    = {"%s"}
HSITEXT.h_clip_relation         = h_clip_relations.COMPARE
HSITEXT.level 				    = 2
HSITEXT.init_pos 			    = {0.9, 0.42, 0}
HSITEXT.init_rot 			    = {0, 0, 0}
HSITEXT.element_params 	        = {"MFD_OPACITY","RMFD_MENU_PAGE"}
HSITEXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(HSITEXT)
----------------------------------------------------------------------------------------------------------------ENG
--ENG TEXT - button 18
ENGTEXT 					    = CreateElement "ceStringPoly"
ENGTEXT.name 				    = "menu"
ENGTEXT.material 			    = UFD_FONT
ENGTEXT.value 				    = "ENG"
ENGTEXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
ENGTEXT.alignment 			    = "CenterCenter"
ENGTEXT.formats 			    = {"%s"}
ENGTEXT.h_clip_relation         = h_clip_relations.COMPARE
ENGTEXT.level 				    = 2
ENGTEXT.init_pos 			    = {-0.90, -0.14, 0}
ENGTEXT.init_rot 			    = {0, 0, 0}
ENGTEXT.element_params 	        = {"MFD_OPACITY","RMFD_MENU_PAGE"}
ENGTEXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(ENGTEXT)
----------------------------------------------------------------------------------------------------------------FCS
--FCS TEXT button 8
FCSTEXT 					    = CreateElement "ceStringPoly"
FCSTEXT.name 				    = "menu"
FCSTEXT.material 			    = UFD_FONT
FCSTEXT.value 				    = "FCS"
FCSTEXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
FCSTEXT.alignment 			    = "CenterCenter"
FCSTEXT.formats 			    = {"%s"}
FCSTEXT.h_clip_relation         = h_clip_relations.COMPARE
FCSTEXT.level 				    = 2
FCSTEXT.init_pos 			    = {0.90,-0.14, 0}
FCSTEXT.init_rot 			    = {0, 0, 0}
FCSTEXT.element_params 	        = {"MFD_OPACITY","RMFD_MENU_PAGE"}
FCSTEXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(FCSTEXT)
----------------------------------------------------------------------------------------------------------------FUEL
--FUEL TEXT - button 10
FUELTEXT 					    = CreateElement "ceStringPoly"
FUELTEXT.name 				    = "menu"
FUELTEXT.material 			    = UFD_FONT
FUELTEXT.value 				    = "FUEL"
FUELTEXT.stringdefs 		    = {0.0050, 0.0050, 0.0004, 0.001}
FUELTEXT.alignment 			    = "CenterCenter"
FUELTEXT.formats 			    = {"%s"}
FUELTEXT.h_clip_relation         = h_clip_relations.COMPARE
FUELTEXT.level 				    = 2
FUELTEXT.init_pos 			    = {0.89, -0.70, 0}
FUELTEXT.init_rot 			    = {0, 0, 0}
FUELTEXT.element_params 	        = {"MFD_OPACITY","RMFD_MENU_PAGE"}
FUELTEXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(FUELTEXT)
----------------------------------------------------------------------------------------------------------------FUEL
--BAY TEXT - button 16

TEWSTEXT 					    = CreateElement "ceStringPoly"
TEWSTEXT.name 				    = "TEWSTEXT"
TEWSTEXT.material 			    = UFD_FONT
TEWSTEXT.value 				    = "TEWS"
TEWSTEXT.stringdefs 		    = {0.0050, 0.0050, 0.0004, 0.001}
TEWSTEXT.alignment 			    = "CenterCenter"
TEWSTEXT.formats 			    = {"%s"}
TEWSTEXT.h_clip_relation         = h_clip_relations.COMPARE
TEWSTEXT.level 				    = 2
TEWSTEXT.init_pos 			    = {-0.89, -0.70, 0}
TEWSTEXT.init_rot 			    = {0, 0, 0}
TEWSTEXT.element_params 	        = {"MFD_OPACITY","RMFD_MENU_PAGE"}
TEWSTEXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(TEWSTEXT)

----------------------------------------------------------------------------------------------------------------CHK
--CHK TEXT - button 3
CHKTEXT 					    = CreateElement "ceStringPoly"
CHKTEXT.name 				    = "menu"
CHKTEXT.material 			    = UFD_FONT
CHKTEXT.value 				    = "CHK"
CHKTEXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
CHKTEXT.alignment 			    = "CenterCenter"
CHKTEXT.formats 			    = {"%s"}
CHKTEXT.h_clip_relation         = h_clip_relations.COMPARE
CHKTEXT.level 				    = 2
CHKTEXT.init_pos 			    = {0, 0.92, 0}
CHKTEXT.init_rot 			    = {0, 0, 0}
CHKTEXT.element_params 	        = {"MFD_OPACITY","RMFD_MENU_PAGE"}
CHKTEXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(CHKTEXT)
----------------------------------------------------------------------------------------------------------------CHK
--#################################################################################################################
--MENU TEXT - button 13

CLOCK				    = CreateElement "ceStringPoly"
CLOCK.name				= "CLOCK"
CLOCK.material			= UFD_YEL
CLOCK.init_pos			= {0.15, -0.92, 0} --L-R,U-D,F-B
CLOCK.alignment			= "RightCenter"
CLOCK.stringdefs		= {0.0050, 0.0050, 0, 0.0} --either 004 or 005
CLOCK.additive_alpha	= true
CLOCK.collimated		= false
CLOCK.isdraw			= true	
CLOCK.use_mipfilter		= true
CLOCK.h_clip_relation	= h_clip_relations.COMPARE
CLOCK.level				= 2
CLOCK.element_params	= {"MFD_OPACITY","CLOCK","RMFD_MENU_PAGE"}
CLOCK.formats			= {"%s"}--= {"%02.0f"}
CLOCK.controllers		=   {
                                        {"opacity_using_parameter",0},
                                        {"text_using_parameter",1,0},
                                        {"parameter_in_range",2,0.9,1.1}
                                    }                            
Add(CLOCK)


--MENU TEXT - button 13
BAYTEXT 					    = CreateElement "ceStringPoly"
BAYTEXT.name 				    = "BAYTEXT"
BAYTEXT.material 			    = UFD_FONT --UFD_YEL
BAYTEXT.value 				    = "BAY"
BAYTEXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
BAYTEXT.alignment 			    = "CenterCenter"
BAYTEXT.formats 			    = {"%s"}
BAYTEXT.h_clip_relation         = h_clip_relations.COMPARE
BAYTEXT.level 				    = 2
BAYTEXT.init_pos 			    = {-0.55,-0.92, 0}
BAYTEXT.init_rot 			    = {0, 0, 0}
BAYTEXT.element_params 	        = {"MFD_OPACITY","RMFD_MENU_PAGE"}
BAYTEXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(BAYTEXT)
