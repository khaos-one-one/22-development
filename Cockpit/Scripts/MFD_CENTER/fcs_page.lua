dofile(LockOn_Options.script_path.."MFD_CENTER/definitions.lua")
dofile(LockOn_Options.script_path.."fonts.lua")
dofile(LockOn_Options.script_path.."materials.lua")
SetScale(FOV)

local function vertices(object, height, half_or_double)
    local width = height
    
    if half_or_double == true then --
        width = 0.015 --height / 2
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
local TealColor 				= {0, 175, 175, 255}--RGBA
local ScreenColor			= {3, 3, 3, 255}--RGBA DO NOT TOUCH 3-3-12-255 is good for on screen
--------------------------------------------------------------------------------------------------------------------------------------------
local FCS_PAGE      = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/fcs_page.dds", GreenColor)
local FCS_PAGE2      = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/fcs_page_white.dds", WhiteColor)
local FCSPAGE_FLAPL      = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/fcs_left_marker.dds", WhiteColor)
local FCSPAGE_FLAPR      = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/fcs_right_marker.dds", WhiteColor)
local FCSPAGE_COG      = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/fcs_cog.dds", WhiteColor)
local FCSPAGE_TVC_NEUT      = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/fcs_tv_neutral.dds", WhiteColor)
local FCSPAGE_TVC_1      = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/fcs_tv1.dds", WhiteColor)
local FCSPAGE_TVC_2      = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/fcs_tv2.dds", WhiteColor)
local FCSPAGE_TVC_3      = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/fcs_tv3.dds", WhiteColor)
local FCSPAGE_ELEVON_NEUT      = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/fcs_le_n.dds", WhiteColor)
local FCSPAGE_ELEVON_1      = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/fcs_le1.dds", WhiteColor)
local FCSPAGE_ELEVON_2      = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/fcs_le2.dds", WhiteColor)
local FCSPAGE_ELEVON_3      = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/fcs_le3.dds", WhiteColor)
local FCSPAGE_ELEVON_4      = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/fcs_le4.dds", WhiteColor)
local FCSPAGE_ELEVON_5      = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/fcs_le5.dds", WhiteColor)
local FCSPAGE_ELEVON_6      = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/fcs_le6.dds", WhiteColor)
local FCSPAGE_AILERON_NEUT      = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/fcs_aileron_neut.dds", WhiteColor)
local FCSPAGE_AILERON_1      = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/fcs_aileron1.dds", WhiteColor)
local FCSPAGE_AILERON_2      = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/fcs_aileron2.dds", WhiteColor)
local FCSPAGE_AILERON_3      = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/fcs_aileron3.dds", WhiteColor)
local FCSPAGE_CONT      = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/fcs_control.dds", TealColor)
local FCSPAGE_CONT_PR      = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/fcs_control_pr.dds", TealColor)
local FCSPAGE_CONT_YAW      = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/fcs_control_yaw.dds", TealColor)
local FCS_IND       = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/fcs_ind.dds", WhiteColor)
local MASK_BOX	    = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mask_box.dds", ScreenColor)
local MASK_BOX_IND  = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mask_box.dds", RedColor)

local RING_NEEDLE_G   = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/ring_needle.dds", GreenColor)
local RING_RPM_G      = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/ring_egt.dds", GreenColor)
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
BGROUND                     = CreateElement "ceTexPoly"
BGROUND.name    			= "BackGround"
BGROUND.material			= MASK_BOX
BGROUND.change_opacity 		= false
BGROUND.collimated 			= false
BGROUND.isvisible 			= true
BGROUND.init_pos 			= {0, 0, 0} --L-R,U-D,F-B
BGROUND.init_rot 			= {0, 0, 0}
BGROUND.element_params 		= {"MFD_OPACITY","CMFD_FCS_PAGE"}--this may not be bneeded check when more pages done for backlight on page 7 SMS fc3 bs
BGROUND.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}--MENU PAGE = 1
BGROUND.level 				= 2
BGROUND.h_clip_relation     = h_clip_relations.COMPARE
vertices(BGROUND,3)
Add(BGROUND)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--FCS PAGE
FCSP                        = CreateElement "ceTexPoly"
FCSP.name    			    = "menu"
FCSP.material			    = FCS_PAGE
FCSP.change_opacity 		= false
FCSP.collimated 			= false
FCSP.isvisible 			    = true
FCSP.init_pos 			    = {0, 0, 0} --L-R,U-D,F-B
FCSP.init_rot 			    = {0, 0, 0}
FCSP.element_params 		= {"MFD_OPACITY","CMFD_FCS_PAGE"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
FCSP.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}--MENU PAGE = 1
FCSP.level 				    = 2
FCSP.h_clip_relation        = h_clip_relations.COMPARE
FCSP.parent_element         = BGROUND.name
vertices(FCSP,2)
Add(FCSP)

FCSP2                        = CreateElement "ceTexPoly"
FCSP2.name    			    = "FCSP2"
FCSP2.material			    = FCS_PAGE2
FCSP2.change_opacity 		= false
FCSP2.collimated 			= false
FCSP2.isvisible 			    = true
FCSP2.init_pos 			    = {0, 0, 0} --L-R,U-D,F-B
FCSP2.init_rot 			    = {0, 0, 0}
FCSP2.element_params 		= {"MFD_OPACITY","CMFD_FCS_PAGE"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
FCSP2.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}--MENU PAGE = 1
FCSP2.level 				    = 2
FCSP2.h_clip_relation        = h_clip_relations.COMPARE
FCSP2.parent_element         = BGROUND.name
vertices(FCSP2,2.25)
Add(FCSP2)

FCSFLAPL                        = CreateElement "ceTexPoly"
FCSFLAPL.name    			    = "FCSFLAPL"
FCSFLAPL.material			    = FCSPAGE_FLAPL
FCSFLAPL.change_opacity 		= false
FCSFLAPL.collimated 			= false
FCSFLAPL.isvisible 			    = true
FCSFLAPL.init_pos 			    = {0, 0, 0} --L-R,U-D,F-B
FCSFLAPL.init_rot 			    = {0, 0, 0}
FCSFLAPL.element_params 		= {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_LEF"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
FCSFLAPL.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"rotate_using_parameter",2,0.35}}--MENU PAGE = 1
FCSFLAPL.level 				    = 2
FCSFLAPL.h_clip_relation        = h_clip_relations.COMPARE
FCSFLAPL.parent_element         = BGROUND.name
vertices(FCSFLAPL,2.25)
Add(FCSFLAPL)

FCSFLAPR                        = CreateElement "ceTexPoly"
FCSFLAPR.name    			    = "FCSFLAPR"
FCSFLAPR.material			    = FCSPAGE_FLAPR
FCSFLAPR.change_opacity 		= false
FCSFLAPR.collimated 			= false
FCSFLAPR.isvisible 			    = true
FCSFLAPR.init_pos 			    = {0, 0, 0} --L-R,U-D,F-B
FCSFLAPR.init_rot 			    = {0, 0, 0}
FCSFLAPR.element_params 		= {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_LEF"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
FCSFLAPR.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"rotate_using_parameter",2,-0.35}}--MENU PAGE = 1
FCSFLAPR.level 				    = 2
FCSFLAPR.h_clip_relation        = h_clip_relations.COMPARE
FCSFLAPR.parent_element         = BGROUND.name
vertices(FCSFLAPR,2.25)
Add(FCSFLAPR)

FCSCOG                        = CreateElement "ceTexPoly"
FCSCOG.name    			    = "FCSCOG"
FCSCOG.material			    = FCSPAGE_COG
FCSCOG.change_opacity 		= false
FCSCOG.collimated 			= false
FCSCOG.isvisible 			    = true
FCSCOG.init_pos 			    = {0.24, 0.19, 0} --L-R,U-D,F-B
FCSCOG.init_rot 			    = {0, 0, 0}
FCSCOG.element_params 		= {"MFD_OPACITY","CMFD_FCS_PAGE"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
FCSCOG.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}--MENU PAGE = 1
FCSCOG.level 				    = 2
FCSCOG.h_clip_relation        = h_clip_relations.COMPARE
FCSCOG.parent_element         = BGROUND.name
vertices(FCSCOG,2.25)
Add(FCSCOG)

FCSCONT                        = CreateElement "ceTexPoly"
FCSCONT.name    			    = "FCSCONT"
FCSCONT.material			    = FCSPAGE_CONT
FCSCONT.change_opacity 		= false
FCSCONT.collimated 			= false
FCSCONT.isvisible 			    = true
FCSCONT.init_pos 			    = {0.075, 0.1, 0} --L-R,U-D,F-B
FCSCONT.init_rot 			    = {0, 0, 0}
FCSCONT.element_params 		= {"MFD_OPACITY","CMFD_FCS_PAGE"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
FCSCONT.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}--MENU PAGE = 1
FCSCONT.level 				    = 2
FCSCONT.h_clip_relation        = h_clip_relations.COMPARE
FCSCONT.parent_element         = BGROUND.name
vertices(FCSCONT,2.5)
Add(FCSCONT) 

