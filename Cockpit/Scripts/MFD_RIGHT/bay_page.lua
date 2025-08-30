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
local BlueColor 			= {0, 0, 255, 255}--RGBA
local ScreenColor			= {3, 3, 3, 255}--RGBA DO NOT TOUCH 3-3-12-255 is good for on screen
--------------------------------------------------------------------------------------------------------------------------------------------
local BAY               = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/bay_frame.dds", GreenColor)--SYSTEM TEST
local BAY_DOOR_BOX      = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/bay_box.dds", WhiteColor)--SYSTEM TEST

local BAY_BOX           = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/bay_midbox.dds", WhiteColor)--SYSTEM TEST
local BAY_SQ            = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/bay_bbox.dds", WhiteColor)--SYSTEM TEST
local BAY_ORIDE         = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/bay_oride.dds", WhiteColor)--SYSTEM TEST
local BAY_X             = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/bay_x.dds", YellowColor)--SYSTEM TEST


local BAY_L_ROT        = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/bay_left_L_door.dds", GreenColor)--SYSTEM TEST
local BAY_R_ROT        = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/bay_left_R_door.dds", GreenColor)--SYSTEM TEST
local BAY_L_ROT_OPEN        = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/bay_left_L_door.dds", YellowColor)--SYSTEM TEST
local BAY_R_ROT_OPEN        = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/bay_left_R_door.dds", YellowColor)--SYSTEM TEST


local BAY_C_DOOR_ROT        = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/bay_center_door.dds", GreenColor)--SYSTEM TEST
local BAY_C_DOOR_OPEN        = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/bay_center_door.dds", YellowColor)--SYSTEM TEST
local BAY_CR_DOOR_ROT        = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/bay_center_r_door.dds", GreenColor)--SYSTEM TEST

local BAY_L_SEL         = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/bay_L_select.dds", WhiteColor)--SYSTEM TEST
local BAY_R_SEL         = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/bay_R_select.dds", WhiteColor)--SYSTEM TEST
local BAY_C_SEL         = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/bay_C_select.dds", WhiteColor)--SYSTEM TEST
local BAY_A_SEL         = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/bay_A_select.dds", WhiteColor)--SYSTEM TEST

local RING_EGT_G        = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/ring_egt.dds", GreenColor)--SYSTEM TEST
local RING_NEEDLE_G     = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/ring_needle.dds", GreenColor)--SYSTEM TEST
local MASK_BOX	        = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mask_box.dds", ScreenColor)--SYSTEM TEST
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
BGROUND                    = CreateElement "ceTexPoly"
BGROUND.name    			= "LMFD_PAGE"
BGROUND.material			= MASK_BOX
BGROUND.change_opacity 		= false
BGROUND.collimated 			= false
BGROUND.isvisible 			= true
BGROUND.init_pos 			= {0, 0, 0} --L-R,U-D,F-B
BGROUND.init_rot 			= {0, 0, 0}
BGROUND.element_params 		= {"MFD_OPACITY","RMFD_BAY_PAGE"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
BGROUND.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}--MENU PAGE = 1
BGROUND.level 				= 2
BGROUND.h_clip_relation     = h_clip_relations.COMPARE
vertices(BGROUND,3)
---------------------
Add(BGROUND)

LEFTTXT 					        = CreateElement "ceStringPoly"
LEFTTXT.name 				        = "LEFTTXT"
LEFTTXT.material 			        = UFD_FONT
LEFTTXT.value 				    = "LEFT"
LEFTTXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
LEFTTXT.alignment 			    = "CenterCenter"
LEFTTXT.formats 			        = {"%s"}
LEFTTXT.h_clip_relation           = h_clip_relations.COMPARE
LEFTTXT.level 				    = 2
LEFTTXT.init_pos 			        = {0.88,-0.12, 0}
LEFTTXT.init_rot 			        = {0, 0, 0}
LEFTTXT.element_params 	        = {"MFD_OPACITY","RMFD_BAY_PAGE"}
LEFTTXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},
						                }
Add(LEFTTXT)

CENTERTXT 					        = CreateElement "ceStringPoly"
CENTERTXT.name 				        = "CENTERTXT"
CENTERTXT.material 			        = UFD_FONT
CENTERTXT.value 				    = "CENTER"
CENTERTXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
CENTERTXT.alignment 			    = "CenterCenter"
CENTERTXT.formats 			        = {"%s"}
CENTERTXT.h_clip_relation           = h_clip_relations.COMPARE
CENTERTXT.level 				    = 2
CENTERTXT.init_pos 			        = {0.85, -0.70, 0}
CENTERTXT.init_rot 			        = {0, 0, 0}
CENTERTXT.element_params 	        = {"MFD_OPACITY","RMFD_BAY_PAGE"}
CENTERTXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},
						                }
Add(CENTERTXT)

RIGHTTXT 					        = CreateElement "ceStringPoly"
RIGHTTXT.name 				        = "RIGHTTXT"
RIGHTTXT.material 			        = UFD_FONT
RIGHTTXT.value 				    = "RIGHT"
RIGHTTXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
RIGHTTXT.alignment 			    = "CenterCenter"
RIGHTTXT.formats 			        = {"%s"}
RIGHTTXT.h_clip_relation           = h_clip_relations.COMPARE
RIGHTTXT.level 				    = 2
RIGHTTXT.init_pos 			        = {0.87,-0.40, 0}
RIGHTTXT.init_rot 			        = {0, 0, 0}
RIGHTTXT.element_params 	        = {"MFD_OPACITY","RMFD_BAY_PAGE"}
RIGHTTXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},
						                }
Add(RIGHTTXT)

ALLTXT 					        = CreateElement "ceStringPoly"
ALLTXT.name 				        = "ALLTXT"
ALLTXT.material 			        = UFD_FONT
ALLTXT.value 				    = "ALL"
ALLTXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
ALLTXT.alignment 			    = "CenterCenter"
ALLTXT.formats 			        = {"%s"}
ALLTXT.h_clip_relation           = h_clip_relations.COMPARE
ALLTXT.level 				    = 2
ALLTXT.init_pos 			        =  {0,-0.92, 0}
ALLTXT.init_rot 			        = {0, 0, 0}
ALLTXT.element_params 	        = {"MFD_OPACITY","RMFD_BAY_PAGE"}
ALLTXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},
						                }
Add(ALLTXT)

OPENCLOSETXT 					        = CreateElement "ceStringPoly"
OPENCLOSETXT.name 				        = "OPENCLOSETXT"
OPENCLOSETXT.material 			        = UFD_FONT
OPENCLOSETXT.value 				    = "OPEN/CLOSE"
OPENCLOSETXT.stringdefs 		        = {0.0050, 0.0050, 0.0002, 0.001}
OPENCLOSETXT.alignment 			    = "CenterCenter"
OPENCLOSETXT.formats 			        = {"%s"}
OPENCLOSETXT.h_clip_relation           = h_clip_relations.COMPARE
OPENCLOSETXT.level 				    = 2
OPENCLOSETXT.init_pos 			        = {-0.78, -0.70, 0}
OPENCLOSETXT.init_rot 			        = {0, 0, 0}
OPENCLOSETXT.element_params 	        = {"MFD_OPACITY","RMFD_BAY_PAGE"}
OPENCLOSETXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},
						                }
