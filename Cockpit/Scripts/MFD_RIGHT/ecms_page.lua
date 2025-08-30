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
local ScreenColor			= {2, 2, 2, 255}--RGBA DO NOT TOUCH 3-3-12-255 is good for on screen
local LogoColor				= {12, 12, 12, 255}
--------------------------------------------------------------------------------------------------------------------------------------------
local MASK_BOX	    = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mask_box.dds", ScreenColor)--SYSTEM TEST
local MFD_LOGO 		= MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/22_logo.dds", LogoColor)
local IND_BOX	    = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/ind_box.dds", WhiteColor)
local PRGM_BOX	    = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/ind_box.dds", GreenColor)
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
BGROUND.element_params 		= {"MFD_OPACITY","RMFD_ECMS_PAGE"}--this may not be bneeded check when more pages done for backlight on page 7 SMS fc3 bs
BGROUND.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}--MENU PAGE = 1
BGROUND.level 				= 2
BGROUND.h_clip_relation     = h_clip_relations.COMPARE
vertices(BGROUND,3)
Add(BGROUND)

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
MENUTEXT.element_params 	        = {"MFD_OPACITY","RMFD_ECMS_PAGE"}
MENUTEXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(MENUTEXT)

BACKTEXT 					    = CreateElement "ceStringPoly"
BACKTEXT.name 				    = "BACKTEXT"
BACKTEXT.material 			    = UFD_FONT 
BACKTEXT.value 				    = "BACK"
BACKTEXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
BACKTEXT.alignment 			    = "CenterCenter"
BACKTEXT.formats 			    = {"%s"}
BACKTEXT.h_clip_relation         = h_clip_relations.COMPARE
BACKTEXT.level 				    = 2
BACKTEXT.init_pos 			    = {0.565, 0.92, 0}
BACKTEXT.init_rot 			    = {0, 0, 0}
BACKTEXT.element_params 	        = {"MFD_OPACITY","RMFD_ECMS_PAGE"}
BACKTEXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(BACKTEXT)

ECMSPWR 					    = CreateElement "ceStringPoly"
ECMSPWR.name 				    = "ECMSPWR"
ECMSPWR.material 			    = UFD_FONT --UFD_YEL
ECMSPWR.value 				    = "POWER"
ECMSPWR.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
ECMSPWR.alignment 			    = "CenterCenter"
ECMSPWR.formats 			    = {"%s"}
ECMSPWR.h_clip_relation         = h_clip_relations.COMPARE
ECMSPWR.level 				    = 2
ECMSPWR.init_pos 			    = {-0.55,-0.92, 0}
ECMSPWR.init_rot 			    = {0, 0, 0}
ECMSPWR.element_params 	        = {"MFD_OPACITY","RMFD_ECMS_PAGE"}
ECMSPWR.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(ECMSPWR)


ECMSPWRBOX 					    = CreateElement "ceTexPoly"
ECMSPWRBOX.name 				    = "ECMSPWRBOX"
ECMSPWRBOX.material 			    = IND_BOX 
ECMSPWRBOX.change_opacity 	= false
ECMSPWRBOX.collimated 		= false
ECMSPWRBOX.isvisible 			= true
ECMSPWRBOX.init_pos 			= {-0.54, -0.88, 0} --L-R,U-D,F-B
ECMSPWRBOX.init_rot 			= {0, 0, 0}
ECMSPWRBOX.element_params 		= {"MFD_OPACITY","RMFD_ECMS_PAGE","ECMS_POWER"}--this may not be bneeded check when more pages done for backlight on page 7 SMS fc3 bs
ECMSPWRBOX.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.9,1.1},}--MENU PAGE = 1
ECMSPWRBOX.level 				= 2
ECMSPWRBOX.h_clip_relation     = h_clip_relations.COMPARE
vertices(ECMSPWRBOX, 2.2)
Add(ECMSPWRBOX)

