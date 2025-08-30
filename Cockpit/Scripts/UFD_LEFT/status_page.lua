dofile(LockOn_Options.script_path.."UFD_LEFT/definitions.lua")
dofile(LockOn_Options.script_path.."fonts.lua")
dofile(LockOn_Options.script_path.."materials.lua")

local function vertices(object, height, half_or_double)
    local width = height
    
    if half_or_double == true then --
        width = 11
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
local MainColor 			= {255, 255, 255, 255}--RGBA
local GreenColor 		    = {0, 255, 0, 255}--RGBA
local WhiteColor 			= {255, 255, 255, 255}--RGBA
local RedColor 				= {255, 0, 0, 255}--RGBA
local BlackColor 			= {0, 0, 0, 255}--RGBA
local ScreenColor			= {3, 3, 3, 255}--RGBA 5-5-5
local ADIbottom				= {8, 8, 8, 255}--RGBA
local TealColor				= {0, 255, 255, 255}--RGBA
local TrimColor				= {255, 255, 255, 255}--RGBA
local BOXColor				= {10, 10, 10, 255}--RGBA

local MASK_BOX	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mask_box.dds", 	ScreenColor)--SYSTEM TEST
local MASK_BOX1	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mask_box.dds", 	ADIbottom)--SYSTEM TEST
local MASK_BOXW	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mask_box.dds", 	WhiteColor)--SYSTEM TEST


local BLACK_MASK = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mask_box.dds", 	BlackColor)


local ClippingPlaneSize = 50 --Clipping Masks   --50
local ClippingWidth 	= 75--Clipping Masks	--85
local PFD_MASK_BASE1 	= MakeMaterial(nil,{255,0,0,255})--Clipping Masks
local PFD_MASK_BASE2 	= MakeMaterial(nil,{0,0,255,255})--Clipping Masks
local IND_BOX	    	= MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/ind_box.dds", GreenColor)
local UFD_VERT_LINE	    = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/ufd_vertical_line.dds", GreenColor)

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
--Add(total_field_of_view)

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
--Add(clipPoly)
-------------------------------------------------------------------------------------------------------------------------------------
--TEST
BGROUND                    = CreateElement "ceTexPoly"
BGROUND.name    			= "BG"
BGROUND.material			= MASK_BOX
BGROUND.change_opacity 		= false
BGROUND.collimated 			= false
BGROUND.isvisible 			= true
BGROUND.init_pos 			= {0, 0, 0} --maybe its x,y,z z being depth.. again who the fuck knows?
BGROUND.init_rot 			= {0, 0, 0}
--BGROUND.indices 			= {0, 1, 2, 2, 3, 0}
BGROUND.element_params 		= {"UFD_OPACITY","LUFD_STATUS_PAGE"} --HOPE THIS WORKS G_OP_BACK
BGROUND.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",0,0.9,1.1}}
BGROUND.level 				= 2
BGROUND.h_clip_relation     = h_clip_relations.COMPARE
vertices(BGROUND,200)

--Add(BGROUND)
----------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------APU-READY
STATUSTXT 					= CreateElement "ceStringPoly"
STATUSTXT.name 			= "STATUSTXT"
STATUSTXT.material 		= UFD_GRN --FONT_RPM--
STATUSTXT.value 			= "STATUS"
STATUSTXT.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
STATUSTXT.alignment 		= "CenterCenter"
STATUSTXT.formats 			= {"%s"}
STATUSTXT.h_clip_relation  = h_clip_relations.COMPARE
STATUSTXT.level 			= 2
STATUSTXT.init_rot 		= {0, 0, 0}
STATUSTXT.init_pos 		= {0, -45, 0}
STATUSTXT.element_params = {"LUFD_STATUS_PAGE","UFD_OPACITY"} --HOPE THIS WORKS G_OP_BACK
STATUSTXT.controllers	= 	{{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(STATUSTXT)

NAVTXT 					= CreateElement "ceStringPoly"
NAVTXT.name 			= "NAVTXT"
NAVTXT.material 		= UFD_FONT --FONT_RPM--
NAVTXT.value 			= "NAV"
NAVTXT.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
NAVTXT.alignment 		= "CenterCenter"
NAVTXT.formats 			= {"%s"}
NAVTXT.h_clip_relation  = h_clip_relations.COMPARE
NAVTXT.level 			= 2
NAVTXT.init_rot 		= {0, 0, 0}
NAVTXT.init_pos 		= {-24, -45, 0}
NAVTXT.element_params = {"LUFD_STATUS_PAGE","UFD_OPACITY"} --HOPE THIS WORKS G_OP_BACK
NAVTXT.controllers	= 	{{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(NAVTXT)

ALERTTXT 					= CreateElement "ceStringPoly"
ALERTTXT.name 			= "ALERTTXT"
ALERTTXT.material 		= UFD_GRN --FONT_RPM--
ALERTTXT.value 			= "ALERT"
ALERTTXT.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
ALERTTXT.alignment 		= "CenterCenter"
ALERTTXT.formats 			= {"%s"}
ALERTTXT.h_clip_relation  = h_clip_relations.COMPARE
ALERTTXT.level 			= 2
ALERTTXT.init_rot 		= {0, 0, 0}
ALERTTXT.init_pos 		= {24, -45, 0}
ALERTTXT.element_params = {"LUFD_STATUS_PAGE","UFD_OPACITY","CHECK_ENGINE_LIGHT"} --HOPE THIS WORKS G_OP_BACK
ALERTTXT.controllers	= 	{{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1},{"parameter_in_range",2,-0.1,0.1},}
Add(ALERTTXT)

ALERTTXTON 					= CreateElement "ceStringPoly"
ALERTTXTON.name 			= "ALERTTXT"
ALERTTXTON.material 		= UFD_RED --FONT_RPM--
ALERTTXTON.value 			= "ALERT"
ALERTTXTON.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
ALERTTXTON.alignment 		= "CenterCenter"
ALERTTXTON.formats 			= {"%s"}
ALERTTXTON.h_clip_relation  = h_clip_relations.COMPARE
ALERTTXTON.level 			= 2
ALERTTXTON.init_rot 		= {0, 0, 0}
ALERTTXTON.init_pos 		= {24, -45, 0}
ALERTTXTON.element_params = {"LUFD_STATUS_PAGE","UFD_OPACITY","CHECK_ENGINE_LIGHT"} --HOPE THIS WORKS G_OP_BACK
ALERTTXTON.controllers	= 	{{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1},{"parameter_in_range",2,0.9,1.1},}
Add(ALERTTXTON)

STATUSBOX 					    = CreateElement "ceTexPoly"
STATUSBOX.name 				    = "STATUSBOX"
STATUSBOX.material 			    = IND_BOX 
STATUSBOX.change_opacity 	= false
STATUSBOX.collimated 		= false
STATUSBOX.isvisible 			= true
STATUSBOX.init_pos 			= {1, -41.5, 0} --L-R,U-D,F-B
STATUSBOX.init_rot 			= {0, 0, 0}
STATUSBOX.element_params 		= {"MFD_OPACITY","LUFD_STATUS_PAGE"}--this may not be bneeded check when more pages done for backlight on page 7 SMS fc3 bs
STATUSBOX.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},}--MENU PAGE = 1
STATUSBOX.level 				= 2
STATUSBOX.h_clip_relation     = h_clip_relations.COMPARE
vertices(STATUSBOX, 190)
Add(STATUSBOX)

UFD_V_LINE 					    = CreateElement "ceTexPoly"
UFD_V_LINE.name 				    = "UFD_V_LINE"
UFD_V_LINE.material 			    = UFD_VERT_LINE 
UFD_V_LINE.change_opacity 	= false
UFD_V_LINE.collimated 		= false
UFD_V_LINE.isvisible 			= true
UFD_V_LINE.additive_alpha = true
UFD_V_LINE.blend_mode = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
UFD_V_LINE.init_pos 			= {0, 0, 0} --L-R,U-D,F-B
UFD_V_LINE.init_rot 			= {0, 0, 0}
UFD_V_LINE.element_params 		= {"MFD_OPACITY","LUFD_STATUS_PAGE"}--this may not be bneeded check when more pages done for backlight on page 7 SMS fc3 bs
UFD_V_LINE.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},}--MENU PAGE = 1
UFD_V_LINE.level 				= 2
UFD_V_LINE.h_clip_relation     = h_clip_relations.COMPARE
vertices(UFD_V_LINE, 65)
Add(UFD_V_LINE)

