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
local YellowColor 			= {255, 255, 0, 255}--RGBA
local ScreenColor			= {3, 3, 3, 255}--RGBA 5-5-5


local MASK_BOX	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mask_box.dds", ScreenColor)--SYSTEM TEST
local JET_FRAME	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/jet_frame.dds", WhiteColor)--SYSTEM TEST
local L_ELEVON	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/jet_l_elevon.dds", RedColor)--SYSTEM TEST
local R_ELEVON	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/jet_r_elevon.dds", RedColor)--SYSTEM TEST
local L_WING	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/jet_l_wing.dds", RedColor)--SYSTEM TEST
local R_WING	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/jet_r_wing.dds", RedColor)--SYSTEM TEST
local L_TAIL	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/jet_l_tail.dds", RedColor)--SYSTEM TEST
local R_TAIL	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/jet_r_tail.dds", RedColor)--SYSTEM TEST
local L_AILERON	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/jet_l_flaperon.dds", RedColor)--SYSTEM TEST
local R_AILERON	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/jet_r_flaperon.dds", RedColor)--SYSTEM TEST
local L_FLAP	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/jet_l_flaperon.dds", RedColor)--SYSTEM TEST
local R_FLAP	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/jet_r_flaperon.dds", RedColor)--SYSTEM TEST
local L_RUDDER	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/jet_l_rudder.dds", RedColor)--SYSTEM TEST
local R_RUDDER	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/jet_r_rudder.dds", RedColor)--SYSTEM TEST
local L_ENGINE	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/jet_l_engine.dds", RedColor)--SYSTEM TEST
local R_ENGINE	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/jet_r_engine.dds", RedColor)--SYSTEM TEST
local CANOPY	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/jet_canopy.dds", YellowColor)--SYSTEM TEST
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
BGROUND.element_params 		= {"MFD_OPACITY","PMFD_SYS_PAGE"}--this may not be bneeded check when more pages done for backlight on page 7 SMS fc3 bs
BGROUND.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}--MENU PAGE = 1
BGROUND.level 				= 2
BGROUND.h_clip_relation     = h_clip_relations.COMPARE
vertices(BGROUND,3)
Add(BGROUND)
----------------------------------------------------------------------------------------------------------------
JETFRAME                    = CreateElement "ceTexPoly"
JETFRAME.name    			= "JETFRAME"
JETFRAME.material			= JET_FRAME
JETFRAME.change_opacity 		= false
JETFRAME.collimated 			= false
JETFRAME.isvisible 			= true
JETFRAME.init_pos 			= {0, 0, 0} --L-R,U-D,F-B
JETFRAME.init_rot 			= {0, 0, 0}
JETFRAME.element_params 		= {"MFD_OPACITY","PMFD_SYS_PAGE"}--this may not be bneeded check when more pages done for backlight on page 7 SMS fc3 bs
JETFRAME.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}--MENU PAGE = 1
JETFRAME.level 				= 2
JETFRAME.h_clip_relation     = h_clip_relations.COMPARE
vertices(JETFRAME,2)
Add(JETFRAME)

LELEVON                    = CreateElement "ceTexPoly"
LELEVON.name    			= "LELEVON"
LELEVON.material			= L_ELEVON
LELEVON.change_opacity 		= false
LELEVON.collimated 			= false
LELEVON.isvisible 			= true
LELEVON.init_pos 			= {0, 0, 0} --L-R,U-D,F-B
LELEVON.init_rot 			= {0, 0, 0}
LELEVON.element_params 		= {"MFD_OPACITY","PMFD_SYS_PAGE","LEFT_ELEVON_INTEGRITY"}--this may not be bneeded check when more pages done for backlight on page 7 SMS fc3 bs
LELEVON.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0,50}}--MENU PAGE = 1
LELEVON.level 				= 2
LELEVON.h_clip_relation     = h_clip_relations.COMPARE
vertices(LELEVON,2)
Add(LELEVON)

-- Left Elevon
LELEVON                    = CreateElement "ceTexPoly"
LELEVON.name               = "LELEVON"
LELEVON.material           = L_ELEVON
LELEVON.change_opacity     = false
LELEVON.collimated         = false
LELEVON.isvisible          = true
LELEVON.init_pos           = {0, 0, 0} --L-R,U-D,F-B
LELEVON.init_rot           = {0, 0, 0}
LELEVON.element_params     = {"MFD_OPACITY","PMFD_SYS_PAGE","LEFT_ELEVON_INTEGRITY"}
LELEVON.controllers        = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0,50}}
LELEVON.level              = 2
LELEVON.h_clip_relation    = h_clip_relations.COMPARE
vertices(LELEVON,2)
Add(LELEVON)

-- Right Elevon
RELEVON                    = CreateElement "ceTexPoly"
RELEVON.name               = "RELEVON"
RELEVON.material           = R_ELEVON
RELEVON.change_opacity     = false
RELEVON.collimated         = false
RELEVON.isvisible          = true
RELEVON.init_pos           = {0, 0, 0} --L-R,U-D,F-B
RELEVON.init_rot           = {0, 0, 0}
RELEVON.element_params     = {"MFD_OPACITY","PMFD_SYS_PAGE","RIGHT_ELEVON_INTEGRITY"}
RELEVON.controllers        = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0,50}}
RELEVON.level              = 2
RELEVON.h_clip_relation    = h_clip_relations.COMPARE
vertices(RELEVON,2)
Add(RELEVON)

-- Left Wing
LWING                      = CreateElement "ceTexPoly"
LWING.name                 = "LWING"
LWING.material             = L_WING
LWING.change_opacity       = false
LWING.collimated           = false
LWING.isvisible            = true
LWING.init_pos             = {0, 0, 0} --L-R,U-D,F-B
LWING.init_rot             = {0, 0, 0}
LWING.element_params       = {"MFD_OPACITY","PMFD_SYS_PAGE","LEFT_WING_INTEGRITY"}
LWING.controllers          = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0,50}}
LWING.level                = 2
LWING.h_clip_relation      = h_clip_relations.COMPARE
vertices(LWING,2)
Add(LWING)

-- Right Wing
RWING                      = CreateElement "ceTexPoly"
RWING.name                 = "RWING"
RWING.material             = R_WING
RWING.change_opacity       = false
RWING.collimated           = false
RWING.isvisible            = true
RWING.init_pos             = {0, 0, 0} --L-R,U-D,F-B
RWING.init_rot             = {0, 0, 0}
RWING.element_params       = {"MFD_OPACITY","PMFD_SYS_PAGE","RIGHT_WING_INTEGRITY"}
RWING.controllers          = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0,50}}
RWING.level                = 2
RWING.h_clip_relation      = h_clip_relations.COMPARE
vertices(RWING,2)
Add(RWING)

-- Left Tail
LTAIL                      = CreateElement "ceTexPoly"
LTAIL.name                 = "LTAIL"
LTAIL.material             = L_TAIL
LTAIL.change_opacity       = false
LTAIL.collimated           = false
LTAIL.isvisible            = true
LTAIL.init_pos             = {0, 0, 0} --L-R,U-D,F-B
LTAIL.init_rot             = {0, 0, 0}
LTAIL.element_params       = {"MFD_OPACITY","PMFD_SYS_PAGE","LEFT_TAIL_INTEGRITY"}
LTAIL.controllers          = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0,50}}
LTAIL.level                = 2
LTAIL.h_clip_relation      = h_clip_relations.COMPARE
vertices(LTAIL,2)
Add(LTAIL)

-- Right Tail
RTAIL                      = CreateElement "ceTexPoly"
RTAIL.name                 = "RTAIL"
RTAIL.material             = R_TAIL
RTAIL.change_opacity       = false
RTAIL.collimated           = false
RTAIL.isvisible            = true
RTAIL.init_pos             = {0, 0, 0} --L-R,U-D,F-B
RTAIL.init_rot             = {0, 0, 0}
RTAIL.element_params       = {"MFD_OPACITY","PMFD_SYS_PAGE","RIGHT_TAIL_INTEGRITY"}
RTAIL.controllers          = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0,50}}
RTAIL.level                = 2
RTAIL.h_clip_relation      = h_clip_relations.COMPARE
vertices(RTAIL,2)
Add(RTAIL)