JAMMERPWR 					    = CreateElement "ceStringPoly"
JAMMERPWR.name 				    = "JAMMERPWR"
JAMMERPWR.material 			    = UFD_FONT --UFD_YEL
JAMMERPWR.value 				    = "JAMMER"
JAMMERPWR.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
JAMMERPWR.alignment 			    = "CenterCenter"
JAMMERPWR.formats 			    = {"%s"}
JAMMERPWR.h_clip_relation         = h_clip_relations.COMPARE
JAMMERPWR.level 				    = 2
JAMMERPWR.init_pos 			    = {0.55,-0.92, 0}
JAMMERPWR.init_rot 			    = {0, 0, 0}
JAMMERPWR.element_params 	        = {"MFD_OPACITY","RMFD_ECMS_PAGE"}
JAMMERPWR.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(JAMMERPWR)


JAMPWRBOX 					    = CreateElement "ceTexPoly"
JAMPWRBOX.name 				    = "JAMPWRBOX"
JAMPWRBOX.material 			    = IND_BOX 
JAMPWRBOX.change_opacity 	= false
JAMPWRBOX.collimated 		= false
JAMPWRBOX.isvisible 			= true
JAMPWRBOX.init_pos 			= {0.562, -0.8725, 0} --L-R,U-D,F-B
JAMPWRBOX.init_rot 			= {0, 0, 0}
JAMPWRBOX.element_params 		= {"MFD_OPACITY","RMFD_ECMS_PAGE","JAMMER_POWER"}--this may not be bneeded check when more pages done for backlight on page 7 SMS fc3 bs
JAMPWRBOX.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.9,1.1},}--MENU PAGE = 1
JAMPWRBOX.level 				= 2
JAMPWRBOX.h_clip_relation     = h_clip_relations.COMPARE
vertices(JAMPWRBOX, 2.45)
Add(JAMPWRBOX)



HEADINGTXT 					    = CreateElement "ceStringPoly"
HEADINGTXT.name 				    = "BACKTEXT"
HEADINGTXT.material 			    = UFD_YEL 
HEADINGTXT.value 				    = "ELECTRONIC COUNTERMEASURES"
HEADINGTXT.stringdefs 		        = {0.0060, 0.0060, 0.0003, 0.001}
HEADINGTXT.alignment 			    = "CenterCenter"
HEADINGTXT.formats 			    = {"%s"}
HEADINGTXT.h_clip_relation         = h_clip_relations.COMPARE
HEADINGTXT.level 				    = 2
HEADINGTXT.init_pos 			    = {0, 0.67, 0}
HEADINGTXT.init_rot 			    = {0, 0, 0}
HEADINGTXT.element_params 	        = {"MFD_OPACITY","RMFD_ECMS_PAGE"}
HEADINGTXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(HEADINGTXT)

PROGRAM1TXT 					    = CreateElement "ceStringPoly"
PROGRAM1TXT.name 				    = "PROGRAM1TXT"
PROGRAM1TXT.material 			    = UFD_GRN 
PROGRAM1TXT.value 				    = "PROGRAM 1:"
PROGRAM1TXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
PROGRAM1TXT.alignment 			    = "CenterCenter"
PROGRAM1TXT.formats 			    = {"%s"}
PROGRAM1TXT.h_clip_relation         = h_clip_relations.COMPARE
PROGRAM1TXT.level 				    = 2
PROGRAM1TXT.init_pos 			    = {0, 0.52, 0}
PROGRAM1TXT.init_rot 			    = {0, 0, 0}
PROGRAM1TXT.element_params 	        = {"MFD_OPACITY","RMFD_ECMS_PAGE"}
PROGRAM1TXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(PROGRAM1TXT)

PROGRAM1DESC 					    = CreateElement "ceStringPoly"
PROGRAM1DESC.name 				    = "PROGRAM1DESC"
PROGRAM1DESC.material 			    = UFD_GRN 
PROGRAM1DESC.value 				    = "MANUAL - DOUBLE"
PROGRAM1DESC.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
PROGRAM1DESC.alignment 			    = "CenterCenter"
PROGRAM1DESC.formats 			    = {"%s"}
PROGRAM1DESC.h_clip_relation         = h_clip_relations.COMPARE
PROGRAM1DESC.level 				    = 2
PROGRAM1DESC.init_pos 			    = {0, 0.44, 0}
PROGRAM1DESC.init_rot 			    = {0, 0, 0}
PROGRAM1DESC.element_params 	        = {"MFD_OPACITY","RMFD_ECMS_PAGE"}
PROGRAM1DESC.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(PROGRAM1DESC)

