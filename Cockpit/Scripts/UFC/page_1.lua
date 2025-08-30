dofile(LockOn_Options.script_path.."UFC/definitions.lua")
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
--------------------------------------------------------------------------------------------------------------------------------------------
local MASK_BOX	    = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mask_box.dds", RedColor)--SYSTEM TEST
--------------------------------------------------------------------------------------------------------------------------------------------
local ClippingPlaneSize = 1.7 --Clipping Masks
local ClippingWidth 	= 2.7   --Clipping Masks
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
total_field_of_view.init_pos        = {-1.1, 0, 0}
total_field_of_view.init_rot        = { 0, 0, 0} -- degree NOT rad
total_field_of_view.h_clip_relation = h_clip_relations.REWRITE_LEVEL
total_field_of_view.level           = 20
total_field_of_view.collimated      = false
total_field_of_view.isvisible       = false
Add(total_field_of_view)
--Clipping Masks
local clipPoly               = CreateElement "ceMeshPoly"
clipPoly.name                = "clipPoly-1"
clipPoly.primitivetype       = "triangles"
clipPoly.init_pos            = {-1.1, 0, 0}
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
clipPoly.level               = 20
clipPoly.collimated          = false
clipPoly.isvisible           = false
Add(clipPoly)
------------------------------------------------------------------------------------------------CLIPPING-END----------------------------------------------------------------------------------------------
--HUD MENU
    NAV 					    = CreateElement "ceStringPoly"
    NAV.name 				    = "menu"
    NAV.material 			    = UFD_GRN
    NAV.value 				    = "NAV MODE"
    NAV.stringdefs 		    = {0.0060, 0.0060, 0.0004, 0.001}
    NAV.alignment 			    = "LeftCenter"
    NAV.formats 			    = {"%s"}
    NAV.h_clip_relation        = h_clip_relations.COMPARE
    NAV.level 				    = 21
    NAV.init_pos 			    = {-1, 1.2, 0}
    NAV.init_rot 			    = {0, 0, 0}
    NAV.element_params 	    = {"ICP_OPACITY","ICP_HUD_MENU"}
    NAV.controllers		    =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
    Add(NAV)
    ----------------------------------------------------------------------------------------------------------------
    BVR 					    = CreateElement "ceStringPoly"
    BVR.name 				    = "menu"
    BVR.material 			    = UFD_GRN
    BVR.value 				    = "BVR MODE"
    BVR.stringdefs 		    = {0.0060, 0.0060, 0.0004, 0.001}
    BVR.alignment 			    = "LeftCenter"
    BVR.formats 			    = {"%s"}
    BVR.h_clip_relation        = h_clip_relations.COMPARE
    BVR.level 				    = 21
    BVR.init_pos 			    = {-1, 0.6, 0}
    BVR.init_rot 			    = {0, 0, 0}
    BVR.element_params 	    = {"ICP_OPACITY","ICP_HUD_MENU"}
    BVR.controllers		    =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
    Add(BVR)
    ----------------
    VERTSCAN 					    = CreateElement "ceStringPoly"
    VERTSCAN.name 				    = "menu"
    VERTSCAN.material 			    = UFD_GRN
    VERTSCAN.value 				    = "VERTICAL SCAN"
    VERTSCAN.stringdefs 		    = {0.0060, 0.0060, 0.0004, 0.001}
    VERTSCAN.alignment 			    = "LeftCenter"
    VERTSCAN.formats 			    = {"%s"}
    VERTSCAN.h_clip_relation        = h_clip_relations.COMPARE
    VERTSCAN.level 				    = 21
    VERTSCAN.init_pos 			    = {-1, 0, 0}
    VERTSCAN.init_rot 			    = {0, 0, 0}
    VERTSCAN.element_params 	    = {"ICP_OPACITY","ICP_HUD_MENU"}
    VERTSCAN.controllers		    =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
    Add(VERTSCAN)
    ----------------
    BORE 					    = CreateElement "ceStringPoly"
    BORE.name 				    = "menu"
    BORE.material 			    = UFD_GRN
    BORE.value 				    = "BORE SIGHT"
    BORE.stringdefs 		    = {0.0060, 0.0060, 0.0004, 0.001}
    BORE.alignment 			    = "LeftCenter"
    BORE.formats 			    = {"%s"}
    BORE.h_clip_relation        = h_clip_relations.COMPARE
    BORE.level 				    = 21
    BORE.init_pos 			    = {-1, -0.6, 0}
    BORE.init_rot 			    = {0, 0, 0}
    BORE.element_params 	    = {"ICP_OPACITY","ICP_HUD_MENU"}
    BORE.controllers		    =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
    Add(BORE)
    ----------------
    FLOOD 					    = CreateElement "ceStringPoly"
    FLOOD.name 				    = "menu"
    FLOOD.material 			    = UFD_GRN
    FLOOD.value 				    = "FLOOD MODE"
    FLOOD.stringdefs 		    = {0.0060, 0.0060, 0.0004, 0.001}
    FLOOD.alignment 			    = "LeftCenter"
    FLOOD.formats 			    = {"%s"}
    FLOOD.h_clip_relation        = h_clip_relations.COMPARE
    FLOOD.level 				    = 21
    FLOOD.init_pos 			    = {-1, -1.2, 0}
    FLOOD.init_rot 			    = {0, 0, 0}
    FLOOD.element_params 	    = {"ICP_OPACITY","ICP_HUD_MENU"}
    FLOOD.controllers		    =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
    Add(FLOOD)