Add(OPENCLOSETXT)

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
BAYFRAME                        = CreateElement "ceTexPoly"
BAYFRAME.name    			    = "BG"
BAYFRAME.material			    = BAY
BAYFRAME.change_opacity 		= false
BAYFRAME.collimated 			= false
BAYFRAME.isvisible 			    = true
BAYFRAME.init_pos 			    = {0, 0.06, 0} --L-R,U-D,F-B
BAYFRAME.init_rot 			    = {0, 0, 0}
BAYFRAME.element_params 		= {"MFD_OPACITY","RMFD_BAY_PAGE"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
BAYFRAME.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}--MENU PAGE = 1
BAYFRAME.level 				    = 2
BAYFRAME.h_clip_relation        = h_clip_relations.COMPARE
vertices(BAYFRAME,2)
Add(BAYFRAME)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
BAYBOX                          = CreateElement "ceTexPoly"
BAYBOX.name    			        = "BG"
BAYBOX.material			        = BAY_BOX
BAYBOX.change_opacity 		    = false
BAYBOX.collimated 			    = false
BAYBOX.isvisible 			    = true
BAYBOX.init_pos 			    = {0, 0.05, 0} --L-R,U-D,F-B
BAYBOX.init_rot 			    = {0, 0, 0}
BAYBOX.element_params 		    = {"MFD_OPACITY","RMFD_BAY_PAGE"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
BAYBOX.controllers			    = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}--MENU PAGE = 1
BAYBOX.level 				    = 2
BAYBOX.h_clip_relation          = h_clip_relations.COMPARE
vertices(BAYBOX,2)
Add(BAYBOX)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
BAYSQC                           = CreateElement "ceTexPoly"
BAYSQC.name    			        = "BG"
BAYSQC.material			        = BAY_SQ
BAYSQC.change_opacity 		    = false
BAYSQC.collimated 			    = false
BAYSQC.isvisible 			    = true
BAYSQC.init_pos 			        = {0, 0.07, 0} --L-R,U-D,F-B
BAYSQC.init_rot 			        = {0, 0, 0}
BAYSQC.element_params 		    = {"MFD_OPACITY","RMFD_BAY_PAGE"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
BAYSQC.controllers			    = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}--MENU PAGE = 1
BAYSQC.level 				    = 2
BAYSQC.h_clip_relation           = h_clip_relations.COMPARE
vertices(BAYSQC,2)
Add(BAYSQC)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
BAYXC                           = CreateElement "ceTexPoly"
BAYXC.name    			        = "BG"
BAYXC.material			        = BAY_X
BAYXC.change_opacity 		    = false
BAYXC.collimated 			    = false
BAYXC.isvisible 			    = true
BAYXC.init_pos 			        = {0, 0.06, 0} --L-R,U-D,F-B
BAYXC.init_rot 			        = {0, 0, 0}
BAYXC.element_params 		    = {"MFD_OPACITY","RMFD_BAY_PAGE","ECM_ARG"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
BAYXC.controllers			    = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.9,1.1}}--MENU PAGE = 1
BAYXC.level 				    = 2
BAYXC.h_clip_relation           = h_clip_relations.COMPARE
vertices(BAYXC,2)
Add(BAYXC)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
BAYSQL                           = CreateElement "ceTexPoly"
BAYSQL.name    			        = "BG"
BAYSQL.material			        = BAY_SQ
BAYSQL.change_opacity 		    = false
BAYSQL.collimated 			    = false
BAYSQL.isvisible 			    = true
BAYSQL.init_pos 			        = {-0.30, 0.07, 0} --L-R,U-D,F-B
BAYSQL.init_rot 			        = {0, 0, 0}
BAYSQL.element_params 		    = {"MFD_OPACITY","RMFD_BAY_PAGE"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
BAYSQL.controllers			    = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}--MENU PAGE = 1
BAYSQL.level 				    = 2
BAYSQL.h_clip_relation           = h_clip_relations.COMPARE
vertices(BAYSQL,2)
Add(BAYSQL)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
BAYXL                           = CreateElement "ceTexPoly"
BAYXL.name    			        = "BG"
BAYXL.material			        = BAY_X
BAYXL.change_opacity 		    = false
BAYXL.collimated 			    = false
BAYXL.isvisible 			    = true
BAYXL.init_pos 			        = {-0.30, 0.06, 0} --L-R,U-D,F-B
BAYXL.init_rot 			        = {0, 0, 0}
BAYXL.element_params 		    = {"MFD_OPACITY","RMFD_BAY_PAGE","CHAFF_DISPENSING"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
BAYXL.controllers			    = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.1,1.1}}--MENU PAGE = 1
BAYXL.level 				    = 2
BAYXL.h_clip_relation           = h_clip_relations.COMPARE
vertices(BAYXL,2)
Add(BAYXL)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
BAYSQR                           = CreateElement "ceTexPoly"
BAYSQR.name    			        = "BG"
BAYSQR.material			        = BAY_SQ
BAYSQR.change_opacity 		    = false
BAYSQR.collimated 			    = false
BAYSQR.isvisible 			    = true
BAYSQR.init_pos 			        = {0.30, 0.07, 0} --L-R,U-D,F-B
BAYSQR.init_rot 			        = {0, 0, 0}
BAYSQR.element_params 		    = {"MFD_OPACITY","RMFD_BAY_PAGE"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
BAYSQR.controllers			    = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}--MENU PAGE = 1
BAYSQR.level 				    = 2
BAYSQR.h_clip_relation           = h_clip_relations.COMPARE
vertices(BAYSQR,2)
Add(BAYSQR)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
BAYXR                           = CreateElement "ceTexPoly"
BAYXR.name    			        = "BG"
BAYXR.material			        = BAY_X
BAYXR.change_opacity 		    = false
BAYXR.collimated 			    = false
BAYXR.isvisible 			    = true
BAYXR.init_pos 			        = {0.30, 0.06, 0} --L-R,U-D,F-B
BAYXR.init_rot 			        = {0, 0, 0}
BAYXR.element_params 		    = {"MFD_OPACITY","RMFD_BAY_PAGE","FLARE_DISPENSING"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
BAYXR.controllers			    = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.1,1.1}}--MENU PAGE = 1
BAYXR.level 				    = 2
BAYXR.h_clip_relation           = h_clip_relations.COMPARE
vertices(BAYXR,2)
Add(BAYXR)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