FCSCONTPR                        = CreateElement "ceTexPoly"
FCSCONTPR.name    			    = "FCSCONTPR"
FCSCONTPR.material			    = FCSPAGE_CONT_PR
FCSCONTPR.change_opacity 		= false
FCSCONTPR.collimated 			= false
FCSCONTPR.isvisible 			    = true
FCSCONTPR.init_pos 			    = {-0.04, 0.065, 0} --L-R,U-D,F-B
FCSCONTPR.init_rot 			    = {0, 0, 0}
FCSCONTPR.element_params 		= {"MFD_OPACITY","CMFD_FCS_PAGE","STICK_PITCH","STICK_ROLL"}
FCSCONTPR.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"move_up_down_using_parameter",2,-0.014},{"move_left_right_using_parameter",3,0.014}}
FCSCONTPR.level 				    = 2
FCSCONTPR.h_clip_relation        = h_clip_relations.COMPARE
FCSCONTPR.parent_element         = BGROUND.name
vertices(FCSCONTPR,2.3)
Add(FCSCONTPR)

FCSCONTYAW                        = CreateElement "ceTexPoly"
FCSCONTYAW.name    			    = "FCSCONTYAW"
FCSCONTYAW.material			    = FCSPAGE_CONT_YAW
FCSCONTYAW.change_opacity 		= false
FCSCONTYAW.collimated 			= false
FCSCONTYAW.isvisible 			    = true
FCSCONTYAW.init_pos 			    = {-0.02, 0.1, 0} --L-R,U-D,F-B
FCSCONTYAW.init_rot 			    = {0, 0, 0}
FCSCONTYAW.element_params 		= {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_RR"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
FCSCONTYAW.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"move_left_right_using_parameter",2,-0.014}}--MENU PAGE = 1
FCSCONTYAW.level 				    = 2
FCSCONTYAW.h_clip_relation        = h_clip_relations.COMPARE
FCSCONTYAW.parent_element         = BGROUND.name
vertices(FCSCONTYAW,2.3)
Add(FCSCONTYAW)

FCSTVCNEUT                        = CreateElement "ceTexPoly"
FCSTVCNEUT.name    			    = "FCSTVCNEUT"
FCSTVCNEUT.material			    = FCSPAGE_TVC_NEUT
FCSTVCNEUT.change_opacity 		= false
FCSTVCNEUT.collimated 			= false
FCSTVCNEUT.isvisible 			    = true
FCSTVCNEUT.init_pos 			    = {0, 0, 0} --L-R,U-D,F-B
FCSTVCNEUT.init_rot 			    = {0, 0, 0}
FCSTVCNEUT.element_params 		= {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_TVC"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
FCSTVCNEUT.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-0.1,0.1}}--MENU PAGE = 1
FCSTVCNEUT.level 				    = 2
FCSTVCNEUT.h_clip_relation        = h_clip_relations.COMPARE
FCSTVCNEUT.parent_element         = BGROUND.name
vertices(FCSTVCNEUT,2.0)
Add(FCSTVCNEUT)

FCSTVCP1                        = CreateElement "ceTexPoly"
FCSTVCP1.name    			    = "FCSTVCP1"
FCSTVCP1.material			    = FCSPAGE_TVC_1
FCSTVCP1.change_opacity 		= false
FCSTVCP1.collimated 			= false
FCSTVCP1.isvisible 			    = true
FCSTVCP1.init_pos 			    = {0, 0.006, 0} --L-R,U-D,F-B
FCSTVCP1.init_rot 			    = {0, 0, 0}
FCSTVCP1.element_params 		= {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_TVC"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
FCSTVCP1.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.1,0.35}}--MENU PAGE = 1
FCSTVCP1.level 				    = 2
FCSTVCP1.h_clip_relation        = h_clip_relations.COMPARE
FCSTVCP1.parent_element         = BGROUND.name
vertices(FCSTVCP1,2.0)
Add(FCSTVCP1)

FCSTVCP2                        = CreateElement "ceTexPoly"
FCSTVCP2.name    			    = "FCSTVCP2"
FCSTVCP2.material			    = FCSPAGE_TVC_2
FCSTVCP2.change_opacity 		= false
FCSTVCP2.collimated 			= false
FCSTVCP2.isvisible 			    = true
FCSTVCP2.init_pos 			    = {0, 0.011, 0} --L-R,U-D,F-B
FCSTVCP2.init_rot 			    = {0, 0, 0}
FCSTVCP2.element_params 		= {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_TVC"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
FCSTVCP2.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.35,0.65}}--MENU PAGE = 1
FCSTVCP2.level 				    = 2
FCSTVCP2.h_clip_relation        = h_clip_relations.COMPARE
FCSTVCP2.parent_element         = BGROUND.name
vertices(FCSTVCP2,2.0)
Add(FCSTVCP2)

FCSTVCP3                        = CreateElement "ceTexPoly"
FCSTVCP3.name    			    = "FCSTVCP3"
FCSTVCP3.material			    = FCSPAGE_TVC_3
FCSTVCP3.change_opacity 		= false
FCSTVCP3.collimated 			= false
FCSTVCP3.isvisible 			    = true
FCSTVCP3.init_pos 			    = {0, 0.016, 0} --L-R,U-D,F-B
FCSTVCP3.init_rot 			    = {0, 0, 0}
FCSTVCP3.element_params 		= {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_TVC"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
FCSTVCP3.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.65,1.1}}--MENU PAGE = 1
FCSTVCP3.level 				    = 2
FCSTVCP3.h_clip_relation        = h_clip_relations.COMPARE
FCSTVCP3.parent_element         = BGROUND.name
vertices(FCSTVCP3,2.0)
Add(FCSTVCP3)

FCSTVCN1                        = CreateElement "ceTexPoly"
FCSTVCN1.name    			    = "FCSTVCN1"
FCSTVCN1.material			    = FCSPAGE_TVC_1
FCSTVCN1.change_opacity 		= false
FCSTVCN1.collimated 			= false
FCSTVCN1.isvisible 			    = true
FCSTVCN1.init_pos 			    = {0, 0, 0} --L-R,U-D,F-B
FCSTVCN1.init_rot 			    = {0, 0, 0}
FCSTVCN1.element_params 		= {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_TVC"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
FCSTVCN1.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-0.35,-0.1}}--MENU PAGE = 1
FCSTVCN1.level 				    = 2
FCSTVCN1.h_clip_relation        = h_clip_relations.COMPARE
FCSTVCN1.parent_element         = BGROUND.name
vertices(FCSTVCN1,2.0)
Add(FCSTVCN1)

FCSTVCN2                        = CreateElement "ceTexPoly"
FCSTVCN2.name    			    = "FCSTVCN2"
FCSTVCN2.material			    = FCSPAGE_TVC_2
FCSTVCN2.change_opacity 		= false
FCSTVCN2.collimated 			= false
FCSTVCN2.isvisible 			    = true
FCSTVCN2.init_pos 			    = {0, 0, 0} --L-R,U-D,F-B
FCSTVCN2.init_rot 			    = {0, 0, 0}
FCSTVCN2.element_params 		= {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_TVC"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
FCSTVCN2.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-0.65,-0.35}}--MENU PAGE = 1
FCSTVCN2.level 				    = 2
FCSTVCN2.h_clip_relation        = h_clip_relations.COMPARE
FCSTVCN2.parent_element         = BGROUND.name
vertices(FCSTVCN2,2.0)
Add(FCSTVCN2)

FCSTVCN3                        = CreateElement "ceTexPoly"
FCSTVCN3.name    			    = "FCSTVCN3"
FCSTVCN3.material			    = FCSPAGE_TVC_3
FCSTVCN3.change_opacity 		= false
FCSTVCN3.collimated 			= false
FCSTVCN3.isvisible 			    = true
FCSTVCN3.init_pos 			    = {0, 0, 0} --L-R,U-D,F-B
FCSTVCN3.init_rot 			    = {0, 0, 0}
FCSTVCN3.element_params 		= {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_TVC"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
FCSTVCN3.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-1.1,-0.65}}--MENU PAGE = 1
FCSTVCN3.level 				    = 2
FCSTVCN3.h_clip_relation        = h_clip_relations.COMPARE
FCSTVCN3.parent_element         = BGROUND.name
vertices(FCSTVCN3,2.0)
Add(FCSTVCN3)

FCSLEL_NEUT                       = CreateElement "ceTexPoly"
FCSLEL_NEUT.name    			    = "FCSLEL_NEUT"
FCSLEL_NEUT.material			    = FCSPAGE_ELEVON_NEUT
FCSLEL_NEUT.change_opacity 		= false
FCSLEL_NEUT.collimated 			= false
FCSLEL_NEUT.isvisible 			    = true
FCSLEL_NEUT.init_pos 			    = {0, 0.005, 0} --L-R,U-D,F-B
FCSLEL_NEUT.init_rot 			    = {0, 0, 0}
FCSLEL_NEUT.element_params 		= {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_LE"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
FCSLEL_NEUT.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-0.1,0.1}}--MENU PAGE = 1
FCSLEL_NEUT.level 				    = 2
FCSLEL_NEUT.h_clip_relation        = h_clip_relations.COMPARE
FCSLEL_NEUT.parent_element         = BGROUND.name
vertices(FCSLEL_NEUT,2.0)
Add(FCSLEL_NEUT)

FCSLEL_U1                       = CreateElement "ceTexPoly"
FCSLEL_U1.name    			    = "FCSLEL_U1"
FCSLEL_U1.material			    = FCSPAGE_ELEVON_1
FCSLEL_U1.change_opacity 		= false
FCSLEL_U1.collimated 			= false
FCSLEL_U1.isvisible 			    = true
FCSLEL_U1.init_pos 			    = {0, 0.005, 0} --L-R,U-D,F-B
FCSLEL_U1.init_rot 			    = {0, 0, 0}
FCSLEL_U1.element_params 		= {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_LE"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
FCSLEL_U1.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.1,0.32}}--MENU PAGE = 1
FCSLEL_U1.level 				    = 2
FCSLEL_U1.h_clip_relation        = h_clip_relations.COMPARE
FCSLEL_U1.parent_element         = BGROUND.name
vertices(FCSLEL_U1,2.0)
Add(FCSLEL_U1)