--AP MENU
AP1 					    = CreateElement "ceStringPoly"
AP1.name 				    = "menu"
AP1.material 			    = UFD_GRN
AP1.value 				    = "ALTITUDE HOLD"
AP1.stringdefs 		        = {0.0060, 0.0060, 0.0004, 0.001}
AP1.alignment 			    = "LeftCenter"
AP1.formats 			    = {"%s"}
AP1.h_clip_relation         = h_clip_relations.COMPARE
AP1.level 				    = 21
AP1.init_pos 			    = {-0.95, 1.2, 0}
AP1.init_rot 			    = {0, 0, 0}
AP1.element_params 	        = {"ICP_OPACITY","ICP_AP_MENU"}
AP1.controllers		        =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(AP1)
----------------------------------------------------------------------------------------------------------------
AP2 					    = CreateElement "ceStringPoly"
AP2.name 				    = "menu"
AP2.material 			    = UFD_GRN
AP2.value 				    = "NAV STEER"
AP2.stringdefs 		        = {0.0060, 0.0060, 0.0004, 0.001}
AP2.alignment 			    = "LeftCenter"
AP2.formats 			    = {"%s"}
AP2.h_clip_relation         = h_clip_relations.COMPARE
AP2.level 				    = 21
AP2.init_pos 			    = {-0.95, 0.6, 0}
AP2.init_rot 			    = {0, 0, 0}
AP2.element_params 	        = {"ICP_OPACITY","ICP_AP_MENU"}
AP2.controllers		        =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(AP2)
----------------
AP3 					    = CreateElement "ceStringPoly"
AP3.name 				    = "menu"
AP3.material 			    = UFD_GRN
AP3.value 				    = "PITCH HOLD"
AP3.stringdefs 		        = {0.0060, 0.0060, 0.0004, 0.001}
AP3.alignment 			    = "LeftCenter"
AP3.formats 			    = {"%s"}
AP3.h_clip_relation         = h_clip_relations.COMPARE
AP3.level 				    = 21
AP3.init_pos 			    = {-0.95, 0, 0}
AP3.init_rot 			    = {0, 0, 0}
AP3.element_params 	        = {"ICP_OPACITY","ICP_AP_MENU"}
AP3.controllers		        =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(AP3)
----
----------------
AP4 					    = CreateElement "ceStringPoly"
AP4.name 				    = "menu"
AP4.material 			    = UFD_GRN
AP4.value 				    = "AP DISENGAGE"
AP4.stringdefs 		        = {0.0060, 0.0060, 0.0004, 0.001}
AP4.alignment 			    = "LeftCenter"
AP4.formats 			    = {"%s"}
AP4.h_clip_relation         = h_clip_relations.COMPARE
AP4.level 				    = 21
AP4.init_pos 			    = {-0.95, -0.6, 0}
AP4.init_rot 			    = {0, 0, 0}
AP4.element_params 	        = {"ICP_OPACITY","ICP_AP_MENU"}
AP4.controllers		        =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(AP4)
----------------
--===============================================================================