BAYLLOPEN                            = CreateElement "ceTexPoly"
BAYLLOPEN.name    			        = "BAYLLOPEN"
BAYLLOPEN.material			        = BAY_L_ROT
BAYLLOPEN.change_opacity 		    = false
BAYLLOPEN.collimated 			    = false
BAYLLOPEN.isvisible 			        = true
BAYLLOPEN.init_pos 			        = {-0.402, 0.1285, 0} --L-R,U-D,F-B
BAYLLOPEN.init_rot 			        = {0, 0, 0}
BAYLLOPEN.element_params 		    = {"MFD_OPACITY","RMFD_BAY_PAGE","LEFT_BAY_ARG"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
BAYLLOPEN.controllers			    = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-0.1,0.99},{"rotate_using_parameter",2,-1.35},{"move_left_right_using_parameter",2,0.0005}}
BAYLLOPEN.level 				        = 2
BAYLLOPEN.h_clip_relation            = h_clip_relations.COMPARE
vertices(BAYLLOPEN,2)
Add(BAYLLOPEN)

BAYLROPEN                            = CreateElement "ceTexPoly"
BAYLROPEN.name    			        = "BAYLLOPEN"
BAYLROPEN.material			        = BAY_R_ROT
BAYLROPEN.change_opacity 		    = false
BAYLROPEN.collimated 			    = false
BAYLROPEN.isvisible 			        = true
BAYLROPEN.init_pos 			        = {-0.33, 0.008, 0} --L-R,U-D,F-B
BAYLROPEN.init_rot 			        = {0, 0, 0}
BAYLROPEN.element_params 		    = {"MFD_OPACITY","RMFD_BAY_PAGE","LEFT_BAY_ARG"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
BAYLROPEN.controllers			    = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-0.1,0.99},{"rotate_using_parameter",2,1.85},{"move_left_right_using_parameter",2,0.0002}}
BAYLROPEN.level 				        = 2
BAYLROPEN.h_clip_relation            = h_clip_relations.COMPARE
vertices(BAYLROPEN,2)
Add(BAYLROPEN)

BAYLLOPENFULL                            = CreateElement "ceTexPoly"
BAYLLOPENFULL.name    			        = "BAYLLOPENFULL"
BAYLLOPENFULL.material			        = BAY_L_ROT_OPEN
BAYLLOPENFULL.change_opacity 		    = false
BAYLLOPENFULL.collimated 			    = false
BAYLLOPENFULL.isvisible 			        = true
BAYLLOPENFULL.init_pos 			        = {-0.452, 0.070, 0} --L-R,U-D,F-B
BAYLLOPENFULL.init_rot 			        = {102, 0, 0}
BAYLLOPENFULL.element_params 		    = {"MFD_OPACITY","RMFD_BAY_PAGE","LEFT_BAY_ARG"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
BAYLLOPENFULL.controllers			    = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.99,1.1}}
BAYLLOPENFULL.level 				        = 2
BAYLLOPENFULL.h_clip_relation            = h_clip_relations.COMPARE
vertices(BAYLLOPENFULL,2)
Add(BAYLLOPENFULL)

BAYLROPENFULL                            = CreateElement "ceTexPoly"
BAYLROPENFULL.name    			        = "BAYLROPENFULL"
BAYLROPENFULL.material			        = BAY_R_ROT_OPEN
BAYLROPENFULL.change_opacity 		    = false
BAYLROPENFULL.collimated 			    = false
BAYLROPENFULL.isvisible 			        = true
BAYLROPENFULL.init_pos 			        = {-0.33, 0.0084, 0} --L-R,U-D,F-B
BAYLROPENFULL.init_rot 			        = {103, 0, 0}
BAYLROPENFULL.element_params 		    = {"MFD_OPACITY","RMFD_BAY_PAGE","LEFT_BAY_ARG"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
BAYLROPENFULL.controllers			    = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.99,1.1}}
BAYLROPENFULL.level 				        = 2
BAYLROPENFULL.h_clip_relation            = h_clip_relations.COMPARE
vertices(BAYLROPENFULL,2)
Add(BAYLROPENFULL)

----------------------------------


BAYRLOPEN                            = CreateElement "ceTexPoly"
BAYRLOPEN.name    			        = "BAYRLOPEN"
BAYRLOPEN.material			        = BAY_L_ROT
BAYRLOPEN.change_opacity 		    = false
BAYRLOPEN.collimated 			    = false
BAYRLOPEN.isvisible 			        = true
BAYRLOPEN.init_pos 			        = {0.399, 0.127, 0} --L-R,U-D,F-B
BAYRLOPEN.init_rot 			        = {299, 0, 0}
BAYRLOPEN.element_params 		    = {"MFD_OPACITY","RMFD_BAY_PAGE","RIGHT_BAY_ARG"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
BAYRLOPEN.controllers			    = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-0.1,0.99},{"rotate_using_parameter",2,1.35},{"move_left_right_using_parameter",2,-0.0005}}
BAYRLOPEN.level 				        = 2
BAYRLOPEN.h_clip_relation            = h_clip_relations.COMPARE
vertices(BAYRLOPEN,2)
Add(BAYRLOPEN)

BAYRROPEN                            = CreateElement "ceTexPoly"
BAYRROPEN.name    			        = "BAYRROPEN"
BAYRROPEN.material			        = BAY_R_ROT
BAYRROPEN.change_opacity 		    = false
BAYRROPEN.collimated 			    = false
BAYRROPEN.isvisible 			        = true
BAYRROPEN.init_pos 			        = {0.33, 0.008, 0} --L-R,U-D,F-B
BAYRROPEN.init_rot 			        = {299, 0, 0}
BAYRROPEN.element_params 		    = {"MFD_OPACITY","RMFD_BAY_PAGE","RIGHT_BAY_ARG"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
BAYRROPEN.controllers			    = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-0.1,0.99},{"rotate_using_parameter",2,-1.80},{"move_left_right_using_parameter",2,-0.0002}}
BAYRROPEN.level 				        = 2
BAYRROPEN.h_clip_relation            = h_clip_relations.COMPARE
vertices(BAYRROPEN,2)
Add(BAYRROPEN)

BAYRLOPENFULL                            = CreateElement "ceTexPoly"
BAYRLOPENFULL.name    			        = "BAYRLOPENFULL"
BAYRLOPENFULL.material			        = BAY_L_ROT_OPEN
BAYRLOPENFULL.change_opacity 		    = false
BAYRLOPENFULL.collimated 			    = false
BAYRLOPENFULL.isvisible 			        = true
BAYRLOPENFULL.init_pos 			        = {0.447, 0.075, 0} --L-R,U-D,F-B
BAYRLOPENFULL.init_rot 			        = {194, 0, 0}
BAYRLOPENFULL.element_params 		    = {"MFD_OPACITY","RMFD_BAY_PAGE","RIGHT_BAY_ARG"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
BAYRLOPENFULL.controllers			    = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.99,1.1}}
BAYRLOPENFULL.level 				        = 2
BAYRLOPENFULL.h_clip_relation            = h_clip_relations.COMPARE
vertices(BAYRLOPENFULL,2)
Add(BAYRLOPENFULL)