PROGRAM2TXT 					    = CreateElement "ceStringPoly"
PROGRAM2TXT.name 				    = "PROGRAM2TXT"
PROGRAM2TXT.material 			    = UFD_GRN 
PROGRAM2TXT.value 				    = "PROGRAM 2:"
PROGRAM2TXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
PROGRAM2TXT.alignment 			    = "CenterCenter"
PROGRAM2TXT.formats 			    = {"%s"}
PROGRAM2TXT.h_clip_relation         = h_clip_relations.COMPARE
PROGRAM2TXT.level 				    = 2
PROGRAM2TXT.init_pos 			    = {0, 0.28, 0}
PROGRAM2TXT.init_rot 			    = {0, 0, 0}
PROGRAM2TXT.element_params 	        = {"MFD_OPACITY","RMFD_ECMS_PAGE"}
PROGRAM2TXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(PROGRAM2TXT)

PROGRAM2DESC 					    = CreateElement "ceStringPoly"
PROGRAM2DESC.name 				    = "PROGRAM2DESC"
PROGRAM2DESC.material 			    = UFD_GRN 
PROGRAM2DESC.value 				    = "MANUAL - SINGLE"
PROGRAM2DESC.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
PROGRAM2DESC.alignment 			    = "CenterCenter"
PROGRAM2DESC.formats 			    = {"%s"}
PROGRAM2DESC.h_clip_relation         = h_clip_relations.COMPARE
PROGRAM2DESC.level 				    = 2
PROGRAM2DESC.init_pos 			    = {0, 0.20, 0}
PROGRAM2DESC.init_rot 			    = {0, 0, 0}
PROGRAM2DESC.element_params 	        = {"MFD_OPACITY","RMFD_ECMS_PAGE"}
PROGRAM2DESC.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(PROGRAM2DESC)

PROGRAM3TXT 					    = CreateElement "ceStringPoly"
PROGRAM3TXT.name 				    = "PROGRAM3TXT"
PROGRAM3TXT.material 			    = UFD_GRN 
PROGRAM3TXT.value 				    = "PROGRAM 3:"
PROGRAM3TXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
PROGRAM3TXT.alignment 			    = "CenterCenter"
PROGRAM3TXT.formats 			    = {"%s"}
PROGRAM3TXT.h_clip_relation         = h_clip_relations.COMPARE
PROGRAM3TXT.level 				    = 2
PROGRAM3TXT.init_pos 			    = {0, 0.06, 0}
PROGRAM3TXT.init_rot 			    = {0, 0, 0}
PROGRAM3TXT.element_params 	        = {"MFD_OPACITY","RMFD_ECMS_PAGE"}
PROGRAM3TXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(PROGRAM3TXT)

PROGRAM3DESC 					    = CreateElement "ceStringPoly"
PROGRAM3DESC.name 				    = "PROGRAM3DESC"
PROGRAM3DESC.material 			    = UFD_GRN 
PROGRAM3DESC.value 				    = "MANUAL - SALVO"
PROGRAM3DESC.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
PROGRAM3DESC.alignment 			    = "CenterCenter"
PROGRAM3DESC.formats 			    = {"%s"}
PROGRAM3DESC.h_clip_relation         = h_clip_relations.COMPARE
PROGRAM3DESC.level 				    = 2
PROGRAM3DESC.init_pos 			    = {0, -0.02, 0}
PROGRAM3DESC.init_rot 			    = {0, 0, 0}
PROGRAM3DESC.element_params 	        = {"MFD_OPACITY","RMFD_ECMS_PAGE"}
PROGRAM3DESC.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(PROGRAM3DESC)

