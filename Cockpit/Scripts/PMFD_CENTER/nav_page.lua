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
local ScreenColor			= {3, 3, 12, 255}--RGBA 5-5-5

--local PFD_PAGE_1 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/pfd_page_1.dds", GreenColor)--SYSTEM TEST
local MASK_BOX	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mask_bx.dds", ScreenColor)--SYSTEM TEST
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
BGROUND.element_params 		= {"MFD_OPACITY","PMFD_MAP_PAGE"}--this may not be bneeded check when more pages done for backlight on page 7 SMS fc3 bs
BGROUND.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}--MENU PAGE = 1
BGROUND.level 				= 2
BGROUND.h_clip_relation     = h_clip_relations.COMPARE
vertices(BGROUND,3)
Add(BGROUND)
----------------------------------------------------------------------------------------------------------------
PH_TEXT 					        = CreateElement "ceStringPoly"
PH_TEXT.name 				        = "menu"
PH_TEXT.material 			        = UFD_RED
PH_TEXT.value 				    = "CLASSIFIED"
PH_TEXT.stringdefs 		        = {0.0099, 0.0099, 0.0004, 0.001}
PH_TEXT.alignment 			    = "CenterCenter"
PH_TEXT.formats 			        = {"%s"}
PH_TEXT.h_clip_relation           = h_clip_relations.COMPARE
PH_TEXT.level 				    = 2
PH_TEXT.init_pos 			        = {0, 0, 0}
PH_TEXT.init_rot 			        = {0, 0, 0}
PH_TEXT.element_params 	        = {"MFD_OPACITY","PMFD_MAP_PAGE"}
PH_TEXT.controllers		        = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
--Add(PH_TEXT)
----------------------------------------------------------------------------------------------------------------
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
MENU.element_params 	        = {"MFD_OPACITY","PMFD_MAP_PAGE"}
MENU.controllers		        =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(MENU)