FCSLEL_U2 = CreateElement "ceTexPoly"
FCSLEL_U2.name = "FCSLEL_U2"
FCSLEL_U2.material = FCSPAGE_ELEVON_2
FCSLEL_U2.change_opacity = false
FCSLEL_U2.collimated = false
FCSLEL_U2.isvisible = true
FCSLEL_U2.init_pos = {0, 0.005, 0} --L-R,U-D,F-B
FCSLEL_U2.init_rot = {0, 0, 0}
FCSLEL_U2.element_params = {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_LE"}
FCSLEL_U2.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.32,0.476}}
FCSLEL_U2.level = 2
FCSLEL_U2.h_clip_relation = h_clip_relations.COMPARE
FCSLEL_U2.parent_element = BGROUND.name
vertices(FCSLEL_U2,2.0)
Add(FCSLEL_U2)

FCSLEL_U3 = CreateElement "ceTexPoly"
FCSLEL_U3.name = "FCSLEL_U3"
FCSLEL_U3.material = FCSPAGE_ELEVON_3
FCSLEL_U3.change_opacity = false
FCSLEL_U3.collimated = false
FCSLEL_U3.isvisible = true
FCSLEL_U3.init_pos = {0, 0.005, 0} --L-R,U-D,F-B
FCSLEL_U3.init_rot = {0, 0, 0}
FCSLEL_U3.element_params = {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_LE"}
FCSLEL_U3.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.476,0.632}}
FCSLEL_U3.level = 2
FCSLEL_U3.h_clip_relation = h_clip_relations.COMPARE
FCSLEL_U3.parent_element = BGROUND.name
vertices(FCSLEL_U3,2.0)
Add(FCSLEL_U3)

FCSLEL_U4 = CreateElement "ceTexPoly"
FCSLEL_U4.name = "FCSLEL_U4"
FCSLEL_U4.material = FCSPAGE_ELEVON_4
FCSLEL_U4.change_opacity = false
FCSLEL_U4.collimated = false
FCSLEL_U4.isvisible = true
FCSLEL_U4.init_pos = {0, 0.005, 0} --L-R,U-D,F-B
FCSLEL_U4.init_rot = {0, 0, 0}
FCSLEL_U4.element_params = {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_LE"}
FCSLEL_U4.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.632,0.788}}
FCSLEL_U4.level = 2
FCSLEL_U4.h_clip_relation = h_clip_relations.COMPARE
FCSLEL_U4.parent_element = BGROUND.name
vertices(FCSLEL_U4,2.0)
Add(FCSLEL_U4)

FCSLEL_U5 = CreateElement "ceTexPoly"
FCSLEL_U5.name = "FCSLEL_U5"
FCSLEL_U5.material = FCSPAGE_ELEVON_5
FCSLEL_U5.change_opacity = false
FCSLEL_U5.collimated = false
FCSLEL_U5.isvisible = true
FCSLEL_U5.init_pos = {0, 0.005, 0} --L-R,U-D,F-B
FCSLEL_U5.init_rot = {0, 0, 0}
FCSLEL_U5.element_params = {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_LE"}
FCSLEL_U5.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.788,0.944}}
FCSLEL_U5.level = 2
FCSLEL_U5.h_clip_relation = h_clip_relations.COMPARE
FCSLEL_U5.parent_element = BGROUND.name
vertices(FCSLEL_U5,2.0)
Add(FCSLEL_U5)

FCSLEL_U6 = CreateElement "ceTexPoly"
FCSLEL_U6.name = "FCSLEL_U6"
FCSLEL_U6.material = FCSPAGE_ELEVON_6
FCSLEL_U6.change_opacity = false
FCSLEL_U6.collimated = false
FCSLEL_U6.isvisible = true
FCSLEL_U6.init_pos = {0, 0.005, 0} --L-R,U-D,F-B
FCSLEL_U6.init_rot = {0, 0, 0}
FCSLEL_U6.element_params = {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_LE"}
FCSLEL_U6.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.944,1.1}}
FCSLEL_U6.level = 2
FCSLEL_U6.h_clip_relation = h_clip_relations.COMPARE
FCSLEL_U6.parent_element = BGROUND.name
vertices(FCSLEL_U6,2.0)
Add(FCSLEL_U6)

FCSLEL_D1                       = CreateElement "ceTexPoly"
FCSLEL_D1.name    			    = "FCSLEL_D1"
FCSLEL_D1.material			    = FCSPAGE_ELEVON_1
FCSLEL_D1.change_opacity 		= false
FCSLEL_D1.collimated 			= false
FCSLEL_D1.isvisible 			    = true
FCSLEL_D1.init_pos 			    = {0, -0.01, 0} --L-R,U-D,F-B
FCSLEL_D1.init_rot 			    = {0, 0, 0}
FCSLEL_D1.element_params 		= {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_LE"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
FCSLEL_D1.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-0.32,-0.1}}--MENU PAGE = 1
FCSLEL_D1.level 				    = 2
FCSLEL_D1.h_clip_relation        = h_clip_relations.COMPARE
FCSLEL_D1.parent_element         = BGROUND.name
vertices(FCSLEL_D1,2.0)
Add(FCSLEL_D1)

FCSLEL_D2 = CreateElement "ceTexPoly"
FCSLEL_D2.name = "FCSLEL_D2"
FCSLEL_D2.material = FCSPAGE_ELEVON_2
FCSLEL_D2.change_opacity = false
FCSLEL_D2.collimated = false
FCSLEL_D2.isvisible = true
FCSLEL_D2.init_pos = {0, -0.021, 0} --L-R,U-D,F-B
FCSLEL_D2.init_rot = {0, 0, 0}
FCSLEL_D2.element_params = {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_LE"}
FCSLEL_D2.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-0.476,-0.32}}
FCSLEL_D2.level = 2
FCSLEL_D2.h_clip_relation = h_clip_relations.COMPARE
FCSLEL_D2.parent_element = BGROUND.name
vertices(FCSLEL_D2,2.0)
Add(FCSLEL_D2)

FCSLEL_D3 = CreateElement "ceTexPoly"
FCSLEL_D3.name = "FCSLEL_D3"
FCSLEL_D3.material = FCSPAGE_ELEVON_3
FCSLEL_D3.change_opacity = false
FCSLEL_D3.collimated = false
FCSLEL_D3.isvisible = true
FCSLEL_D3.init_pos = {0, -0.031, 0} --L-R,U-D,F-B
FCSLEL_D3.init_rot = {0, 0, 0}
FCSLEL_D3.element_params = {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_LE"}
FCSLEL_D3.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-0.632,-0.476}}
FCSLEL_D3.level = 2
FCSLEL_D3.h_clip_relation = h_clip_relations.COMPARE
FCSLEL_D3.parent_element = BGROUND.name
vertices(FCSLEL_D3,2.0)
Add(FCSLEL_D3)

FCSLEL_D4 = CreateElement "ceTexPoly"
FCSLEL_D4.name = "FCSLEL_D4"
FCSLEL_D4.material = FCSPAGE_ELEVON_4
FCSLEL_D4.change_opacity = false
FCSLEL_D4.collimated = false
FCSLEL_D4.isvisible = true
FCSLEL_D4.init_pos = {0, -0.042, 0} --L-R,U-D,F-B
FCSLEL_D4.init_rot = {0, 0, 0}
FCSLEL_D4.element_params = {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_LE"}
FCSLEL_D4.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-0.788,-0.632}}
FCSLEL_D4.level = 2
FCSLEL_D4.h_clip_relation = h_clip_relations.COMPARE
FCSLEL_D4.parent_element = BGROUND.name
vertices(FCSLEL_D4,2.0)
Add(FCSLEL_D4)

FCSLEL_D5 = CreateElement "ceTexPoly"
FCSLEL_D5.name = "FCSLEL_D5"
FCSLEL_D5.material = FCSPAGE_ELEVON_5
FCSLEL_D5.change_opacity = false
FCSLEL_D5.collimated = false
FCSLEL_D5.isvisible = true
FCSLEL_D5.init_pos = {0, -0.053, 0} --L-R,U-D,F-B
FCSLEL_D5.init_rot = {0, 0, 0}
FCSLEL_D5.element_params = {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_LE"}
FCSLEL_D5.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-0.944,-0.788}}
FCSLEL_D5.level = 2
FCSLEL_D5.h_clip_relation = h_clip_relations.COMPARE
FCSLEL_D5.parent_element = BGROUND.name
vertices(FCSLEL_D5,2.0)
Add(FCSLEL_D5)

FCSLEL_D6 = CreateElement "ceTexPoly"
FCSLEL_D6.name = "FCSLEL_D6"
FCSLEL_D6.material = FCSPAGE_ELEVON_6
FCSLEL_D6.change_opacity = false
FCSLEL_D6.collimated = false
FCSLEL_D6.isvisible = true
FCSLEL_D6.init_pos = {0, -0.064, 0} --L-R,U-D,F-B
FCSLEL_D6.init_rot = {0, 0, 0}
FCSLEL_D6.element_params = {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_LE"}
FCSLEL_D6.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-1.1,-0.944}}
FCSLEL_D6.level = 2
FCSLEL_D6.h_clip_relation = h_clip_relations.COMPARE
FCSLEL_D6.parent_element = BGROUND.name
vertices(FCSLEL_D6,2.0)
Add(FCSLEL_D6)


