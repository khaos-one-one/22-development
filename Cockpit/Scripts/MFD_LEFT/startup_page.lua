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
local YellowColor 			= {255, 255, 0, 255}--RGBA
local OrangeColor           = {255, 102, 0, 255}--RGBA
local RedColor 				= {255, 0, 0, 255}--RGBA
local WhiteColor 			= {255, 255, 255, 255}--RGBA
local ScreenColor			= {3, 3, 3, 255}--RGBA 5-5-5


local MASK_BOX	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mask_box.dds", ScreenColor)
local RING_EGT_G      = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/ring_egt.dds", GreenColor)
local RING_EGT_Y      = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/ring_egt.dds", YellowColor)
local RING_EGT_R      = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/ring_egt.dds", RedColor)

local RING_NEEDLE_G   = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/ring_needle.dds", GreenColor)
local RING_NEEDLE_Y   = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/ring_needle.dds", YellowColor)
local RING_NEEDLE_R   = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/ring_needle.dds", RedColor)
local RING_NEEDLE_O   = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/ring_needle.dds", OrangeColor)

local RING_RPM_G      = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/ring_rpm.dds", GreenColor)
local RING_RPM_O      = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/ring_rpm.dds", YellowColor)

local RING_OIL_R      = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/ring_oil.dds", RedColor)   
local RING_OIL_G      = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/ring_oil.dds", GreenColor) 

local RING_HYD_G       = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/ring_hyd.dds", GreenColor)
local RING_HYD_R       = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/ring_hyd.dds", RedColor)  

local RING_LINE      = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/ring_line.dds", GreenColor)
local RING_BOX       = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/ring_box.dds", GreenColor)
local RING_CABIN     = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/ring_cabin.dds", GreenColor)
local IND_BOX_WIDE	    = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/ind_box_wide.dds", WhiteColor)
------------------------------------------------------------------------------------------------CLIPPING-MASK-------------------------------------------
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
    total_field_of_view.init_pos        = {0, 0, -0.2}
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
    clipPoly.init_pos            = {0, 0, -0.2}
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
BGROUND.element_params 		= {"MFD_OPACITY","LMFD_STARTUP_PAGE"}--this may not be bneeded check when more pages done for backlight on page 7 SMS fc3 bs
BGROUND.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}--MENU PAGE = 1
BGROUND.level 				= 2
BGROUND.h_clip_relation     = h_clip_relations.COMPARE
vertices(BGROUND,3)
Add(BGROUND)
----------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------
MENU 					    = CreateElement "ceStringPoly"
MENU.name 				    = "MENU"
MENU.material 			    = UFD_FONT
MENU.value 				    = "MENU"
MENU.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
MENU.alignment 			    = "CenterCenter"
MENU.formats 			    = {"%s"}
MENU.h_clip_relation         = h_clip_relations.COMPARE
MENU.level 				    = 2
MENU.init_pos 			    = {-0.565, 0.92, 0}
MENU.init_rot 			    = {0, 0, 0}
MENU.element_params 	        = {"MFD_OPACITY","LMFD_STARTUP_PAGE","MAIN_POWER"}
MENU.controllers		        =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.9,1.1}}
Add(MENU)

CHECK_BAY1 					    = CreateElement "ceStringPoly"
CHECK_BAY1.name 				    = "CHECK_BAY1"
CHECK_BAY1.material 			    = UFD_YEL
CHECK_BAY1.value 				    = "CHECK WEAPONS BAY"
CHECK_BAY1.stringdefs 		        = {0.0060, 0.0060, 0.0002, 0.001}
CHECK_BAY1.alignment 			    = "CenterCenter"
CHECK_BAY1.formats 			    = {"%s"}
CHECK_BAY1.h_clip_relation         = h_clip_relations.COMPARE
CHECK_BAY1.level 				    = 2
CHECK_BAY1.init_pos 			    = {0,-0.80, 0}
CHECK_BAY1.init_rot 			    = {0, 0, 0}
CHECK_BAY1.element_params 	        = {"MFD_OPACITY","LMFD_STARTUP_PAGE","CHECK_BAYS"}
CHECK_BAY1.controllers		        =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.9,1.1},}
Add(CHECK_BAY1)



WEIGHTTXT 					    = CreateElement "ceStringPoly"
WEIGHTTXT.name 				    = "WEIGHTTXT"
WEIGHTTXT.material 			    = UFD_GRN
WEIGHTTXT.value 				    = "CURRENT WEIGHT:"
WEIGHTTXT.stringdefs 		        = {0.0060, 0.0060, 0.0002, 0.001}
WEIGHTTXT.alignment 			    = "CenterCenter"
WEIGHTTXT.formats 			    = {"%s"}
WEIGHTTXT.h_clip_relation         = h_clip_relations.COMPARE
WEIGHTTXT.level 				    = 2
WEIGHTTXT.init_pos 			    = {0.01,-0.19, 0}
WEIGHTTXT.init_rot 			    = {0, 0, 0}
WEIGHTTXT.element_params 	        = {"MFD_OPACITY","LMFD_STARTUP_PAGE",}
WEIGHTTXT.controllers		        =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},}
Add(WEIGHTTXT)


WEIGHTVAL				    = CreateElement "ceStringPoly"
WEIGHTVAL.name				= "WEIGHTVAL"
WEIGHTVAL.material			= UFD_FONT
WEIGHTVAL.init_pos			= {0.01,-0.3, 0} --L-R,U-D,F-B
WEIGHTVAL.alignment			= "CenterCenter"
WEIGHTVAL.stringdefs			= {0.0055, 0.0055, 0.0002, 0.001} --either 004 or 005
WEIGHTVAL.additive_alpha		= true
WEIGHTVAL.collimated			= false
WEIGHTVAL.isdraw				= true	
WEIGHTVAL.use_mipfilter		= true
WEIGHTVAL.h_clip_relation	= h_clip_relations.COMPARE
WEIGHTVAL.level				= 2
WEIGHTVAL.element_params		= {"MFD_OPACITY","CURRENT_WEIGHT","LMFD_STARTUP_PAGE"}
WEIGHTVAL.formats			= {"%.0f"}--= {"%02.0f"}
WEIGHTVAL.controllers		=   {
                                        {"opacity_using_parameter",0},
                                        {"text_using_parameter",1,0},
                                        {"parameter_in_range",2,0.9,1.1},

                                    }
                                
Add(WEIGHTVAL)


L_ENG_TEXT 					    = CreateElement "ceStringPoly"
L_ENG_TEXT.name 				    = "L_ENG_TEXT"
L_ENG_TEXT.material 			    = UFD_FONT
L_ENG_TEXT.value 				    = "LEFT ENGINE"
L_ENG_TEXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
L_ENG_TEXT.alignment 			    = "CenterCenter"
L_ENG_TEXT.formats 			    = {"%s"}
L_ENG_TEXT.h_clip_relation         = h_clip_relations.COMPARE
L_ENG_TEXT.level 				    = 2
L_ENG_TEXT.init_pos 			    = {-0.35, 0.82, 0}
L_ENG_TEXT.init_rot 			    = {0, 0, 0}
L_ENG_TEXT.element_params 	        = {"MFD_OPACITY","LMFD_STARTUP_PAGE"}
L_ENG_TEXT.controllers		        =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(L_ENG_TEXT)

R_ENG_TEXT 					    = CreateElement "ceStringPoly"
R_ENG_TEXT.name 				    = "R_ENG_TEXT"
R_ENG_TEXT.material 			    = UFD_FONT
R_ENG_TEXT.value 				    = "RIGHT ENGINE"
R_ENG_TEXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
R_ENG_TEXT.alignment 			    = "CenterCenter"
R_ENG_TEXT.formats 			    = {"%s"}
R_ENG_TEXT.h_clip_relation         = h_clip_relations.COMPARE
R_ENG_TEXT.level 				    = 2
R_ENG_TEXT.init_pos 			    = {0.35, 0.82, 0}
R_ENG_TEXT.init_rot 			    = {0, 0, 0}
R_ENG_TEXT.element_params 	        = {"MFD_OPACITY","LMFD_STARTUP_PAGE"}
R_ENG_TEXT.controllers		        =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(R_ENG_TEXT)

HMDPOWERTXT 					        = CreateElement "ceStringPoly"
HMDPOWERTXT.name 				    = "HMDPOWERTXT"
HMDPOWERTXT.material 			    = UFD_FONT
HMDPOWERTXT.value 				    = "HMD POWER"
HMDPOWERTXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
HMDPOWERTXT.alignment 			    = "CenterCenter"
HMDPOWERTXT.formats 			        = {"%s"}
HMDPOWERTXT.h_clip_relation          = h_clip_relations.COMPARE
HMDPOWERTXT.level 				    = 2
HMDPOWERTXT.init_pos 			    = {0.75,-0.70, 0}
HMDPOWERTXT.init_rot 			    = {0, 0, 0}
HMDPOWERTXT.element_params 	        = {"MFD_OPACITY","LMFD_STARTUP_PAGE"}
HMDPOWERTXT.controllers		        =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},}
Add(HMDPOWERTXT)