-- Left Aileron
LAILERON                   = CreateElement "ceTexPoly"
LAILERON.name              = "LAILERON"
LAILERON.material          = L_AILERON
LAILERON.change_opacity    = false
LAILERON.collimated        = false
LAILERON.isvisible         = true
LAILERON.init_pos          = {0, 0, 0} --L-R,U-D,F-B
LAILERON.init_rot          = {0, 0, 0}
LAILERON.element_params    = {"MFD_OPACITY","PMFD_SYS_PAGE","LEFT_AILERON_INTEGRITY"}
LAILERON.controllers       = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0,50}}
LAILERON.level             = 2
LAILERON.h_clip_relation   = h_clip_relations.COMPARE
vertices(LAILERON,2)
Add(LAILERON)

-- Right Aileron
RAILERON                   = CreateElement "ceTexPoly"
RAILERON.name              = "RAILERON"
RAILERON.material          = R_AILERON
RAILERON.change_opacity    = false
RAILERON.collimated        = false
RAILERON.isvisible         = true
RAILERON.init_pos          = {0, 0, 0} --L-R,U-D,F-B
RAILERON.init_rot          = {0, 0, 0}
RAILERON.element_params    = {"MFD_OPACITY","PMFD_SYS_PAGE","RIGHT_AILERON_INTEGRITY"}
RAILERON.controllers       = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0,50}}
RAILERON.level             = 2
RAILERON.h_clip_relation   = h_clip_relations.COMPARE
vertices(RAILERON,2)
Add(RAILERON)

-- Left Flap
LFLAP                      = CreateElement "ceTexPoly"
LFLAP.name                 = "LFLAP"
LFLAP.material             = L_FLAP
LFLAP.change_opacity       = false
LFLAP.collimated           = false
LFLAP.isvisible            = true
LFLAP.init_pos             = {0, 0, 0} --L-R,U-D,F-B
LFLAP.init_rot             = {0, 0, 0}
LFLAP.element_params       = {"MFD_OPACITY","PMFD_SYS_PAGE","LEFT_FLAP_INTEGRITY"}
LFLAP.controllers          = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0,50}}
LFLAP.level                = 2
LFLAP.h_clip_relation      = h_clip_relations.COMPARE
vertices(LFLAP,2)
Add(LFLAP)

-- Right Flap
RFLAP                      = CreateElement "ceTexPoly"
RFLAP.name                 = "RFLAP"
RFLAP.material             = R_FLAP
RFLAP.change_opacity       = false
RFLAP.collimated           = false
RFLAP.isvisible            = true
RFLAP.init_pos             = {0, 0, 0} --L-R,U-D,F-B
RFLAP.init_rot             = {0, 0, 0}
RFLAP.element_params       = {"MFD_OPACITY","PMFD_SYS_PAGE","RIGHT_FLAP_INTEGRITY"}
RFLAP.controllers          = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0,50}}
RFLAP.level                = 2
RFLAP.h_clip_relation      = h_clip_relations.COMPARE
vertices(RFLAP,2)
Add(RFLAP)

-- Left Rudder
LRUDDER                    = CreateElement "ceTexPoly"
LRUDDER.name               = "LRUDDER"
LRUDDER.material           = L_RUDDER
LRUDDER.change_opacity     = false
LRUDDER.collimated         = false
LRUDDER.isvisible          = true
LRUDDER.init_pos           = {0, 0, 0} --L-R,U-D,F-B
LRUDDER.init_rot           = {0, 0, 0}
LRUDDER.element_params     = {"MFD_OPACITY","PMFD_SYS_PAGE","LEFT_RUDDER_INTEGRITY"}
LRUDDER.controllers        = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0,50}}
LRUDDER.level              = 2
LRUDDER.h_clip_relation    = h_clip_relations.COMPARE
vertices(LRUDDER,2)
Add(LRUDDER)

-- Right Rudder
RRUDDER                    = CreateElement "ceTexPoly"
RRUDDER.name               = "RRUDDER"
RRUDDER.material           = R_RUDDER
RRUDDER.change_opacity     = false
RRUDDER.collimated         = false
RRUDDER.isvisible          = true
RRUDDER.init_pos           = {0, 0, 0} --L-R,U-D,F-B
RRUDDER.init_rot           = {0, 0, 0}
RRUDDER.element_params     = {"MFD_OPACITY","PMFD_SYS_PAGE","RIGHT_RUDDER_INTEGRITY"}
RRUDDER.controllers        = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0,50}}
RRUDDER.level              = 2
RRUDDER.h_clip_relation    = h_clip_relations.COMPARE
vertices(RRUDDER,2)
Add(RRUDDER)

-- Left Engine
LENGINE                    = CreateElement "ceTexPoly"
LENGINE.name               = "LENGINE"
LENGINE.material           = L_ENGINE
LENGINE.change_opacity     = false
LENGINE.collimated         = false
LENGINE.isvisible          = true
LENGINE.init_pos           = {0, 0, 0} --L-R,U-D,F-B
LENGINE.init_rot           = {0, 0, 0}
LENGINE.element_params     = {"MFD_OPACITY","PMFD_SYS_PAGE","LEFT_ENGINE_INTEGRITY"}
LENGINE.controllers        = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0,50}}
LENGINE.level              = 2
LENGINE.h_clip_relation    = h_clip_relations.COMPARE
vertices(LENGINE,2)
Add(LENGINE)

-- Right Engine
RENGINE                    = CreateElement "ceTexPoly"
RENGINE.name               = "RENGINE"
RENGINE.material           = R_ENGINE
RENGINE.change_opacity     = false
RENGINE.collimated         = false
RENGINE.isvisible          = true
RENGINE.init_pos           = {0, 0, 0} --L-R,U-D,F-B
RENGINE.init_rot           = {0, 0, 0}
RENGINE.element_params     = {"MFD_OPACITY","PMFD_SYS_PAGE","RIGHT_ENGINE_INTEGRITY"}
RENGINE.controllers        = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0,50}}
RENGINE.level              = 2
RENGINE.h_clip_relation    = h_clip_relations.COMPARE
vertices(RENGINE,2)
Add(RENGINE)
----------------------------------------------------------------------------------------------------------------
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
MENU.element_params 	        = {"MFD_OPACITY","PMFD_SYS_PAGE"}
MENU.controllers		        =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(MENU)

TEMPTXT 					    = CreateElement "ceStringPoly"
TEMPTXT.name 				    = "TEMPTXT"
TEMPTXT.material 			    = UFD_GRN
TEMPTXT.value 				    = "OUTSIDE TEMP:"
TEMPTXT.stringdefs 		        = {0.00550, 0.00550, 0.0000, 0.000}
TEMPTXT.alignment 			    = "CenterCenter"
TEMPTXT.formats 			    = {"%s"}
TEMPTXT.h_clip_relation         = h_clip_relations.COMPARE
TEMPTXT.level 				    = 2
TEMPTXT.init_pos 			    = {-0.75,0.70, 0}
TEMPTXT.init_rot 			    = {0, 0, 0}
TEMPTXT.element_params 	        = {"MFD_OPACITY","PMFD_SYS_PAGE"}
TEMPTXT.controllers		        =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(TEMPTXT)