FCSREL_NEUT                       = CreateElement "ceTexPoly"
FCSREL_NEUT.name    			    = "FCSREL_NEUT"
FCSREL_NEUT.material			    = FCSPAGE_ELEVON_NEUT
FCSREL_NEUT.change_opacity 		= false
FCSREL_NEUT.collimated 			= false
FCSREL_NEUT.isvisible 			    = true
FCSREL_NEUT.init_pos 			    = {0.54, 0.005, 0} --L-R,U-D,F-B
FCSREL_NEUT.init_rot 			    = {0, 0, 0}
FCSREL_NEUT.element_params 		= {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_RE"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
FCSREL_NEUT.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-0.1,0.1}}--MENU PAGE = 1
FCSREL_NEUT.level 				    = 2
FCSREL_NEUT.h_clip_relation        = h_clip_relations.COMPARE
FCSREL_NEUT.parent_element         = BGROUND.name
vertices(FCSREL_NEUT,2.0)
Add(FCSREL_NEUT)

FCSREL_U1                       = CreateElement "ceTexPoly"
FCSREL_U1.name    			    = "FCSREL_U1"
FCSREL_U1.material			    = FCSPAGE_ELEVON_1
FCSREL_U1.change_opacity 		= false
FCSREL_U1.collimated 			= false
FCSREL_U1.isvisible 			    = true
FCSREL_U1.init_pos 			    = {0.54, 0.005, 0} --L-R,U-D,F-B
FCSREL_U1.init_rot 			    = {0, 0, 0}
FCSREL_U1.element_params 		= {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_RE"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
FCSREL_U1.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.1,0.32}}--MENU PAGE = 1
FCSREL_U1.level 				    = 2
FCSREL_U1.h_clip_relation        = h_clip_relations.COMPARE
FCSREL_U1.parent_element         = BGROUND.name
vertices(FCSREL_U1,2.0)
Add(FCSREL_U1)

FCSREL_U2 = CreateElement "ceTexPoly"
FCSREL_U2.name = "FCSREL_U2"
FCSREL_U2.material = FCSPAGE_ELEVON_2
FCSREL_U2.change_opacity = false
FCSREL_U2.collimated = false
FCSREL_U2.isvisible = true
FCSREL_U2.init_pos = {0.54, 0.005, 0} --L-R,U-D,F-B
FCSREL_U2.init_rot = {0, 0, 0}
FCSREL_U2.element_params = {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_RE"}
FCSREL_U2.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.32,0.476}}
FCSREL_U2.level = 2
FCSREL_U2.h_clip_relation = h_clip_relations.COMPARE
FCSREL_U2.parent_element = BGROUND.name
vertices(FCSREL_U2,2.0)
Add(FCSREL_U2)

FCSREL_U3 = CreateElement "ceTexPoly"
FCSREL_U3.name = "FCSREL_U3"
FCSREL_U3.material = FCSPAGE_ELEVON_3
FCSREL_U3.change_opacity = false
FCSREL_U3.collimated = false
FCSREL_U3.isvisible = true
FCSREL_U3.init_pos = {0.54, 0.005, 0} --L-R,U-D,F-B
FCSREL_U3.init_rot = {0, 0, 0}
FCSREL_U3.element_params = {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_RE"}
FCSREL_U3.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.476,0.632}}
FCSREL_U3.level = 2
FCSREL_U3.h_clip_relation = h_clip_relations.COMPARE
FCSREL_U3.parent_element = BGROUND.name
vertices(FCSREL_U3,2.0)
Add(FCSREL_U3)

FCSREL_U4 = CreateElement "ceTexPoly"
FCSREL_U4.name = "FCSREL_U4"
FCSREL_U4.material = FCSPAGE_ELEVON_4
FCSREL_U4.change_opacity = false
FCSREL_U4.collimated = false
FCSREL_U4.isvisible = true
FCSREL_U4.init_pos = {0.54, 0.005, 0} --L-R,U-D,F-B
FCSREL_U4.init_rot = {0, 0, 0}
FCSREL_U4.element_params = {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_RE"}
FCSREL_U4.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.632,0.788}}
FCSREL_U4.level = 2
FCSREL_U4.h_clip_relation = h_clip_relations.COMPARE
FCSREL_U4.parent_element = BGROUND.name
vertices(FCSREL_U4,2.0)
Add(FCSREL_U4)

FCSREL_U5 = CreateElement "ceTexPoly"
FCSREL_U5.name = "FCSREL_U5"
FCSREL_U5.material = FCSPAGE_ELEVON_5
FCSREL_U5.change_opacity = false
FCSREL_U5.collimated = false
FCSREL_U5.isvisible = true
FCSREL_U5.init_pos = {0.54, 0.005, 0} --L-R,U-D,F-B
FCSREL_U5.init_rot = {0, 0, 0}
FCSREL_U5.element_params = {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_RE"}
FCSREL_U5.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.788,0.944}}
FCSREL_U5.level = 2
FCSREL_U5.h_clip_relation = h_clip_relations.COMPARE
FCSREL_U5.parent_element = BGROUND.name
vertices(FCSREL_U5,2.0)
Add(FCSREL_U5)

FCSREL_U6 = CreateElement "ceTexPoly"
FCSREL_U6.name = "FCSREL_U6"
FCSREL_U6.material = FCSPAGE_ELEVON_6
FCSREL_U6.change_opacity = false
FCSREL_U6.collimated = false
FCSREL_U6.isvisible = true
FCSREL_U6.init_pos = {0.54, 0.005, 0} --L-R,U-D,F-B
FCSREL_U6.init_rot = {0, 0, 0}
FCSREL_U6.element_params = {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_RE"}
FCSREL_U6.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.944,1.1}}
FCSREL_U6.level = 2
FCSREL_U6.h_clip_relation = h_clip_relations.COMPARE
FCSREL_U6.parent_element = BGROUND.name
vertices(FCSREL_U6,2.0)
Add(FCSREL_U6)

FCSREL_D1                       = CreateElement "ceTexPoly"
FCSREL_D1.name    			    = "FCSREL_D1"
FCSREL_D1.material			    = FCSPAGE_ELEVON_1
FCSREL_D1.change_opacity 		= false
FCSREL_D1.collimated 			= false
FCSREL_D1.isvisible 			    = true
FCSREL_D1.init_pos 			    = {0.54, -0.01, 0} --L-R,U-D,F-B
FCSREL_D1.init_rot 			    = {0, 0, 0}
FCSREL_D1.element_params 		= {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_RE"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
FCSREL_D1.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-0.32,-0.1}}--MENU PAGE = 1
FCSREL_D1.level 				    = 2
FCSREL_D1.h_clip_relation        = h_clip_relations.COMPARE
FCSREL_D1.parent_element         = BGROUND.name
vertices(FCSREL_D1,2.0)
Add(FCSREL_D1)

FCSREL_D2 = CreateElement "ceTexPoly"
FCSREL_D2.name = "FCSREL_D2"
FCSREL_D2.material = FCSPAGE_ELEVON_2
FCSREL_D2.change_opacity = false
FCSREL_D2.collimated = false
FCSREL_D2.isvisible = true
FCSREL_D2.init_pos = {0.54, -0.021, 0} --L-R,U-D,F-B
FCSREL_D2.init_rot = {0, 0, 0}
FCSREL_D2.element_params = {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_RE"}
FCSREL_D2.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-0.476,-0.32}}
FCSREL_D2.level = 2
FCSREL_D2.h_clip_relation = h_clip_relations.COMPARE
FCSREL_D2.parent_element = BGROUND.name
vertices(FCSREL_D2,2.0)
Add(FCSREL_D2)

FCSREL_D3 = CreateElement "ceTexPoly"
FCSREL_D3.name = "FCSREL_D3"
FCSREL_D3.material = FCSPAGE_ELEVON_3
FCSREL_D3.change_opacity = false
FCSREL_D3.collimated = false
FCSREL_D3.isvisible = true
FCSREL_D3.init_pos = {0.54, -0.031, 0} --L-R,U-D,F-B
FCSREL_D3.init_rot = {0, 0, 0}
FCSREL_D3.element_params = {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_RE"}
FCSREL_D3.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-0.632,-0.476}}
FCSREL_D3.level = 2
FCSREL_D3.h_clip_relation = h_clip_relations.COMPARE
FCSREL_D3.parent_element = BGROUND.name
vertices(FCSREL_D3,2.0)
Add(FCSREL_D3)

FCSREL_D4 = CreateElement "ceTexPoly"
FCSREL_D4.name = "FCSREL_D4"
FCSREL_D4.material = FCSPAGE_ELEVON_4
FCSREL_D4.change_opacity = false
FCSREL_D4.collimated = false
FCSREL_D4.isvisible = true
FCSREL_D4.init_pos = {0.54, -0.042, 0} --L-R,U-D,F-B
FCSREL_D4.init_rot = {0, 0, 0}
FCSREL_D4.element_params = {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_RE"}
FCSREL_D4.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-0.788,-0.632}}
FCSREL_D4.level = 2
FCSREL_D4.h_clip_relation = h_clip_relations.COMPARE
FCSREL_D4.parent_element = BGROUND.name
vertices(FCSREL_D4,2.0)
Add(FCSREL_D4)