PROGRAM4TXT 					    = CreateElement "ceStringPoly"
PROGRAM4TXT.name 				    = "PROGRAM4TXT"
PROGRAM4TXT.material 			    = UFD_GRN 
PROGRAM4TXT.value 				    = "PROGRAM 4:"
PROGRAM4TXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
PROGRAM4TXT.alignment 			    = "CenterCenter"
PROGRAM4TXT.formats 			    = {"%s"}
PROGRAM4TXT.h_clip_relation         = h_clip_relations.COMPARE
PROGRAM4TXT.level 				    = 2
PROGRAM4TXT.init_pos 			    = {0, -0.16, 0}
PROGRAM4TXT.init_rot 			    = {0, 0, 0}
PROGRAM4TXT.element_params 	        = {"MFD_OPACITY","RMFD_ECMS_PAGE"}
PROGRAM4TXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(PROGRAM4TXT)

PROGRAM4DESC 					    = CreateElement "ceStringPoly"
PROGRAM4DESC.name 				    = "PROGRAM4DESC"
PROGRAM4DESC.material 			    = UFD_GRN 
PROGRAM4DESC.value 				    = "MANUAL - BURST"
PROGRAM4DESC.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
PROGRAM4DESC.alignment 			    = "CenterCenter"
PROGRAM4DESC.formats 			    = {"%s"}
PROGRAM4DESC.h_clip_relation         = h_clip_relations.COMPARE
PROGRAM4DESC.level 				    = 2
PROGRAM4DESC.init_pos 			    = {0, -0.24, 0}
PROGRAM4DESC.init_rot 			    = {0, 0, 0}
PROGRAM4DESC.element_params 	        = {"MFD_OPACITY","RMFD_ECMS_PAGE"}
PROGRAM4DESC.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(PROGRAM4DESC)

PROGRAM5TXT 					    = CreateElement "ceStringPoly"
PROGRAM5TXT.name 				    = "PROGRAM5TXT"
PROGRAM5TXT.material 			    = UFD_GRN 
PROGRAM5TXT.value 				    = "PROGRAM 5:"
PROGRAM5TXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
PROGRAM5TXT.alignment 			    = "CenterCenter"
PROGRAM5TXT.formats 			    = {"%s"}
PROGRAM5TXT.h_clip_relation         = h_clip_relations.COMPARE
PROGRAM5TXT.level 				    = 2
PROGRAM5TXT.init_pos 			    = {0, -0.38, 0}
PROGRAM5TXT.init_rot 			    = {0, 0, 0}
PROGRAM5TXT.element_params 	        = {"MFD_OPACITY","RMFD_ECMS_PAGE"}
PROGRAM5TXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(PROGRAM5TXT)

PROGRAM5DESC 					    = CreateElement "ceStringPoly"
PROGRAM5DESC.name 				    = "PROGRAM5DESC"
PROGRAM5DESC.material 			    = UFD_GRN 
PROGRAM5DESC.value 				    = "MANUAL - COMBO SALVO"
PROGRAM5DESC.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
PROGRAM5DESC.alignment 			    = "CenterCenter"
PROGRAM5DESC.formats 			    = {"%s"}
PROGRAM5DESC.h_clip_relation         = h_clip_relations.COMPARE
PROGRAM5DESC.level 				    = 2
PROGRAM5DESC.init_pos 			    = {0, -0.46, 0}
PROGRAM5DESC.init_rot 			    = {0, 0, 0}
PROGRAM5DESC.element_params 	        = {"MFD_OPACITY","RMFD_ECMS_PAGE"}
PROGRAM5DESC.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(PROGRAM5DESC)