BAYRROPENFULL                            = CreateElement "ceTexPoly"
BAYRROPENFULL.name    			        = "BAYRROPENFULL"
BAYRROPENFULL.material			        = BAY_R_ROT_OPEN
BAYRROPENFULL.change_opacity 		    = false
BAYRROPENFULL.collimated 			    = false
BAYRROPENFULL.isvisible 			        = true
BAYRROPENFULL.init_pos 			        = {0.33, 0.0084, 0} --L-R,U-D,F-B
BAYRROPENFULL.init_rot 			        = {195, 0, 0}
BAYRROPENFULL.element_params 		    = {"MFD_OPACITY","RMFD_BAY_PAGE","RIGHT_BAY_ARG"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
BAYRROPENFULL.controllers			    = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.99,1.1}}
BAYRROPENFULL.level 				        = 2
BAYRROPENFULL.h_clip_relation            = h_clip_relations.COMPARE
vertices(BAYRROPENFULL,2)
Add(BAYRROPENFULL)





-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


BAYCDOORL                            = CreateElement "ceTexPoly"
BAYCDOORL.name    			        = "BAYCDOORL"
BAYCDOORL.material			        = BAY_C_DOOR_ROT
BAYCDOORL.change_opacity 		    = false
BAYCDOORL.collimated 			    = false
BAYCDOORL.isvisible 			        = true
BAYCDOORL.init_pos 			        = {-0.3385, -0.126, 0} --L-R,U-D,F-B
BAYCDOORL.init_rot 			        = {180, 0, 0}
BAYCDOORL.element_params 		    = {"MFD_OPACITY","RMFD_BAY_PAGE","BAY_C_ARG","CENT_BAY_ARG"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
BAYCDOORL.controllers			    = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-0.1,0.99},{"rotate_using_parameter",3,-1.55},{"move_left_right_using_parameter",3,0.006}}--MENU PAGE = 1
BAYCDOORL.level 				        = 2
BAYCDOORL.h_clip_relation            = h_clip_relations.COMPARE
vertices(BAYCDOORL,2)
Add(BAYCDOORL)

BAYCDOORR                            = CreateElement "ceTexPoly"
BAYCDOORR.name    			        = "BAYCDOORR"
BAYCDOORR.material			        = BAY_CR_DOOR_ROT
BAYCDOORR.change_opacity 		    = false
BAYCDOORR.collimated 			    = false
BAYCDOORR.isvisible 			        = true
BAYCDOORR.init_pos 			        = {0.3385, -0.127, 0} --L-R,U-D,F-B
BAYCDOORR.init_rot 			        = {180, 0, 0}
BAYCDOORR.element_params 		    = {"MFD_OPACITY","RMFD_BAY_PAGE","BAY_C_ARG","CENT_BAY_ARG"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
BAYCDOORR.controllers			    = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-0.1,0.99},{"rotate_using_parameter",3,1.55},{"move_left_right_using_parameter",3,-0.006}}--MENU PAGE = 1
BAYCDOORR.level 				        = 2
BAYCDOORR.h_clip_relation            = h_clip_relations.COMPARE
vertices(BAYCDOORR,2)
Add(BAYCDOORR)

BAYCDOOROPENL                            = CreateElement "ceTexPoly"
BAYCDOOROPENL.name    			        = "BAYCDOOROPENL"
BAYCDOOROPENL.material			        = BAY_C_DOOR_OPEN
BAYCDOOROPENL.change_opacity 		    = false
BAYCDOOROPENL.collimated 			    = false
BAYCDOOROPENL.isvisible 			        = true
BAYCDOOROPENL.init_pos 			        = {-0.3385, -0.05, 0} --L-R,U-D,F-B
BAYCDOOROPENL.init_rot 			        = {91, 0, 0}
BAYCDOOROPENL.element_params 		    = {"MFD_OPACITY","RMFD_BAY_PAGE","BAY_C_ARG","CENT_BAY_ARG"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
BAYCDOOROPENL.controllers			    = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.99,1.1},}--MENU PAGE = 1
BAYCDOOROPENL.level 				        = 2
BAYCDOOROPENL.h_clip_relation            = h_clip_relations.COMPARE
vertices(BAYCDOOROPENL,2)
Add(BAYCDOOROPENL)