HMDPOWERBOX 					    = CreateElement "ceTexPoly"
HMDPOWERBOX.name 				    = "HMDPOWERBOX"
HMDPOWERBOX.material 			    = IND_BOX_WIDE 
HMDPOWERBOX.change_opacity 	= false
HMDPOWERBOX.collimated 		= false
HMDPOWERBOX.isvisible 			= true
HMDPOWERBOX.init_pos 			= {0.77, -0.655, 0} --L-R,U-D,F-B
HMDPOWERBOX.init_rot 			= {0, 0, 0}
HMDPOWERBOX.element_params 		= {"MFD_OPACITY","LMFD_STARTUP_PAGE","HMD_POWER"}
HMDPOWERBOX.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.9,1.1},}
HMDPOWERBOX.level 				= 2
HMDPOWERBOX.h_clip_relation     = h_clip_relations.COMPARE
vertices(HMDPOWERBOX, 3.75)
Add(HMDPOWERBOX)

CANOPYTXT 					        = CreateElement "ceStringPoly"
CANOPYTXT.name 				    = "CANOPYTXT"
CANOPYTXT.material 			    = UFD_FONT
CANOPYTXT.value 				    = "CANOPY"
CANOPYTXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
CANOPYTXT.alignment 			    = "CenterCenter"
CANOPYTXT.formats 			        = {"%s"}
CANOPYTXT.h_clip_relation          = h_clip_relations.COMPARE
CANOPYTXT.level 				    = 2
CANOPYTXT.init_pos 			    = {-0.85,-0.70, 0}
CANOPYTXT.init_rot 			    = {0, 0, 0}
CANOPYTXT.element_params 	        = {"MFD_OPACITY","LMFD_STARTUP_PAGE"}
CANOPYTXT.controllers		        =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},}
Add(CANOPYTXT)

CANOPY_OPEN 					        = CreateElement "ceStringPoly"
CANOPY_OPEN.name 				    = "CANOPY_OPEN"
CANOPY_OPEN.material 			    = UFD_YEL
CANOPY_OPEN.value 				    = "OPEN"
CANOPY_OPEN.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
CANOPY_OPEN.alignment 			    = "CenterCenter"
CANOPY_OPEN.formats 			        = {"%s"}
CANOPY_OPEN.h_clip_relation          = h_clip_relations.COMPARE
CANOPY_OPEN.level 				    = 2
CANOPY_OPEN.init_pos 			    = {-0.62,-0.70, 0}
CANOPY_OPEN.init_rot 			    = {0, 0, 0}
CANOPY_OPEN.element_params 	        = {"MFD_OPACITY","LMFD_STARTUP_PAGE","CANOPY_STATE","CANOPY_STATE"}
CANOPY_OPEN.controllers		        =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.101,0.949},}
Add(CANOPY_OPEN)

CANOPY_CLOSED 					        = CreateElement "ceStringPoly"
CANOPY_CLOSED.name 				    = "CANOPY_CLOSED"
CANOPY_CLOSED.material 			    = UFD_FONT
CANOPY_CLOSED.value 				    = "CLOSED"
CANOPY_CLOSED.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
CANOPY_CLOSED.alignment 			    = "CenterCenter"
CANOPY_CLOSED.formats 			        = {"%s"}
CANOPY_CLOSED.h_clip_relation          = h_clip_relations.COMPARE
CANOPY_CLOSED.level 				    = 2
CANOPY_CLOSED.init_pos 			    = {-0.58,-0.70, 0}
CANOPY_CLOSED.init_rot 			    = {0, 0, 0}
CANOPY_CLOSED.element_params 	        = {"MFD_OPACITY","LMFD_STARTUP_PAGE","CANOPY_STATE"}
CANOPY_CLOSED.controllers		        =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,-0.1,0.1},}
Add(CANOPY_CLOSED)


R_RING_RPM_G                    = CreateElement "ceTexPoly"
R_RING_RPM_G.name    			= "ring green"
R_RING_RPM_G.material			= RING_RPM_G
R_RING_RPM_G.change_opacity 	= false
R_RING_RPM_G.collimated 		= false
R_RING_RPM_G.isvisible 			= true
R_RING_RPM_G.init_pos 			= {0.35, 0.6, 0} --L-R,U-D,F-B
R_RING_RPM_G.init_rot 			= {0, 0, 0}
R_RING_RPM_G.element_params 	= {"MFD_OPACITY","R_RPM_COLOR","LMFD_STARTUP_PAGE"} 
R_RING_RPM_G.controllers		= {
                                    {"opacity_using_parameter",0},
                                    {"parameter_in_range",1,0.4,0.6},--
                                    {"parameter_in_range",2,0.9,1.1},--
                                   
                                }
R_RING_RPM_G.level 				    = 2
R_RING_RPM_G.h_clip_relation        = h_clip_relations.COMPARE
vertices(R_RING_RPM_G,0.3)
Add(R_RING_RPM_G)
------------------------------------------------------------------------------------------------RPM-RING-ORANGE-R
R_RING_RPM_O                    = CreateElement "ceTexPoly"
R_RING_RPM_O.name    			= "ring green"
R_RING_RPM_O.material			= RING_RPM_O
R_RING_RPM_O.change_opacity 	= false
R_RING_RPM_O.collimated 		= false
R_RING_RPM_O.isvisible 			= true
R_RING_RPM_O.init_pos 			= {0.35, 0.6, 0} --L-R,U-D,F-B
R_RING_RPM_O.init_rot 			= {0, 0, 0}
R_RING_RPM_O.element_params 	= {"MFD_OPACITY","R_RPM_COLOR","LMFD_STARTUP_PAGE"} 
R_RING_RPM_O.controllers		= {
                                    {"opacity_using_parameter",0},
                                    {"parameter_in_range",1,0.9,1.1},--
                                    {"parameter_in_range",2,0.9,1.1},--
                                   
                                }