PROGRAM6TXT 					    = CreateElement "ceStringPoly"
PROGRAM6TXT.name 				    = "PROGRAM6TXT"
PROGRAM6TXT.material 			    = UFD_GRN 
PROGRAM6TXT.value 				    = "PROGRAM 6:"
PROGRAM6TXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
PROGRAM6TXT.alignment 			    = "CenterCenter"
PROGRAM6TXT.formats 			    = {"%s"}
PROGRAM6TXT.h_clip_relation         = h_clip_relations.COMPARE
PROGRAM6TXT.level 				    = 2
PROGRAM6TXT.init_pos 			    = {0, -0.60, 0}
PROGRAM6TXT.init_rot 			    = {0, 0, 0}
PROGRAM6TXT.element_params 	        = {"MFD_OPACITY","RMFD_ECMS_PAGE"}
PROGRAM6TXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(PROGRAM6TXT)

PROGRAM6DESC 					    = CreateElement "ceStringPoly"
PROGRAM6DESC.name 				    = "PROGRAM6DESC"
PROGRAM6DESC.material 			    = UFD_GRN 
PROGRAM6DESC.value 				    = "AUTOMATIC"
PROGRAM6DESC.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
PROGRAM6DESC.alignment 			    = "CenterCenter"
PROGRAM6DESC.formats 			    = {"%s"}
PROGRAM6DESC.h_clip_relation         = h_clip_relations.COMPARE
PROGRAM6DESC.level 				    = 2
PROGRAM6DESC.init_pos 			    = {0, -0.68, 0}
PROGRAM6DESC.init_rot 			    = {0, 0, 0}
PROGRAM6DESC.element_params 	        = {"MFD_OPACITY","RMFD_ECMS_PAGE"}
PROGRAM6DESC.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(PROGRAM6DESC)

PROG1TXT 					    = CreateElement "ceStringPoly"
PROG1TXT.name 				    = "PROG1TXT"
PROG1TXT.material 			    = UFD_GRN 
PROG1TXT.value 				    = "PRGM 1"
PROG1TXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
PROG1TXT.alignment 			    = "CenterCenter"
PROG1TXT.formats 			    = {"%s"}
PROG1TXT.h_clip_relation         = h_clip_relations.COMPARE
PROG1TXT.level 				    = 2
PROG1TXT.init_pos 			    = {-0.84, 0.42, 0}
PROG1TXT.init_rot 			    = {0, 0, 0}
PROG1TXT.element_params 	        = {"MFD_OPACITY","RMFD_ECMS_PAGE"}
PROG1TXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(PROG1TXT)


PROG2TXT 					    = CreateElement "ceStringPoly"
PROG2TXT.name 				    = "PROG2TXT"
PROG2TXT.material 			    = UFD_GRN 
PROG2TXT.value 				    = "PRGM 2"
PROG2TXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
PROG2TXT.alignment 			    = "CenterCenter"
PROG2TXT.formats 			    = {"%s"}
PROG2TXT.h_clip_relation         = h_clip_relations.COMPARE
PROG2TXT.level 				    = 2
PROG2TXT.init_pos 			    = {-0.84, -0.14, 0}
PROG2TXT.init_rot 			    = {0, 0, 0}
PROG2TXT.element_params 	        = {"MFD_OPACITY","RMFD_ECMS_PAGE"}
PROG2TXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(PROG2TXT)

PROG3TXT 					    = CreateElement "ceStringPoly"
PROG3TXT.name 				    = "PROG3TXT"
PROG3TXT.material 			    = UFD_GRN 
PROG3TXT.value 				    = "PRGM 3"
PROG3TXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
PROG3TXT.alignment 			    = "CenterCenter"
PROG3TXT.formats 			    = {"%s"}
PROG3TXT.h_clip_relation         = h_clip_relations.COMPARE
PROG3TXT.level 				    = 2
PROG3TXT.init_pos 			    = {-0.84, -0.70, 0}
PROG3TXT.init_rot 			    = {0, 0, 0}
PROG3TXT.element_params 	        = {"MFD_OPACITY","RMFD_ECMS_PAGE"}
PROG3TXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(PROG3TXT)