BAYCDOOROPENR                            = CreateElement "ceTexPoly"
BAYCDOOROPENR.name    			        = "BAYCDOOROPENR"
BAYCDOOROPENR.material			        = BAY_C_DOOR_OPEN
BAYCDOOROPENR.change_opacity 		    = false
BAYCDOOROPENR.collimated 			    = false
BAYCDOOROPENR.isvisible 			        = true
BAYCDOOROPENR.init_pos 			        = {0.35, -0.05, 0} --L-R,U-D,F-B
BAYCDOOROPENR.init_rot 			        = {89, 0, 0}
BAYCDOOROPENR.element_params 		    = {"MFD_OPACITY","RMFD_BAY_PAGE","BAY_C_ARG","CENT_BAY_ARG"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
BAYCDOOROPENR.controllers			    = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.99,1.1},}--MENU PAGE = 1
BAYCDOOROPENR.level 				        = 2
BAYCDOOROPENR.h_clip_relation            = h_clip_relations.COMPARE
vertices(BAYCDOOROPENR,2)
Add(BAYCDOOROPENR)


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
BAYLSEL                             = CreateElement "ceTexPoly"
BAYLSEL.name    			        = "BG"
BAYLSEL.material			        = BAY_L_SEL
BAYLSEL.change_opacity 		        = false
BAYLSEL.collimated 			        = false
BAYLSEL.isvisible 			        = true
BAYLSEL.init_pos 			        = {0, 0.06, 0} --L-R,U-D,F-B
BAYLSEL.init_rot 			        = {0, 0, 0}
BAYLSEL.element_params 		        = {"MFD_OPACITY","RMFD_BAY_PAGE","BAY_STATION"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
BAYLSEL.controllers			        = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.9,1.1} }
BAYLSEL.level 				        = 2
BAYLSEL.h_clip_relation             = h_clip_relations.COMPARE
vertices(BAYLSEL,2)
Add(BAYLSEL)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
BAYRSEL                             = CreateElement "ceTexPoly"
BAYRSEL.name    			        = "BG"
BAYRSEL.material			        = BAY_R_SEL
BAYRSEL.change_opacity 		        = false
BAYRSEL.collimated 			        = false
BAYRSEL.isvisible 			        = true
BAYRSEL.init_pos 			        = {0, 0.06, 0} --L-R,U-D,F-B
BAYRSEL.init_rot 			        = {0, 0, 0}
BAYRSEL.element_params 		        = {"MFD_OPACITY","RMFD_BAY_PAGE","BAY_STATION"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
BAYRSEL.controllers			        = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,2.9,3.1}}
BAYRSEL.level 				        = 2
BAYRSEL.h_clip_relation             = h_clip_relations.COMPARE
vertices(BAYRSEL,2)
Add(BAYRSEL)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
BAYCSEL                             = CreateElement "ceTexPoly"
BAYCSEL.name    			        = "BG"
BAYCSEL.material			        = BAY_C_SEL
BAYCSEL.change_opacity 		        = false
BAYCSEL.collimated 			        = false
BAYCSEL.isvisible 			        = true
BAYCSEL.init_pos 			        = {0, 0.06, 0} --L-R,U-D,F-B
BAYCSEL.init_rot 			        = {0, 0, 0}
BAYCSEL.element_params 		        = {"MFD_OPACITY","RMFD_BAY_PAGE","BAY_STATION"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
BAYCSEL.controllers			        = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,1.9,2.1}}
BAYCSEL.level 				        = 2
BAYCSEL.h_clip_relation             = h_clip_relations.COMPARE
vertices(BAYCSEL,2)
Add(BAYCSEL)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
BAYASEL                             = CreateElement "ceTexPoly"
BAYASEL.name    			        = "BG"
BAYASEL.material			        = BAY_A_SEL
BAYASEL.change_opacity 		        = false
BAYASEL.collimated 			        = false
BAYASEL.isvisible 			        = true
BAYASEL.init_pos 			        = {0, 0.06, 0} --L-R,U-D,F-B
BAYASEL.init_rot 			        = {0, 0, 0}
BAYASEL.element_params 		        = {"MFD_OPACITY","RMFD_BAY_PAGE","BAY_STATION"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
BAYASEL.controllers			        = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,3.9,4.1}}
BAYASEL.level 				        = 2
BAYASEL.h_clip_relation             = h_clip_relations.COMPARE
vertices(BAYASEL,2)
Add(BAYASEL)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ORIDE                           = CreateElement "ceTexPoly"
ORIDE.name    			        = "BG"
ORIDE.material			        = BAY_ORIDE
ORIDE.change_opacity 		    = false
ORIDE.collimated 			    = false
ORIDE.isvisible 			    = true
ORIDE.init_pos 			        = {-0.06, 0.0, 0} --L-R,U-D,F-B
ORIDE.init_rot 			        = {0, 0, 0}
ORIDE.element_params 		    = {"MFD_OPACITY","RMFD_BAY_PAGE","WoW"}--this may not be bneeded check when more pages done for backlight on page 7 RWR fc3 bs
ORIDE.controllers			    = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-0.1,0.1}}
ORIDE.level 				        = 2
ORIDE.h_clip_relation            = h_clip_relations.COMPARE
vertices(ORIDE,2)
Add(ORIDE)
---------------------------------------------------------------------------------------------------GROUND OVERRIDE TEXT GREEN
GORIDE_GRN 					            = CreateElement "ceStringPoly"
GORIDE_GRN.name 				        = "menu"
GORIDE_GRN.material 			        = UFD_GRN
GORIDE_GRN.value 				        = "AIR"
GORIDE_GRN.stringdefs 		            = {0.005, 0.005, 0.0004, 0.001}
GORIDE_GRN.alignment 			        = "CenterCenter"
GORIDE_GRN.formats 			            = {"%s"}
GORIDE_GRN.h_clip_relation              = h_clip_relations.COMPARE
GORIDE_GRN.level 				        = 2
GORIDE_GRN.init_pos 			        = {-0.835, -0.345, 0}
GORIDE_GRN.init_rot 			        = {0, 0, 0}
GORIDE_GRN.element_params 	            = {"MFD_OPACITY","RMFD_BAY_PAGE","ORIDE_TEXT","WoW"}
GORIDE_GRN.controllers		            =   {
                                                {"opacity_using_parameter",0},
                                                {"parameter_in_range",1,0.9,1.1},
                                                {"parameter_in_range",2,-0.1,0.1},
                                                {"parameter_in_range",3,-0.1,0.1},
						                    }
Add(GORIDE_GRN)
---------------------------------------------------------------------------------------------------GROUND OVERRIDE TEXT YELLOW
GORIDE_YEL 					            = CreateElement "ceStringPoly"
GORIDE_YEL.name 				        = "menu"
GORIDE_YEL.material 			        = UFD_RED
GORIDE_YEL.value 				        = "AIR"
GORIDE_YEL.stringdefs 		            = {0.005, 0.005, 0.0004, 0.001}
GORIDE_YEL.alignment 			        = "CenterCenter"
GORIDE_YEL.formats 			            = {"%s"}
GORIDE_YEL.h_clip_relation              = h_clip_relations.COMPARE
GORIDE_YEL.level 				        = 2
GORIDE_YEL.init_pos 			        = {-0.835, -0.345, 0}
GORIDE_YEL.init_rot 			        = {0, 0, 0}
GORIDE_YEL.element_params 	            = {"MFD_OPACITY","RMFD_BAY_PAGE","ORIDE_TEXT","WoW"}
GORIDE_YEL.controllers		            =   {
                                                {"opacity_using_parameter",0},
                                                {"parameter_in_range",1,0.9,1.1},
                                                {"parameter_in_range",2,0.9,1.1},
                                                {"parameter_in_range",3,-0.1,0.1},
						                    }
Add(GORIDE_YEL)
---------------------------------------------------------------------------------------------------GROUND OVERRIDE TEXT GREEN
GORIDE_GRN1 					            = CreateElement "ceStringPoly"
GORIDE_GRN1.name 				        = "menu"
GORIDE_GRN1.material 			        = UFD_GRN
GORIDE_GRN1.value 				        = "OVRIDE"
GORIDE_GRN1.stringdefs 		            = {0.005, 0.005, 0.0004, 0.001}
GORIDE_GRN1.alignment 			        = "CenterCenter"
GORIDE_GRN1.formats 			            = {"%s"}
GORIDE_GRN1.h_clip_relation              = h_clip_relations.COMPARE
GORIDE_GRN1.level 				        = 2
GORIDE_GRN1.init_pos 			        = {-0.835, -0.415, 0}
GORIDE_GRN1.init_rot 			        = {0, 0, 0}
GORIDE_GRN1.element_params 	            = {"MFD_OPACITY","RMFD_BAY_PAGE","ORIDE_TEXT","WoW"}
GORIDE_GRN1.controllers		            =   {
                                                {"opacity_using_parameter",0},
                                                {"parameter_in_range",1,0.9,1.1},
                                                {"parameter_in_range",2,-0.1,0.1},
                                                {"parameter_in_range",3,-0.1,0.1},
						                    }
Add(GORIDE_GRN1)
---------------------------------------------------------------------------------------------------GROUND OVERRIDE TEXT YELLOW
GORIDE_YEL1 					            = CreateElement "ceStringPoly"
GORIDE_YEL1.name 				        = "menu"
GORIDE_YEL1.material 			        = UFD_RED
GORIDE_YEL1.value 				        = "OVRIDE"
GORIDE_YEL1.stringdefs 		            = {0.005, 0.005, 0.0004, 0.001}
GORIDE_YEL1.alignment 			        = "CenterCenter"
GORIDE_YEL1.formats 			            = {"%s"}
GORIDE_YEL1.h_clip_relation              = h_clip_relations.COMPARE
GORIDE_YEL1.level 				        = 2
GORIDE_YEL1.init_pos 			        = {-0.835, -0.415, 0}
GORIDE_YEL1.init_rot 			        = {0, 0, 0}
GORIDE_YEL1.element_params 	            = {"MFD_OPACITY","RMFD_BAY_PAGE","ORIDE_TEXT","WoW"}
GORIDE_YEL1.controllers		            =   {
                                                {"opacity_using_parameter",0},
                                                {"parameter_in_range",1,0.9,1.1},
                                                {"parameter_in_range",2,0.9,1.1},
                                                {"parameter_in_range",3,-0.1,0.1},
						                    }