INPUT = CreateElement "ceStringPoly"
INPUT.name = "INPUT"
INPUT.material = UFD_GRN
INPUT.init_pos = {-1.8, 1.2, 0}
INPUT.alignment = "RightCenter"
INPUT.stringdefs = {0.0060, 0.0060, 0.0025, 0.001} -- Size and spacing
INPUT.additive_alpha = true
INPUT.collimated = false
INPUT.isdraw = true
INPUT.use_mipfilter = true
INPUT.h_clip_relation = h_clip_relations.COMPARE
INPUT.level = 21
INPUT.element_params = {"ICP_OPACITY", "ICP_INPUT"}
INPUT.formats = {"%01.0f"} 
INPUT.controllers = {
    {"opacity_using_parameter", 0}, 
    {"text_using_parameter", 1, 0}, 
    {"parameter_in_range", 1, 0.1, 99999999999} 
}
Add(INPUT)

--===========BINGO

BINGO_1				        = CreateElement "ceStringPoly"
BINGO_1.name				= "BINGO_1"
BINGO_1.material			= UFD_GRN
BINGO_1.init_pos			= {0.75, 0.6, 0}
BINGO_1.alignment			= "RightCenter"
BINGO_1.stringdefs			= {0.0060, 0.0060, 0.0004, 0.001}
BINGO_1.additive_alpha		= true
BINGO_1.collimated			= false
BINGO_1.isdraw				= true	
BINGO_1.use_mipfilter		= true
BINGO_1.h_clip_relation		= h_clip_relations.COMPARE
BINGO_1.level				= 21
BINGO_1.element_params		= {"ICP_OPACITY","BINGO_VAL","ICP_BINGO_MENU"}
BINGO_1.formats				= {"%04.0f"}
BINGO_1.controllers			= {{"opacity_using_parameter",0},{"text_using_parameter",1,0},{"parameter_in_range",2,0.9,1.1}}
Add(BINGO_1)

BINGO_1_CUR 					    = CreateElement "ceStringPoly"
BINGO_1_CUR.name 				    = "BINGO_1_CUR"
BINGO_1_CUR.material 			    = UFD_GRN
BINGO_1_CUR.value 				    = "UPDATE BINGO"
BINGO_1_CUR.stringdefs 		    = {0.0060, 0.0060, 0.0004, 0.001}
BINGO_1_CUR.alignment 			    = "LeftCenter"
BINGO_1_CUR.formats 			    = {"%s"}
BINGO_1_CUR.h_clip_relation        = h_clip_relations.COMPARE
BINGO_1_CUR.level 				    = 21
BINGO_1_CUR.init_pos 			    = {-0.9, 1.2, 0}
BINGO_1_CUR.init_rot 			    = {0, 0, 0}
BINGO_1_CUR.element_params 	    = {"ICP_OPACITY","ICP_BINGO_MENU"}
BINGO_1_CUR.controllers		    =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(BINGO_1_CUR)

----------------------------------------------------------------------------------------------------------------
BINGO_2 					    = CreateElement "ceStringPoly"
BINGO_2.name 				    = "BINGO_2"
BINGO_2.material 			    = UFD_GRN
BINGO_2.value 				    = "CURRENT:"
BINGO_2.stringdefs 		    = {0.0060, 0.0060, 0.0004, 0.001}
BINGO_2.alignment 			    = "LeftCenter"
BINGO_2.formats 			    = {"%s"}
BINGO_2.h_clip_relation        = h_clip_relations.COMPARE
BINGO_2.level 				    = 21
BINGO_2.init_pos 			    = {-0.9, 0.6, 0}
BINGO_2.init_rot 			    = {0, 0, 0}
BINGO_2.element_params 	    = {"ICP_OPACITY","ICP_BINGO_MENU"}
BINGO_2.controllers		    =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(BINGO_2)
----------------



--===========COM1
COM1_TITLE 					    = CreateElement "ceStringPoly"
COM1_TITLE.name 				    = "COM1_TITLE"
COM1_TITLE.material 			    = UFD_GRN
COM1_TITLE.value 				    = "1  UHF"
COM1_TITLE.stringdefs 		    = {0.0060, 0.0060, 0.0004, 0.001}
COM1_TITLE.alignment 			    = "LeftCenter"
COM1_TITLE.formats 			    = {"%s"}
COM1_TITLE.h_clip_relation        = h_clip_relations.COMPARE
COM1_TITLE.level 				    = 21
COM1_TITLE.init_pos 			    = {-3.6, 1.2, 0}
COM1_TITLE.init_rot 			    = {0, 0, 0}
COM1_TITLE.element_params 	    = {"ICP_OPACITY","ICP_COM1_MENU","ICP_COM1_TITLE"}
COM1_TITLE.controllers		    =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.9,1.1}}
Add(COM1_TITLE)