PROG4TXT 					    = CreateElement "ceStringPoly"
PROG4TXT.name 				    = "PROG4TXT"
PROG4TXT.material 			    = UFD_GRN 
PROG4TXT.value 				    = "PRGM 4"
PROG4TXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
PROG4TXT.alignment 			    = "CenterCenter"
PROG4TXT.formats 			    = {"%s"}
PROG4TXT.h_clip_relation         = h_clip_relations.COMPARE
PROG4TXT.level 				    = 2
PROG4TXT.init_pos 			    = {0.84, 0.42, 0}
PROG4TXT.init_rot 			    = {0, 0, 0}
PROG4TXT.element_params 	        = {"MFD_OPACITY","RMFD_ECMS_PAGE"}
PROG4TXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(PROG4TXT)


PROG5TXT 					    = CreateElement "ceStringPoly"
PROG5TXT.name 				    = "PROG5TXT"
PROG5TXT.material 			    = UFD_GRN 
PROG5TXT.value 				    = "PRGM 5"
PROG5TXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
PROG5TXT.alignment 			    = "CenterCenter"
PROG5TXT.formats 			    = {"%s"}
PROG5TXT.h_clip_relation         = h_clip_relations.COMPARE
PROG5TXT.level 				    = 2
PROG5TXT.init_pos 			    = {0.84, -0.14, 0}
PROG5TXT.init_rot 			    = {0, 0, 0}
PROG5TXT.element_params 	        = {"MFD_OPACITY","RMFD_ECMS_PAGE"}
PROG5TXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(PROG5TXT)

PROG6TXT 					    = CreateElement "ceStringPoly"
PROG6TXT.name 				    = "PROG6TXT"
PROG6TXT.material 			    = UFD_GRN 
PROG6TXT.value 				    = "PRGM 6"
PROG6TXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
PROG6TXT.alignment 			    = "CenterCenter"
PROG6TXT.formats 			    = {"%s"}
PROG6TXT.h_clip_relation         = h_clip_relations.COMPARE
PROG6TXT.level 				    = 2
PROG6TXT.init_pos 			    = {0.84, -0.70, 0}
PROG6TXT.init_rot 			    = {0, 0, 0}
PROG6TXT.element_params 	        = {"MFD_OPACITY","RMFD_ECMS_PAGE"}
PROG6TXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(PROG6TXT)

PRGM1BOX 					    = CreateElement "ceTexPoly"
PRGM1BOX.name 				    = "PRGM1BOX"
PRGM1BOX.material 			    = PRGM_BOX 
PRGM1BOX.change_opacity 	= false
PRGM1BOX.collimated 		= false
PRGM1BOX.isvisible 			= true
PRGM1BOX.init_pos 			= {-0.83, 0.47, 0} --L-R,U-D,F-B
PRGM1BOX.init_rot 			= {0, 0, 0}
PRGM1BOX.element_params 		= {"MFD_OPACITY","RMFD_ECMS_PAGE","CMDS_PRGM_1"}--this may not be bneeded check when more pages done for backlight on page 7 SMS fc3 bs
PRGM1BOX.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.9,1.1},}--MENU PAGE = 1
PRGM1BOX.level 				= 2
PRGM1BOX.h_clip_relation     = h_clip_relations.COMPARE
vertices(PRGM1BOX, 2.5)
Add(PRGM1BOX)

PRGM2BOX 					    = CreateElement "ceTexPoly"
PRGM2BOX.name 				    = "PRGM2BOX"
PRGM2BOX.material 			    = PRGM_BOX 
PRGM2BOX.change_opacity 	= false
PRGM2BOX.collimated 		= false
PRGM2BOX.isvisible 			= true
PRGM2BOX.init_pos 			= {-0.83, -0.09, 0} --L-R,U-D,F-B
PRGM2BOX.init_rot 			= {0, 0, 0}
PRGM2BOX.element_params 		= {"MFD_OPACITY","RMFD_ECMS_PAGE","CMDS_PRGM_2"}--this may not be bneeded check when more pages done for backlight on page 7 SMS fc3 bs
PRGM2BOX.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.9,1.1},}--MENU PAGE = 1
PRGM2BOX.level 				= 2
PRGM2BOX.h_clip_relation     = h_clip_relations.COMPARE
vertices(PRGM2BOX, 2.5)
Add(PRGM2BOX)