TEMP_VAL				    = CreateElement "ceStringPoly"
TEMP_VAL.name				= "TEMP_VAL"
TEMP_VAL.material			= UFD_GRN
TEMP_VAL.init_pos			= {-0.39, 0.70, 0} --L-R,U-D,F-B
TEMP_VAL.alignment			= "RightCenter"
TEMP_VAL.stringdefs			= {0.0055, 0.0055, 0, 0.0} --either 004 or 005
TEMP_VAL.additive_alpha		= true
TEMP_VAL.collimated			= false
TEMP_VAL.isdraw				= true	
TEMP_VAL.use_mipfilter		= true
TEMP_VAL.h_clip_relation	= h_clip_relations.COMPARE
TEMP_VAL.level				= 2
TEMP_VAL.element_params		= {"MFD_OPACITY","TEMP","PMFD_SYS_PAGE"}
TEMP_VAL.formats			= {"%.0fdF"}
TEMP_VAL.controllers		=   {
                                        {"opacity_using_parameter",0},
                                        {"text_using_parameter",1,0},
                                        {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                    }
                                
Add(TEMP_VAL)


BAROTXT 					    = CreateElement "ceStringPoly"
BAROTXT.name 				    = "BAROTXT"
BAROTXT.material 			    = UFD_GRN
BAROTXT.value 				    = "BARO:"
BAROTXT.stringdefs 		        = {0.00550, 0.00550, 0.0000, 0.000}
BAROTXT.alignment 			    = "CenterCenter"
BAROTXT.formats 			    = {"%s"}
BAROTXT.h_clip_relation         = h_clip_relations.COMPARE
BAROTXT.level 				    = 2
BAROTXT.init_pos 			    = {-0.88, 0.60, 0}
BAROTXT.init_rot 			    = {0, 0, 0}
BAROTXT.element_params 	        = {"MFD_OPACITY","PMFD_SYS_PAGE"}
BAROTXT.controllers		        =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(BAROTXT)

BARO_VAL				    = CreateElement "ceStringPoly"
BARO_VAL.name				= "BARO_VAL"
BARO_VAL.material			= UFD_GRN
BARO_VAL.init_pos			= {-0.67,0.60, 0} --L-R,U-D,F-B
BARO_VAL.alignment			= "CenterCenter"
BARO_VAL.stringdefs			= {0.0055, 0.0055, 0, 0.0} --either 004 or 005
BARO_VAL.additive_alpha		= true
BARO_VAL.collimated			= false
BARO_VAL.isdraw				= true	
BARO_VAL.use_mipfilter		= true
BARO_VAL.h_clip_relation	= h_clip_relations.COMPARE
BARO_VAL.level				= 2
BARO_VAL.element_params		= {"MFD_OPACITY","B_PRESSURE","PMFD_SYS_PAGE"}
BARO_VAL.formats			= {"%.0f INHG"}
BARO_VAL.controllers		=   {
                                        {"opacity_using_parameter",0},
                                        {"text_using_parameter",1,0},
                                        {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                    }
                                
Add(BARO_VAL)

WINDDIRTXT 					    = CreateElement "ceStringPoly"
WINDDIRTXT.name 				    = "WINDDIRTXT"
WINDDIRTXT.material 			    = UFD_GRN
WINDDIRTXT.value 				    = "WIND DIR:"
WINDDIRTXT.stringdefs 		        = {0.00550, 0.00550, 0.0000, 0.000}
WINDDIRTXT.alignment 			    = "LeftCenter"
WINDDIRTXT.formats 			    = {"%s"}
WINDDIRTXT.h_clip_relation         = h_clip_relations.COMPARE
WINDDIRTXT.level 				    = 2
WINDDIRTXT.init_pos 			    = {0.485,0.70, 0}
WINDDIRTXT.init_rot 			    = {0, 0, 0}
WINDDIRTXT.element_params 	        = {"MFD_OPACITY","PMFD_SYS_PAGE"}
WINDDIRTXT.controllers		        =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(WINDDIRTXT)


WIND_DIR_VAL				    = CreateElement "ceStringPoly"
WIND_DIR_VAL.name				= "WIND_DIR_VAL"
WIND_DIR_VAL.material			= UFD_GRN
WIND_DIR_VAL.init_pos			= {0.80, 0.70, 0} --L-R,U-D,F-B
WIND_DIR_VAL.alignment			= "LeftCenter"
WIND_DIR_VAL.stringdefs			= {0.0055, 0.0055, 0, 0.0} --either 004 or 005
WIND_DIR_VAL.additive_alpha		= true
WIND_DIR_VAL.collimated			= false
WIND_DIR_VAL.isdraw				= true	
WIND_DIR_VAL.use_mipfilter		= true
WIND_DIR_VAL.h_clip_relation	= h_clip_relations.COMPARE
WIND_DIR_VAL.level				= 2
WIND_DIR_VAL.element_params		= {"MFD_OPACITY","WIND_DIRECTION","PMFD_SYS_PAGE"}
WIND_DIR_VAL.formats			= {"%.0fd"}
WIND_DIR_VAL.controllers		=   {
                                        {"opacity_using_parameter",0},
                                        {"text_using_parameter",1,0},
                                        {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                    }
                                
Add(WIND_DIR_VAL)

WINDSPDTXT 					    = CreateElement "ceStringPoly"
WINDSPDTXT.name 				    = "WINDSPDTXT"
WINDSPDTXT.material 			    = UFD_GRN
WINDSPDTXT.value 				    = "WIND SPD:"
WINDSPDTXT.stringdefs 		        = {0.00550, 0.00550, 0.0000, 0.000}
WINDSPDTXT.alignment 			    = "CenterCenter"
WINDSPDTXT.formats 			    = {"%s"}
WINDSPDTXT.h_clip_relation         = h_clip_relations.COMPARE
WINDSPDTXT.level 				    = 2
WINDSPDTXT.init_pos 			    = {0.63,0.60, 0}
WINDSPDTXT.init_rot 			    = {0, 0, 0}
WINDSPDTXT.element_params 	        = {"MFD_OPACITY","PMFD_SYS_PAGE"}
WINDSPDTXT.controllers		        =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(WINDSPDTXT)



WIND_SPD_VAL				    = CreateElement "ceStringPoly"
WIND_SPD_VAL.name				= "WIND_SPD_VAL"
WIND_SPD_VAL.material			= UFD_GRN
WIND_SPD_VAL.init_pos			= {0.81, 0.60, 0} --L-R,U-D,F-B
WIND_SPD_VAL.alignment			= "LeftCenter"
WIND_SPD_VAL.stringdefs			= {0.0055, 0.0055, 0, 0.0} --either 004 or 005
WIND_SPD_VAL.additive_alpha		= true
WIND_SPD_VAL.collimated			= false
WIND_SPD_VAL.isdraw				= true	
WIND_SPD_VAL.use_mipfilter		= true
WIND_SPD_VAL.h_clip_relation	= h_clip_relations.COMPARE
WIND_SPD_VAL.level				= 2
WIND_SPD_VAL.element_params		= {"MFD_OPACITY","WIND_SPEED","PMFD_SYS_PAGE"}
WIND_SPD_VAL.formats			= {"%.0f KTS"}
WIND_SPD_VAL.controllers		=   {
                                        {"opacity_using_parameter",0},
                                        {"text_using_parameter",1,0},
                                        {"parameter_in_range",2,0.9,1.1},--ENGINE PAGE = 1
                                    }
                                
Add(WIND_SPD_VAL)



-- Left Wing Label
LW_TXT = CreateElement "ceStringPoly"
LW_TXT.name = "LW_TXT"
LW_TXT.material = UFD_FONT
LW_TXT.value = "LEFT WING:"
LW_TXT.stringdefs = {0.00500, 0.00500, 0.0000, 0.000}
LW_TXT.alignment = "LeftCenter"
LW_TXT.formats = {"%s"}
LW_TXT.h_clip_relation = h_clip_relations.COMPARE
LW_TXT.level = 2
LW_TXT.init_pos = {-0.96, 0.10, 0}
LW_TXT.init_rot = {0, 0, 0}
LW_TXT.element_params = {"MFD_OPACITY","PMFD_SYS_PAGE"}
LW_TXT.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(LW_TXT)

-- Right Wing Label
RW_TXT = CreateElement "ceStringPoly"
RW_TXT.name = "RW_TXT"
RW_TXT.material = UFD_FONT
RW_TXT.value = "RIGHT WING:"
RW_TXT.stringdefs = {0.00500, 0.00500, 0.0000, 0.000}
RW_TXT.alignment = "LeftCenter"
RW_TXT.formats = {"%s"}
RW_TXT.h_clip_relation = h_clip_relations.COMPARE
RW_TXT.level = 2
RW_TXT.init_pos = {0.48, 0.10, 0}
RW_TXT.init_rot = {0, 0, 0}
RW_TXT.element_params = {"MFD_OPACITY","PMFD_SYS_PAGE"}
RW_TXT.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(RW_TXT)

-- Left Tail Label
LT_TXT = CreateElement "ceStringPoly"
LT_TXT.name = "LT_TXT"
LT_TXT.material = UFD_FONT
LT_TXT.value = "LEFT TAIL:"
LT_TXT.stringdefs = {0.00500, 0.00500, 0.0000, 0.000}
LT_TXT.alignment = "LeftCenter"
LT_TXT.formats = {"%s"}
LT_TXT.h_clip_relation = h_clip_relations.COMPARE
LT_TXT.level = 2
LT_TXT.init_pos = {-0.96, -0.60, 0}
LT_TXT.init_rot = {0, 0, 0}
LT_TXT.element_params = {"MFD_OPACITY","PMFD_SYS_PAGE"}
LT_TXT.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(LT_TXT)

-- Right Tail Label
RT_TXT = CreateElement "ceStringPoly"
RT_TXT.name = "RT_TXT"
RT_TXT.material = UFD_FONT
RT_TXT.value = "RIGHT TAIL:"
RT_TXT.stringdefs = {0.00500, 0.00500, 0.0000, 0.000}
RT_TXT.alignment = "LeftCenter"
RT_TXT.formats = {"%s"}
RT_TXT.h_clip_relation = h_clip_relations.COMPARE
RT_TXT.level = 2
RT_TXT.init_pos = {0.48, -0.60, 0}
RT_TXT.init_rot = {0, 0, 0}
RT_TXT.element_params = {"MFD_OPACITY","PMFD_SYS_PAGE"}
RT_TXT.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(RT_TXT)

-- Left Elevon Label
LE_TXT = CreateElement "ceStringPoly"
LE_TXT.name = "LE_TXT"
LE_TXT.material = UFD_FONT
LE_TXT.value = "LEFT ELEVON:"
LE_TXT.stringdefs = {0.00500, 0.00500, 0.0000, 0.000}
LE_TXT.alignment = "LeftCenter"
LE_TXT.formats = {"%s"}
LE_TXT.h_clip_relation = h_clip_relations.COMPARE
LE_TXT.level = 2
LE_TXT.init_pos = {-0.96, -0.70, 0}
LE_TXT.init_rot = {0, 0, 0}
LE_TXT.element_params = {"MFD_OPACITY","PMFD_SYS_PAGE"}
LE_TXT.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(LE_TXT)

-- Right Elevon Label
RE_TXT = CreateElement "ceStringPoly"
RE_TXT.name = "RE_TXT"
RE_TXT.material = UFD_FONT
RE_TXT.value = "RIGHT ELEVON:"
RE_TXT.stringdefs = {0.00500, 0.00500, 0.0000, 0.000}
RE_TXT.alignment = "LeftCenter"
RE_TXT.formats = {"%s"}
RE_TXT.h_clip_relation = h_clip_relations.COMPARE
RE_TXT.level = 2
RE_TXT.init_pos = {0.48, -0.70, 0}
RE_TXT.init_rot = {0, 0, 0}
RE_TXT.element_params = {"MFD_OPACITY","PMFD_SYS_PAGE"}
RE_TXT.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(RE_TXT)

-- Left Aileron Label
LA_TXT = CreateElement "ceStringPoly"
LA_TXT.name = "LA_TXT"
LA_TXT.material = UFD_FONT
LA_TXT.value = "LEFT AILERON:"
LA_TXT.stringdefs = {0.00500, 0.00500, 0.0000, 0.000}
LA_TXT.alignment = "LeftCenter"
LA_TXT.formats = {"%s"}
LA_TXT.h_clip_relation = h_clip_relations.COMPARE
LA_TXT.level = 2
LA_TXT.init_pos = {-0.96, 0.20, 0}
LA_TXT.init_rot = {0, 0, 0}
LA_TXT.element_params = {"MFD_OPACITY","PMFD_SYS_PAGE"}
LA_TXT.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(LA_TXT)

-- Right Aileron Label
RA_TXT = CreateElement "ceStringPoly"
RA_TXT.name = "RA_TXT"
RA_TXT.material = UFD_FONT
RA_TXT.value = "RIGHT AILERON:"
RA_TXT.stringdefs = {0.00500, 0.00500, 0.0000, 0.000}
RA_TXT.alignment = "LeftCenter"
RA_TXT.formats = {"%s"}
RA_TXT.h_clip_relation = h_clip_relations.COMPARE
RA_TXT.level = 2
RA_TXT.init_pos = {0.48, 0.20, 0}
RA_TXT.init_rot = {0, 0, 0}
RA_TXT.element_params = {"MFD_OPACITY","PMFD_SYS_PAGE"}
RA_TXT.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(RA_TXT)

-- Left Flap Label
LF_TXT = CreateElement "ceStringPoly"
LF_TXT.name = "LF_TXT"
LF_TXT.material = UFD_FONT
LF_TXT.value = "LEFT FLAP:"
LF_TXT.stringdefs = {0.00500, 0.00500, 0.0000, 0.000}
LF_TXT.alignment = "LeftCenter"
LF_TXT.formats = {"%s"}
LF_TXT.h_clip_relation = h_clip_relations.COMPARE
LF_TXT.level = 2
LF_TXT.init_pos = {-0.96, 0.30, 0}
LF_TXT.init_rot = {0, 0, 0}
LF_TXT.element_params = {"MFD_OPACITY","PMFD_SYS_PAGE"}
LF_TXT.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(LF_TXT)

-- Right Flap Label
RF_TXT = CreateElement "ceStringPoly"
RF_TXT.name = "RF_TXT"
RF_TXT.material = UFD_FONT
RF_TXT.value = "RIGHT FLAP:"
RF_TXT.stringdefs = {0.00500, 0.00500, 0.0000, 0.000}
RF_TXT.alignment = "LeftCenter"
RF_TXT.formats = {"%s"}
RF_TXT.h_clip_relation = h_clip_relations.COMPARE
RF_TXT.level = 2
RF_TXT.init_pos = {0.48, 0.30, 0}
RF_TXT.init_rot = {0, 0, 0}
RF_TXT.element_params = {"MFD_OPACITY","PMFD_SYS_PAGE"}
RF_TXT.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(RF_TXT)

-- Left Rudder Label
LR_TXT = CreateElement "ceStringPoly"
LR_TXT.name = "LR_TXT"
LR_TXT.material = UFD_FONT
LR_TXT.value = "LEFT RUDDER:"
LR_TXT.stringdefs = {0.00500, 0.00500, 0.0000, 0.000}
LR_TXT.alignment = "LeftCenter"
LR_TXT.formats = {"%s"}
LR_TXT.h_clip_relation = h_clip_relations.COMPARE
LR_TXT.level = 2
LR_TXT.init_pos = {-0.96, -0.80, 0}
LR_TXT.init_rot = {0, 0, 0}
LR_TXT.element_params = {"MFD_OPACITY","PMFD_SYS_PAGE"}
LR_TXT.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(LR_TXT)

-- Right Rudder Label
RR_TXT = CreateElement "ceStringPoly"
RR_TXT.name = "RR_TXT"
RR_TXT.material = UFD_FONT
RR_TXT.value = "RIGHT RUDDER:"
RR_TXT.stringdefs = {0.00500, 0.00500, 0.0000, 0.000}
RR_TXT.alignment = "LeftCenter"
RR_TXT.formats = {"%s"}
RR_TXT.h_clip_relation = h_clip_relations.COMPARE
RR_TXT.level = 2
RR_TXT.init_pos = {0.48, -0.80, 0}
RR_TXT.init_rot = {0, 0, 0}
RR_TXT.element_params = {"MFD_OPACITY","PMFD_SYS_PAGE"}
RR_TXT.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(RR_TXT)

-- Left Engine Label
LENG_TXT = CreateElement "ceStringPoly"
LENG_TXT.name = "LENG_TXT"
LENG_TXT.material = UFD_FONT
LENG_TXT.value = "LEFT ENGINE:"
LENG_TXT.stringdefs = {0.00500, 0.00500, 0.0000, 0.000}
LENG_TXT.alignment = "LeftCenter"
LENG_TXT.formats = {"%s"}
LENG_TXT.h_clip_relation = h_clip_relations.COMPARE
LENG_TXT.level = 2
LENG_TXT.init_pos = {-0.96, -0.90, 0}
LENG_TXT.init_rot = {0, 0, 0}
LENG_TXT.element_params = {"MFD_OPACITY","PMFD_SYS_PAGE"}
LENG_TXT.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(LENG_TXT)

-- Right Engine Label
RENG_TXT = CreateElement "ceStringPoly"
RENG_TXT.name = "RENG_TXT"
RENG_TXT.material = UFD_FONT
RENG_TXT.value = "RIGHT ENGINE:"
RENG_TXT.stringdefs = {0.00500, 0.00500, 0.0000, 0.000}
RENG_TXT.alignment = "LeftCenter"
RENG_TXT.formats = {"%s"}
RENG_TXT.h_clip_relation = h_clip_relations.COMPARE
RENG_TXT.level = 2
RENG_TXT.init_pos = {0.48, -0.90, 0}
RENG_TXT.init_rot = {0, 0, 0}
RENG_TXT.element_params = {"MFD_OPACITY","PMFD_SYS_PAGE"}
RENG_TXT.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(RENG_TXT)

----------------------Values

-- Left Wing Value
LW_VAL = CreateElement "ceStringPoly"
LW_VAL.name = "LW_VAL"
LW_VAL.material = UFD_GRN
LW_VAL.init_pos = {-0.46, 0.10, 0} -- X = -0.46, Y matches LW_TXT
LW_VAL.alignment = "RightCenter"
LW_VAL.stringdefs = {0.005, 0.005, 0, 0.0}
LW_VAL.additive_alpha = true
LW_VAL.collimated = false
LW_VAL.isdraw = true
LW_VAL.use_mipfilter = true
LW_VAL.h_clip_relation = h_clip_relations.COMPARE
LW_VAL.level = 2
LW_VAL.element_params = {"MFD_OPACITY","LEFT_WING_INTEGRITY","PMFD_SYS_PAGE"}
LW_VAL.formats = {"%.0f%%"}
LW_VAL.controllers = {
    {"opacity_using_parameter",0},
    {"text_using_parameter",1,0},
    {"parameter_in_range",1,90,101},
    {"parameter_in_range",2,0.9,1.1}
}
Add(LW_VAL)

-- Right Wing Value
RW_VAL = CreateElement "ceStringPoly"
RW_VAL.name = "RW_VAL"
RW_VAL.material = UFD_GRN
RW_VAL.init_pos = {1.01, 0.10, 0} -- X = 1.01, Y matches RW_TXT
RW_VAL.alignment = "RightCenter"
RW_VAL.stringdefs = {0.005, 0.005, 0, 0.0}
RW_VAL.additive_alpha = true
RW_VAL.collimated = false
RW_VAL.isdraw = true
RW_VAL.use_mipfilter = true
RW_VAL.h_clip_relation = h_clip_relations.COMPARE
RW_VAL.level = 2
RW_VAL.element_params = {"MFD_OPACITY","RIGHT_WING_INTEGRITY","PMFD_SYS_PAGE"}
RW_VAL.formats = {"%.0f%%"}
RW_VAL.controllers = {
    {"opacity_using_parameter",0},
    {"text_using_parameter",1,0},
    {"parameter_in_range",1,90,101},
    {"parameter_in_range",2,0.9,1.1}
}
Add(RW_VAL)

-- Left Tail Value
LT_VAL = CreateElement "ceStringPoly"
LT_VAL.name = "LT_VAL"
LT_VAL.material = UFD_GRN
LT_VAL.init_pos = {-0.46, -0.60, 0} -- X = -0.46, Y matches LT_TXT
LT_VAL.alignment = "RightCenter"
LT_VAL.stringdefs = {0.005, 0.005, 0, 0.0}
LT_VAL.additive_alpha = true
LT_VAL.collimated = false
LT_VAL.isdraw = true
LT_VAL.use_mipfilter = true
LT_VAL.h_clip_relation = h_clip_relations.COMPARE
LT_VAL.level = 2
LT_VAL.element_params = {"MFD_OPACITY","LEFT_TAIL_INTEGRITY","PMFD_SYS_PAGE"}
LT_VAL.formats = {"%.0f%%"}
LT_VAL.controllers = {
    {"opacity_using_parameter",0},
    {"text_using_parameter",1,0},
    {"parameter_in_range",1,90,101},
    {"parameter_in_range",2,0.9,1.1}
}
Add(LT_VAL)

-- Right Tail Value
RT_VAL = CreateElement "ceStringPoly"
RT_VAL.name = "RT_VAL"
RT_VAL.material = UFD_GRN
RT_VAL.init_pos = {1.01, -0.60, 0} -- X = 1.01, Y matches RT_TXT
RT_VAL.alignment = "RightCenter"
RT_VAL.stringdefs = {0.005, 0.005, 0, 0.0}
RT_VAL.additive_alpha = true
RT_VAL.collimated = false
RT_VAL.isdraw = true
RT_VAL.use_mipfilter = true
RT_VAL.h_clip_relation = h_clip_relations.COMPARE
RT_VAL.level = 2
RT_VAL.element_params = {"MFD_OPACITY","RIGHT_TAIL_INTEGRITY","PMFD_SYS_PAGE"}
RT_VAL.formats = {"%.0f%%"}
RT_VAL.controllers = {
    {"opacity_using_parameter",0},
    {"text_using_parameter",1,0},
    {"parameter_in_range",1,90,101},
    {"parameter_in_range",2,0.9,1.1}
}
Add(RT_VAL)

-- Left Elevon Value
LE_VAL = CreateElement "ceStringPoly"
LE_VAL.name = "LE_VAL"
LE_VAL.material = UFD_GRN
LE_VAL.init_pos = {-0.46, -0.70, 0} -- X = -0.46, Y matches LE_TXT
LE_VAL.alignment = "RightCenter"
LE_VAL.stringdefs = {0.005, 0.005, 0, 0.0}
LE_VAL.additive_alpha = true
LE_VAL.collimated = false
LE_VAL.isdraw = true
LE_VAL.use_mipfilter = true
LE_VAL.h_clip_relation = h_clip_relations.COMPARE
LE_VAL.level = 2
LE_VAL.element_params = {"MFD_OPACITY","LEFT_ELEVON_INTEGRITY","PMFD_SYS_PAGE"}
LE_VAL.formats = {"%.0f%%"}
LE_VAL.controllers = {
    {"opacity_using_parameter",0},
    {"text_using_parameter",1,0},
    {"parameter_in_range",1,90,101},
    {"parameter_in_range",2,0.9,1.1}
}
Add(LE_VAL)

-- Right Elevon Value
RE_VAL = CreateElement "ceStringPoly"
RE_VAL.name = "RE_VAL"
RE_VAL.material = UFD_GRN
RE_VAL.init_pos = {1.01, -0.70, 0} -- X = 1.01, Y matches RE_TXT
RE_VAL.alignment = "RightCenter"
RE_VAL.stringdefs = {0.005, 0.005, 0, 0.0}
RE_VAL.additive_alpha = true
RE_VAL.collimated = false
RE_VAL.isdraw = true
RE_VAL.use_mipfilter = true
RE_VAL.h_clip_relation = h_clip_relations.COMPARE
RE_VAL.level = 2
RE_VAL.element_params = {"MFD_OPACITY","RIGHT_ELEVON_INTEGRITY","PMFD_SYS_PAGE"}
RE_VAL.formats = {"%.0f%%"}
RE_VAL.controllers = {
    {"opacity_using_parameter",0},
    {"text_using_parameter",1,0},
    {"parameter_in_range",1,90,101},
    {"parameter_in_range",2,0.9,1.1}
}
Add(RE_VAL)

-- Left Aileron Value
LA_VAL = CreateElement "ceStringPoly"
LA_VAL.name = "LA_VAL"
LA_VAL.material = UFD_GRN
LA_VAL.init_pos = {-0.46, 0.20, 0} -- X = -0.46, Y matches LA_TXT
LA_VAL.alignment = "RightCenter"
LA_VAL.stringdefs = {0.005, 0.005, 0, 0.0}
LA_VAL.additive_alpha = true
LA_VAL.collimated = false
LA_VAL.isdraw = true
LA_VAL.use_mipfilter = true
LA_VAL.h_clip_relation = h_clip_relations.COMPARE
LA_VAL.level = 2
LA_VAL.element_params = {"MFD_OPACITY","LEFT_AILERON_INTEGRITY","PMFD_SYS_PAGE"}
LA_VAL.formats = {"%.0f%%"}
LA_VAL.controllers = {
    {"opacity_using_parameter",0},
    {"text_using_parameter",1,0},
    {"parameter_in_range",1,90,101},
    {"parameter_in_range",2,0.9,1.1}
}
Add(LA_VAL)

-- Right Aileron Value
RA_VAL = CreateElement "ceStringPoly"
RA_VAL.name = "RA_VAL"
RA_VAL.material = UFD_GRN
RA_VAL.init_pos = {1.01, 0.20, 0} -- X = 1.01, Y matches RA_TXT
RA_VAL.alignment = "RightCenter"
RA_VAL.stringdefs = {0.005, 0.005, 0, 0.0}
RA_VAL.additive_alpha = true
RA_VAL.collimated = false
RA_VAL.isdraw = true
RA_VAL.use_mipfilter = true
RA_VAL.h_clip_relation = h_clip_relations.COMPARE
RA_VAL.level = 2
RA_VAL.element_params = {"MFD_OPACITY","RIGHT_AILERON_INTEGRITY","PMFD_SYS_PAGE"}
RA_VAL.formats = {"%.0f%%"}
RA_VAL.controllers = {
    {"opacity_using_parameter",0},
    {"text_using_parameter",1,0},
    {"parameter_in_range",1,90,101},
    {"parameter_in_range",2,0.9,1.1}
}
Add(RA_VAL)

-- Left Flap Value
LF_VAL = CreateElement "ceStringPoly"
LF_VAL.name = "LF_VAL"
LF_VAL.material = UFD_GRN
LF_VAL.init_pos = {-0.46, 0.30, 0} -- X = -0.46, Y matches LF_TXT
LF_VAL.alignment = "RightCenter"
LF_VAL.stringdefs = {0.005, 0.005, 0, 0.0}
LF_VAL.additive_alpha = true
LF_VAL.collimated = false
LF_VAL.isdraw = true
LF_VAL.use_mipfilter = true
LF_VAL.h_clip_relation = h_clip_relations.COMPARE
LF_VAL.level = 2
LF_VAL.element_params = {"MFD_OPACITY","LEFT_FLAP_INTEGRITY","PMFD_SYS_PAGE"}
LF_VAL.formats = {"%.0f%%"}
LF_VAL.controllers = {
    {"opacity_using_parameter",0},
    {"text_using_parameter",1,0},
    {"parameter_in_range",1,90,101},
    {"parameter_in_range",2,0.9,1.1}
}
Add(LF_VAL)

-- Right Flap Value
RF_VAL = CreateElement "ceStringPoly"
RF_VAL.name = "RF_VAL"
RF_VAL.material = UFD_GRN
RF_VAL.init_pos = {1.01, 0.30, 0} -- X = 1.01, Y matches RF_TXT
RF_VAL.alignment = "RightCenter"
RF_VAL.stringdefs = {0.005, 0.005, 0, 0.0}
RF_VAL.additive_alpha = true
RF_VAL.collimated = false
RF_VAL.isdraw = true
RF_VAL.use_mipfilter = true
RF_VAL.h_clip_relation = h_clip_relations.COMPARE
RF_VAL.level = 2
RF_VAL.element_params = {"MFD_OPACITY","RIGHT_FLAP_INTEGRITY","PMFD_SYS_PAGE"}
RF_VAL.formats = {"%.0f%%"}
RF_VAL.controllers = {
    {"opacity_using_parameter",0},
    {"text_using_parameter",1,0},
    {"parameter_in_range",1,90,101},
    {"parameter_in_range",2,0.9,1.1}
}
Add(RF_VAL)

-- Left Rudder Value
LR_VAL = CreateElement "ceStringPoly"
LR_VAL.name = "LR_VAL"
LR_VAL.material = UFD_GRN
LR_VAL.init_pos = {-0.46, -0.80, 0} -- X = -0.46, Y matches LR_TXT
LR_VAL.alignment = "RightCenter"
LR_VAL.stringdefs = {0.005, 0.005, 0, 0.0}
LR_VAL.additive_alpha = true
LR_VAL.collimated = false
LR_VAL.isdraw = true
LR_VAL.use_mipfilter = true
LR_VAL.h_clip_relation = h_clip_relations.COMPARE
LR_VAL.level = 2
LR_VAL.element_params = {"MFD_OPACITY","LEFT_RUDDER_INTEGRITY","PMFD_SYS_PAGE"}
LR_VAL.formats = {"%.0f%%"}
LR_VAL.controllers = {
    {"opacity_using_parameter",0},
    {"text_using_parameter",1,0},
    {"parameter_in_range",1,90,101},
    {"parameter_in_range",2,0.9,1.1}
}
Add(LR_VAL)

-- Right Rudder Value
RR_VAL = CreateElement "ceStringPoly"
RR_VAL.name = "RR_VAL"
RR_VAL.material = UFD_GRN
RR_VAL.init_pos = {1.01, -0.80, 0} -- X = 1.01, Y matches RR_TXT
RR_VAL.alignment = "RightCenter"
RR_VAL.stringdefs = {0.005, 0.005, 0, 0.0}
RR_VAL.additive_alpha = true
RR_VAL.collimated = false
RR_VAL.isdraw = true
RR_VAL.use_mipfilter = true
RR_VAL.h_clip_relation = h_clip_relations.COMPARE
RR_VAL.level = 2
RR_VAL.element_params = {"MFD_OPACITY","RIGHT_RUDDER_INTEGRITY","PMFD_SYS_PAGE"}
RR_VAL.formats = {"%.0f%%"}
RR_VAL.controllers = {
    {"opacity_using_parameter",0},
    {"text_using_parameter",1,0},
    {"parameter_in_range",1,90,101},
    {"parameter_in_range",2,0.9,1.1}
}
Add(RR_VAL)

-- Left Engine Value
LENG_VAL = CreateElement "ceStringPoly"
LENG_VAL.name = "LENG_VAL"
LENG_VAL.material = UFD_GRN
LENG_VAL.init_pos = {-0.46, -0.90, 0} -- X = -0.46, Y matches LENG_TXT
LENG_VAL.alignment = "RightCenter"
LENG_VAL.stringdefs = {0.005, 0.005, 0, 0.0}
LENG_VAL.additive_alpha = true
LENG_VAL.collimated = false
LENG_VAL.isdraw = true
LENG_VAL.use_mipfilter = true
LENG_VAL.h_clip_relation = h_clip_relations.COMPARE
LENG_VAL.level = 2
LENG_VAL.element_params = {"MFD_OPACITY","LEFT_ENGINE_INTEGRITY","PMFD_SYS_PAGE"}
LENG_VAL.formats = {"%.0f%%"}
LENG_VAL.controllers = {
    {"opacity_using_parameter",0},
    {"text_using_parameter",1,0},
    {"parameter_in_range",1,90,101},
    {"parameter_in_range",2,0.9,1.1}
}
Add(LENG_VAL)

-- Right Engine Value
RENG_VAL = CreateElement "ceStringPoly"
RENG_VAL.name = "RENG_VAL"
RENG_VAL.material = UFD_GRN
RENG_VAL.init_pos = {1.01, -0.90, 0} -- X = 1.01, Y matches RENG_TXT
RENG_VAL.alignment = "RightCenter"
RENG_VAL.stringdefs = {0.005, 0.005, 0, 0.0}
RENG_VAL.additive_alpha = true
RENG_VAL.collimated = false
RENG_VAL.isdraw = true
RENG_VAL.use_mipfilter = true
RENG_VAL.h_clip_relation = h_clip_relations.COMPARE
RENG_VAL.level = 2
RENG_VAL.element_params = {"MFD_OPACITY","RIGHT_ENGINE_INTEGRITY","PMFD_SYS_PAGE"}
RENG_VAL.formats = {"%.0f%%"}
RENG_VAL.controllers = {
    {"opacity_using_parameter",0},
    {"text_using_parameter",1,0},
    {"parameter_in_range",1,90,101},
    {"parameter_in_range",2,0.9,1.1}
}
Add(RENG_VAL)

---RED VALUES=======================================

-- Left Wing Value
LW_VAL = CreateElement "ceStringPoly"
LW_VAL.name = "LW_VAL"
LW_VAL.material = UFD_RED
LW_VAL.init_pos = {-0.46, 0.10, 0} -- X = -0.46, Y matches LW_TXT
LW_VAL.alignment = "RightCenter"
LW_VAL.stringdefs = {0.005, 0.005, 0, 0.0}
LW_VAL.additive_alpha = true
LW_VAL.collimated = false
LW_VAL.isdraw = true
LW_VAL.use_mipfilter = true
LW_VAL.h_clip_relation = h_clip_relations.COMPARE
LW_VAL.level = 2
LW_VAL.element_params = {"MFD_OPACITY","LEFT_WING_INTEGRITY","PMFD_SYS_PAGE"}
LW_VAL.formats = {"%.0f%%"}
LW_VAL.controllers = {
    {"opacity_using_parameter",0},
    {"text_using_parameter",1,0},
    {"parameter_in_range",1,-1,89},
    {"parameter_in_range",2,0.9,1.1}
}
Add(LW_VAL)

-- Right Wing Value
RW_VAL = CreateElement "ceStringPoly"
RW_VAL.name = "RW_VAL"
RW_VAL.material = UFD_RED
RW_VAL.init_pos = {1.01, 0.10, 0} -- X = 1.01, Y matches RW_TXT
RW_VAL.alignment = "RightCenter"
RW_VAL.stringdefs = {0.005, 0.005, 0, 0.0}
RW_VAL.additive_alpha = true
RW_VAL.collimated = false
RW_VAL.isdraw = true
RW_VAL.use_mipfilter = true
RW_VAL.h_clip_relation = h_clip_relations.COMPARE
RW_VAL.level = 2
RW_VAL.element_params = {"MFD_OPACITY","RIGHT_WING_INTEGRITY","PMFD_SYS_PAGE"}
RW_VAL.formats = {"%.0f%%"}
RW_VAL.controllers = {
    {"opacity_using_parameter",0},
    {"text_using_parameter",1,0},
    {"parameter_in_range",1,-1,89},
    {"parameter_in_range",2,0.9,1.1}
}
Add(RW_VAL)

-- Left Tail Value
LT_VAL = CreateElement "ceStringPoly"
LT_VAL.name = "LT_VAL"
LT_VAL.material = UFD_RED
LT_VAL.init_pos = {-0.46, -0.60, 0} -- X = -0.46, Y matches LT_TXT
LT_VAL.alignment = "RightCenter"
LT_VAL.stringdefs = {0.005, 0.005, 0, 0.0}
LT_VAL.additive_alpha = true
LT_VAL.collimated = false
LT_VAL.isdraw = true
LT_VAL.use_mipfilter = true
LT_VAL.h_clip_relation = h_clip_relations.COMPARE
LT_VAL.level = 2
LT_VAL.element_params = {"MFD_OPACITY","LEFT_TAIL_INTEGRITY","PMFD_SYS_PAGE"}
LT_VAL.formats = {"%.0f%%"}
LT_VAL.controllers = {
    {"opacity_using_parameter",0},
    {"text_using_parameter",1,0},
    {"parameter_in_range",1,-1,89},
    {"parameter_in_range",2,0.9,1.1}
}
Add(LT_VAL)

-- Right Tail Value
RT_VAL = CreateElement "ceStringPoly"
RT_VAL.name = "RT_VAL"
RT_VAL.material = UFD_RED
RT_VAL.init_pos = {1.01, -0.60, 0} -- X = 1.01, Y matches RT_TXT
RT_VAL.alignment = "RightCenter"
RT_VAL.stringdefs = {0.005, 0.005, 0, 0.0}
RT_VAL.additive_alpha = true
RT_VAL.collimated = false
RT_VAL.isdraw = true
RT_VAL.use_mipfilter = true
RT_VAL.h_clip_relation = h_clip_relations.COMPARE
RT_VAL.level = 2
RT_VAL.element_params = {"MFD_OPACITY","RIGHT_TAIL_INTEGRITY","PMFD_SYS_PAGE"}
RT_VAL.formats = {"%.0f%%"}
RT_VAL.controllers = {
    {"opacity_using_parameter",0},
    {"text_using_parameter",1,0},
    {"parameter_in_range",1,-1,89},
    {"parameter_in_range",2,0.9,1.1}
}
Add(RT_VAL)

-- Left Elevon Value
LE_VAL = CreateElement "ceStringPoly"
LE_VAL.name = "LE_VAL"
LE_VAL.material = UFD_RED
LE_VAL.init_pos = {-0.46, -0.70, 0} -- X = -0.46, Y matches LE_TXT
LE_VAL.alignment = "RightCenter"
LE_VAL.stringdefs = {0.005, 0.005, 0, 0.0}
LE_VAL.additive_alpha = true
LE_VAL.collimated = false
LE_VAL.isdraw = true
LE_VAL.use_mipfilter = true
LE_VAL.h_clip_relation = h_clip_relations.COMPARE
LE_VAL.level = 2
LE_VAL.element_params = {"MFD_OPACITY","LEFT_ELEVON_INTEGRITY","PMFD_SYS_PAGE"}
LE_VAL.formats = {"%.0f%%"}
LE_VAL.controllers = {
    {"opacity_using_parameter",0},
    {"text_using_parameter",1,0},
    {"parameter_in_range",1,-1,89},
    {"parameter_in_range",2,0.9,1.1}
}
Add(LE_VAL)

-- Right Elevon Value
RE_VAL = CreateElement "ceStringPoly"
RE_VAL.name = "RE_VAL"
RE_VAL.material = UFD_RED
RE_VAL.init_pos = {1.01, -0.70, 0} -- X = 1.01, Y matches RE_TXT
RE_VAL.alignment = "RightCenter"
RE_VAL.stringdefs = {0.005, 0.005, 0, 0.0}
RE_VAL.additive_alpha = true
RE_VAL.collimated = false
RE_VAL.isdraw = true
RE_VAL.use_mipfilter = true
RE_VAL.h_clip_relation = h_clip_relations.COMPARE
RE_VAL.level = 2
RE_VAL.element_params = {"MFD_OPACITY","RIGHT_ELEVON_INTEGRITY","PMFD_SYS_PAGE"}
RE_VAL.formats = {"%.0f%%"}
RE_VAL.controllers = {
    {"opacity_using_parameter",0},
    {"text_using_parameter",1,0},
    {"parameter_in_range",1,-1,89},
    {"parameter_in_range",2,0.9,1.1}
}
Add(RE_VAL)

-- Left Aileron Value
LA_VAL = CreateElement "ceStringPoly"
LA_VAL.name = "LA_VAL"
LA_VAL.material = UFD_RED
LA_VAL.init_pos = {-0.46, 0.20, 0} -- X = -0.46, Y matches LA_TXT
LA_VAL.alignment = "RightCenter"
LA_VAL.stringdefs = {0.005, 0.005, 0, 0.0}
LA_VAL.additive_alpha = true
LA_VAL.collimated = false
LA_VAL.isdraw = true
LA_VAL.use_mipfilter = true
LA_VAL.h_clip_relation = h_clip_relations.COMPARE
LA_VAL.level = 2
LA_VAL.element_params = {"MFD_OPACITY","LEFT_AILERON_INTEGRITY","PMFD_SYS_PAGE"}
LA_VAL.formats = {"%.0f%%"}
LA_VAL.controllers = {
    {"opacity_using_parameter",0},
    {"text_using_parameter",1,0},
    {"parameter_in_range",1,-1,89},
    {"parameter_in_range",2,0.9,1.1}
}
Add(LA_VAL)

-- Right Aileron Value
RA_VAL = CreateElement "ceStringPoly"
RA_VAL.name = "RA_VAL"
RA_VAL.material = UFD_RED
RA_VAL.init_pos = {1.01, 0.20, 0} -- X = 1.01, Y matches RA_TXT
RA_VAL.alignment = "RightCenter"
RA_VAL.stringdefs = {0.005, 0.005, 0, 0.0}
RA_VAL.additive_alpha = true
RA_VAL.collimated = false
RA_VAL.isdraw = true
RA_VAL.use_mipfilter = true
RA_VAL.h_clip_relation = h_clip_relations.COMPARE
RA_VAL.level = 2
RA_VAL.element_params = {"MFD_OPACITY","RIGHT_AILERON_INTEGRITY","PMFD_SYS_PAGE"}
RA_VAL.formats = {"%.0f%%"}
RA_VAL.controllers = {
    {"opacity_using_parameter",0},
    {"text_using_parameter",1,0},
    {"parameter_in_range",1,-1,89},
    {"parameter_in_range",2,0.9,1.1}
}
Add(RA_VAL)

-- Left Flap Value
LF_VAL = CreateElement "ceStringPoly"
LF_VAL.name = "LF_VAL"
LF_VAL.material = UFD_RED
LF_VAL.init_pos = {-0.46, 0.30, 0} -- X = -0.46, Y matches LF_TXT
LF_VAL.alignment = "RightCenter"
LF_VAL.stringdefs = {0.005, 0.005, 0, 0.0}
LF_VAL.additive_alpha = true
LF_VAL.collimated = false
LF_VAL.isdraw = true
LF_VAL.use_mipfilter = true
LF_VAL.h_clip_relation = h_clip_relations.COMPARE
LF_VAL.level = 2
LF_VAL.element_params = {"MFD_OPACITY","LEFT_FLAP_INTEGRITY","PMFD_SYS_PAGE"}
LF_VAL.formats = {"%.0f%%"}
LF_VAL.controllers = {
    {"opacity_using_parameter",0},
    {"text_using_parameter",1,0},
    {"parameter_in_range",1,-1,89},
    {"parameter_in_range",2,0.9,1.1}
}
Add(LF_VAL)

-- Right Flap Value
RF_VAL = CreateElement "ceStringPoly"
RF_VAL.name = "RF_VAL"
RF_VAL.material = UFD_RED
RF_VAL.init_pos = {1.01, 0.30, 0} -- X = 1.01, Y matches RF_TXT
RF_VAL.alignment = "RightCenter"
RF_VAL.stringdefs = {0.005, 0.005, 0, 0.0}
RF_VAL.additive_alpha = true
RF_VAL.collimated = false
RF_VAL.isdraw = true
RF_VAL.use_mipfilter = true
RF_VAL.h_clip_relation = h_clip_relations.COMPARE
RF_VAL.level = 2
RF_VAL.element_params = {"MFD_OPACITY","RIGHT_FLAP_INTEGRITY","PMFD_SYS_PAGE"}
RF_VAL.formats = {"%.0f%%"}
RF_VAL.controllers = {
    {"opacity_using_parameter",0},
    {"text_using_parameter",1,0},
    {"parameter_in_range",1,-1,89},
    {"parameter_in_range",2,0.9,1.1}
}
Add(RF_VAL)

-- Left Rudder Value
LR_VAL = CreateElement "ceStringPoly"
LR_VAL.name = "LR_VAL"
LR_VAL.material = UFD_RED
LR_VAL.init_pos = {-0.46, -0.80, 0} -- X = -0.46, Y matches LR_TXT
LR_VAL.alignment = "RightCenter"
LR_VAL.stringdefs = {0.005, 0.005, 0, 0.0}
LR_VAL.additive_alpha = true
LR_VAL.collimated = false
LR_VAL.isdraw = true
LR_VAL.use_mipfilter = true
LR_VAL.h_clip_relation = h_clip_relations.COMPARE
LR_VAL.level = 2
LR_VAL.element_params = {"MFD_OPACITY","LEFT_RUDDER_INTEGRITY","PMFD_SYS_PAGE"}
LR_VAL.formats = {"%.0f%%"}
LR_VAL.controllers = {
    {"opacity_using_parameter",0},
    {"text_using_parameter",1,0},
    {"parameter_in_range",1,-1,89},
    {"parameter_in_range",2,0.9,1.1}
}
Add(LR_VAL)

-- Right Rudder Value
RR_VAL = CreateElement "ceStringPoly"
RR_VAL.name = "RR_VAL"
RR_VAL.material = UFD_RED
RR_VAL.init_pos = {1.01, -0.80, 0} -- X = 1.01, Y matches RR_TXT
RR_VAL.alignment = "RightCenter"
RR_VAL.stringdefs = {0.005, 0.005, 0, 0.0}
RR_VAL.additive_alpha = true
RR_VAL.collimated = false
RR_VAL.isdraw = true
RR_VAL.use_mipfilter = true
RR_VAL.h_clip_relation = h_clip_relations.COMPARE
RR_VAL.level = 2
RR_VAL.element_params = {"MFD_OPACITY","RIGHT_RUDDER_INTEGRITY","PMFD_SYS_PAGE"}
RR_VAL.formats = {"%.0f%%"}
RR_VAL.controllers = {
    {"opacity_using_parameter",0},
    {"text_using_parameter",1,0},
    {"parameter_in_range",1,-1,89},
    {"parameter_in_range",2,0.9,1.1}
}
Add(RR_VAL)

-- Left Engine Value
LENG_VAL = CreateElement "ceStringPoly"
LENG_VAL.name = "LENG_VAL"
LENG_VAL.material = UFD_RED
LENG_VAL.init_pos = {-0.46, -0.90, 0} -- X = -0.46, Y matches LENG_TXT
LENG_VAL.alignment = "RightCenter"
LENG_VAL.stringdefs = {0.005, 0.005, 0, 0.0}
LENG_VAL.additive_alpha = true
LENG_VAL.collimated = false
LENG_VAL.isdraw = true
LENG_VAL.use_mipfilter = true
LENG_VAL.h_clip_relation = h_clip_relations.COMPARE
LENG_VAL.level = 2
LENG_VAL.element_params = {"MFD_OPACITY","LEFT_ENGINE_INTEGRITY","PMFD_SYS_PAGE"}
LENG_VAL.formats = {"%.0f%%"}
LENG_VAL.controllers = {
    {"opacity_using_parameter",0},
    {"text_using_parameter",1,0},
    {"parameter_in_range",1,-1,89},
    {"parameter_in_range",2,0.9,1.1}
}
Add(LENG_VAL)

-- Right Engine Value
RENG_VAL = CreateElement "ceStringPoly"
RENG_VAL.name = "RENG_VAL"
RENG_VAL.material = UFD_RED
RENG_VAL.init_pos = {1.01, -0.90, 0} -- X = 1.01, Y matches RENG_TXT
RENG_VAL.alignment = "RightCenter"
RENG_VAL.stringdefs = {0.005, 0.005, 0, 0.0}
RENG_VAL.additive_alpha = true
RENG_VAL.collimated = false
RENG_VAL.isdraw = true
RENG_VAL.use_mipfilter = true
RENG_VAL.h_clip_relation = h_clip_relations.COMPARE
RENG_VAL.level = 2
RENG_VAL.element_params = {"MFD_OPACITY","RIGHT_ENGINE_INTEGRITY","PMFD_SYS_PAGE"}
RENG_VAL.formats = {"%.0f%%"}
RENG_VAL.controllers = {
    {"opacity_using_parameter",0},
    {"text_using_parameter",1,0},
    {"parameter_in_range",1,-1,89},
    {"parameter_in_range",2,0.9,1.1}
}
Add(RENG_VAL)