COM1_1 					    = CreateElement "ceStringPoly"
COM1_1.name 				    = "COM1_1"
COM1_1.material 			    = UFD_GRN
COM1_1.value 				    = "126.005"
COM1_1.stringdefs 		    = {0.0060, 0.0060, 0.0004, 0.001}
COM1_1.alignment 			    = "LeftCenter"
COM1_1.formats 			    = {"%s"}
COM1_1.h_clip_relation        = h_clip_relations.COMPARE
COM1_1.level 				    = 21
COM1_1.init_pos 			    = {-0.9, 1.2, 0}
COM1_1.init_rot 			    = {0, 0, 0}
COM1_1.element_params 	    = {"ICP_OPACITY","ICP_COM1_MENU"}
COM1_1.controllers		    =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(COM1_1)
----------------------------------------------------------------------------------------------------------------
COM1_2 					    = CreateElement "ceStringPoly"
COM1_2.name 				    = "menu"
COM1_2.material 			    = UFD_GRN
COM1_2.value 				    = "UPDATE FREQ"
COM1_2.stringdefs 		    = {0.0060, 0.0060, 0.0004, 0.001}
COM1_2.alignment 			    = "LeftCenter"
COM1_2.formats 			    = {"%s"}
COM1_2.h_clip_relation        = h_clip_relations.COMPARE
COM1_2.level 				    = 21
COM1_2.init_pos 			    = {-0.9, 0.6, 0}
COM1_2.init_rot 			    = {0, 0, 0}
COM1_2.element_params 	    = {"ICP_OPACITY","ICP_COM1_MENU"}
COM1_2.controllers		    =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(COM1_2)
----------------
COM1_3 					    = CreateElement "ceStringPoly"
COM1_3.name 				    = "menu"
COM1_3.material 			    = UFD_GRN
COM1_3.value 				    = "TX/RX"
COM1_3.stringdefs 		    = {0.0060, 0.0060, 0.0004, 0.001}
COM1_3.alignment 			    = "LeftCenter"
COM1_3.formats 			    = {"%s"}
COM1_3.h_clip_relation        = h_clip_relations.COMPARE
COM1_3.level 				    = 21
COM1_3.init_pos 			    = {-0.9, 0, 0}
COM1_3.init_rot 			    = {0, 0, 0}
COM1_3.element_params 	    = {"ICP_OPACITY","ICP_COM1_MENU"}
COM1_3.controllers		    =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(COM1_3)
----------------
COM1_4 					    = CreateElement "ceStringPoly"
COM1_4.name 				    = "menu"
COM1_4.material 			    = UFD_GRN
COM1_4.value 				    = "---"
COM1_4.stringdefs 		    = {0.0060, 0.0060, 0.0004, 0.001}
COM1_4.alignment 			    = "LeftCenter"
COM1_4.formats 			    = {"%s"}
COM1_4.h_clip_relation        = h_clip_relations.COMPARE
COM1_4.level 				    = 21
COM1_4.init_pos 			    = {-0.9, -0.6, 0}
COM1_4.init_rot 			    = {0, 0, 0}
COM1_4.element_params 	    = {"ICP_OPACITY","ICP_COM1_MENU"}
COM1_4.controllers		    =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(COM1_4)
----------------
COM1_5 					    = CreateElement "ceStringPoly"
COM1_5.name 				    = "menu"
COM1_5.material 			    = UFD_GRN
COM1_5.value 				    = "REARM / REFUEL"
COM1_5.stringdefs 		    = {0.0060, 0.0060, 0.0004, 0.001}
COM1_5.alignment 			    = "LeftCenter"
COM1_5.formats 			    = {"%s"}
COM1_5.h_clip_relation        = h_clip_relations.COMPARE
COM1_5.level 				    = 21
COM1_5.init_pos 			    = {-0.9, -1.2, 0}
COM1_5.init_rot 			    = {0, 0, 0}
COM1_5.element_params 	    = {"ICP_OPACITY","ICP_COM1_MENU"}
COM1_5.controllers		    =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(COM1_5)

--COM2

COM2_TITLE 					    = CreateElement "ceStringPoly"
COM2_TITLE.name 				    = "COM2_TITLE"
COM2_TITLE.material 			    = UFD_GRN
COM2_TITLE.value 				    = "2  VHF"
COM2_TITLE.stringdefs 		    = {0.0060, 0.0060, 0.0004, 0.001}
COM2_TITLE.alignment 			    = "LeftCenter"
COM2_TITLE.formats 			    = {"%s"}
COM2_TITLE.h_clip_relation        = h_clip_relations.COMPARE
COM2_TITLE.level 				    = 21
COM2_TITLE.init_pos 			    = {-3.6, 1.2, 0}
COM2_TITLE.init_rot 			    = {0, 0, 0}
COM2_TITLE.element_params 	    = {"ICP_OPACITY","ICP_COM2_MENU","ICP_COM2_TITLE"}
COM2_TITLE.controllers		    =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.9,1.1}}
Add(COM2_TITLE)