FCSREL_D5 = CreateElement "ceTexPoly"
FCSREL_D5.name = "FCSREL_D5"
FCSREL_D5.material = FCSPAGE_ELEVON_5
FCSREL_D5.change_opacity = false
FCSREL_D5.collimated = false
FCSREL_D5.isvisible = true
FCSREL_D5.init_pos = {0.54, -0.053, 0} --L-R,U-D,F-B
FCSREL_D5.init_rot = {0, 0, 0}
FCSREL_D5.element_params = {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_RE"}
FCSREL_D5.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-0.944,-0.788}}
FCSREL_D5.level = 2
FCSREL_D5.h_clip_relation = h_clip_relations.COMPARE
FCSREL_D5.parent_element = BGROUND.name
vertices(FCSREL_D5,2.0)
Add(FCSREL_D5)

FCSREL_D6 = CreateElement "ceTexPoly"
FCSREL_D6.name = "FCSREL_D6"
FCSREL_D6.material = FCSPAGE_ELEVON_6
FCSREL_D6.change_opacity = false
FCSREL_D6.collimated = false
FCSREL_D6.isvisible = true
FCSREL_D6.init_pos = {0.54, -0.064, 0} --L-R,U-D,F-B
FCSREL_D6.init_rot = {0, 0, 0}
FCSREL_D6.element_params = {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_RE"}
FCSREL_D6.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-1.1,-0.944}}
FCSREL_D6.level = 2
FCSREL_D6.h_clip_relation = h_clip_relations.COMPARE
FCSREL_D6.parent_element = BGROUND.name
vertices(FCSREL_D6,2.0)
Add(FCSREL_D6)

FCSAILL_NEU = CreateElement "ceTexPoly"
FCSAILL_NEU.name = "FCSAILL_NEU"
FCSAILL_NEU.material = FCSPAGE_AILERON_NEUT
FCSAILL_NEU.change_opacity = false
FCSAILL_NEU.collimated = false
FCSAILL_NEU.isvisible = true
FCSAILL_NEU.init_pos = {0, 0, 0} --L-R,U-D,F-B
FCSAILL_NEU.init_rot = {0, 0, 0}
FCSAILL_NEU.element_params = {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_LA"}
FCSAILL_NEU.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-0.1,0.1}}
FCSAILL_NEU.level = 2
FCSAILL_NEU.h_clip_relation = h_clip_relations.COMPARE
FCSAILL_NEU.parent_element = BGROUND.name
vertices(FCSAILL_NEU,2.0)
Add(FCSAILL_NEU)

FCSAILL_U1 = CreateElement "ceTexPoly"
FCSAILL_U1.name = "FCSAILL_U1"
FCSAILL_U1.material = FCSPAGE_AILERON_1
FCSAILL_U1.change_opacity = false
FCSAILL_U1.collimated = false
FCSAILL_U1.isvisible = true
FCSAILL_U1.init_pos = {0, 0, 0} --L-R,U-D,F-B
FCSAILL_U1.init_rot = {0, 0, 0}
FCSAILL_U1.element_params = {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_LA"}
FCSAILL_U1.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.1,0.35}}
FCSAILL_U1.level = 2
FCSAILL_U1.h_clip_relation = h_clip_relations.COMPARE
FCSAILL_U1.parent_element = BGROUND.name
vertices(FCSAILL_U1,2.0)
Add(FCSAILL_U1)

FCSAILL_U2 = CreateElement "ceTexPoly"
FCSAILL_U2.name = "FCSAILL_U2"
FCSAILL_U2.material = FCSPAGE_AILERON_2
FCSAILL_U2.change_opacity = false
FCSAILL_U2.collimated = false
FCSAILL_U2.isvisible = true
FCSAILL_U2.init_pos = {0, 0, 0} --L-R,U-D,F-B
FCSAILL_U2.init_rot = {0, 0, 0}
FCSAILL_U2.element_params = {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_LA"}
FCSAILL_U2.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.35,0.70}}
FCSAILL_U2.level = 2
FCSAILL_U2.h_clip_relation = h_clip_relations.COMPARE
FCSAILL_U2.parent_element = BGROUND.name
vertices(FCSAILL_U2,2.0)
Add(FCSAILL_U2)

FCSAILL_U3 = CreateElement "ceTexPoly"
FCSAILL_U3.name = "FCSAILL_U3"
FCSAILL_U3.material = FCSPAGE_AILERON_3
FCSAILL_U3.change_opacity = false
FCSAILL_U3.collimated = false
FCSAILL_U3.isvisible = true
FCSAILL_U3.init_pos = {0, 0, 0} --L-R,U-D,F-B
FCSAILL_U3.init_rot = {0, 0, 0}
FCSAILL_U3.element_params = {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_LA"}
FCSAILL_U3.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.70,1.1}}
FCSAILL_U3.level = 2
FCSAILL_U3.h_clip_relation = h_clip_relations.COMPARE
FCSAILL_U3.parent_element = BGROUND.name
vertices(FCSAILL_U3,2.0)
Add(FCSAILL_U3)

FCSAILL_D1 = CreateElement "ceTexPoly"
FCSAILL_D1.name = "FCSAILL_D1"
FCSAILL_D1.material = FCSPAGE_AILERON_1
FCSAILL_D1.change_opacity = false
FCSAILL_D1.collimated = false
FCSAILL_D1.isvisible = true
FCSAILL_D1.init_pos = {0, -0.015, 0} --L-R,U-D,F-B
FCSAILL_D1.init_rot = {0, 0, 0}
FCSAILL_D1.element_params = {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_LA"}
FCSAILL_D1.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-0.35,-0.1}}
FCSAILL_D1.level = 2
FCSAILL_D1.h_clip_relation = h_clip_relations.COMPARE
FCSAILL_D1.parent_element = BGROUND.name
vertices(FCSAILL_D1,2.0)
Add(FCSAILL_D1)

FCSAILL_D2 = CreateElement "ceTexPoly"
FCSAILL_D2.name = "FCSAILL_D2"
FCSAILL_D2.material = FCSPAGE_AILERON_2
FCSAILL_D2.change_opacity = false
FCSAILL_D2.collimated = false
FCSAILL_D2.isvisible = true
FCSAILL_D2.init_pos = {0, -0.025, 0} --L-R,U-D,F-B
FCSAILL_D2.init_rot = {0, 0, 0}
FCSAILL_D2.element_params = {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_LA"}
FCSAILL_D2.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-0.70,-0.35}}
FCSAILL_D2.level = 2
FCSAILL_D2.h_clip_relation = h_clip_relations.COMPARE
FCSAILL_D2.parent_element = BGROUND.name
vertices(FCSAILL_D2,2.0)
Add(FCSAILL_D2)

FCSAILL_D3 = CreateElement "ceTexPoly"
FCSAILL_D3.name = "FCSAILL_D3"
FCSAILL_D3.material = FCSPAGE_AILERON_3
FCSAILL_D3.change_opacity = false
FCSAILL_D3.collimated = false
FCSAILL_D3.isvisible = true
FCSAILL_D3.init_pos = {0, -0.035, 0} --L-R,U-D,F-B
FCSAILL_D3.init_rot = {0, 0, 0}
FCSAILL_D3.element_params = {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_LA"}
FCSAILL_D3.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-1.1,-0.70}}
FCSAILL_D3.level = 2
FCSAILL_D3.h_clip_relation = h_clip_relations.COMPARE
FCSAILL_D3.parent_element = BGROUND.name
vertices(FCSAILL_D3,2.0)
Add(FCSAILL_D3)

FCSAILR_NEU = CreateElement "ceTexPoly"
FCSAILR_NEU.name = "FCSAILR_NEU"
FCSAILR_NEU.material = FCSPAGE_AILERON_NEUT
FCSAILR_NEU.change_opacity = false
FCSAILR_NEU.collimated = false
FCSAILR_NEU.isvisible = true
FCSAILR_NEU.init_pos = {1.41, 0, 0} --L-R,U-D,F-B
FCSAILR_NEU.init_rot = {0, 0, 0}
FCSAILR_NEU.element_params = {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_RA"}
FCSAILR_NEU.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-0.1,0.1}}
FCSAILR_NEU.level = 2
FCSAILR_NEU.h_clip_relation = h_clip_relations.COMPARE
FCSAILR_NEU.parent_element = BGROUND.name
vertices(FCSAILR_NEU,2.0)
Add(FCSAILR_NEU)



FCSAILR_U1 = CreateElement "ceTexPoly"
FCSAILR_U1.name = "FCSAILR_U1"
FCSAILR_U1.material = FCSPAGE_AILERON_1
FCSAILR_U1.change_opacity = false
FCSAILR_U1.collimated = false
FCSAILR_U1.isvisible = true
FCSAILR_U1.init_pos = {1.41, 0, 0} --L-R,U-D,F-B
FCSAILR_U1.init_rot = {0, 0, 0}
FCSAILR_U1.element_params = {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_RA"}
FCSAILR_U1.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.1,0.35}}
FCSAILR_U1.level = 2
FCSAILR_U1.h_clip_relation = h_clip_relations.COMPARE
FCSAILR_U1.parent_element = BGROUND.name
vertices(FCSAILR_U1,2.0)
Add(FCSAILR_U1)

FCSAILR_U2 = CreateElement "ceTexPoly"
FCSAILR_U2.name = "FCSAILR_U2"
FCSAILR_U2.material = FCSPAGE_AILERON_2
FCSAILR_U2.change_opacity = false
FCSAILR_U2.collimated = false
FCSAILR_U2.isvisible = true
FCSAILR_U2.init_pos = {1.41, 0, 0} --L-R,U-D,F-B
FCSAILR_U2.init_rot = {0, 0, 0}
FCSAILR_U2.element_params = {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_RA"}
FCSAILR_U2.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.35,0.70}}
FCSAILR_U2.level = 2
FCSAILR_U2.h_clip_relation = h_clip_relations.COMPARE
FCSAILR_U2.parent_element = BGROUND.name
vertices(FCSAILR_U2,2.0)
Add(FCSAILR_U2)