PRGM3BOX 					    = CreateElement "ceTexPoly"
PRGM3BOX.name 				    = "PRGM3BOX"
PRGM3BOX.material 			    = PRGM_BOX 
PRGM3BOX.change_opacity 	= false
PRGM3BOX.collimated 		= false
PRGM3BOX.isvisible 			= true
PRGM3BOX.init_pos 			= {-0.83, -0.65, 0} --L-R,U-D,F-B
PRGM3BOX.init_rot 			= {0, 0, 0}
PRGM3BOX.element_params 		= {"MFD_OPACITY","RMFD_ECMS_PAGE","CMDS_PRGM_3"}--this may not be bneeded check when more pages done for backlight on page 7 SMS fc3 bs
PRGM3BOX.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.9,1.1},}--MENU PAGE = 1
PRGM3BOX.level 				= 2
PRGM3BOX.h_clip_relation     = h_clip_relations.COMPARE
vertices(PRGM3BOX, 2.5)
Add(PRGM3BOX)

PRGM4BOX 					    = CreateElement "ceTexPoly"
PRGM4BOX.name 				    = "PRGM4BOX"
PRGM4BOX.material 			    = PRGM_BOX 
PRGM4BOX.change_opacity 	= false
PRGM4BOX.collimated 		= false
PRGM4BOX.isvisible 			= true
PRGM4BOX.init_pos 			= {0.85, 0.47, 0} --L-R,U-D,F-B
PRGM4BOX.init_rot 			= {0, 0, 0}
PRGM4BOX.element_params 		= {"MFD_OPACITY","RMFD_ECMS_PAGE","CMDS_PRGM_4"}--this may not be bneeded check when more pages done for backlight on page 7 SMS fc3 bs
PRGM4BOX.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.9,1.1},}--MENU PAGE = 1
PRGM4BOX.level 				= 2
PRGM4BOX.h_clip_relation     = h_clip_relations.COMPARE
vertices(PRGM4BOX, 2.5)
Add(PRGM4BOX)

PRGM5BOX 					    = CreateElement "ceTexPoly"
PRGM5BOX.name 				    = "PRGM5BOX"
PRGM5BOX.material 			    = PRGM_BOX 
PRGM5BOX.change_opacity 	= false
PRGM5BOX.collimated 		= false
PRGM5BOX.isvisible 			= true
PRGM5BOX.init_pos 			= {0.85, -0.09, 0} --L-R,U-D,F-B
PRGM5BOX.init_rot 			= {0, 0, 0}
PRGM5BOX.element_params 		= {"MFD_OPACITY","RMFD_ECMS_PAGE","CMDS_PRGM_5"}--this may not be bneeded check when more pages done for backlight on page 7 SMS fc3 bs
PRGM5BOX.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.9,1.1},}--MENU PAGE = 1
PRGM5BOX.level 				= 2
PRGM5BOX.h_clip_relation     = h_clip_relations.COMPARE
vertices(PRGM5BOX, 2.5)
Add(PRGM5BOX)

PRGM6BOX 					    = CreateElement "ceTexPoly"
PRGM6BOX.name 				    = "PRGM6BOX"
PRGM6BOX.material 			    = PRGM_BOX 
PRGM6BOX.change_opacity 	= false
PRGM6BOX.collimated 		= false
PRGM6BOX.isvisible 			= true
PRGM6BOX.init_pos 			= {0.85, -0.65, 0} --L-R,U-D,F-B
PRGM6BOX.init_rot 			= {0, 0, 0}
PRGM6BOX.element_params 		= {"MFD_OPACITY","RMFD_ECMS_PAGE","CMDS_PRGM_6"}--this may not be bneeded check when more pages done for backlight on page 7 SMS fc3 bs
PRGM6BOX.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.9,1.1},}--MENU PAGE = 1
PRGM6BOX.level 				= 2
PRGM6BOX.h_clip_relation     = h_clip_relations.COMPARE
vertices(PRGM6BOX, 2.5)
Add(PRGM6BOX)