COM2_1 					    = CreateElement "ceStringPoly"
COM2_1.name 				    = "COM2_1"
COM2_1.material 			    = UFD_GRN
COM2_1.value 				    = "181.065"
COM2_1.stringdefs 		    = {0.0060, 0.0060, 0.0004, 0.001}
COM2_1.alignment 			    = "LeftCenter"
COM2_1.formats 			    = {"%s"}
COM2_1.h_clip_relation        = h_clip_relations.COMPARE
COM2_1.level 				    = 21
COM2_1.init_pos 			    = {-0.9, 1.2, 0}
COM2_1.init_rot 			    = {0, 0, 0}
COM2_1.element_params 	    = {"ICP_OPACITY","ICP_COM2_MENU"}
COM2_1.controllers		    =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(COM2_1)
----------------------------------------------------------------------------------------------------------------
COM2_2 					    = CreateElement "ceStringPoly"
COM2_2.name 				    = "menu"
COM2_2.material 			    = UFD_GRN
COM2_2.value 				    = "UPDATE FREQ"
COM2_2.stringdefs 		    = {0.0060, 0.0060, 0.0004, 0.001}
COM2_2.alignment 			    = "LeftCenter"
COM2_2.formats 			    = {"%s"}
COM2_2.h_clip_relation        = h_clip_relations.COMPARE
COM2_2.level 				    = 21
COM2_2.init_pos 			    = {-0.9, 0.6, 0}
COM2_2.init_rot 			    = {0, 0, 0}
COM2_2.element_params 	    = {"ICP_OPACITY","ICP_COM2_MENU"}
COM2_2.controllers		    =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(COM2_2)
----------------
COM2_3 					    = CreateElement "ceStringPoly"
COM2_3.name 				    = "menu"
COM2_3.material 			    = UFD_GRN
COM2_3.value 				    = "----"
COM2_3.stringdefs 		    = {0.0060, 0.0060, 0.0004, 0.001}
COM2_3.alignment 			    = "LeftCenter"
COM2_3.formats 			    = {"%s"}
COM2_3.h_clip_relation        = h_clip_relations.COMPARE
COM2_3.level 				    = 21
COM2_3.init_pos 			    = {-0.9, 0, 0}
COM2_3.init_rot 			    = {0, 0, 0}
COM2_3.element_params 	    = {"ICP_OPACITY","ICP_COM2_MENU"}
COM2_3.controllers		    =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(COM2_3)
----------------
COM2_4 					    = CreateElement "ceStringPoly"
COM2_4.name 				    = "menu"
COM2_4.material 			    = UFD_GRN
COM2_4.value 				    = "----"
COM2_4.stringdefs 		    = {0.0060, 0.0060, 0.0004, 0.001}
COM2_4.alignment 			    = "LeftCenter"
COM2_4.formats 			    = {"%s"}
COM2_4.h_clip_relation        = h_clip_relations.COMPARE
COM2_4.level 				    = 21
COM2_4.init_pos 			    = {-0.9, -0.6, 0}
COM2_4.init_rot 			    = {0, 0, 0}
COM2_4.element_params 	    = {"ICP_OPACITY","ICP_COM2_MENU"}
COM2_4.controllers		    =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(COM2_4)
----------------
COM2_5 					    = CreateElement "ceStringPoly"
COM2_5.name 				    = "menu"
COM2_5.material 			    = UFD_GRN
COM2_5.value 				    = "REFUEL"
COM2_5.stringdefs 		    = {0.0060, 0.0060, 0.0004, 0.001}
COM2_5.alignment 			    = "LeftCenter"
COM2_5.formats 			    = {"%s"}
COM2_5.h_clip_relation        = h_clip_relations.COMPARE
COM2_5.level 				    = 21
COM2_5.init_pos 			    = {-0.9, -1.2, 0}
COM2_5.init_rot 			    = {0, 0, 0}
COM2_5.element_params 	    = {"ICP_OPACITY","ICP_COM2_MENU"}
COM2_5.controllers		    =   {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(COM2_5)