Add(GORIDE_YEL1)
------------------------------------------------------------------------------------------------------------------------------------------------------THRUST SHIT
R_RING_EGT_G                    = CreateElement "ceTexPoly"
R_RING_EGT_G.name    			= "ring green"
R_RING_EGT_G.material			= RING_EGT_G
R_RING_EGT_G.change_opacity 	= false
R_RING_EGT_G.collimated 		= false
R_RING_EGT_G.isvisible 			= true
R_RING_EGT_G.init_pos 			= {0.28, 0.70, 0} --L-R,U-D,F-B
R_RING_EGT_G.init_rot 			= {0, 0, 0}
R_RING_EGT_G.element_params 	= {"MFD_OPACITY","RMFD_BAY_PAGE"} 
R_RING_EGT_G.controllers		= {
                                    {"opacity_using_parameter",0},
                                    {"parameter_in_range",1,0.9,1.1},--ENGINE PAGE = 1
                                }
R_RING_EGT_G.level 				    = 2
R_RING_EGT_G.h_clip_relation        = h_clip_relations.COMPARE
vertices(R_RING_EGT_G,0.3)
Add(R_RING_EGT_G)
------------------------------------------------------------------------------------------------THRUST SHIT
R_NEEDLE_EGT_G                      = CreateElement "ceTexPoly"
R_NEEDLE_EGT_G .name    			= "needle g"
R_NEEDLE_EGT_G .material			= RING_NEEDLE_G
R_NEEDLE_EGT_G .change_opacity 	    = false
R_NEEDLE_EGT_G .collimated 		    = false
R_NEEDLE_EGT_G .isvisible 	        = true
R_NEEDLE_EGT_G .init_pos 			= {0.28, 0.70, 0} --L-R,U-D,F-B
R_NEEDLE_EGT_G .init_rot 			= {0, 0, 0}
R_NEEDLE_EGT_G .element_params 	    = {"MFD_OPACITY","RMFD_BAY_PAGE","R_ENGINE_THRUST"} 
R_NEEDLE_EGT_G .controllers		    = {
                                        {"opacity_using_parameter",0},
                                        {"parameter_in_range",1, 0.9,1.1},--ENGINE PAGE = 1
                                        {"rotate_using_parameter",2, -0.1330,0}
                                    }
R_NEEDLE_EGT_G .level 				= 2
R_NEEDLE_EGT_G .h_clip_relation     = h_clip_relations.COMPARE
vertices(R_NEEDLE_EGT_G,0.3)
Add(R_NEEDLE_EGT_G)
------------------------------------------------------------------------------------------------THRUST SHIT
L_RING_EGT_G                    = CreateElement "ceTexPoly"
L_RING_EGT_G.name    			= "ring green"
L_RING_EGT_G.material			= RING_EGT_G
L_RING_EGT_G.change_opacity 	= false
L_RING_EGT_G.collimated 		= false
L_RING_EGT_G.isvisible 			= true
L_RING_EGT_G.init_pos 			= {-0.28, 0.70, 0} --L-R,U-D,F-B
L_RING_EGT_G.init_rot 			= {0, 0, 0}
L_RING_EGT_G.element_params 	= {"MFD_OPACITY","RMFD_BAY_PAGE"} 
L_RING_EGT_G.controllers		= {
                                    {"opacity_using_parameter",0},
                                    {"parameter_in_range",1,0.9,1.1},--ENGINE PAGE = 1
                                   
                                }
L_RING_EGT_G.level 				    = 2
L_RING_EGT_G.h_clip_relation        = h_clip_relations.COMPARE
vertices(L_RING_EGT_G,0.3)
Add(L_RING_EGT_G)
------------------------------------------------------------------------------------------------THRUST SHIT
L_NEEDLE_EGT_G                      = CreateElement "ceTexPoly"
L_NEEDLE_EGT_G .name    			= "needle g"
L_NEEDLE_EGT_G .material			= RING_NEEDLE_G
L_NEEDLE_EGT_G .change_opacity 	    = false
L_NEEDLE_EGT_G .collimated 		    = false
L_NEEDLE_EGT_G .isvisible 	        = true
L_NEEDLE_EGT_G .init_pos 			= {-0.28, 0.70, 0} --L-R,U-D,F-B
L_NEEDLE_EGT_G .init_rot 			= {0, 0, 0}
L_NEEDLE_EGT_G .element_params 	    = {"MFD_OPACITY","RMFD_BAY_PAGE","L_ENGINE_THRUST"} 
L_NEEDLE_EGT_G .controllers		    = {
                                        {"opacity_using_parameter",0},
                                        {"parameter_in_range",1, 0.9,1.1},--ENGINE PAGE = 1
                                        {"rotate_using_parameter",2, -0.1330,0}
                                    }