FCSAILR_U3 = CreateElement "ceTexPoly"
FCSAILR_U3.name = "FCSAILR_U3"
FCSAILR_U3.material = FCSPAGE_AILERON_3
FCSAILR_U3.change_opacity = false
FCSAILR_U3.collimated = false
FCSAILR_U3.isvisible = true
FCSAILR_U3.init_pos = {1.41, 0, 0} --L-R,U-D,F-B
FCSAILR_U3.init_rot = {0, 0, 0}
FCSAILR_U3.element_params = {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_RA"}
FCSAILR_U3.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.70,1.1}}
FCSAILR_U3.level = 2
FCSAILR_U3.h_clip_relation = h_clip_relations.COMPARE
FCSAILR_U3.parent_element = BGROUND.name
vertices(FCSAILR_U3,2.0)
Add(FCSAILR_U3)

FCSAILR_D1 = CreateElement "ceTexPoly"
FCSAILR_D1.name = "FCSAILR_D1"
FCSAILR_D1.material = FCSPAGE_AILERON_1
FCSAILR_D1.change_opacity = false
FCSAILR_D1.collimated = false
FCSAILR_D1.isvisible = true
FCSAILR_D1.init_pos = {1.41, -0.015, 0} --L-R,U-D,F-B
FCSAILR_D1.init_rot = {0, 0, 0}
FCSAILR_D1.element_params = {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_RA"}
FCSAILR_D1.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-0.35,-0.1}}
FCSAILR_D1.level = 2
FCSAILR_D1.h_clip_relation = h_clip_relations.COMPARE
FCSAILR_D1.parent_element = BGROUND.name
vertices(FCSAILR_D1,2.0)
Add(FCSAILR_D1)

FCSAILR_D2 = CreateElement "ceTexPoly"
FCSAILR_D2.name = "FCSAILR_D2"
FCSAILR_D2.material = FCSPAGE_AILERON_2
FCSAILR_D2.change_opacity = false
FCSAILR_D2.collimated = false
FCSAILR_D2.isvisible = true
FCSAILR_D2.init_pos = {1.41, -0.025, 0} --L-R,U-D,F-B
FCSAILR_D2.init_rot = {0, 0, 0}
FCSAILR_D2.element_params = {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_RA"}
FCSAILR_D2.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-0.70,-0.35}}
FCSAILR_D2.level = 2
FCSAILR_D2.h_clip_relation = h_clip_relations.COMPARE
FCSAILR_D2.parent_element = BGROUND.name
vertices(FCSAILR_D2,2.0)
Add(FCSAILR_D2)

FCSAILR_D3 = CreateElement "ceTexPoly"
FCSAILR_D3.name = "FCSAILR_D3"
FCSAILR_D3.material = FCSPAGE_AILERON_3
FCSAILR_D3.change_opacity = false
FCSAILR_D3.collimated = false
FCSAILR_D3.isvisible = true
FCSAILR_D3.init_pos = {1.41, -0.035, 0} --L-R,U-D,F-B
FCSAILR_D3.init_rot = {0, 0, 0}
FCSAILR_D3.element_params = {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_RA"}
FCSAILR_D3.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-1.1,-0.70}}
FCSAILR_D3.level = 2
FCSAILR_D3.h_clip_relation = h_clip_relations.COMPARE
FCSAILR_D3.parent_element = BGROUND.name
vertices(FCSAILR_D3,2.0)
Add(FCSAILR_D3)



FCSRUDL_NEUT                       = CreateElement "ceTexPoly"
FCSRUDL_NEUT.name    			    = "FCSRUDL_NEUT"
FCSRUDL_NEUT.material			    = FCSPAGE_ELEVON_NEUT
FCSRUDL_NEUT.change_opacity 		= false
FCSRUDL_NEUT.collimated 			= false
FCSRUDL_NEUT.isvisible 			    = true
FCSRUDL_NEUT.init_pos 			    = {-0.27, 0.2, 0} --L-R,U-D,F-B
FCSRUDL_NEUT.init_rot 			    = {-41, 0, 0}
FCSRUDL_NEUT.element_params 		= {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_LR"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
FCSRUDL_NEUT.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-0.1,0.1}}--MENU PAGE = 1
FCSRUDL_NEUT.level 				    = 2
FCSRUDL_NEUT.h_clip_relation        = h_clip_relations.COMPARE
FCSRUDL_NEUT.parent_element         = BGROUND.name
vertices(FCSRUDL_NEUT,2.0)
Add(FCSRUDL_NEUT)





FCSRUDL_P1                       = CreateElement "ceTexPoly"
FCSRUDL_P1.name    			    = "FCSRUDL_P1"
FCSRUDL_P1.material			    = FCSPAGE_ELEVON_1
FCSRUDL_P1.change_opacity 		= false
FCSRUDL_P1.collimated 			= false
FCSRUDL_P1.isvisible 			    = true
FCSRUDL_P1.init_pos 			    = {-0.27, 0.2, 0} --L-R,U-D,F-B
FCSRUDL_P1.init_rot 			    = {-41, 0, 0}
FCSRUDL_P1.element_params 		= {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_LR"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
FCSRUDL_P1.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.1,0.35}}--MENU PAGE = 1
FCSRUDL_P1.level 				    = 2
FCSRUDL_P1.h_clip_relation        = h_clip_relations.COMPARE
FCSRUDL_P1.parent_element         = BGROUND.name
vertices(FCSRUDL_P1,2.0)
Add(FCSRUDL_P1)

FCSRUDL_P2                       = CreateElement "ceTexPoly"
FCSRUDL_P2.name    			    = "FCSRUDL_P2"
FCSRUDL_P2.material			    = FCSPAGE_ELEVON_2
FCSRUDL_P2.change_opacity 		= false
FCSRUDL_P2.collimated 			= false
FCSRUDL_P2.isvisible 			    = true
FCSRUDL_P2.init_pos 			    = {-0.27, 0.2, 0} --L-R,U-D,F-B
FCSRUDL_P2.init_rot 			    = {-41, 0, 0}
FCSRUDL_P2.element_params 		= {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_LR"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
FCSRUDL_P2.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.35,0.7}}--MENU PAGE = 1
FCSRUDL_P2.level 				    = 2
FCSRUDL_P2.h_clip_relation        = h_clip_relations.COMPARE
FCSRUDL_P2.parent_element         = BGROUND.name
vertices(FCSRUDL_P2,2.0)
Add(FCSRUDL_P2)

FCSRUDL_P3                       = CreateElement "ceTexPoly"
FCSRUDL_P3.name    			    = "FCSRUDL_P3"
FCSRUDL_P3.material			    = FCSPAGE_ELEVON_3
FCSRUDL_P3.change_opacity 		= false
FCSRUDL_P3.collimated 			= false
FCSRUDL_P3.isvisible 			    = true
FCSRUDL_P3.init_pos 			    = {-0.27, 0.2, 0} --L-R,U-D,F-B
FCSRUDL_P3.init_rot 			    = {-41, 0, 0}
FCSRUDL_P3.element_params 		= {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_LR"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
FCSRUDL_P3.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.7,1.1}}--MENU PAGE = 1
FCSRUDL_P3.level 				    = 2
FCSRUDL_P3.h_clip_relation        = h_clip_relations.COMPARE
FCSRUDL_P3.parent_element         = BGROUND.name
vertices(FCSRUDL_P3,2.0)
Add(FCSRUDL_P3)

FCSRUDL_N1                       = CreateElement "ceTexPoly"
FCSRUDL_N1.name    			    = "FCSRUDL_N1"
FCSRUDL_N1.material			    = FCSPAGE_ELEVON_1
FCSRUDL_N1.change_opacity 		= false
FCSRUDL_N1.collimated 			= false
FCSRUDL_N1.isvisible 			    = true
FCSRUDL_N1.init_pos 			    = {-0.279, 0.189, 0} --L-R,U-D,F-B
FCSRUDL_N1.init_rot 			    = {-41, 0, 0}
FCSRUDL_N1.element_params 		= {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_LR"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
FCSRUDL_N1.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-0.35,-0.1}}--MENU PAGE = 1
FCSRUDL_N1.level 				    = 2
FCSRUDL_N1.h_clip_relation        = h_clip_relations.COMPARE
FCSRUDL_N1.parent_element         = BGROUND.name
vertices(FCSRUDL_N1,2.0)
Add(FCSRUDL_N1)

FCSRUDL_N2                       = CreateElement "ceTexPoly"
FCSRUDL_N2.name    			    = "FCSRUDL_N2"
FCSRUDL_N2.material			    = FCSPAGE_ELEVON_2
FCSRUDL_N2.change_opacity 		= false
FCSRUDL_N2.collimated 			= false
FCSRUDL_N2.isvisible 			    = true
FCSRUDL_N2.init_pos 			    = {-0.285, 0.182, 0} --L-R,U-D,F-B
FCSRUDL_N2.init_rot 			    = {-41, 0, 0}
FCSRUDL_N2.element_params 		= {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_LR"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
FCSRUDL_N2.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-0.7,-0.35}}--MENU PAGE = 1
FCSRUDL_N2.level 				    = 2
FCSRUDL_N2.h_clip_relation        = h_clip_relations.COMPARE
FCSRUDL_N2.parent_element         = BGROUND.name
vertices(FCSRUDL_N2,2.0)
Add(FCSRUDL_N2)