BATTSTATTXT					= CreateElement "ceStringPoly"
BATTSTATTXT.name 			= "BATTSTATTXT"
BATTSTATTXT.material 		= UFD_GRN --FONT_RPM--
BATTSTATTXT.value 			= "BATTERY"
BATTSTATTXT.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
BATTSTATTXT.alignment 		= "LeftCenter"
BATTSTATTXT.formats 			= {"%s"}
BATTSTATTXT.h_clip_relation  = h_clip_relations.COMPARE
BATTSTATTXT.level 			= 2
BATTSTATTXT.init_rot 		= {0, 0, 0}
BATTSTATTXT.init_pos 		= {-60, 30, 0}
BATTSTATTXT.element_params = {"LUFD_STATUS_PAGE","UFD_OPACITY"} 
BATTSTATTXT.controllers	= 	{{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(BATTSTATTXT)

-- MAIN POWER
MAINPWRSTATTXT = CreateElement "ceStringPoly"
MAINPWRSTATTXT.name = "MAINPWRSTATTXT"
MAINPWRSTATTXT.material = UFD_GRN
MAINPWRSTATTXT.value = "MAIN POWER"
MAINPWRSTATTXT.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
MAINPWRSTATTXT.alignment = "LeftCenter"
MAINPWRSTATTXT.formats = {"%s"}
MAINPWRSTATTXT.h_clip_relation = h_clip_relations.COMPARE
MAINPWRSTATTXT.level = 2
MAINPWRSTATTXT.init_rot = {0, 0, 0}
MAINPWRSTATTXT.init_pos = {-60, 24, 0}
MAINPWRSTATTXT.element_params = {"LUFD_STATUS_PAGE","UFD_OPACITY"}
MAINPWRSTATTXT.controllers = {{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(MAINPWRSTATTXT)

-- LEFT ENG
LENGSTATTXT = CreateElement "ceStringPoly"
LENGSTATTXT.name = "LENGSTATTXT"
LENGSTATTXT.material = UFD_GRN
LENGSTATTXT.value = "LEFT ENG"
LENGSTATTXT.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
LENGSTATTXT.alignment = "LeftCenter"
LENGSTATTXT.formats = {"%s"}
LENGSTATTXT.h_clip_relation = h_clip_relations.COMPARE
LENGSTATTXT.level = 2
LENGSTATTXT.init_rot = {0, 0, 0}
LENGSTATTXT.init_pos = {-60, 18, 0} 
LENGSTATTXT.element_params = {"LUFD_STATUS_PAGE","UFD_OPACITY"}
LENGSTATTXT.controllers = {{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(LENGSTATTXT)

-- RIGHT ENG
RENGSTATTXT = CreateElement "ceStringPoly"
RENGSTATTXT.name = "RENGSTATTXT"
RENGSTATTXT.material = UFD_GRN
RENGSTATTXT.value = "RIGHT ENG"
RENGSTATTXT.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
RENGSTATTXT.alignment = "LeftCenter"
RENGSTATTXT.formats = {"%s"}
RENGSTATTXT.h_clip_relation = h_clip_relations.COMPARE
RENGSTATTXT.level = 2
RENGSTATTXT.init_rot = {0, 0, 0}
RENGSTATTXT.init_pos = {-60, 12, 0} 
RENGSTATTXT.element_params = {"LUFD_STATUS_PAGE","UFD_OPACITY"}
RENGSTATTXT.controllers = {{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(RENGSTATTXT)

-- AN/APG-77
APG77STATTXT = CreateElement "ceStringPoly"
APG77STATTXT.name = "APG77STATTXT"
APG77STATTXT.material = UFD_GRN
APG77STATTXT.value = "AN/APG-77"
APG77STATTXT.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
APG77STATTXT.alignment = "LeftCenter"
APG77STATTXT.formats = {"%s"}
APG77STATTXT.h_clip_relation = h_clip_relations.COMPARE
APG77STATTXT.level = 2
APG77STATTXT.init_rot = {0, 0, 0}
APG77STATTXT.init_pos = {-60, 6, 0} 
APG77STATTXT.element_params = {"LUFD_STATUS_PAGE","UFD_OPACITY"}
APG77STATTXT.controllers = {{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(APG77STATTXT)


-- AN/ALR-94
RWRSTATTXT = CreateElement "ceStringPoly"
RWRSTATTXT.name = "RWRSTATTXT"
RWRSTATTXT.material = UFD_GRN
RWRSTATTXT.value = "RWR"
RWRSTATTXT.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
RWRSTATTXT.alignment = "LeftCenter"
RWRSTATTXT.formats = {"%s"}
RWRSTATTXT.h_clip_relation = h_clip_relations.COMPARE
RWRSTATTXT.level = 2
RWRSTATTXT.init_rot = {0, 0, 0}
RWRSTATTXT.init_pos = {-60, 0, 0} 
RWRSTATTXT.element_params = {"LUFD_STATUS_PAGE","UFD_OPACITY"}
RWRSTATTXT.controllers = {{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(RWRSTATTXT)


-- WPNS
WPNSSTATTXT = CreateElement "ceStringPoly"
WPNSSTATTXT.name = "WPNSSTATTXT"
WPNSSTATTXT.material = UFD_GRN
WPNSSTATTXT.value = "WEAPONS"
WPNSSTATTXT.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
WPNSSTATTXT.alignment = "LeftCenter"
WPNSSTATTXT.formats = {"%s"}
WPNSSTATTXT.h_clip_relation = h_clip_relations.COMPARE
WPNSSTATTXT.level = 2
WPNSSTATTXT.init_rot = {0, 0, 0}
WPNSSTATTXT.init_pos = {-60, -6, 0} 
WPNSSTATTXT.element_params = {"LUFD_STATUS_PAGE","UFD_OPACITY"}
WPNSSTATTXT.controllers = {{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(WPNSSTATTXT)

-- CMDS
CMDSSTATTXT = CreateElement "ceStringPoly"
CMDSSTATTXT.name = "CMDSSTATTXT"
CMDSSTATTXT.material = UFD_GRN
CMDSSTATTXT.value = "CMDS"
CMDSSTATTXT.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
CMDSSTATTXT.alignment = "LeftCenter"
CMDSSTATTXT.formats = {"%s"}
CMDSSTATTXT.h_clip_relation = h_clip_relations.COMPARE
CMDSSTATTXT.level = 2
CMDSSTATTXT.init_rot = {0, 0, 0}
CMDSSTATTXT.init_pos = {-60, -12, 0} 
CMDSSTATTXT.element_params = {"LUFD_STATUS_PAGE","UFD_OPACITY"}
CMDSSTATTXT.controllers = {{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(CMDSSTATTXT)

-- HMD
HMDSTATTXT = CreateElement "ceStringPoly"
HMDSTATTXT.name = "HMDSTATTXT"
HMDSTATTXT.material = UFD_GRN
HMDSTATTXT.value = "HMD"
HMDSTATTXT.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
HMDSTATTXT.alignment = "LeftCenter"
HMDSTATTXT.formats = {"%s"}
HMDSTATTXT.h_clip_relation = h_clip_relations.COMPARE
HMDSTATTXT.level = 2
HMDSTATTXT.init_rot = {0, 0, 0}
HMDSTATTXT.init_pos = {-60, -18, 0} 
HMDSTATTXT.element_params = {"LUFD_STATUS_PAGE","UFD_OPACITY"}
HMDSTATTXT.controllers = {{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(HMDSTATTXT)

-- NAV
NAVSTATTXT = CreateElement "ceStringPoly"
NAVSTATTXT.name = "NAVSTATTXT"
NAVSTATTXT.material = UFD_GRN
NAVSTATTXT.value = "NAV"
NAVSTATTXT.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
NAVSTATTXT.alignment = "LeftCenter"
NAVSTATTXT.formats = {"%s"}
NAVSTATTXT.h_clip_relation = h_clip_relations.COMPARE
NAVSTATTXT.level = 2
NAVSTATTXT.init_rot = {0, 0, 0}
NAVSTATTXT.init_pos = {4, 30, 0}
NAVSTATTXT.element_params = {"LUFD_STATUS_PAGE","UFD_OPACITY"}
NAVSTATTXT.controllers = {{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(NAVSTATTXT)

-- IRST
IRSTSTATTXT = CreateElement "ceStringPoly"
IRSTSTATTXT.name = "IRSTSTATTXT"
IRSTSTATTXT.material = UFD_GRN
IRSTSTATTXT.value = "IRST"
IRSTSTATTXT.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
IRSTSTATTXT.alignment = "LeftCenter"
IRSTSTATTXT.formats = {"%s"}
IRSTSTATTXT.h_clip_relation = h_clip_relations.COMPARE
IRSTSTATTXT.level = 2
IRSTSTATTXT.init_rot = {0, 0, 0}
IRSTSTATTXT.init_pos = {3.5, 24, 0} 
IRSTSTATTXT.element_params = {"LUFD_STATUS_PAGE","UFD_OPACITY"}
IRSTSTATTXT.controllers = {{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(IRSTSTATTXT)

-- GPS
GPSSTATTXT = CreateElement "ceStringPoly"
GPSSTATTXT.name = "GPSSTATTXT"
GPSSTATTXT.material = UFD_GRN
GPSSTATTXT.value = "GPS"
GPSSTATTXT.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
GPSSTATTXT.alignment = "LeftCenter"
GPSSTATTXT.formats = {"%s"}
GPSSTATTXT.h_clip_relation = h_clip_relations.COMPARE
GPSSTATTXT.level = 2
GPSSTATTXT.init_rot = {0, 0, 0}
GPSSTATTXT.init_pos = {4, 18, 0} 
GPSSTATTXT.element_params = {"LUFD_STATUS_PAGE","UFD_OPACITY"}
GPSSTATTXT.controllers = {{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(GPSSTATTXT)

-- COMM
COMMSTATTXT = CreateElement "ceStringPoly"
COMMSTATTXT.name = "COMMSTATTXT"
COMMSTATTXT.material = UFD_GRN
COMMSTATTXT.value = "COMM"
COMMSTATTXT.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
COMMSTATTXT.alignment = "LeftCenter"
COMMSTATTXT.formats = {"%s"}
COMMSTATTXT.h_clip_relation = h_clip_relations.COMPARE
COMMSTATTXT.level = 2
COMMSTATTXT.init_rot = {0, 0, 0}
COMMSTATTXT.init_pos = {4, 12, 0} 
COMMSTATTXT.element_params = {"LUFD_STATUS_PAGE","UFD_OPACITY"}
COMMSTATTXT.controllers = {{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(COMMSTATTXT)

-- FCS
FCSSTATTXT = CreateElement "ceStringPoly"
FCSSTATTXT.name = "FCSSTATTXT"
FCSSTATTXT.material = UFD_GRN
FCSSTATTXT.value = "FCS"
FCSSTATTXT.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
FCSSTATTXT.alignment = "LeftCenter"
FCSSTATTXT.formats = {"%s"}
FCSSTATTXT.h_clip_relation = h_clip_relations.COMPARE
FCSSTATTXT.level = 2
FCSSTATTXT.init_rot = {0, 0, 0}
FCSSTATTXT.init_pos = {4, 6, 0} 
FCSSTATTXT.element_params = {"LUFD_STATUS_PAGE","UFD_OPACITY"}
FCSSTATTXT.controllers = {{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(FCSSTATTXT)

-- STORES
STORESSTATTXT = CreateElement "ceStringPoly"
STORESSTATTXT.name = "STORESSTATTXT"
STORESSTATTXT.material = UFD_GRN
STORESSTATTXT.value = "STORES"
STORESSTATTXT.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
STORESSTATTXT.alignment = "LeftCenter"
STORESSTATTXT.formats = {"%s"}
STORESSTATTXT.h_clip_relation = h_clip_relations.COMPARE
STORESSTATTXT.level = 2
STORESSTATTXT.init_rot = {0, 0, 0}
STORESSTATTXT.init_pos = {4, 0, 0} 
STORESSTATTXT.element_params = {"LUFD_STATUS_PAGE","UFD_OPACITY"}
STORESSTATTXT.controllers = {{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(STORESSTATTXT)

-- DISPLAYS
DISPSTATTXT = CreateElement "ceStringPoly"
DISPSTATTXT.name = "DISPSTATTXT"
DISPSTATTXT.material = UFD_GRN
DISPSTATTXT.value = "DISPLAYS"
DISPSTATTXT.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
DISPSTATTXT.alignment = "LeftCenter"
DISPSTATTXT.formats = {"%s"}
DISPSTATTXT.h_clip_relation = h_clip_relations.COMPARE
DISPSTATTXT.level = 2
DISPSTATTXT.init_rot = {0, 0, 0}
DISPSTATTXT.init_pos = {4, -6, 0} 
DISPSTATTXT.element_params = {"LUFD_STATUS_PAGE","UFD_OPACITY"}
DISPSTATTXT.controllers = {{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(DISPSTATTXT)

-- PARK BRAKE
PARKBRAKESTATTXT = CreateElement "ceStringPoly"
PARKBRAKESTATTXT.name = "PARKBRAKESTATTXT"
PARKBRAKESTATTXT.material = UFD_GRN
PARKBRAKESTATTXT.value = "PARK BRK"
PARKBRAKESTATTXT.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
PARKBRAKESTATTXT.alignment = "LeftCenter"
PARKBRAKESTATTXT.formats = {"%s"}
PARKBRAKESTATTXT.h_clip_relation = h_clip_relations.COMPARE
PARKBRAKESTATTXT.level = 2
PARKBRAKESTATTXT.init_rot = {0, 0, 0}
PARKBRAKESTATTXT.init_pos = {4, -12, 0}
PARKBRAKESTATTXT.element_params = {"LUFD_STATUS_PAGE","UFD_OPACITY"}
PARKBRAKESTATTXT.controllers = {{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(PARKBRAKESTATTXT)

-- CANOPY
CANOPYSTATTXT = CreateElement "ceStringPoly"
CANOPYSTATTXT.name = "CANOPYSTATTXT"
CANOPYSTATTXT.material = UFD_GRN
CANOPYSTATTXT.value = "CANOPY"
CANOPYSTATTXT.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
CANOPYSTATTXT.alignment = "LeftCenter"
CANOPYSTATTXT.formats = {"%s"}
CANOPYSTATTXT.h_clip_relation = h_clip_relations.COMPARE
CANOPYSTATTXT.level = 2
CANOPYSTATTXT.init_rot = {0, 0, 0}
CANOPYSTATTXT.init_pos = {4, -18, 0} 
CANOPYSTATTXT.element_params = {"LUFD_STATUS_PAGE","UFD_OPACITY"}
CANOPYSTATTXT.controllers = {{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(CANOPYSTATTXT)

--##Values of Params

-- BATTERY STATUS
BATTSTATON = CreateElement "ceStringPoly"
BATTSTATON.name = "BATTSTATON"
BATTSTATON.material = UFD_GRN
BATTSTATON.value = "ON"
BATTSTATON.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
BATTSTATON.alignment = "RightCenter"
BATTSTATON.formats = {"%s"}
BATTSTATON.h_clip_relation = h_clip_relations.COMPARE
BATTSTATON.level = 2
BATTSTATON.init_rot = {0, 0, 0}
BATTSTATON.init_pos = {-4, 30, 0} 
BATTSTATON.element_params = {"LUFD_STATUS_PAGE", "UFD_OPACITY", "BATTERY_POWER"}
BATTSTATON.controllers = {
    {"parameter_in_range", 0, 0.9, 1.1}, 
    {"opacity_using_parameter", 1}, 
    {"parameter_in_range", 2, 0.9, 1.1}
}
Add(BATTSTATON)

BATTSTATOFF = CreateElement "ceStringPoly"
BATTSTATOFF.name = "BATTSTATOFF"
BATTSTATOFF.material = UFD_RED
BATTSTATOFF.value = "OFF"
BATTSTATOFF.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
BATTSTATOFF.alignment = "RightCenter"
BATTSTATOFF.formats = {"%s"}
BATTSTATOFF.h_clip_relation = h_clip_relations.COMPARE
BATTSTATOFF.level = 2
BATTSTATOFF.init_rot = {0, 0, 0}
BATTSTATOFF.init_pos = {-4, 30, 0} 
BATTSTATOFF.element_params = {"LUFD_STATUS_PAGE", "UFD_OPACITY", "BATTERY_POWER"}
BATTSTATOFF.controllers = {
    {"parameter_in_range", 0, 0.9, 1.1}, 
    {"opacity_using_parameter", 1}, 
    {"parameter_in_range", 2, -0.1, 0.1}
}
Add(BATTSTATOFF)

-- MAIN POWER STATUS
MAINPWRSTATON = CreateElement "ceStringPoly"
MAINPWRSTATON.name = "MAINPWRSTATON"
MAINPWRSTATON.material = UFD_GRN
MAINPWRSTATON.value = "ON"
MAINPWRSTATON.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
MAINPWRSTATON.alignment = "RightCenter"
MAINPWRSTATON.formats = {"%s"}
MAINPWRSTATON.h_clip_relation = h_clip_relations.COMPARE
MAINPWRSTATON.level = 2
MAINPWRSTATON.init_rot = {0, 0, 0}
MAINPWRSTATON.init_pos = {-4, 24, 0}
MAINPWRSTATON.element_params = {"LUFD_STATUS_PAGE", "UFD_OPACITY", "MAIN_POWER"}
MAINPWRSTATON.controllers = {
    {"parameter_in_range", 0, 0.9, 1.1}, 
    {"opacity_using_parameter", 1}, 
    {"parameter_in_range", 2, 0.9, 1.1}
}
Add(MAINPWRSTATON)

MAINPWRSTATOFF = CreateElement "ceStringPoly"
MAINPWRSTATOFF.name = "MAINPWRSTATOFF"
MAINPWRSTATOFF.material = UFD_YEL
MAINPWRSTATOFF.value = "OFF"
MAINPWRSTATOFF.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
MAINPWRSTATOFF.alignment = "RightCenter"
MAINPWRSTATOFF.formats = {"%s"}
MAINPWRSTATOFF.h_clip_relation = h_clip_relations.COMPARE
MAINPWRSTATOFF.level = 2
MAINPWRSTATOFF.init_rot = {0, 0, 0}
MAINPWRSTATOFF.init_pos = {-4, 24, 0}
MAINPWRSTATOFF.element_params = {"LUFD_STATUS_PAGE", "UFD_OPACITY", "MAIN_POWER"}
MAINPWRSTATOFF.controllers = {
    {"parameter_in_range", 0, 0.9, 1.1}, 
    {"opacity_using_parameter", 1}, 
    {"parameter_in_range", 2, -0.1, 0.1}
}
Add(MAINPWRSTATOFF)

-- LEFT ENG STATUS
LENGRUN = CreateElement "ceStringPoly"
LENGRUN.name = "LENGRUN"
LENGRUN.material = UFD_GRN
LENGRUN.value = "RUNNING"
LENGRUN.stringdefs = {0.0040, 0.0040, 0.0001, 0.001}
LENGRUN.alignment = "RightCenter"
LENGRUN.formats = {"%s"}
LENGRUN.h_clip_relation = h_clip_relations.COMPARE
LENGRUN.level = 2
LENGRUN.init_rot = {0, 0, 0}
LENGRUN.init_pos = {-4, 18, 0}
LENGRUN.element_params = {"LUFD_STATUS_PAGE", "UFD_OPACITY", "L_ENG_STATUS"}
LENGRUN.controllers = {
    {"parameter_in_range", 0, 0.9, 1.1}, 
    {"opacity_using_parameter", 1}, 
    {"parameter_in_range", 2, 0.9, 1.1}
}
Add(LENGRUN)

LENGOFF = CreateElement "ceStringPoly"
LENGOFF.name = "LENGOFF"
LENGOFF.material = UFD_RED
LENGOFF.value = "OFF"
LENGOFF.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
LENGOFF.alignment = "RightCenter"
LENGOFF.formats = {"%s"}
LENGOFF.h_clip_relation = h_clip_relations.COMPARE
LENGOFF.level = 2
LENGOFF.init_rot = {0, 0, 0}
LENGOFF.init_pos = {-4, 18, 0}
LENGOFF.element_params = {"LUFD_STATUS_PAGE", "UFD_OPACITY", "L_ENG_STATUS"}
LENGOFF.controllers = {
    {"parameter_in_range", 0, 0.9, 1.1}, 
    {"opacity_using_parameter", 1}, 
    {"parameter_in_range", 2, -0.1, 0.1}
}

Add(LENGOFF)

LENGSTART = CreateElement "ceStringPoly"
LENGSTART.name = "LENGSTART"
LENGSTART.material = UFD_YEL
LENGSTART.value = "STARTING"
LENGSTART.stringdefs = {0.0040, 0.0040, 0.0001, 0.001}
LENGSTART.alignment = "RightCenter"
LENGSTART.formats = {"%s"}
LENGSTART.h_clip_relation = h_clip_relations.COMPARE
LENGSTART.level = 2
LENGSTART.init_rot = {0, 0, 0}
LENGSTART.init_pos = {-4, 18, 0}
LENGSTART.element_params = {"LUFD_STATUS_PAGE", "UFD_OPACITY", "L_ENG_STATUS"}
LENGSTART.controllers = {
    {"parameter_in_range", 0, 0.9, 1.1}, 
    {"opacity_using_parameter", 1}, 
    {"parameter_in_range", 2, 0.2, 0.3}
}

Add(LENGSTART)

LENGSTOP = CreateElement "ceStringPoly"
LENGSTOP.name = "LENGSTART"
LENGSTOP.material = UFD_RED
LENGSTOP.value = "SHUTDOWN"
LENGSTOP.stringdefs = {0.0040, 0.0040, 0.0001, 0.001}
LENGSTOP.alignment = "RightCenter"
LENGSTOP.formats = {"%s"}
LENGSTOP.h_clip_relation = h_clip_relations.COMPARE
LENGSTOP.level = 2
LENGSTOP.init_rot = {0, 0, 0}
LENGSTOP.init_pos = {-4, 18, 0}
LENGSTOP.element_params = {"LUFD_STATUS_PAGE", "UFD_OPACITY", "L_ENG_STATUS"}
LENGSTOP.controllers = {
    {"parameter_in_range", 0, 0.9, 1.1}, 
    {"opacity_using_parameter", 1}, 
    {"parameter_in_range", 2, 0.4, 0.6}
}

Add(LENGSTOP)






-- RIGHT ENG STATUS

RENGRUN = CreateElement "ceStringPoly"
RENGRUN.name = "RENGRUN"
RENGRUN.material = UFD_GRN
RENGRUN.value = "RUNNING"
RENGRUN.stringdefs = {0.0040, 0.0040, 0.0001, 0.001}
RENGRUN.alignment = "RightCenter"
RENGRUN.formats = {"%s"}
RENGRUN.h_clip_relation = h_clip_relations.COMPARE
RENGRUN.level = 2
RENGRUN.init_rot = {0, 0, 0}
RENGRUN.init_pos = {-4, 12, 0}
RENGRUN.element_params = {"LUFD_STATUS_PAGE", "UFD_OPACITY", "R_ENG_STATUS"}
RENGRUN.controllers = {
    {"parameter_in_range", 0, 0.9, 1.1}, 
    {"opacity_using_parameter", 1}, 
    {"parameter_in_range", 2, 0.9, 1.1}
}
Add(RENGRUN)

RENGOFF = CreateElement "ceStringPoly"
RENGOFF.name = "RENGOFF"
RENGOFF.material = UFD_RED
RENGOFF.value = "OFF"
RENGOFF.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
RENGOFF.alignment = "RightCenter"
RENGOFF.formats = {"%s"}
RENGOFF.h_clip_relation = h_clip_relations.COMPARE
RENGOFF.level = 2
RENGOFF.init_rot = {0, 0, 0}
RENGOFF.init_pos = {-4, 12, 0}
RENGOFF.element_params = {"LUFD_STATUS_PAGE", "UFD_OPACITY", "R_ENG_STATUS"}
RENGOFF.controllers = {
    {"parameter_in_range", 0, 0.9, 1.1}, 
    {"opacity_using_parameter", 1}, 
    {"parameter_in_range", 2, -0.1, 0.1}
}

Add(RENGOFF)

RENGSTART = CreateElement "ceStringPoly"
RENGSTART.name = "RENGSTART"
RENGSTART.material = UFD_YEL
RENGSTART.value = "STARTING"
RENGSTART.stringdefs = {0.0040, 0.0040, 0.0001, 0.001}
RENGSTART.alignment = "RightCenter"
RENGSTART.formats = {"%s"}
RENGSTART.h_clip_relation = h_clip_relations.COMPARE
RENGSTART.level = 2
RENGSTART.init_rot = {0, 0, 0}
RENGSTART.init_pos = {-4, 12, 0}
RENGSTART.element_params = {"LUFD_STATUS_PAGE", "UFD_OPACITY", "R_ENG_STATUS"}
RENGSTART.controllers = {
    {"parameter_in_range", 0, 0.9, 1.1}, 
    {"opacity_using_parameter", 1}, 
    {"parameter_in_range", 2, 0.2, 0.3}
}

Add(RENGSTART)

RENGSTOP = CreateElement "ceStringPoly"
RENGSTOP.name = "LENGSTART"
RENGSTOP.material = UFD_RED
RENGSTOP.value = "SHUTDOWN"
RENGSTOP.stringdefs = {0.0040, 0.0040, 0.0001, 0.001}
RENGSTOP.alignment = "RightCenter"
RENGSTOP.formats = {"%s"}
RENGSTOP.h_clip_relation = h_clip_relations.COMPARE
RENGSTOP.level = 2
RENGSTOP.init_rot = {0, 0, 0}
RENGSTOP.init_pos = {-4, 12, 0}
RENGSTOP.element_params = {"LUFD_STATUS_PAGE", "UFD_OPACITY", "R_ENG_STATUS"}
RENGSTOP.controllers = {
    {"parameter_in_range", 0, 0.9, 1.1}, 
    {"opacity_using_parameter", 1}, 
    {"parameter_in_range", 2, 0.4, 0.6}
}

Add(RENGSTOP)


-- AN/APG-77 STATUS
APG77STAT = CreateElement "ceStringPoly"
APG77STAT.name = "APG77STAT"
APG77STAT.material = UFD_YEL
APG77STAT.value = "DEGR"
APG77STAT.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
APG77STAT.alignment = "RightCenter"
APG77STAT.formats = {"%s"}
APG77STAT.h_clip_relation = h_clip_relations.COMPARE
APG77STAT.level = 2
APG77STAT.init_rot = {0, 0, 0}
APG77STAT.init_pos = {-4, 6, 0} 
APG77STAT.element_params = {"LUFD_STATUS_PAGE","UFD_OPACITY"}
APG77STAT.controllers = {{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(APG77STAT)

-- AN/ALR-94 STATUS
RWRSTATOFF = CreateElement "ceStringPoly"
RWRSTATOFF.name = "RWRSTATOFF"
RWRSTATOFF.material = UFD_GRN
RWRSTATOFF.value = "OFF"
RWRSTATOFF.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
RWRSTATOFF.alignment = "RightCenter"
RWRSTATOFF.formats = {"%s"}
RWRSTATOFF.h_clip_relation = h_clip_relations.COMPARE
RWRSTATOFF.level = 2
RWRSTATOFF.init_rot = {0, 0, 0}
RWRSTATOFF.init_pos = {-4, 0, 0} 
RWRSTATOFF.element_params = {"LUFD_STATUS_PAGE","UFD_OPACITY","RWR_POWER"}
RWRSTATOFF.controllers = {{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1},{"parameter_in_range", 2, -0.1, 0.1}}
Add(RWRSTATOFF)

RWRSTATON = CreateElement "ceStringPoly"
RWRSTATON.name = "RWRSTATON"
RWRSTATON.material = UFD_GRN
RWRSTATON.value = "ON"
RWRSTATON.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
RWRSTATON.alignment = "RightCenter"
RWRSTATON.formats = {"%s"}
RWRSTATON.h_clip_relation = h_clip_relations.COMPARE
RWRSTATON.level = 2
RWRSTATON.init_rot = {0, 0, 0}
RWRSTATON.init_pos = {-4, 0, 0} 
RWRSTATON.element_params = {"LUFD_STATUS_PAGE","UFD_OPACITY","RWR_POWER"}
RWRSTATON.controllers = {{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1},{"parameter_in_range", 2, 0.9, 1.1}}
Add(RWRSTATON)

-- WEAPONS STATUS
WPNSSTATON = CreateElement "ceStringPoly"
WPNSSTATON.name = "WPNSSTATON"
WPNSSTATON.material = UFD_GRN
WPNSSTATON.value = "ON"
WPNSSTATON.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
WPNSSTATON.alignment = "RightCenter"
WPNSSTATON.formats = {"%s"}
WPNSSTATON.h_clip_relation = h_clip_relations.COMPARE
WPNSSTATON.level = 2
WPNSSTATON.init_rot = {0, 0, 0}
WPNSSTATON.init_pos = {-4, -6, 0} 
WPNSSTATON.element_params = {"LUFD_STATUS_PAGE","UFD_OPACITY","MASTER_ARM"}
WPNSSTATON.controllers = {{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1},{"parameter_in_range",2,0.9,1.1}}
Add(WPNSSTATON)

WPNSSTATOFF = CreateElement "ceStringPoly"
WPNSSTATOFF.name = "WPNSSTATOFF"
WPNSSTATOFF.material = UFD_GRN
WPNSSTATOFF.value = "OFF"
WPNSSTATOFF.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
WPNSSTATOFF.alignment = "RightCenter"
WPNSSTATOFF.formats = {"%s"}
WPNSSTATOFF.h_clip_relation = h_clip_relations.COMPARE
WPNSSTATOFF.level = 2
WPNSSTATOFF.init_rot = {0, 0, 0}
WPNSSTATOFF.init_pos = {-4, -6, 0} 
WPNSSTATOFF.element_params = {"LUFD_STATUS_PAGE","UFD_OPACITY","MASTER_ARM"}
WPNSSTATOFF.controllers = {{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1},{"parameter_in_range",2,-0.1,0.1}}
Add(WPNSSTATOFF)

-- CMDS STATUS
CMDSSTATON = CreateElement "ceStringPoly"
CMDSSTATON.name = "CMDSSTATON"
CMDSSTATON.material = UFD_GRN
CMDSSTATON.value = "ON"
CMDSSTATON.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
CMDSSTATON.alignment = "RightCenter"
CMDSSTATON.formats = {"%s"}
CMDSSTATON.h_clip_relation = h_clip_relations.COMPARE
CMDSSTATON.level = 2
CMDSSTATON.init_rot = {0, 0, 0}
CMDSSTATON.init_pos = {-4, -12, 0} 
CMDSSTATON.element_params = {"LUFD_STATUS_PAGE", "UFD_OPACITY", "ECMS_POWER"}
CMDSSTATON.controllers = {
    {"parameter_in_range", 0, 0.9, 1.1}, 
    {"opacity_using_parameter", 1}, 
    {"parameter_in_range", 2, 0.9, 1.1}
}
Add(CMDSSTATON)

CMDSSTATOFF = CreateElement "ceStringPoly"
CMDSSTATOFF.name = "CMDSSTATOFF"
CMDSSTATOFF.material = UFD_GRN
CMDSSTATOFF.value = "OFF"
CMDSSTATOFF.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
CMDSSTATOFF.alignment = "RightCenter"
CMDSSTATOFF.formats = {"%s"}
CMDSSTATOFF.h_clip_relation = h_clip_relations.COMPARE
CMDSSTATOFF.level = 2
CMDSSTATOFF.init_rot = {0, 0, 0}
CMDSSTATOFF.init_pos = {-4, -12, 0} 
CMDSSTATOFF.element_params = {"LUFD_STATUS_PAGE", "UFD_OPACITY", "ECMS_POWER"}
CMDSSTATOFF.controllers = {
    {"parameter_in_range", 0, 0.9, 1.1}, 
    {"opacity_using_parameter", 1}, 
    {"parameter_in_range", 2, -0.1, 0.1}
}
Add(CMDSSTATOFF)


-- HMD STATUS
HMDSTATON = CreateElement "ceStringPoly"
HMDSTATON.name = "HMDSTATON"
HMDSTATON.material = UFD_GRN
HMDSTATON.value = "ON"
HMDSTATON.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
HMDSTATON.alignment = "RightCenter"
HMDSTATON.formats = {"%s"}
HMDSTATON.h_clip_relation = h_clip_relations.COMPARE
HMDSTATON.level = 2
HMDSTATON.init_rot = {0, 0, 0}
HMDSTATON.init_pos = {-4, -18, 0}
HMDSTATON.element_params = {"LUFD_STATUS_PAGE", "UFD_OPACITY", "HMD_POWER"}
HMDSTATON.controllers = {
    {"parameter_in_range", 0, 0.9, 1.1}, 
    {"opacity_using_parameter", 1}, 
    {"parameter_in_range", 2, 0.9, 1.1}
}
Add(HMDSTATON)

HMDSTATOFF = CreateElement "ceStringPoly"
HMDSTATOFF.name = "HMDSTATOFF"
HMDSTATOFF.material = UFD_GRN
HMDSTATOFF.value = "OFF"
HMDSTATOFF.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
HMDSTATOFF.alignment = "RightCenter"
HMDSTATOFF.formats = {"%s"}
HMDSTATOFF.h_clip_relation = h_clip_relations.COMPARE
HMDSTATOFF.level = 2
HMDSTATOFF.init_rot = {0, 0, 0}
HMDSTATOFF.init_pos = {-4, -18, 0}
HMDSTATOFF.element_params = {"LUFD_STATUS_PAGE", "UFD_OPACITY", "HMD_POWER"}
HMDSTATOFF.controllers = {
    {"parameter_in_range", 0, 0.9, 1.1}, 
    {"opacity_using_parameter", 1}, 
    {"parameter_in_range", 2, -0.1, 0.1}
}
Add(HMDSTATOFF)


-- NAV STATUS
NAVSTAT = CreateElement "ceStringPoly"
NAVSTAT.name = "NAVSTAT"
NAVSTAT.material = UFD_GRN
NAVSTAT.value = "ON"
NAVSTAT.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
NAVSTAT.alignment = "RightCenter"
NAVSTAT.formats = {"%s"}
NAVSTAT.h_clip_relation = h_clip_relations.COMPARE
NAVSTAT.level = 2
NAVSTAT.init_rot = {0, 0, 0}
NAVSTAT.init_pos = {54, 30, 0} 
NAVSTAT.element_params = {"LUFD_STATUS_PAGE","UFD_OPACITY"}
NAVSTAT.controllers = {{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(NAVSTAT)

-- IRST STATUS
IRSTSTAT = CreateElement "ceStringPoly"
IRSTSTAT.name = "IRSTSTAT"
IRSTSTAT.material = UFD_GRN
IRSTSTAT.value = "SOON"
IRSTSTAT.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
IRSTSTAT.alignment = "RightCenter"
IRSTSTAT.formats = {"%s"}
IRSTSTAT.h_clip_relation = h_clip_relations.COMPARE
IRSTSTAT.level = 2
IRSTSTAT.init_rot = {0, 0, 0}
IRSTSTAT.init_pos = {54, 24, 0} 
IRSTSTAT.element_params = {"LUFD_STATUS_PAGE","UFD_OPACITY"}
IRSTSTAT.controllers = {{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(IRSTSTAT)

-- GPS STATUS
GPSSTATON = CreateElement "ceStringPoly"
GPSSTATON.name = "GPSSTATON"
GPSSTATON.material = UFD_GRN
GPSSTATON.value = "ON"
GPSSTATON.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
GPSSTATON.alignment = "RightCenter"
GPSSTATON.formats = {"%s"}
GPSSTATON.h_clip_relation = h_clip_relations.COMPARE
GPSSTATON.level = 2
GPSSTATON.init_rot = {0, 0, 0}
GPSSTATON.init_pos = {54, 18, 0}
GPSSTATON.element_params = {"LUFD_STATUS_PAGE","UFD_OPACITY","GPS_ENABLED"}
GPSSTATON.controllers = {{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1},{"parameter_in_range",2,0.9,1.1},}
Add(GPSSTATON)

GPSSTATOFF = CreateElement "ceStringPoly"
GPSSTATOFF.name = "GPSSTATOFF"
GPSSTATOFF.material = UFD_YEL
GPSSTATOFF.value = "OFF"
GPSSTATOFF.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
GPSSTATOFF.alignment = "RightCenter"
GPSSTATOFF.formats = {"%s"}
GPSSTATOFF.h_clip_relation = h_clip_relations.COMPARE
GPSSTATOFF.level = 2
GPSSTATOFF.init_rot = {0, 0, 0}
GPSSTATOFF.init_pos = {54, 18, 0}
GPSSTATOFF.element_params = {"LUFD_STATUS_PAGE","UFD_OPACITY","GPS_ENABLED"}
GPSSTATOFF.controllers = {{"parameter_in_range",0,0.9,1.1},{"opacity_using_parameter",1},{"parameter_in_range",2,-0.1,0.1},}
Add(GPSSTATOFF)

-- COMM STATUS
COMMSTAT = CreateElement "ceStringPoly"
COMMSTAT.name = "COMMSTAT"
COMMSTAT.material = UFD_GRN
COMMSTAT.value = "ON"
COMMSTAT.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
COMMSTAT.alignment = "RightCenter"
COMMSTAT.formats = {"%s"}
COMMSTAT.h_clip_relation = h_clip_relations.COMPARE
COMMSTAT.level = 2
COMMSTAT.init_rot = {0, 0, 0}
COMMSTAT.init_pos = {54, 12, 0} 
COMMSTAT.element_params = {"LUFD_STATUS_PAGE","UFD_OPACITY"}
COMMSTAT.controllers = {{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(COMMSTAT)

-- FCS STATUS
FCSSTAT = CreateElement "ceStringPoly"
FCSSTAT.name = "FCSSTAT"
FCSSTAT.material = UFD_GRN
FCSSTAT.value = "ON"
FCSSTAT.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
FCSSTAT.alignment = "RightCenter"
FCSSTAT.formats = {"%s"}
FCSSTAT.h_clip_relation = h_clip_relations.COMPARE
FCSSTAT.level = 2
FCSSTAT.init_rot = {0, 0, 0}
FCSSTAT.init_pos = {54, 6, 0} 
FCSSTAT.element_params = {"LUFD_STATUS_PAGE","UFD_OPACITY"}
FCSSTAT.controllers = {{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(FCSSTAT)

-- STORES STATUS
STORESSTAT = CreateElement "ceStringPoly"
STORESSTAT.name = "STORESSTAT"
STORESSTAT.material = UFD_GRN
STORESSTAT.value = "ON"
STORESSTAT.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
STORESSTAT.alignment = "RightCenter"
STORESSTAT.formats = {"%s"}
STORESSTAT.h_clip_relation = h_clip_relations.COMPARE
STORESSTAT.level = 2
STORESSTAT.init_rot = {0, 0, 0}
STORESSTAT.init_pos = {54, 0, 0} 
STORESSTAT.element_params = {"LUFD_STATUS_PAGE","UFD_OPACITY"}
STORESSTAT.controllers = {{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(STORESSTAT)

-- DISPLAYS STATUS
DISPSTATON = CreateElement "ceStringPoly"
DISPSTATON.name = "DISPSTATON"
DISPSTATON.material = UFD_GRN
DISPSTATON.value = "ON"
DISPSTATON.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
DISPSTATON.alignment = "RightCenter"
DISPSTATON.formats = {"%s"}
DISPSTATON.h_clip_relation = h_clip_relations.COMPARE
DISPSTATON.level = 2
DISPSTATON.init_rot = {0, 0, 0}
DISPSTATON.init_pos = {54, -6, 0}
DISPSTATON.element_params = {"LUFD_STATUS_PAGE","UFD_OPACITY","MAIN_POWER"}
DISPSTATON.controllers = {{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1},{"parameter_in_range",2,0.9,1.1}}
Add(DISPSTATON)

DISPSTATOFF = CreateElement "ceStringPoly"
DISPSTATOFF.name = "DISPSTATOFF"
DISPSTATOFF.material = UFD_YEL
DISPSTATOFF.value = "OFF"
DISPSTATOFF.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
DISPSTATOFF.alignment = "RightCenter"
DISPSTATOFF.formats = {"%s"}
DISPSTATOFF.h_clip_relation = h_clip_relations.COMPARE
DISPSTATOFF.level = 2
DISPSTATOFF.init_rot = {0, 0, 0}
DISPSTATOFF.init_pos = {54, -6, 0}
DISPSTATOFF.element_params = {"LUFD_STATUS_PAGE","UFD_OPACITY","MAIN_POWER"}
DISPSTATOFF.controllers = {{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1},{"parameter_in_range",2,-0.1,0.1}}
Add(DISPSTATOFF)

-- PARK BRAKE STATUS
PARKBRAKESTATON = CreateElement "ceStringPoly"
PARKBRAKESTATON.name = "PARKBRAKESTATON"
PARKBRAKESTATON.material = UFD_YEL
PARKBRAKESTATON.value = "ON"
PARKBRAKESTATON.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
PARKBRAKESTATON.alignment = "RightCenter"
PARKBRAKESTATON.formats = {"%s"}
PARKBRAKESTATON.h_clip_relation = h_clip_relations.COMPARE
PARKBRAKESTATON.level = 2
PARKBRAKESTATON.init_rot = {0, 0, 0}
PARKBRAKESTATON.init_pos = {54, -12, 0}
PARKBRAKESTATON.element_params = {"LUFD_STATUS_PAGE", "UFD_OPACITY", "PARK"}
PARKBRAKESTATON.controllers = {
    {"parameter_in_range", 0, 0.9, 1.1}, 
    {"opacity_using_parameter", 1}, 
    {"parameter_in_range", 2, 0.9, 1.1}
}

Add(PARKBRAKESTATON)

-- PARK BRAKE STATUS
PARKBRAKESTATOFF = CreateElement "ceStringPoly"
PARKBRAKESTATOFF.name = "PARKBRAKESTATOFF"
PARKBRAKESTATOFF.material = UFD_GRN
PARKBRAKESTATOFF.value = "OFF"
PARKBRAKESTATOFF.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
PARKBRAKESTATOFF.alignment = "RightCenter"
PARKBRAKESTATOFF.formats = {"%s"}
PARKBRAKESTATOFF.h_clip_relation = h_clip_relations.COMPARE
PARKBRAKESTATOFF.level = 2
PARKBRAKESTATOFF.init_rot = {0, 0, 0}
PARKBRAKESTATOFF.init_pos = {54, -12, 0}
PARKBRAKESTATOFF.element_params = {"LUFD_STATUS_PAGE", "UFD_OPACITY", "PARK"}
PARKBRAKESTATOFF.controllers = {
    {"parameter_in_range", 0, 0.9, 1.1}, 
    {"opacity_using_parameter", 1}, 
    {"parameter_in_range", 2, -0.1, 0.1}
}

Add(PARKBRAKESTATOFF)

-- CANOPY STATUS
CANOPYSTATOPEN = CreateElement "ceStringPoly"
CANOPYSTATOPEN.name = "CANOPYSTATOPEN"
CANOPYSTATOPEN.material = UFD_YEL
CANOPYSTATOPEN.value = "OPEN"
CANOPYSTATOPEN.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
CANOPYSTATOPEN.alignment = "RightCenter"
CANOPYSTATOPEN.formats = {"%s"}
CANOPYSTATOPEN.h_clip_relation = h_clip_relations.COMPARE
CANOPYSTATOPEN.level = 2
CANOPYSTATOPEN.init_rot = {0, 0, 0}
CANOPYSTATOPEN.init_pos = {54, -18, 0}
CANOPYSTATOPEN.element_params = {"LUFD_STATUS_PAGE", "UFD_OPACITY", "CANOPY_STATE"}
CANOPYSTATOPEN.controllers = {
    {"parameter_in_range", 0, 0.9, 1.1}, 
    {"opacity_using_parameter", 1}, 
    {"parameter_in_range", 2, 0.101,0.949}
}

Add(CANOPYSTATOPEN)

CANOPYSTATCLOSED = CreateElement "ceStringPoly"
CANOPYSTATCLOSED.name = "CANOPYSTATCLOSED"
CANOPYSTATCLOSED.material = UFD_GRN
CANOPYSTATCLOSED.value = "CLOSED"
CANOPYSTATCLOSED.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
CANOPYSTATCLOSED.alignment = "RightCenter"
CANOPYSTATCLOSED.formats = {"%s"}
CANOPYSTATCLOSED.h_clip_relation = h_clip_relations.COMPARE
CANOPYSTATCLOSED.level = 2
CANOPYSTATCLOSED.init_rot = {0, 0, 0}
CANOPYSTATCLOSED.init_pos = {54, -18, 0}
CANOPYSTATCLOSED.element_params = {"LUFD_STATUS_PAGE", "UFD_OPACITY", "CANOPY_STATE"}
CANOPYSTATCLOSED.controllers = {
    {"parameter_in_range", 0, 0.9, 1.1}, 
    {"opacity_using_parameter", 1}, 
    {"parameter_in_range", 2, -0.1,0.1}
}

Add(CANOPYSTATCLOSED)

CANOPYSTATGONE = CreateElement "ceStringPoly"
CANOPYSTATGONE.name = "PARKBRAKESTATOFF"
CANOPYSTATGONE.material = UFD_RED
CANOPYSTATGONE.value = "GONE"
CANOPYSTATGONE.stringdefs = {0.0040, 0.0040, 0.0004, 0.001}
CANOPYSTATGONE.alignment = "RightCenter"
CANOPYSTATGONE.formats = {"%s"}
CANOPYSTATGONE.h_clip_relation = h_clip_relations.COMPARE
CANOPYSTATGONE.level = 2
CANOPYSTATGONE.init_rot = {0, 0, 0}
CANOPYSTATGONE.init_pos = {54, -18, 0}
CANOPYSTATGONE.element_params = {"LUFD_STATUS_PAGE", "UFD_OPACITY", "CANOPY_STATE"}
CANOPYSTATGONE.controllers = {
    {"parameter_in_range", 0, 0.9, 1.1}, 
    {"opacity_using_parameter", 1}, 
    {"parameter_in_range", 2, 0.95, 1.1}
}

Add(CANOPYSTATGONE)