L_NEEDLE_EGT_G .level 				= 2
L_NEEDLE_EGT_G .h_clip_relation     = h_clip_relations.COMPARE
vertices(L_NEEDLE_EGT_G,0.3)
Add(L_NEEDLE_EGT_G)
-----------------------------------------------------------------------------------------------------------THRUST SHIT
R_RPM_NUM_G				        = CreateElement "ceStringPoly"
R_RPM_NUM_G.name				= "rad Alt"
R_RPM_NUM_G.material			= UFD_GRN
R_RPM_NUM_G.init_pos			= {0.20, 0.79, 0} --L-R,U-D,F-B
R_RPM_NUM_G.alignment			= "RightCenter"
R_RPM_NUM_G.stringdefs			= {0.005, 0.005, 0, 0.0} --either 004 or 005
R_RPM_NUM_G.additive_alpha		= true
R_RPM_NUM_G.collimated			= false
R_RPM_NUM_G.isdraw				= true	
R_RPM_NUM_G.use_mipfilter		= true
R_RPM_NUM_G.h_clip_relation	    = h_clip_relations.COMPARE
R_RPM_NUM_G.level				= 2
R_RPM_NUM_G.element_params		= {"MFD_OPACITY","R_ENGINE_THRUST","RMFD_BAY_PAGE"}
R_RPM_NUM_G.formats			    = {"%.0fK"}--= {"%02.0f"}
R_RPM_NUM_G.controllers		    =   {
                                        {"opacity_using_parameter",0},
                                        {"text_using_parameter",1,0},
                                        {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                    }
                                
Add(R_RPM_NUM_G)
-----------------------------------------------------------------------------------------------------------THRUST SHIT
L_RPM_NUM_G				        = CreateElement "ceStringPoly"
L_RPM_NUM_G.name				= "rad Alt"
L_RPM_NUM_G.material			= UFD_GRN
L_RPM_NUM_G.init_pos			= {-0.36, 0.79, 0} --L-R,U-D,F-B
L_RPM_NUM_G.alignment			= "RightCenter"
L_RPM_NUM_G.stringdefs			= {0.005, 0.005, 0, 0.0} --either 004 or 005
L_RPM_NUM_G.additive_alpha		= true
L_RPM_NUM_G.collimated			= false
L_RPM_NUM_G.isdraw				= true	
L_RPM_NUM_G.use_mipfilter		= true
L_RPM_NUM_G.h_clip_relation	    = h_clip_relations.COMPARE
L_RPM_NUM_G.level				= 2
L_RPM_NUM_G.element_params		= {"MFD_OPACITY","L_ENGINE_THRUST","RMFD_BAY_PAGE"}
L_RPM_NUM_G.formats			    = {"%.0fK"}--= {"%02.0f"}
L_RPM_NUM_G.controllers		    =   {
                                        {"opacity_using_parameter",0},
                                        {"text_using_parameter",1,0},
                                        {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                    }
                                
Add(L_RPM_NUM_G)
--------------------------------------------------------------------------------------------------- NAV
MENU_TEXT 					        = CreateElement "ceStringPoly"
MENU_TEXT.name 				        = "menu"
MENU_TEXT.material 			        = UFD_FONT
MENU_TEXT.value 				    = "MENU"
MENU_TEXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
MENU_TEXT.alignment 			    = "CenterCenter"
MENU_TEXT.formats 			        = {"%s"}
MENU_TEXT.h_clip_relation           = h_clip_relations.COMPARE
MENU_TEXT.level 				    = 2
MENU_TEXT.init_pos 			        = {-0.565, 0.92, 0}
MENU_TEXT.init_rot 			        = {0, 0, 0}
MENU_TEXT.element_params 	        = {"MFD_OPACITY","RMFD_BAY_PAGE"}
MENU_TEXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},
						                }
Add(MENU_TEXT)

--------------------------------------------------------------------------------------------------- NAV
THRUST_TEXT 					    = CreateElement "ceStringPoly"
THRUST_TEXT.name 				    = "menu"
THRUST_TEXT.material 			    = UFD_GRN
THRUST_TEXT.value 				    = "THRUST"
THRUST_TEXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
THRUST_TEXT.alignment 			    = "CenterCenter"
THRUST_TEXT.formats 			    = {"%s"}
THRUST_TEXT.h_clip_relation         = h_clip_relations.COMPARE
THRUST_TEXT.level 				    = 2
THRUST_TEXT.init_pos 			     = {0, 0.71, 0}
THRUST_TEXT.init_rot 			    = {0, 0, 0}
THRUST_TEXT.element_params 	        = {"MFD_OPACITY","RMFD_BAY_PAGE"}
THRUST_TEXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},
						                }
Add(THRUST_TEXT)

FTLBS_TEXT 					    = CreateElement "ceStringPoly"
FTLBS_TEXT.name 				    = "FTLBS_TEXT"
FTLBS_TEXT.material 			    = UFD_GRN
FTLBS_TEXT.value 				    = "LBF"
FTLBS_TEXT.stringdefs 		        = {0.0035, 0.0035, 0.0000, 0.000}
FTLBS_TEXT.alignment 			    = "CenterCenter"
FTLBS_TEXT.formats 			    = {"%s"}
FTLBS_TEXT.h_clip_relation         = h_clip_relations.COMPARE
FTLBS_TEXT.level 				    = 2
FTLBS_TEXT.init_pos 			     = {0, 0.64, 0}
FTLBS_TEXT.init_rot 			    = {0, 0, 0}
FTLBS_TEXT.element_params 	        = {"MFD_OPACITY","RMFD_BAY_PAGE"}
FTLBS_TEXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},
						                }
Add(FTLBS_TEXT)


--------------------------------------------------------------------------------------------------- NAV
CENTER_TEXT 					    = CreateElement "ceStringPoly"
CENTER_TEXT.name 				    = "menu"
CENTER_TEXT.material 			    = UFD_GRN
CENTER_TEXT.value 				    = "CENTER"
CENTER_TEXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
CENTER_TEXT.alignment 			    = "CenterCenter"
CENTER_TEXT.formats 			    = {"%s"}
CENTER_TEXT.h_clip_relation         = h_clip_relations.COMPARE
CENTER_TEXT.level 				    = 2
CENTER_TEXT.init_pos 			     = {0, 0.1675, 0}
CENTER_TEXT.init_rot 			    = {0, 0, 0}
CENTER_TEXT.element_params 	        = {"MFD_OPACITY","RMFD_BAY_PAGE","BAY_STATION"}
CENTER_TEXT.controllers		        = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,1.9,2.1}}
Add(CENTER_TEXT)
--------------------------------------------------------------------------------------------------- NAV
LEFT_TEXT 					        = CreateElement "ceStringPoly"
LEFT_TEXT.name 				        = "menu"
LEFT_TEXT.material 			        = UFD_GRN
LEFT_TEXT.value 				    = "LEFT"
LEFT_TEXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
LEFT_TEXT.alignment 			    = "CenterCenter"
LEFT_TEXT.formats 			        = {"%s"}
LEFT_TEXT.h_clip_relation           = h_clip_relations.COMPARE
LEFT_TEXT.level 				    = 2
LEFT_TEXT.init_pos 			        = {0, 0.1675, 0}
LEFT_TEXT.init_rot 			        = {0, 0, 0}
LEFT_TEXT.element_params 	        = {"MFD_OPACITY","RMFD_BAY_PAGE","BAY_STATION"}
LEFT_TEXT.controllers		        = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.9,1.1}}
Add(LEFT_TEXT)
--------------------------------------------------------------------------------------------------- NAV
RIGHT_TEXT 					            = CreateElement "ceStringPoly"
RIGHT_TEXT.name 				        = "menu"
RIGHT_TEXT.material 			        = UFD_GRN
RIGHT_TEXT.value 				        = "RIGHT"
RIGHT_TEXT.stringdefs 		            = {0.0050, 0.0050, 0.0004, 0.001}
RIGHT_TEXT.alignment 			        = "CenterCenter"
RIGHT_TEXT.formats 			            = {"%s"}
RIGHT_TEXT.h_clip_relation              = h_clip_relations.COMPARE
RIGHT_TEXT.level 				        = 2
RIGHT_TEXT.init_pos 			        = {0, 0.1675, 0}
RIGHT_TEXT.init_rot 			        = {0, 0, 0}
RIGHT_TEXT.element_params 	            = {"MFD_OPACITY","RMFD_BAY_PAGE","BAY_STATION"}
RIGHT_TEXT.controllers		            = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,2.9,3.1}}
Add(RIGHT_TEXT)
--------------------------------------------------------------------------------------------------- NAV
GUN_TEXT 					            = CreateElement "ceStringPoly"
GUN_TEXT.name 				            = "GUN_TEXT"
GUN_TEXT.material 			            = UFD_GRN
GUN_TEXT.value 				            = "GUN - 480"
GUN_TEXT.stringdefs 		            = {0.00450, 0.00450, 0.0000, 0.000}
GUN_TEXT.alignment 			            = "CenterCenter"
GUN_TEXT.formats 			            = {"%s"}
GUN_TEXT.h_clip_relation                = h_clip_relations.COMPARE
GUN_TEXT.level 				            = 2
GUN_TEXT.init_pos 			            = {0, 0.22, 0}
GUN_TEXT.init_rot 			            = {0, 0, 0}
GUN_TEXT.element_params 	            = {"MFD_OPACITY","RMFD_BAY_PAGE","MASTER_ARM"}
GUN_TEXT.controllers		            = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.9,1.1}}
Add(GUN_TEXT)
--------------------------------------------------------------------------------------------------- NAV
--------------------------------------------------------------------------------------------------- NAV
ECM_TEXT 					            = CreateElement "ceStringPoly"
ECM_TEXT.name 				            = "menu"
ECM_TEXT.material 			            = UFD_YEL
ECM_TEXT.value 				            = "ECM"
ECM_TEXT.stringdefs 		            = {0.0040, 0.0040, 0.0004, 0.001}
ECM_TEXT.alignment 			            = "CenterCenter"
ECM_TEXT.formats 			            = {"%s"}
ECM_TEXT.h_clip_relation                = h_clip_relations.COMPARE
ECM_TEXT.level 				            = 2
ECM_TEXT.init_pos 			            = {0, -0.70, 0}
ECM_TEXT.init_rot 			            = {0, 0, 0}
ECM_TEXT.element_params 	            = {"MFD_OPACITY","RMFD_BAY_PAGE"}
ECM_TEXT.controllers		            =   {
                                                {"opacity_using_parameter",0},
                                                {"parameter_in_range",1,0.9,1.1},
						                    }