FCSRUDL_N3                       = CreateElement "ceTexPoly"
FCSRUDL_N3.name    			    = "FCSRUDL_N3"
FCSRUDL_N3.material			    = FCSPAGE_ELEVON_3
FCSRUDL_N3.change_opacity 		= false
FCSRUDL_N3.collimated 			= false
FCSRUDL_N3.isvisible 			    = true
FCSRUDL_N3.init_pos 			    = {-0.292, 0.175, 0} --L-R,U-D,F-B
FCSRUDL_N3.init_rot 			    = {-41, 0, 0}
FCSRUDL_N3.element_params 		= {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_LR"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
FCSRUDL_N3.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-1.1,-0.7}}--MENU PAGE = 1
FCSRUDL_N3.level 				    = 2
FCSRUDL_N3.h_clip_relation        = h_clip_relations.COMPARE
FCSRUDL_N3.parent_element         = BGROUND.name
vertices(FCSRUDL_N3,2.0)
Add(FCSRUDL_N3)




FCSRUDR_NEUT                       = CreateElement "ceTexPoly"
FCSRUDR_NEUT.name    			    = "FCSRUDR_NEUT"
FCSRUDR_NEUT.material			    = FCSPAGE_ELEVON_NEUT
FCSRUDR_NEUT.change_opacity 		= false
FCSRUDR_NEUT.collimated 			= false
FCSRUDR_NEUT.isvisible 			    = true
FCSRUDR_NEUT.init_pos 			    = {0.70, 0.53, 0} --L-R,U-D,F-B
FCSRUDR_NEUT.init_rot 			    = {40, 0, 0}
FCSRUDR_NEUT.element_params 		= {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_RR"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
FCSRUDR_NEUT.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-0.1,0.1}}--MENU PAGE = 1
FCSRUDR_NEUT.level 				    = 2
FCSRUDR_NEUT.h_clip_relation        = h_clip_relations.COMPARE
FCSRUDR_NEUT.parent_element         = BGROUND.name
vertices(FCSRUDR_NEUT,2.0)
Add(FCSRUDR_NEUT)

FCSRUDR_P1                       = CreateElement "ceTexPoly"
FCSRUDR_P1.name    			    = "FCSRUDR_P1"
FCSRUDR_P1.material			    = FCSPAGE_ELEVON_1
FCSRUDR_P1.change_opacity 		= false
FCSRUDR_P1.collimated 			= false
FCSRUDR_P1.isvisible 			    = true
FCSRUDR_P1.init_pos 			    = {0.71, 0.52, 0} --L-R,U-D,F-B
FCSRUDR_P1.init_rot 			    = {40, 0, 0}
FCSRUDR_P1.element_params 		= {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_LR"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
FCSRUDR_P1.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.1,0.35}}--MENU PAGE = 1
FCSRUDR_P1.level 				    = 2
FCSRUDR_P1.h_clip_relation        = h_clip_relations.COMPARE
FCSRUDR_P1.parent_element         = BGROUND.name
vertices(FCSRUDR_P1,2.0)
Add(FCSRUDR_P1)

FCSRUDR_P2                       = CreateElement "ceTexPoly"
FCSRUDR_P2.name    			    = "FCSRUDR_P2"
FCSRUDR_P2.material			    = FCSPAGE_ELEVON_2
FCSRUDR_P2.change_opacity 		= false
FCSRUDR_P2.collimated 			= false
FCSRUDR_P2.isvisible 			    = true
FCSRUDR_P2.init_pos 			    = {0.715, 0.513, 0} --L-R,U-D,F-B
FCSRUDR_P2.init_rot 			    = {40, 0, 0}
FCSRUDR_P2.element_params 		= {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_LR"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
FCSRUDR_P2.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.35,0.7}}--MENU PAGE = 1
FCSRUDR_P2.level 				    = 2
FCSRUDR_P2.h_clip_relation        = h_clip_relations.COMPARE
FCSRUDR_P2.parent_element         = BGROUND.name
vertices(FCSRUDR_P2,2.0)
Add(FCSRUDR_P2)

FCSRUDR_P3                       = CreateElement "ceTexPoly"
FCSRUDR_P3.name    			    = "FCSRUDR_P3"
FCSRUDR_P3.material			    = FCSPAGE_ELEVON_3
FCSRUDR_P3.change_opacity 		= false
FCSRUDR_P3.collimated 			= false
FCSRUDR_P3.isvisible 			    = true
FCSRUDR_P3.init_pos 			    = {0.72, 0.505, 0} --L-R,U-D,F-B
FCSRUDR_P3.init_rot 			    = {40, 0, 0}
FCSRUDR_P3.element_params 		= {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_LR"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
FCSRUDR_P3.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.7,1.1}}--MENU PAGE = 1
FCSRUDR_P3.level 				    = 2
FCSRUDR_P3.h_clip_relation        = h_clip_relations.COMPARE
FCSRUDR_P3.parent_element         = BGROUND.name
vertices(FCSRUDR_P3,2.0)
Add(FCSRUDR_P3)

FCSRUDR_N1                       = CreateElement "ceTexPoly"
FCSRUDR_N1.name    			    = "FCSRUDR_N1"
FCSRUDR_N1.material			    = FCSPAGE_ELEVON_1
FCSRUDR_N1.change_opacity 		= false
FCSRUDR_N1.collimated 			= false
FCSRUDR_N1.isvisible 			    = true
FCSRUDR_N1.init_pos 			    = {0.70, 0.53, 00} --L-R,U-D,F-B
FCSRUDR_N1.init_rot 			    = {40, 0, 0}
FCSRUDR_N1.element_params 		= {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_LR"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
FCSRUDR_N1.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-0.35,-0.1}}--MENU PAGE = 1
FCSRUDR_N1.level 				    = 2
FCSRUDR_N1.h_clip_relation        = h_clip_relations.COMPARE
FCSRUDR_N1.parent_element         = BGROUND.name
vertices(FCSRUDR_N1,2.0)
Add(FCSRUDR_N1)

FCSRUDR_N2                       = CreateElement "ceTexPoly"
FCSRUDR_N2.name    			    = "FCSRUDR_N2"
FCSRUDR_N2.material			    = FCSPAGE_ELEVON_2
FCSRUDR_N2.change_opacity 		= false
FCSRUDR_N2.collimated 			= false
FCSRUDR_N2.isvisible 			    = true
FCSRUDR_N2.init_pos 			    = {0.70, 0.53, 0} --L-R,U-D,F-B
FCSRUDR_N2.init_rot 			    = {40, 0, 0}
FCSRUDR_N2.element_params 		= {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_LR"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
FCSRUDR_N2.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-0.7,-0.35}}--MENU PAGE = 1
FCSRUDR_N2.level 				    = 2
FCSRUDR_N2.h_clip_relation        = h_clip_relations.COMPARE
FCSRUDR_N2.parent_element         = BGROUND.name
vertices(FCSRUDR_N2,2.0)
Add(FCSRUDR_N2)

FCSRUDR_N3                       = CreateElement "ceTexPoly"
FCSRUDR_N3.name    			    = "FCSRUDR_N3"
FCSRUDR_N3.material			    = FCSPAGE_ELEVON_3
FCSRUDR_N3.change_opacity 		= false
FCSRUDR_N3.collimated 			= false
FCSRUDR_N3.isvisible 			    = true
FCSRUDR_N3.init_pos 			    = {0.70, 0.53, 0} --L-R,U-D,F-B
FCSRUDR_N3.init_rot 			    = {40, 0, 0}
FCSRUDR_N3.element_params 		= {"MFD_OPACITY","CMFD_FCS_PAGE","FCS_LR"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
FCSRUDR_N3.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-1.1,-0.7}}--MENU PAGE = 1
FCSRUDR_N3.level 				    = 2
FCSRUDR_N3.h_clip_relation        = h_clip_relations.COMPARE
FCSRUDR_N3.parent_element         = BGROUND.name
vertices(FCSRUDR_N3,2.0)
Add(FCSRUDR_N3)







----------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------- MENU TEXT

MENUTEXT 					    = CreateElement "ceStringPoly"
MENUTEXT.name 				    = "MENUTEXT"
MENUTEXT.material 			    = UFD_FONT --UFD_YEL
MENUTEXT.value 				    = "MENU"
MENUTEXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
MENUTEXT.alignment 			    = "CenterCenter"
MENUTEXT.formats 			    = {"%s"}
MENUTEXT.h_clip_relation         = h_clip_relations.COMPARE
MENUTEXT.level 				    = 2
MENUTEXT.init_pos 			    = {-0.565, 0.92, 0}
MENUTEXT.init_rot 			    = {0, 0, 0}
MENUTEXT.element_params 	        = {"MFD_OPACITY","CMFD_FCS_PAGE"}
MENUTEXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(MENUTEXT)

----------------------------------

R_RING_RPM_G                    = CreateElement "ceTexPoly"
R_RING_RPM_G.name    			= "ring green"
R_RING_RPM_G.material			= RING_RPM_G
R_RING_RPM_G.change_opacity 	= false
R_RING_RPM_G.collimated 		= false
R_RING_RPM_G.isvisible 			= true
R_RING_RPM_G.init_pos 			= {0.35, 0.21, 0} --L-R,U-D,F-B
R_RING_RPM_G.init_rot 			= {0, 0, 0}
R_RING_RPM_G.element_params 	= {"MFD_OPACITY","CMFD_FCS_PAGE"} 
R_RING_RPM_G.controllers		= {
                                    {"opacity_using_parameter",0},
                                    {"parameter_in_range",1,0.9,1.1},--
                                   
                                }