R_RING_RPM_O.level 				    = 2
R_RING_RPM_O.h_clip_relation        = h_clip_relations.COMPARE
vertices(R_RING_RPM_O,0.3)
Add(R_RING_RPM_O)
------------------------------------------------------------------------------------------------RPM-NEEDLE-YELLOW-R
R_NEEDLE_RPM_G                     = CreateElement "ceTexPoly"
R_NEEDLE_RPM_G.name    			= "needle y"
R_NEEDLE_RPM_G.material			= RING_NEEDLE_G
R_NEEDLE_RPM_G.change_opacity 	    = false
R_NEEDLE_RPM_G.collimated 		    = false
R_NEEDLE_RPM_G.isvisible 	        = true
R_NEEDLE_RPM_G.init_pos 			= {0.35, 0.6, 0} --L-R,U-D,F-B
R_NEEDLE_RPM_G.init_rot 			= {0, 0, 0}
R_NEEDLE_RPM_G.element_params 	    = {"MFD_OPACITY","R_RPM_COLOR","LMFD_STARTUP_PAGE","RPM_R"} 
R_NEEDLE_RPM_G.controllers		    = {
                                        {"opacity_using_parameter",0},
                                        {"parameter_in_range",1,0.4,0.6},--Yellow
                                        {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                        {"rotate_using_parameter",3, -0.04280,0}
                                    }
R_NEEDLE_RPM_G.level 				= 2
R_NEEDLE_RPM_G.h_clip_relation     = h_clip_relations.COMPARE
vertices(R_NEEDLE_RPM_G ,0.3)
Add(R_NEEDLE_RPM_G )
------------------------------------------------------------------------------------------------RPM-NEEDLE-ORANGE-R
R_NEEDLE_RPM_O                      = CreateElement "ceTexPoly"
R_NEEDLE_RPM_O .name    			= "needle y"
R_NEEDLE_RPM_O .material			= RING_NEEDLE_Y
R_NEEDLE_RPM_O .change_opacity 	    = false
R_NEEDLE_RPM_O .collimated 		    = false
R_NEEDLE_RPM_O .isvisible 	        = true
R_NEEDLE_RPM_O .init_pos 			= {0.35, 0.6, 0} --L-R,U-D,F-B
R_NEEDLE_RPM_O .init_rot 			= {0, 0, 0}
R_NEEDLE_RPM_O .element_params 	    = {"MFD_OPACITY","R_RPM_COLOR","LMFD_STARTUP_PAGE","RPM_R"} 
R_NEEDLE_RPM_O .controllers		    = {
                                        {"opacity_using_parameter",0},
                                        {"parameter_in_range",1,0.9,1.1},--ORANGE
                                        {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                        {"rotate_using_parameter",3, -0.04280,0}
                                    }
R_NEEDLE_RPM_O .level 				= 2
R_NEEDLE_RPM_O .h_clip_relation     = h_clip_relations.COMPARE
vertices(R_NEEDLE_RPM_O ,0.3)
Add(R_NEEDLE_RPM_O)
------------------------------------------------------------------------------------------------EGT-RING-GREEN
R_RING_EGT_G                    = CreateElement "ceTexPoly"
R_RING_EGT_G.name    			= "ring green"
R_RING_EGT_G.material			= RING_EGT_G
R_RING_EGT_G.change_opacity 	= false
R_RING_EGT_G.collimated 		= false
R_RING_EGT_G.isvisible 			= true
R_RING_EGT_G.init_pos 			= {0.35, 0.3, 0} --L-R,U-D,F-B
R_RING_EGT_G.init_rot 			= {0, 0, 0}
R_RING_EGT_G.element_params 	= {"MFD_OPACITY","R_EGT_COLOR","LMFD_STARTUP_PAGE"} 
R_RING_EGT_G.controllers		= {
                                    {"opacity_using_parameter",0},
                                    {"parameter_in_range",1,-0.1,0.1},--Green
                                    {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                   
                                }
R_RING_EGT_G.level 				    = 2
R_RING_EGT_G.h_clip_relation        = h_clip_relations.COMPARE
vertices(R_RING_EGT_G,0.3)
Add(R_RING_EGT_G)
------------------------------------------------------------------------------------------------EGT-NEEDLE-GREEN
R_NEEDLE_EGT_G                      = CreateElement "ceTexPoly"
R_NEEDLE_EGT_G .name    			= "needle g"
R_NEEDLE_EGT_G .material			= RING_NEEDLE_G
R_NEEDLE_EGT_G .change_opacity 	    = false
R_NEEDLE_EGT_G .collimated 		    = false
R_NEEDLE_EGT_G .isvisible 	        = true
R_NEEDLE_EGT_G .init_pos 			= {0.35, 0.3, 0} --L-R,U-D,F-B
R_NEEDLE_EGT_G .init_rot 			= {0, 0, 0}
R_NEEDLE_EGT_G .element_params 	    = {"MFD_OPACITY","R_EGT_COLOR","LMFD_STARTUP_PAGE","EGT_R"} 
R_NEEDLE_EGT_G .controllers		    = {
                                        {"opacity_using_parameter",0},
                                        {"parameter_in_range",1,-0.1,0.1},--Green
                                        {"parameter_in_range",2, 0.9,1.1},--ENGINE PAGE = 1
                                        {"rotate_using_parameter",3, -0.00427,0}
                                    }
R_NEEDLE_EGT_G .level 				= 2
R_NEEDLE_EGT_G .h_clip_relation     = h_clip_relations.COMPARE
vertices(R_NEEDLE_EGT_G ,0.3)
Add(R_NEEDLE_EGT_G )
------------------------------------------------------------------------------------------------EGT-RING-YELLOW
R_RING_EGT_Y                    = CreateElement "ceTexPoly"
R_RING_EGT_Y.name    			= "ring y"
R_RING_EGT_Y.material			= RING_EGT_Y
R_RING_EGT_Y.change_opacity 	= false
R_RING_EGT_Y.collimated 		= false
R_RING_EGT_Y.isvisible 		    = true
R_RING_EGT_Y.init_pos 		    = {0.35, 0.3, 0} --L-R,U-D,F-B
R_RING_EGT_Y.init_rot 		    = {0, 0, 0}
R_RING_EGT_Y.element_params 	= {"MFD_OPACITY","R_EGT_COLOR","LMFD_STARTUP_PAGE"} 
R_RING_EGT_Y.controllers		= {
                                    {"opacity_using_parameter",0},
                                    {"parameter_in_range",1,0.4,0.6},--Green
                                    {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                   
                                }
R_RING_EGT_Y.level 			     = 2
R_RING_EGT_Y.h_clip_relation     = h_clip_relations.COMPARE
vertices(R_RING_EGT_Y,0.3)
Add(R_RING_EGT_Y)
------------------------------------------------------------------------------------------------EGT-NEEDLE-YELLOW
R_NEEDLE_EGT_Y                      = CreateElement "ceTexPoly"
R_NEEDLE_EGT_Y .name    			= "needle y"
R_NEEDLE_EGT_Y .material			= RING_NEEDLE_Y
R_NEEDLE_EGT_Y .change_opacity 	    = false
R_NEEDLE_EGT_Y .collimated 		    = false
R_NEEDLE_EGT_Y .isvisible 	        = true
R_NEEDLE_EGT_Y .init_pos 			= {0.35, 0.3, 0} --L-R,U-D,F-B
R_NEEDLE_EGT_Y .init_rot 			= {0, 0, 0}
R_NEEDLE_EGT_Y .element_params 	    = {"MFD_OPACITY","R_EGT_COLOR","LMFD_STARTUP_PAGE","EGT_R"} 
R_NEEDLE_EGT_Y .controllers		    = {
                                        {"opacity_using_parameter",0},
                                        {"parameter_in_range",1,0.4,0.6},--Yellow
                                        {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                        {"rotate_using_parameter",3, -0.00427,0}
                                    }
R_NEEDLE_EGT_Y .level 				= 2
R_NEEDLE_EGT_Y .h_clip_relation     = h_clip_relations.COMPARE
vertices(R_NEEDLE_EGT_Y ,0.3)
Add(R_NEEDLE_EGT_Y)
------------------------------------------------------------------------------------------------EGT-RING-RED
R_RING_EGT_R                    = CreateElement "ceTexPoly"
R_RING_EGT_R.name    			= "ring r"
R_RING_EGT_R.material			= RING_EGT_R
R_RING_EGT_R.change_opacity 	= false
R_RING_EGT_R.collimated 		= false
R_RING_EGT_R.isvisible 		    = true
R_RING_EGT_R.init_pos 		    = {0.35, 0.3, 0} --L-R,U-D,F-B
R_RING_EGT_R.init_rot 		    = {0, 0, 0}
R_RING_EGT_R.element_params 	= {"MFD_OPACITY","R_EGT_COLOR","LMFD_STARTUP_PAGE"} 
R_RING_EGT_R.controllers		= {
                                    {"opacity_using_parameter",0},
                                    {"parameter_in_range",1,0.9,1.1},-- RED
                                    {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                   
                                }
R_RING_EGT_R.level 			     = 2
R_RING_EGT_R.h_clip_relation     = h_clip_relations.COMPARE
vertices(R_RING_EGT_R,0.3)
Add(R_RING_EGT_R)
------------------------------------------------------------------------------------------------EGT-NEEDLE-RED
R_NEEDLE_EGT_R                      = CreateElement "ceTexPoly"
R_NEEDLE_EGT_R.name    			    = "needle r"
R_NEEDLE_EGT_R.material			    = RING_NEEDLE_R
R_NEEDLE_EGT_R.change_opacity 	    = false
R_NEEDLE_EGT_R.collimated 		    = false
R_NEEDLE_EGT_R.isvisible 	        = true
R_NEEDLE_EGT_R.init_pos 			= {0.35, 0.3, 0} --L-R,U-D,F-B
R_NEEDLE_EGT_R.init_rot 			= {0, 0, 0}
R_NEEDLE_EGT_R.element_params 	    = {"MFD_OPACITY","R_EGT_COLOR","LMFD_STARTUP_PAGE","EGT_R"} 
R_NEEDLE_EGT_R.controllers		    = {
                                        {"opacity_using_parameter",0},
                                        {"parameter_in_range",1,0.9,1.1},--RED
                                        {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                        {"rotate_using_parameter",3, -0.00427,0}
                                    }
R_NEEDLE_EGT_R.level 				= 2
R_NEEDLE_EGT_R.h_clip_relation      = h_clip_relations.COMPARE
vertices(R_NEEDLE_EGT_R ,0.3)
Add(R_NEEDLE_EGT_R)
------------------------------------------------------------------------------------------------OIL-RING-RED
R_RING_OIL_R                    = CreateElement "ceTexPoly"
R_RING_OIL_R.name    			= "ring green"
R_RING_OIL_R.material			= RING_OIL_R
R_RING_OIL_R.change_opacity 	= false
R_RING_OIL_R.collimated 		= false
R_RING_OIL_R.isvisible 			= true
R_RING_OIL_R.init_pos 			= {0.33, 0.03, 0} --L-R,U-D,F-B
R_RING_OIL_R.init_rot 			= {0, 0, 0}
R_RING_OIL_R.element_params 	= {"MFD_OPACITY","R_OIL_COLOR","LMFD_STARTUP_PAGE"} 
R_RING_OIL_R.controllers		= {
                                    {"opacity_using_parameter",0},
                                    {"parameter_in_range",1,0.9,1.1},
                                    {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                   
                                }
R_RING_OIL_R.level 				    = 2
R_RING_OIL_R.h_clip_relation        = h_clip_relations.COMPARE
vertices(R_RING_OIL_R,0.20)
Add(R_RING_OIL_R)
------------------------------------------------------------------------------------------------OIL-NEEDLE-RED
R_NEEDLE_OIL_R                      = CreateElement "ceTexPoly"
R_NEEDLE_OIL_R.name    			    = "needle r"
R_NEEDLE_OIL_R.material			    = RING_NEEDLE_R
R_NEEDLE_OIL_R.change_opacity 	    = false
R_NEEDLE_OIL_R.collimated 		    = false
R_NEEDLE_OIL_R.isvisible 	        = true
R_NEEDLE_OIL_R.init_pos 			= {0.33, 0.03, 0} --L-R,U-D,F-B
R_NEEDLE_OIL_R.init_rot 			= {0, 0, 0}
R_NEEDLE_OIL_R.element_params 	    = {"MFD_OPACITY","R_OIL_COLOR","LMFD_STARTUP_PAGE","RPM_R"} 
R_NEEDLE_OIL_R.controllers		    = {
                                        {"opacity_using_parameter",0},
                                        {"parameter_in_range",1,0.9,1.1},--RED
                                        {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                        {"rotate_using_parameter",3, -0.03926,0}
                                    }
R_NEEDLE_OIL_R.level 				= 2
R_NEEDLE_OIL_R.h_clip_relation      = h_clip_relations.COMPARE
vertices(R_NEEDLE_OIL_R,0.20)
Add(R_NEEDLE_OIL_R)
-------------------------------------------------------------------------------------------------OIL-RING-GREEN
R_RING_OIL_G                    = CreateElement "ceTexPoly"
R_RING_OIL_G.name    			= "ring green"
R_RING_OIL_G.material			= RING_OIL_G
R_RING_OIL_G.change_opacity 	= false
R_RING_OIL_G.collimated 		= false
R_RING_OIL_G.isvisible 			= true
R_RING_OIL_G.init_pos 			= {0.33, 0.03, 0} --L-R,U-D,F-B
R_RING_OIL_G.init_rot 			= {0, 0, 0}
R_RING_OIL_G.element_params 	= {"MFD_OPACITY","R_OIL_COLOR","LMFD_STARTUP_PAGE"} 
R_RING_OIL_G.controllers		= {
                                    {"opacity_using_parameter",0},
                                    {"parameter_in_range",1,-0.1,0.1},--Green
                                    {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                   
                                }
R_RING_OIL_G.level 				    = 2
R_RING_OIL_G.h_clip_relation        = h_clip_relations.COMPARE
vertices(R_RING_OIL_G,0.20)
Add(R_RING_OIL_G)
------------------------------------------------------------------------------------------------OIL-NEEDLE-GREEN--RIGHT
R_NEEDLE_OIL_G                      = CreateElement "ceTexPoly"
R_NEEDLE_OIL_G.name    			    = "needle r"
R_NEEDLE_OIL_G.material			    = RING_NEEDLE_G
R_NEEDLE_OIL_G.change_opacity 	    = false
R_NEEDLE_OIL_G.collimated 		    = false
R_NEEDLE_OIL_G.isvisible 	        = true
R_NEEDLE_OIL_G.init_pos 			= {0.33, 0.03, 0} --L-R,U-D,F-B
R_NEEDLE_OIL_G.init_rot 			= {0, 0, 0}
R_NEEDLE_OIL_G.element_params 	    = {"MFD_OPACITY","R_OIL_COLOR","LMFD_STARTUP_PAGE","RPM_R"} 
R_NEEDLE_OIL_G.controllers		    = {
                                        {"opacity_using_parameter",0},
                                        {"parameter_in_range",1,-0.1,0.1},--green
                                        {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                        {"rotate_using_parameter",3, -0.03926,0}
                                    }
R_NEEDLE_OIL_G.level 				= 2
R_NEEDLE_OIL_G.h_clip_relation      = h_clip_relations.COMPARE
vertices(R_NEEDLE_OIL_G ,0.20)
Add(R_NEEDLE_OIL_G)-----END RIGHT
------------------------------------------------------------------------------------------------RPM-RING-YELLOW-R
L_RING_RPM_G                    = CreateElement "ceTexPoly"
L_RING_RPM_G.name    			= "ring green"
L_RING_RPM_G.material			= RING_RPM_G
L_RING_RPM_G.change_opacity 	= false
L_RING_RPM_G.collimated 		= false
L_RING_RPM_G.isvisible 			= true
L_RING_RPM_G.init_pos 			= {-0.35, 0.6, 0} --L-R,U-D,F-B
L_RING_RPM_G.init_rot 			= {0, 0, 0}
L_RING_RPM_G.element_params 	= {"MFD_OPACITY","L_RPM_COLOR","LMFD_STARTUP_PAGE"} 
L_RING_RPM_G.controllers		= {
                                    {"opacity_using_parameter",0},
                                    {"parameter_in_range",1,0.4,0.6},--
                                    {"parameter_in_range",2,0.9,1.1},--
                                   
                                }
L_RING_RPM_G.level 				    = 2
L_RING_RPM_G.h_clip_relation        = h_clip_relations.COMPARE
vertices(L_RING_RPM_G,0.3)
Add(L_RING_RPM_G)
------------------------------------------------------------------------------------------------RPM-RING-ORANGE-R
L_RING_RPM_O                    = CreateElement "ceTexPoly"
L_RING_RPM_O.name    			= "ring green"
L_RING_RPM_O.material			= RING_RPM_O
L_RING_RPM_O.change_opacity 	= false
L_RING_RPM_O.collimated 		= false
L_RING_RPM_O.isvisible 			= true
L_RING_RPM_O.init_pos 			= {-0.35, 0.6, 0} --L-R,U-D,F-B
L_RING_RPM_O.init_rot 			= {0, 0, 0}
L_RING_RPM_O.element_params 	= {"MFD_OPACITY","L_RPM_COLOR","LMFD_STARTUP_PAGE"} 
L_RING_RPM_O.controllers		= {
                                    {"opacity_using_parameter",0},
                                    {"parameter_in_range",1,0.9,1.1},--
                                    {"parameter_in_range",2,0.9,1.1},--
                                   
                                }
L_RING_RPM_O.level 				    = 2
L_RING_RPM_O.h_clip_relation        = h_clip_relations.COMPARE
vertices(L_RING_RPM_O,0.3)
Add(L_RING_RPM_O)
------------------------------------------------------------------------------------------------RPM-NEEDLE-YELLOW-R
L_NEEDLE_RPM_G                     = CreateElement "ceTexPoly"
L_NEEDLE_RPM_G.name    			= "needle y"
L_NEEDLE_RPM_G.material			= RING_NEEDLE_G
L_NEEDLE_RPM_G.change_opacity 	    = false
L_NEEDLE_RPM_G.collimated 		    = false
L_NEEDLE_RPM_G.isvisible 	        = true
L_NEEDLE_RPM_G.init_pos 			= {-0.35, 0.6, 0} --L-R,U-D,F-B
L_NEEDLE_RPM_G.init_rot 			= {0, 0, 0}
L_NEEDLE_RPM_G.element_params 	    = {"MFD_OPACITY","L_RPM_COLOR","LMFD_STARTUP_PAGE","RPM_L"} 
L_NEEDLE_RPM_G.controllers		    = {
                                        {"opacity_using_parameter",0},
                                        {"parameter_in_range",1,0.4,0.6},--Yellow
                                        {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                        {"rotate_using_parameter",3, -0.04280,0}
                                    }
L_NEEDLE_RPM_G.level 				= 2
L_NEEDLE_RPM_G.h_clip_relation     = h_clip_relations.COMPARE
vertices(L_NEEDLE_RPM_G ,0.3)
Add(L_NEEDLE_RPM_G )
------------------------------------------------------------------------------------------------RPM-NEEDLE-ORANGE-R
L_NEEDLE_RPM_O                      = CreateElement "ceTexPoly"
L_NEEDLE_RPM_O .name    			= "needle y"
L_NEEDLE_RPM_O .material			= RING_NEEDLE_Y
L_NEEDLE_RPM_O .change_opacity 	    = false
L_NEEDLE_RPM_O .collimated 		    = false
L_NEEDLE_RPM_O .isvisible 	        = true
L_NEEDLE_RPM_O .init_pos 			= {-0.35, 0.6, 0} --L-R,U-D,F-B
L_NEEDLE_RPM_O .init_rot 			= {0, 0, 0}
L_NEEDLE_RPM_O .element_params 	    = {"MFD_OPACITY","L_RPM_COLOR","LMFD_STARTUP_PAGE","RPM_L"} 
L_NEEDLE_RPM_O .controllers		    = {
                                        {"opacity_using_parameter",0},
                                        {"parameter_in_range",1,0.9,1.1},--ORANGE
                                        {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                        {"rotate_using_parameter",3, -0.04280,0}
                                    }
L_NEEDLE_RPM_O .level 				= 2
L_NEEDLE_RPM_O .h_clip_relation     = h_clip_relations.COMPARE
vertices(L_NEEDLE_RPM_O ,0.3)
Add(L_NEEDLE_RPM_O)
------------------------------------------------------------------------------------------------OIL-RING-RED--LEF
L_RING_OIL_R                    = CreateElement "ceTexPoly"
L_RING_OIL_R.name    			= "ring green"
L_RING_OIL_R.material			= RING_OIL_R
L_RING_OIL_R.change_opacity 	= false
L_RING_OIL_R.collimated 		= false
L_RING_OIL_R.isvisible 			= true
L_RING_OIL_R.init_pos 			= {-0.33, 0.03, 0} --L-R,U-D,F-B
L_RING_OIL_R.init_rot 			= {0, 0, 0}
L_RING_OIL_R.element_params 	= {"MFD_OPACITY","L_OIL_COLOR","LMFD_STARTUP_PAGE"} 
L_RING_OIL_R.controllers		= {
                                    {"opacity_using_parameter",0},
                                    {"parameter_in_range",1,0.9,1.1},
                                    {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                   
                                }
L_RING_OIL_R.level 				    = 2
L_RING_OIL_R.h_clip_relation        = h_clip_relations.COMPARE
vertices(L_RING_OIL_R,0.2)
Add(L_RING_OIL_R)
------------------------------------------------------------------------------------------------OIL-NEEDLE-RED--LEFT
L_NEEDLE_OIL_L                      = CreateElement "ceTexPoly"
L_NEEDLE_OIL_L.name    			    = "needle r"
L_NEEDLE_OIL_L.material			    = RING_NEEDLE_R
L_NEEDLE_OIL_L.change_opacity 	    = false
L_NEEDLE_OIL_L.collimated 		    = false
L_NEEDLE_OIL_L.isvisible 	        = true
L_NEEDLE_OIL_L.init_pos 			= {-0.33, 0.03, 0} --L-R,U-D,F-B
L_NEEDLE_OIL_L.init_rot 			= {0, 0, 0}
L_NEEDLE_OIL_L.element_params 	    = {"MFD_OPACITY","L_OIL_COLOR","LMFD_STARTUP_PAGE","RPM_L"} 
L_NEEDLE_OIL_L.controllers		    = {
                                        {"opacity_using_parameter",0},
                                        {"parameter_in_range",1,0.9,1.1},--RED
                                        {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                        {"rotate_using_parameter",3, -0.03926,0}
                                    }
L_NEEDLE_OIL_L.level 				= 2
L_NEEDLE_OIL_L.h_clip_relation      = h_clip_relations.COMPARE
vertices(L_NEEDLE_OIL_L,0.2)
Add(L_NEEDLE_OIL_L)
-------------------------------------------------------------------------------------------------OIL-RING-GREEN--LEFT
L_RING_OIL_G                    = CreateElement "ceTexPoly"
L_RING_OIL_G.name    			= "ring green"
L_RING_OIL_G.material			= RING_OIL_G
L_RING_OIL_G.change_opacity 	= false
L_RING_OIL_G.collimated 		= false
L_RING_OIL_G.isvisible 			= true
L_RING_OIL_G.init_pos 			= {-0.33, 0.03, 0} --L-R,U-D,F-B
L_RING_OIL_G.init_rot 			= {0, 0, 0}
L_RING_OIL_G.element_params 	= {"MFD_OPACITY","L_OIL_COLOR","LMFD_STARTUP_PAGE"} 
L_RING_OIL_G.controllers		= {
                                    {"opacity_using_parameter",0},
                                    {"parameter_in_range",1,-0.1,0.1},--Green
                                    {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                   
                                }
L_RING_OIL_G.level 				    = 2
L_RING_OIL_G.h_clip_relation        = h_clip_relations.COMPARE
vertices(L_RING_OIL_G,0.2)
Add(L_RING_OIL_G)
------------------------------------------------------------------------------------------------OIL-NEEDLE-GREEN--LEFT
L_NEEDLE_OIL_G                      = CreateElement "ceTexPoly"
L_NEEDLE_OIL_G.name    			    = "needle r"
L_NEEDLE_OIL_G.material			    = RING_NEEDLE_G
L_NEEDLE_OIL_G.change_opacity 	    = false
L_NEEDLE_OIL_G.collimated 		    = false
L_NEEDLE_OIL_G.isvisible 	        = true
L_NEEDLE_OIL_G.init_pos 			= {-0.33, 0.03, 0} --L-R,U-D,F-B
L_NEEDLE_OIL_G.init_rot 			= {0, 0, 0}
L_NEEDLE_OIL_G.element_params 	    = {"MFD_OPACITY","L_OIL_COLOR","LMFD_STARTUP_PAGE","RPM_L"} 
L_NEEDLE_OIL_G.controllers		    = {
                                        {"opacity_using_parameter",0},
                                        {"parameter_in_range",1,-0.1,0.1},--green
                                        {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                        {"rotate_using_parameter",3, -0.03926,0}
                                    }
L_NEEDLE_OIL_G.level 				= 2
L_NEEDLE_OIL_G.h_clip_relation      = h_clip_relations.COMPARE
vertices(L_NEEDLE_OIL_G ,0.2)
Add(L_NEEDLE_OIL_G)
------------------------------------------------------------------------------------------------EGT-RING-GREEN--LEFT
L_RING_EGT_G                    = CreateElement "ceTexPoly"
L_RING_EGT_G.name    			= "ring green"
L_RING_EGT_G.material			= RING_EGT_G
L_RING_EGT_G.change_opacity 	= false
L_RING_EGT_G.collimated 		= false
L_RING_EGT_G.isvisible 			= true
L_RING_EGT_G.init_pos 			= {-0.35, 0.3, 0} --L-R,U-D,F-B
L_RING_EGT_G.init_rot 			= {0, 0, 0}
L_RING_EGT_G.element_params 	= {"MFD_OPACITY","L_EGT_COLOR","LMFD_STARTUP_PAGE"} 
L_RING_EGT_G.controllers		= {
                                    {"opacity_using_parameter",0},
                                    {"parameter_in_range",1,-0.1,0.1},--Green
                                    {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                   
                                }
L_RING_EGT_G.level 				    = 2
L_RING_EGT_G.h_clip_relation        = h_clip_relations.COMPARE
vertices(L_RING_EGT_G,0.3)
Add(L_RING_EGT_G)
------------------------------------------------------------------------------------------------EGT-NEEDLE-GREEN
L_NEEDLE_EGT_G                      = CreateElement "ceTexPoly"
L_NEEDLE_EGT_G .name    			= "needle g"
L_NEEDLE_EGT_G .material			= RING_NEEDLE_G
L_NEEDLE_EGT_G .change_opacity 	    = false
L_NEEDLE_EGT_G .collimated 		    = false
L_NEEDLE_EGT_G .isvisible 	        = true
L_NEEDLE_EGT_G .init_pos 			= {-0.35, 0.3, 0} --L-R,U-D,F-B
L_NEEDLE_EGT_G .init_rot 			= {0, 0, 0}
L_NEEDLE_EGT_G .element_params 	    = {"MFD_OPACITY","L_EGT_COLOR","LMFD_STARTUP_PAGE","EGT_L"} 
L_NEEDLE_EGT_G .controllers		    = {
                                        {"opacity_using_parameter",0},
                                        {"parameter_in_range",1,-0.1,0.1},--Green
                                        {"parameter_in_range",2, 0.9,1.1},--ENGINE PAGE = 1
                                        {"rotate_using_parameter",3, -0.00427,0}
                                    }
L_NEEDLE_EGT_G .level 				= 2
L_NEEDLE_EGT_G .h_clip_relation     = h_clip_relations.COMPARE
vertices(L_NEEDLE_EGT_G ,0.3)
Add(L_NEEDLE_EGT_G )
------------------------------------------------------------------------------------------------EGT-RING-YELLOW
L_RING_EGT_Y                    = CreateElement "ceTexPoly"
L_RING_EGT_Y.name    			= "ring y"
L_RING_EGT_Y.material			= RING_EGT_Y
L_RING_EGT_Y.change_opacity 	= false
L_RING_EGT_Y.collimated 		= false
L_RING_EGT_Y.isvisible 		    = true
L_RING_EGT_Y.init_pos 		    = {-0.35, 0.3, 0} --L-R,U-D,F-B
L_RING_EGT_Y.init_rot 		    = {0, 0, 0}
L_RING_EGT_Y.element_params 	= {"MFD_OPACITY","L_EGT_COLOR","LMFD_STARTUP_PAGE"} 
L_RING_EGT_Y.controllers		= {
                                    {"opacity_using_parameter",0},
                                    {"parameter_in_range",1,0.4,0.6},--Green
                                    {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                   
                                }
L_RING_EGT_Y.level 			     = 2
L_RING_EGT_Y.h_clip_relation     = h_clip_relations.COMPARE
vertices(L_RING_EGT_Y,0.3)
Add(L_RING_EGT_Y)
------------------------------------------------------------------------------------------------EGT-NEEDLE-YELLOW
L_NEEDLE_EGT_Y                      = CreateElement "ceTexPoly"
L_NEEDLE_EGT_Y .name    			= "needle y"
L_NEEDLE_EGT_Y .material			= RING_NEEDLE_Y
L_NEEDLE_EGT_Y .change_opacity 	    = false
L_NEEDLE_EGT_Y .collimated 		    = false
L_NEEDLE_EGT_Y .isvisible 	        = true
L_NEEDLE_EGT_Y .init_pos 			= {-0.35, 0.3, 0} --L-R,U-D,F-B
L_NEEDLE_EGT_Y .init_rot 			= {0, 0, 0}
L_NEEDLE_EGT_Y .element_params 	    = {"MFD_OPACITY","L_EGT_COLOR","LMFD_STARTUP_PAGE","EGT_L"} 
L_NEEDLE_EGT_Y .controllers		    = {
                                        {"opacity_using_parameter",0},
                                        {"parameter_in_range",1,0.4,0.6},--Yellow
                                        {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                        {"rotate_using_parameter",3, -0.00427,0}
                                    }
L_NEEDLE_EGT_Y .level 				= 2
L_NEEDLE_EGT_Y .h_clip_relation     = h_clip_relations.COMPARE
vertices(L_NEEDLE_EGT_Y ,0.3)
Add(L_NEEDLE_EGT_Y)
------------------------------------------------------------------------------------------------EGT-RING-RED
L_RING_EGT_R                    = CreateElement "ceTexPoly"
L_RING_EGT_R.name    			= "ring r"
L_RING_EGT_R.material			= RING_EGT_R
L_RING_EGT_R.change_opacity 	= false
L_RING_EGT_R.collimated 		= false
L_RING_EGT_R.isvisible 		    = true
L_RING_EGT_R.init_pos 		    = {-0.35, 0.3, 0} --L-R,U-D,F-B
L_RING_EGT_R.init_rot 		    = {0, 0, 0}
L_RING_EGT_R.element_params 	= {"MFD_OPACITY","L_EGT_COLOR","LMFD_STARTUP_PAGE"} 
L_RING_EGT_R.controllers		= {
                                    {"opacity_using_parameter",0},
                                    {"parameter_in_range",1,0.9,1.1},-- RED
                                    {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                   
                                }
L_RING_EGT_R.level 			     = 2
L_RING_EGT_R.h_clip_relation     = h_clip_relations.COMPARE
vertices(L_RING_EGT_R,0.3)
Add(L_RING_EGT_R)
------------------------------------------------------------------------------------------------EGT-NEEDLE-RED
L_NEEDLE_EGT_R                      = CreateElement "ceTexPoly"
L_NEEDLE_EGT_R.name    			    = "needle r"
L_NEEDLE_EGT_R.material			    = RING_NEEDLE_R
L_NEEDLE_EGT_R.change_opacity 	    = false
L_NEEDLE_EGT_R.collimated 		    = false
L_NEEDLE_EGT_R.isvisible 	        = true
L_NEEDLE_EGT_R.init_pos 			= {-0.35, 0.3, 0} --L-R,U-D,F-B
L_NEEDLE_EGT_R.init_rot 			= {0, 0, 0}
L_NEEDLE_EGT_R.element_params 	    = {"MFD_OPACITY","L_EGT_COLOR","LMFD_STARTUP_PAGE","EGT_L"} 
L_NEEDLE_EGT_R.controllers		    = {
                                        {"opacity_using_parameter",0},
                                        {"parameter_in_range",1,0.9,1.1},--RED
                                        {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                        {"rotate_using_parameter",3, -0.00427,0}
                                    }
L_NEEDLE_EGT_R.level 				= 2
L_NEEDLE_EGT_R.h_clip_relation      = h_clip_relations.COMPARE
vertices(L_NEEDLE_EGT_R ,0.3)
Add(L_NEEDLE_EGT_R)


--RPM ORANGE TEXT
RPM_O 					    = CreateElement "ceStringPoly"
RPM_O.name 				    = "menu"
RPM_O.material 			    = UFD_GRN
RPM_O.value 				= "RPM"
RPM_O.stringdefs 		    = {0.0050, 0.0050, 0.0004, 0.001}
RPM_O.alignment 			= "CenterCenter"
RPM_O.formats 			    = {"%s"}
RPM_O.h_clip_relation       = h_clip_relations.COMPARE
RPM_O.level 				= 2
RPM_O.init_pos 			    = {0, 0.6, 0}
RPM_O.init_rot 			    = {0, 0, 0}
RPM_O.element_params 	    = {"MFD_OPACITY","LMFD_STARTUP_PAGE"} --"L_RPM_COLOR"
RPM_O.controllers		    =   {
                                    {"opacity_using_parameter",0},
                                    {"parameter_in_range",1,0.9,1.1},--ENGINE PAGE = 0
                                }
Add(RPM_O)
--EGT GREEN TEXT
EGT_G 					    = CreateElement "ceStringPoly"
EGT_G.name 				    = "menu"
EGT_G.material 			    = UFD_GRN
EGT_G.value 				= "EGT"
EGT_G.stringdefs 		    = {0.0050, 0.0050, 0.0004, 0.001}
EGT_G.alignment 			= "CenterCenter"
EGT_G.formats 			    = {"%s"}
EGT_G.h_clip_relation       = h_clip_relations.COMPARE
EGT_G.level 				= 2
EGT_G.init_pos 			    = {0, 0.3, 0}
EGT_G.init_rot 			    = {0, 0, 0}
EGT_G.element_params 	    = {"MFD_OPACITY","LMFD_STARTUP_PAGE"} -- "L_EGT_COLOR"
EGT_G.controllers		    =   {
                                    {"opacity_using_parameter",0},
                                    {"parameter_in_range",1,0.9,1.1},--ENGINE PAGE = 0
                                }
Add(EGT_G)


OIL_G_L 					    = CreateElement "ceStringPoly"
OIL_G_L.name 				    = "menu"
OIL_G_L.material 			    = UFD_GRN
OIL_G_L.value 				    = "OIL"
OIL_G_L.stringdefs 		         = {0.0050, 0.0050, 0.0004, 0.001}
OIL_G_L.alignment 			    = "CenterCenter"
OIL_G_L.formats 			    = {"%s"}
OIL_G_L.h_clip_relation         = h_clip_relations.COMPARE
OIL_G_L.level 				    = 2
OIL_G_L.init_pos 			    = {0, 0.03, 0}
OIL_G_L.init_rot 			    = {0, 0, 0}
OIL_G_L.element_params 	        = {"MFD_OPACITY","LMFD_STARTUP_PAGE"}
OIL_G_L.controllers		        =   {
                                    {"opacity_using_parameter",0},
                                    {"parameter_in_range",1,0.9,1.1},--ENGINE PAGE = 0
                                    --{"parameter_in_range",2,-0.1,0.1},
                                }
Add(OIL_G_L)


-----------------------------------------------------------------------------------------------------------TEXT NUMBERS R RPM YEL
R_RPM_TEXT_G				    = CreateElement "ceStringPoly"
R_RPM_TEXT_G.name				= "rad Alt"
R_RPM_TEXT_G.material			= UFD_GRN
R_RPM_TEXT_G.init_pos			= {0.28, 0.69, 0} --L-R,U-D,F-B
R_RPM_TEXT_G.alignment			= "RightCenter"
R_RPM_TEXT_G.stringdefs			= {0.005, 0.005, 0, 0.0} --either 004 or 005
R_RPM_TEXT_G.additive_alpha		= true
R_RPM_TEXT_G.collimated			= false
R_RPM_TEXT_G.isdraw				= true	
R_RPM_TEXT_G.use_mipfilter		= true
R_RPM_TEXT_G.h_clip_relation	= h_clip_relations.COMPARE
R_RPM_TEXT_G.level				= 2
R_RPM_TEXT_G.element_params		= {"MFD_OPACITY","RPM_R","LMFD_STARTUP_PAGE","R_RPM_COLOR"}
R_RPM_TEXT_G.formats			= {"%.0f"}--= {"%02.0f"}
R_RPM_TEXT_G.controllers		=   {
                                        {"opacity_using_parameter",0},
                                        {"text_using_parameter",1,0},
                                        {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                        {"parameter_in_range",3,0.4,0.6}
                                    }
                                
Add(R_RPM_TEXT_G)
-----------------------------------------------------------------------------------------------------------R RPM ORANGE
R_RPM_TEXT_O				    = CreateElement "ceStringPoly"
R_RPM_TEXT_O.name				= "rad Alt"
R_RPM_TEXT_O.material			= UFD_YEL
R_RPM_TEXT_O.init_pos			= {0.28, 0.69, 0} --L-R,U-D,F-B
R_RPM_TEXT_O.alignment			= "RightCenter"
R_RPM_TEXT_O.stringdefs			= {0.005, 0.005, 0, 0.0} --either 004 or 005
R_RPM_TEXT_O.additive_alpha		= true
R_RPM_TEXT_O.collimated			= false
R_RPM_TEXT_O.isdraw				= true	
R_RPM_TEXT_O.use_mipfilter		= true
R_RPM_TEXT_O.h_clip_relation	= h_clip_relations.COMPARE
R_RPM_TEXT_O.level				= 2
R_RPM_TEXT_O.element_params		= {"MFD_OPACITY","RPM_R","LMFD_STARTUP_PAGE","R_RPM_COLOR"}
R_RPM_TEXT_O.formats			= {"%.0f"}--= {"%02.0f"}
R_RPM_TEXT_O.controllers		=   {
                                        {"opacity_using_parameter",0},
                                        {"text_using_parameter",1,0},
                                        {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                        {"parameter_in_range",3,0.9,1.1}
                                    }
                                
Add(R_RPM_TEXT_O)
-----------------------------------------------------------------------------------------------------------L RPM YEL
L_RPM_TEXT_G				    = CreateElement "ceStringPoly"
L_RPM_TEXT_G.name				= "rad Alt"
L_RPM_TEXT_G.material			= UFD_GRN
L_RPM_TEXT_G.init_pos			= {-0.41, 0.69, 0} --L-R,U-D,F-B
L_RPM_TEXT_G.alignment			= "RightCenter"
L_RPM_TEXT_G.stringdefs			= {0.005, 0.005, 0, 0.0} --either 004 or 005
L_RPM_TEXT_G.additive_alpha		= true
L_RPM_TEXT_G.collimated			= false
L_RPM_TEXT_G.isdraw				= true	
L_RPM_TEXT_G.use_mipfilter		= true
L_RPM_TEXT_G.h_clip_relation	= h_clip_relations.COMPARE
L_RPM_TEXT_G.level				= 2
L_RPM_TEXT_G.element_params		= {"MFD_OPACITY","RPM_L","LMFD_STARTUP_PAGE","L_RPM_COLOR"}
L_RPM_TEXT_G.formats			= {"%.0f"}--= {"%02.0f"}
L_RPM_TEXT_G.controllers		=   {
                                        {"opacity_using_parameter",0},
                                        {"text_using_parameter",1,0},
                                        {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                        {"parameter_in_range",3,0.4,0.6}
                                    }
                                
Add(L_RPM_TEXT_G)
-----------------------------------------------------------------------------------------------------------L RPM ORANGE
L_RPM_TEXT_O				    = CreateElement "ceStringPoly"
L_RPM_TEXT_O.name				= "rad Alt"
L_RPM_TEXT_O.material			= UFD_YEL
L_RPM_TEXT_O.init_pos			= {-0.41, 0.69, 0} --L-R,U-D,F-B
L_RPM_TEXT_O.alignment			= "RightCenter"
L_RPM_TEXT_O.stringdefs			= {0.005, 0.005, 0, 0.0} --either 004 or 005
L_RPM_TEXT_O.additive_alpha		= true
L_RPM_TEXT_O.collimated			= false
L_RPM_TEXT_O.isdraw				= true	
L_RPM_TEXT_O.use_mipfilter		= true
L_RPM_TEXT_O.h_clip_relation	= h_clip_relations.COMPARE
L_RPM_TEXT_O.level				= 2
L_RPM_TEXT_O.element_params		= {"MFD_OPACITY","RPM_L","LMFD_STARTUP_PAGE","L_RPM_COLOR"}
L_RPM_TEXT_O.formats			= {"%.0f"}--= {"%02.0f"}
L_RPM_TEXT_O.controllers		=   {
                                        {"opacity_using_parameter",0},
                                        {"text_using_parameter",1,0},
                                        {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                        {"parameter_in_range",3,0.9,1.1}
                                    }
                                
Add(L_RPM_TEXT_O)
-----------------------------------------------------------------------------------------------------------TEXT NUMBERS R EGT YEL
R_EGT_TEXT_G				    = CreateElement "ceStringPoly"
R_EGT_TEXT_G.name				= "rad Alt"
R_EGT_TEXT_G.material			= UFD_GRN
R_EGT_TEXT_G.init_pos			= {0.28, 0.39, 0} --L-R,U-D,F-B
R_EGT_TEXT_G.alignment			= "RightCenter"
R_EGT_TEXT_G.stringdefs			= {0.005, 0.005, 0, 0.0} --either 004 or 005
R_EGT_TEXT_G.additive_alpha		= true
R_EGT_TEXT_G.collimated			= false
R_EGT_TEXT_G.isdraw				= true	
R_EGT_TEXT_G.use_mipfilter		= true
R_EGT_TEXT_G.h_clip_relation	= h_clip_relations.COMPARE
R_EGT_TEXT_G.level				= 2
R_EGT_TEXT_G.element_params		= {"MFD_OPACITY","EGT_R","LMFD_STARTUP_PAGE","R_EGT_COLOR"}
R_EGT_TEXT_G.formats			= {"%.0f"}--= {"%02.0f"}
R_EGT_TEXT_G.controllers		=   {
                                        {"opacity_using_parameter",0},
                                        {"text_using_parameter",1,0},
                                        {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                        {"parameter_in_range",3,-0.1,0.1}
                                    }
                                
Add(R_EGT_TEXT_G)
-----------------------------------------------------------------------------------------------------------R EGT YELLOW
R_EGT_TEXT_Y				    = CreateElement "ceStringPoly"
R_EGT_TEXT_Y.name				= "rad Alt"
R_EGT_TEXT_Y.material			= UFD_YEL
R_EGT_TEXT_Y.init_pos			= {0.28, 0.39, 0} --L-R,U-D,F-B
R_EGT_TEXT_Y.alignment			= "RightCenter"
R_EGT_TEXT_Y.stringdefs			= {0.005, 0.005, 0, 0.0} --either 004 or 005
R_EGT_TEXT_Y.additive_alpha		= true
R_EGT_TEXT_Y.collimated			= false
R_EGT_TEXT_Y.isdraw				= true	
R_EGT_TEXT_Y.use_mipfilter		= true
R_EGT_TEXT_Y.h_clip_relation	= h_clip_relations.COMPARE
R_EGT_TEXT_Y.level				= 2
R_EGT_TEXT_Y.element_params		= {"MFD_OPACITY","EGT_R","LMFD_STARTUP_PAGE","R_EGT_COLOR"}
R_EGT_TEXT_Y.formats			= {"%.0f"}--= {"%02.0f"}
R_EGT_TEXT_Y.controllers		=   {
                                        {"opacity_using_parameter",0},
                                        {"text_using_parameter",1,0},
                                        {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                        {"parameter_in_range",3,0.4,0.6}
                                    }
                                
Add(R_EGT_TEXT_Y)
-----------------------------------------------------------------------------------------------------------R EGT RED
R_EGT_TEXT_R				    = CreateElement "ceStringPoly"
R_EGT_TEXT_R.name				= "rad Alt"
R_EGT_TEXT_R.material			= UFD_RED
R_EGT_TEXT_R.init_pos			= {0.28, 0.39, 0} --L-R,U-D,F-B
R_EGT_TEXT_R.alignment			= "RightCenter"
R_EGT_TEXT_R.stringdefs			= {0.005, 0.005, 0, 0.0} --either 004 or 005
R_EGT_TEXT_R.additive_alpha		= true
R_EGT_TEXT_R.collimated			= false
R_EGT_TEXT_R.isdraw				= true	
R_EGT_TEXT_R.use_mipfilter		= true
R_EGT_TEXT_R.h_clip_relation	= h_clip_relations.COMPARE
R_EGT_TEXT_R.level				= 2
R_EGT_TEXT_R.element_params		= {"MFD_OPACITY","EGT_R","LMFD_STARTUP_PAGE","R_EGT_COLOR"}
R_EGT_TEXT_R.formats			= {"%.0f"}--= {"%02.0f"}
R_EGT_TEXT_R.controllers		=   {
                                        {"opacity_using_parameter",0},
                                        {"text_using_parameter",1,0},
                                        {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                        {"parameter_in_range",3,0.9,1.1}
                                    }
                                
Add(R_EGT_TEXT_R)
-----------------------------------------------------------------------------------------------------------L EGT YEL
L_EGT_TEXT_G				    = CreateElement "ceStringPoly"
L_EGT_TEXT_G.name				= "rad Alt"
L_EGT_TEXT_G.material			= UFD_GRN
L_EGT_TEXT_G.init_pos			= {-0.41, 0.39, 0} --L-R,U-D,F-B
L_EGT_TEXT_G.alignment			= "RightCenter"
L_EGT_TEXT_G.stringdefs			= {0.005, 0.005, 0, 0.0} --either 004 or 005
L_EGT_TEXT_G.additive_alpha		= true
L_EGT_TEXT_G.collimated			= false
L_EGT_TEXT_G.isdraw				= true	
L_EGT_TEXT_G.use_mipfilter		= true
L_EGT_TEXT_G.h_clip_relation	= h_clip_relations.COMPARE
L_EGT_TEXT_G.level				= 2
L_EGT_TEXT_G.element_params		= {"MFD_OPACITY","EGT_L","LMFD_STARTUP_PAGE","L_EGT_COLOR"}
L_EGT_TEXT_G.formats			= {"%.0f"}--= {"%02.0f"}
L_EGT_TEXT_G.controllers		=   {
                                        {"opacity_using_parameter",0},
                                        {"text_using_parameter",1,0},
                                        {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                        {"parameter_in_range",3,-0.1,0.1}
                                    }
                                
Add(L_EGT_TEXT_G)
-----------------------------------------------------------------------------------------------------------R EGT YELLOW
L_EGT_TEXT_Y				    = CreateElement "ceStringPoly"
L_EGT_TEXT_Y.name				= "rad Alt"
L_EGT_TEXT_Y.material			= UFD_YEL
L_EGT_TEXT_Y.init_pos			= {-0.41, 0.39, 0} --L-R,U-D,F-B
L_EGT_TEXT_Y.alignment			= "RightCenter"
L_EGT_TEXT_Y.stringdefs			= {0.005, 0.005, 0, 0.0} --either 004 or 005
L_EGT_TEXT_Y.additive_alpha		= true
L_EGT_TEXT_Y.collimated			= false
L_EGT_TEXT_Y.isdraw				= true	
L_EGT_TEXT_Y.use_mipfilter		= true
L_EGT_TEXT_Y.h_clip_relation	= h_clip_relations.COMPARE
L_EGT_TEXT_Y.level				= 2
L_EGT_TEXT_Y.element_params		= {"MFD_OPACITY","EGT_L","LMFD_STARTUP_PAGE","L_EGT_COLOR"}
L_EGT_TEXT_Y.formats			= {"%.0f"}--= {"%02.0f"}
L_EGT_TEXT_Y.controllers		=   {
                                        {"opacity_using_parameter",0},
                                        {"text_using_parameter",1,0},
                                        {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                        {"parameter_in_range",3,0.4,0.6}
                                    }
                                
Add(L_EGT_TEXT_Y)
-----------------------------------------------------------------------------------------------------------L EGT RED
L_EGT_TEXT_R				    = CreateElement "ceStringPoly"
L_EGT_TEXT_R.name				= "rad Alt"
L_EGT_TEXT_R.material			= UFD_RED
L_EGT_TEXT_R.init_pos			= {-0.41, 0.39, 0} --L-R,U-D,F-B
L_EGT_TEXT_R.alignment			= "RightCenter"
L_EGT_TEXT_R.stringdefs			= {0.005, 0.005, 0, 0.0} --either 004 or 005
L_EGT_TEXT_R.additive_alpha		= true
L_EGT_TEXT_R.collimated			= false
L_EGT_TEXT_R.isdraw				= true	
L_EGT_TEXT_R.use_mipfilter		= true
L_EGT_TEXT_R.h_clip_relation	= h_clip_relations.COMPARE
L_EGT_TEXT_R.level				= 2
L_EGT_TEXT_R.element_params		= {"MFD_OPACITY","EGT_L","LMFD_STARTUP_PAGE","L_EGT_COLOR"}
L_EGT_TEXT_R.formats			= {"%.0f"}--= {"%02.0f"}
L_EGT_TEXT_R.controllers		=   {
                                        {"opacity_using_parameter",0},
                                        {"text_using_parameter",1,0},
                                        {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                        {"parameter_in_range",3,0.9,1.1}
                                    }
                                
Add(L_EGT_TEXT_R)
-----------------------------------------------------------------------------------------------------------L OIL GRN
L_OIL_TEXT_G				    = CreateElement "ceStringPoly"
L_OIL_TEXT_G.name				= "rad Alt"
L_OIL_TEXT_G.material			= UFD_GRN
L_OIL_TEXT_G.init_pos			= {-0.40, 0.10, 0} --L-R,U-D,F-B
L_OIL_TEXT_G.alignment			= "RightCenter"
L_OIL_TEXT_G.stringdefs			= {0.004, 0.004, 0, 0.0} --either 004 or 005
L_OIL_TEXT_G.additive_alpha		= true
L_OIL_TEXT_G.collimated			= false
L_OIL_TEXT_G.isdraw				= true	
L_OIL_TEXT_G.use_mipfilter		= true
L_OIL_TEXT_G.h_clip_relation	= h_clip_relations.COMPARE
L_OIL_TEXT_G.level				= 2
L_OIL_TEXT_G.element_params		= {"MFD_OPACITY","OIL_L","LMFD_STARTUP_PAGE","L_OIL_COLOR"}
L_OIL_TEXT_G.formats			= {"%.0f"}--= {"%02.0f"}
L_OIL_TEXT_G.controllers		=   {
                                        {"opacity_using_parameter",0},
                                        {"text_using_parameter",1,0},
                                        {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                        {"parameter_in_range",3,-0.1,0.1}
                                    }
                                
Add(L_OIL_TEXT_G)
-----------------------------------------------------------------------------------------------------------L OIL RED
L_OIL_TEXT_R				    = CreateElement "ceStringPoly"
L_OIL_TEXT_R.name				= "rad Alt"
L_OIL_TEXT_R.material			= UFD_RED
L_OIL_TEXT_R.init_pos			= {-0.40, 0.10, 0} --L-R,U-D,F-B
L_OIL_TEXT_R.alignment			= "RightCenter"
L_OIL_TEXT_R.stringdefs			= {0.004, 0.004, 0, 0.0} --either 004 or 005
L_OIL_TEXT_R.additive_alpha		= true
L_OIL_TEXT_R.collimated			= false
L_OIL_TEXT_R.isdraw				= true	
L_OIL_TEXT_R.use_mipfilter		= true
L_OIL_TEXT_R.h_clip_relation	= h_clip_relations.COMPARE
L_OIL_TEXT_R.level				= 2
L_OIL_TEXT_R.element_params		= {"MFD_OPACITY","OIL_L","LMFD_STARTUP_PAGE","L_OIL_COLOR"}
L_OIL_TEXT_R.formats			= {"%.0f"}--= {"%02.0f"}
L_OIL_TEXT_R.controllers		=   {
                                        {"opacity_using_parameter",0},
                                        {"text_using_parameter",1,0},
                                        {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                        {"parameter_in_range",3,0.9,1.1}
                                    }
                                
Add(L_OIL_TEXT_R)
-----------------------------------------------------------------------------------------------------------R OIL GRN
R_OIL_TEXT_G				    = CreateElement "ceStringPoly"
R_OIL_TEXT_G.name				= "rad Alt"
R_OIL_TEXT_G.material			= UFD_GRN
R_OIL_TEXT_G.init_pos			= {0.26, 0.10, 0} --L-R,U-D,F-B
R_OIL_TEXT_G.alignment			= "RightCenter"
R_OIL_TEXT_G.stringdefs			= {0.004, 0.004, 0, 0.0} --either 004 or 005
R_OIL_TEXT_G.additive_alpha		= true
R_OIL_TEXT_G.collimated			= false
R_OIL_TEXT_G.isdraw				= true	
R_OIL_TEXT_G.use_mipfilter		= true
R_OIL_TEXT_G.h_clip_relation	= h_clip_relations.COMPARE
R_OIL_TEXT_G.level				= 2
R_OIL_TEXT_G.element_params		= {"MFD_OPACITY","OIL_R","LMFD_STARTUP_PAGE","R_OIL_COLOR"}
R_OIL_TEXT_G.formats			= {"%.0f"}--= {"%02.0f"}
R_OIL_TEXT_G.controllers		=   {
                                        {"opacity_using_parameter",0},
                                        {"text_using_parameter",1,0},
                                        {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                        {"parameter_in_range",3,-0.1,0.1}
                                    }
                                
Add(R_OIL_TEXT_G)
-----------------------------------------------------------------------------------------------------------R OIL RED
R_OIL_TEXT_R				    = CreateElement "ceStringPoly"
R_OIL_TEXT_R.name				= "rad Alt"
R_OIL_TEXT_R.material			= UFD_RED
R_OIL_TEXT_R.init_pos			= {0.26, 0.10, 0} --L-R,U-D,F-B
R_OIL_TEXT_R.alignment			= "RightCenter"
R_OIL_TEXT_R.stringdefs			= {0.004, 0.004, 0, 0.0} --either 004 or 005
R_OIL_TEXT_R.additive_alpha		= true
R_OIL_TEXT_R.collimated			= false
R_OIL_TEXT_R.isdraw				= true	
R_OIL_TEXT_R.use_mipfilter		= true
R_OIL_TEXT_R.h_clip_relation	= h_clip_relations.COMPARE
R_OIL_TEXT_R.level				= 2
R_OIL_TEXT_R.element_params		= {"MFD_OPACITY","OIL_R","LMFD_STARTUP_PAGE","R_OIL_COLOR"}
R_OIL_TEXT_R.formats			= {"%.0f"}--= {"%02.0f"}
R_OIL_TEXT_R.controllers		=   {
                                        {"opacity_using_parameter",0},
                                        {"text_using_parameter",1,0},
                                        {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                        {"parameter_in_range",3,0.9,1.1}
                                    }
                                
Add(R_OIL_TEXT_R)