Add(ECM_TEXT)
--------------------------------------------------------------------------------------------------- NAV
CHAFF_TEXT 					            = CreateElement "ceStringPoly"
CHAFF_TEXT.name 				        = "menu"
CHAFF_TEXT.material 			        = UFD_GRN
CHAFF_TEXT.value 				        = "CHAFF"
CHAFF_TEXT.stringdefs 		            = {0.0040, 0.0040, 0.0004, 0.001}
CHAFF_TEXT.alignment 			        = "CenterCenter"
CHAFF_TEXT.formats 			            = {"%s"}
CHAFF_TEXT.h_clip_relation              = h_clip_relations.COMPARE
CHAFF_TEXT.level 				        = 2
CHAFF_TEXT.init_pos 			        = {-0.30, -0.70, 0}
CHAFF_TEXT.init_rot 			        = {0, 0, 0}
CHAFF_TEXT.element_params 	            = {"MFD_OPACITY","RMFD_BAY_PAGE"}
CHAFF_TEXT.controllers		            =   {
                                                {"opacity_using_parameter",0},
                                                {"parameter_in_range",1,0.9,1.1},
						                    }
Add(CHAFF_TEXT)
--------------------------------------------------------------------------------------------------- NAV
FLARE_TEXT 					            = CreateElement "ceStringPoly"
FLARE_TEXT.name 				        = "menu"
FLARE_TEXT.material 			        = UFD_GRN
FLARE_TEXT.value 				        = "FLARE"
FLARE_TEXT.stringdefs 		            = {0.0040, 0.0040, 0.0004, 0.001}
FLARE_TEXT.alignment 			        = "CenterCenter"
FLARE_TEXT.formats 			            = {"%s"}
FLARE_TEXT.h_clip_relation              = h_clip_relations.COMPARE
FLARE_TEXT.level 				        = 2
FLARE_TEXT.init_pos 			        = {0.30, -0.70, 0}
FLARE_TEXT.init_rot 			        = {0, 0, 0}
FLARE_TEXT.element_params 	            = {"MFD_OPACITY","RMFD_BAY_PAGE"}
FLARE_TEXT.controllers		            =   {
                                                {"opacity_using_parameter",0},
                                                {"parameter_in_range",1,0.9,1.1},
						                    }
											
Add(FLARE_TEXT)
--------------------------------------------------------------------------------------------------- NAV
WEAPONSARM_TEXT 					            = CreateElement "ceStringPoly"
WEAPONSARM_TEXT.name 				            = "menu"
WEAPONSARM_TEXT.material 			            = UFD_GRN
WEAPONSARM_TEXT.value 				            = "AIM-120C - READY"
WEAPONSARM_TEXT.stringdefs 		            = {0.0060, 0.0060, 0.0002, 0.001}
WEAPONSARM_TEXT.alignment 			            = "CenterCenter"
WEAPONSARM_TEXT.formats 			            = {"%s"}
WEAPONSARM_TEXT.h_clip_relation                = h_clip_relations.COMPARE
WEAPONSARM_TEXT.level 				            = 2
WEAPONSARM_TEXT.init_pos 			            = {0, 0.47, 0}
WEAPONSARM_TEXT.init_rot 			            = {0, 0, 0}
WEAPONSARM_TEXT.element_params 	            = {"MFD_OPACITY","RMFD_BAY_PAGE","MASTER_ARM"}
WEAPONSARM_TEXT.controllers		            =   {
                                                    {"opacity_using_parameter",0},
                                                    {"parameter_in_range",1,0.9,1.1},
                                                    {"parameter_in_range",2,0.9,1.1},
						                        }
Add(WEAPONSARM_TEXT)
--------------------------------------------------------------------------------------------------- NAV
WEAPONSSAFE_TEXT 					            = CreateElement "ceStringPoly"
WEAPONSSAFE_TEXT.name 				            = "menu"
WEAPONSSAFE_TEXT.material 			            = UFD_FONT
WEAPONSSAFE_TEXT.value 				        = "WEAPONS SAFE"
WEAPONSSAFE_TEXT.stringdefs 		            = {0.0060, 0.0060, 0.0002, 0.001}
WEAPONSSAFE_TEXT.alignment 			        = "CenterCenter"
WEAPONSSAFE_TEXT.formats 			            = {"%s"}
WEAPONSSAFE_TEXT.h_clip_relation               = h_clip_relations.COMPARE
WEAPONSSAFE_TEXT.level 				        = 2
WEAPONSSAFE_TEXT.init_pos 			            = {0, 0.46, 0}
WEAPONSSAFE_TEXT.init_rot 			            = {0, 0, 0}
WEAPONSSAFE_TEXT.element_params 	            = {"MFD_OPACITY","RMFD_BAY_PAGE","MASTER_ARM"}
WEAPONSSAFE_TEXT.controllers		            =   {
                                                {"opacity_using_parameter",0},
                                                {"parameter_in_range",1,0.9,1.1},
                                                {"parameter_in_range",2,-0.1,0.1},
						                    }
Add(WEAPONSSAFE_TEXT)