R_RING_RPM_G.level 				    = 2
R_RING_RPM_G.h_clip_relation        = h_clip_relations.COMPARE
vertices(R_RING_RPM_G,0.3)
Add(R_RING_RPM_G)



R_NEEDLE_RPM_G                     = CreateElement "ceTexPoly"
R_NEEDLE_RPM_G.name    			= "needle y"
R_NEEDLE_RPM_G.material			= RING_NEEDLE_G
R_NEEDLE_RPM_G.change_opacity 	    = false
R_NEEDLE_RPM_G.collimated 		    = false
R_NEEDLE_RPM_G.isvisible 	        = true
R_NEEDLE_RPM_G.init_pos 			= {0.35, 0.21, 0} --L-R,U-D,F-B
R_NEEDLE_RPM_G.init_rot 			= {0, 0, 0}
R_NEEDLE_RPM_G.element_params 	    = {"MFD_OPACITY","CMFD_FCS_PAGE","R_ENGINE_THRUST"} 
R_NEEDLE_RPM_G.controllers		    = {
                                        {"opacity_using_parameter",0},
                                        {"parameter_in_range",1,0.9,1.1},--ENGINE PAGE = 1
                                        {"rotate_using_parameter",2, -0.1330,0}
                                    }
R_NEEDLE_RPM_G.level 				= 2
R_NEEDLE_RPM_G.h_clip_relation     = h_clip_relations.COMPARE
vertices(R_NEEDLE_RPM_G ,0.3)
Add(R_NEEDLE_RPM_G )
------------------------------------------------------------------------------------------------RPM-NEEDLE-ORANGE-R


L_RING_RPM_G                    = CreateElement "ceTexPoly"
L_RING_RPM_G.name    			= "ring green"
L_RING_RPM_G.material			= RING_RPM_G
L_RING_RPM_G.change_opacity 	= false
L_RING_RPM_G.collimated 		= false
L_RING_RPM_G.isvisible 			= true
L_RING_RPM_G.init_pos 			= {-0.35, 0.21, 0} --L-R,U-D,F-B
L_RING_RPM_G.init_rot 			= {0, 0, 0}
L_RING_RPM_G.element_params 	= {"MFD_OPACITY","CMFD_FCS_PAGE"} 
L_RING_RPM_G.controllers		= {
                                    {"opacity_using_parameter",0},
                                    {"parameter_in_range",1,0.9,1.1},--
                                   
                                }
L_RING_RPM_G.level 				    = 2
L_RING_RPM_G.h_clip_relation        = h_clip_relations.COMPARE
vertices(L_RING_RPM_G,0.3)
Add(L_RING_RPM_G)
------------------------------------------------------------------------------------------------RPM-RING-ORANGE-R

------------------------------------------------------------------------------------------------RPM-NEEDLE-YELLOW-R
L_NEEDLE_RPM_G                     = CreateElement "ceTexPoly"
L_NEEDLE_RPM_G.name    			= "needle y"
L_NEEDLE_RPM_G.material			= RING_NEEDLE_G
L_NEEDLE_RPM_G.change_opacity 	    = false
L_NEEDLE_RPM_G.collimated 		    = false
L_NEEDLE_RPM_G.isvisible 	        = true
L_NEEDLE_RPM_G.init_pos 			= {-0.35, 0.21, 0} --L-R,U-D,F-B
L_NEEDLE_RPM_G.init_rot 			= {0, 0, 0}
L_NEEDLE_RPM_G.element_params 	    = {"MFD_OPACITY","CMFD_FCS_PAGE","L_ENGINE_THRUST"} 
L_NEEDLE_RPM_G.controllers		    = {
                                        {"opacity_using_parameter",0},
                                        {"parameter_in_range",1,0.9,1.1},--ENGINE PAGE = 1
                                        {"rotate_using_parameter",2, -0.1330,0}
                                    }
L_NEEDLE_RPM_G.level 				= 2
L_NEEDLE_RPM_G.h_clip_relation     = h_clip_relations.COMPARE
vertices(L_NEEDLE_RPM_G ,0.3)
Add(L_NEEDLE_RPM_G )
------------------------------------------------------------------------------------------------RPM-NEEDLE-ORANGE-R


R_RPM_TEXT_G				    = CreateElement "ceStringPoly"
R_RPM_TEXT_G.name				= "rad Alt"
R_RPM_TEXT_G.material			= UFD_GRN
R_RPM_TEXT_G.init_pos			= {0.28, 0.30, 0} --L-R,U-D,F-B
R_RPM_TEXT_G.alignment			= "RightCenter"
R_RPM_TEXT_G.stringdefs			= {0.005, 0.005, 0, 0.0} --either 004 or 005
R_RPM_TEXT_G.additive_alpha		= true
R_RPM_TEXT_G.collimated			= false
R_RPM_TEXT_G.isdraw				= true	
R_RPM_TEXT_G.use_mipfilter		= true
R_RPM_TEXT_G.h_clip_relation	= h_clip_relations.COMPARE
R_RPM_TEXT_G.level				= 2
R_RPM_TEXT_G.element_params		= {"MFD_OPACITY","R_ENGINE_THRUST","CMFD_FCS_PAGE"}
R_RPM_TEXT_G.formats			= {"%.0fK"}--= {"%02.0f"}
R_RPM_TEXT_G.controllers		=   {
                                        {"opacity_using_parameter",0},
                                        {"text_using_parameter",1,0},
                                        {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                    }
                                
Add(R_RPM_TEXT_G)
-----------------------------------------------------------------------------------------------------------R RPM ORANGE

-----------------------------------------------------------------------------------------------------------L RPM YEL
L_RPM_TEXT_G				    = CreateElement "ceStringPoly"
L_RPM_TEXT_G.name				= "rad Alt"
L_RPM_TEXT_G.material			= UFD_GRN
L_RPM_TEXT_G.init_pos			= {-0.41, 0.30, 0} --L-R,U-D,F-B
L_RPM_TEXT_G.alignment			= "RightCenter"
L_RPM_TEXT_G.stringdefs			= {0.005, 0.005, 0, 0.0} --either 004 or 005
L_RPM_TEXT_G.additive_alpha		= true
L_RPM_TEXT_G.collimated			= false
L_RPM_TEXT_G.isdraw				= true	
L_RPM_TEXT_G.use_mipfilter		= true
L_RPM_TEXT_G.h_clip_relation	= h_clip_relations.COMPARE
L_RPM_TEXT_G.level				= 2
L_RPM_TEXT_G.element_params		= {"MFD_OPACITY","L_ENGINE_THRUST","CMFD_FCS_PAGE"}
L_RPM_TEXT_G.formats			= {"%.0fK"}--= {"%02.0f"}
L_RPM_TEXT_G.controllers		=   {
                                        {"opacity_using_parameter",0},
                                        {"text_using_parameter",1,0},
                                        {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1

                                    }
                                
Add(L_RPM_TEXT_G)

THRUSTTEXT 					    = CreateElement "ceStringPoly"
THRUSTTEXT.name 				    = "THRUSTTEXT"
THRUSTTEXT.material 			    = UFD_GRN
THRUSTTEXT.value 				    = "THRUST"
THRUSTTEXT.stringdefs 		        = {0.005, 0.005, 0.0002, 0.001}
THRUSTTEXT.alignment 			    = "CenterCenter"
THRUSTTEXT.formats 			    = {"%s"}
THRUSTTEXT.h_clip_relation         = h_clip_relations.COMPARE
THRUSTTEXT.level 				    = 2
THRUSTTEXT.init_pos 			    = {0, 0.27, 0}
THRUSTTEXT.init_rot 			    = {0, 0, 0}
THRUSTTEXT.element_params 	        = {"MFD_OPACITY","CMFD_FCS_PAGE"}
THRUSTTEXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(THRUSTTEXT)

FTLBS_TEXT 					    = CreateElement "ceStringPoly"
FTLBS_TEXT.name 				    = "FTLBS_TEXT"
FTLBS_TEXT.material 			    = UFD_GRN
FTLBS_TEXT.value 				    = "LBF"
FTLBS_TEXT.stringdefs 		        = {0.0035, 0.0035, 0.0000, 0.000}
FTLBS_TEXT.alignment 			    = "CenterCenter"
FTLBS_TEXT.formats 			    = {"%s"}
FTLBS_TEXT.h_clip_relation         = h_clip_relations.COMPARE
FTLBS_TEXT.level 				    = 2
FTLBS_TEXT.init_pos 			     = {0, 0.20, 0}
FTLBS_TEXT.init_rot 			    = {0, 0, 0}
FTLBS_TEXT.element_params 	        = {"MFD_OPACITY","CMFD_FCS_PAGE"}
FTLBS_TEXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},
						                }
Add(FTLBS_TEXT)





LEFTEXT 					    = CreateElement "ceStringPoly"
LEFTEXT.name 				    = "LEFTEXT"
LEFTEXT.material 			    = UFD_FONT
LEFTEXT.value 				    = "LEF"
LEFTEXT.stringdefs 		        = {0.0045, 0.0045, 0.0001, 0.001}
LEFTEXT.alignment 			    = "CenterCenter"
LEFTEXT.formats 			    = {"%s"}
LEFTEXT.h_clip_relation         = h_clip_relations.COMPARE
LEFTEXT.level 				    = 2
LEFTEXT.init_pos 			    = {0, 0.03, 0}
LEFTEXT.init_rot 			    = {0, 0, 0}
LEFTEXT.element_params 	        = {"MFD_OPACITY","CMFD_FCS_PAGE"}
LEFTEXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},--MENU PAGE = 0
						                }
Add(LEFTEXT)