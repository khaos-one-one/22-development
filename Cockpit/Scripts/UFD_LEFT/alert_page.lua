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
local IND_BOX	    	= MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/ind_box.dds", RedColor)

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
BGROUND.element_params 		= {"UFD_OPACITY","LUFD_ALERT_PAGE" } --HOPE THIS WORKS G_OP_BACK
BGROUND.controllers			= {{"opacity_using_parameter",0}, {"parameter_in_range", 1}}
BGROUND.level 				= 2
BGROUND.h_clip_relation     = h_clip_relations.COMPARE
vertices(BGROUND,200)

--Add(BGROUND)
----------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------APU-READY
COMMSTXT					= CreateElement "ceStringPoly"
COMMSTXT.name 			= "COMMSTXT"
COMMSTXT.material 		= UFD_GRN --FONT_RPM--
COMMSTXT.value 			= "COMMS MENU"
COMMSTXT.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
COMMSTXT.alignment 		= "CenterCenter"
COMMSTXT.formats 			= {"%s"}
COMMSTXT.h_clip_relation  = h_clip_relations.COMPARE
COMMSTXT.level 			= 2
COMMSTXT.init_rot 		= {0, 0, 0}
COMMSTXT.init_pos 		= {0, 46, 0}
COMMSTXT.element_params = {"LUFD_ALERT_PAGE","UFD_OPACITY"} --HOPE THIS WORKS G_OP_BACK
COMMSTXT.controllers	= 	{{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(COMMSTXT)

STATUSTXT 					= CreateElement "ceStringPoly"
STATUSTXT.name 			= "STATUSTXT"
STATUSTXT.material 		= UFD_FONT --FONT_RPM--
STATUSTXT.value 			= "STATUS"
STATUSTXT.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
STATUSTXT.alignment 		= "CenterCenter"
STATUSTXT.formats 			= {"%s"}
STATUSTXT.h_clip_relation  = h_clip_relations.COMPARE
STATUSTXT.level 			= 2
STATUSTXT.init_rot 		= {0, 0, 0}
STATUSTXT.init_pos 		= {0, -45, 0}
STATUSTXT.element_params = {"LUFD_ALERT_PAGE","UFD_OPACITY"} --HOPE THIS WORKS G_OP_BACK
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
NAVTXT.element_params = {"LUFD_ALERT_PAGE","UFD_OPACITY"} --HOPE THIS WORKS G_OP_BACK
NAVTXT.controllers	= 	{{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(NAVTXT)

ALERTTXT 					= CreateElement "ceStringPoly"
ALERTTXT.name 			= "ALERTTXT"
ALERTTXT.material 		= UFD_RED --FONT_RPM--
ALERTTXT.value 			= "ALERT"
ALERTTXT.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
ALERTTXT.alignment 		= "CenterCenter"
ALERTTXT.formats 			= {"%s"}
ALERTTXT.h_clip_relation  = h_clip_relations.COMPARE
ALERTTXT.level 			= 2
ALERTTXT.init_rot 		= {0, 0, 0}
ALERTTXT.init_pos 		= {24, -45, 0}
ALERTTXT.element_params = {"LUFD_ALERT_PAGE","UFD_OPACITY"} --HOPE THIS WORKS G_OP_BACK
ALERTTXT.controllers	= 	{{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(ALERTTXT)

ALERTBOX 					    = CreateElement "ceTexPoly"
ALERTBOX.name 				    = "ALERTBOX"
ALERTBOX.material 			    = IND_BOX 
ALERTBOX.change_opacity 	= false
ALERTBOX.collimated 		= false
ALERTBOX.isvisible 			= true
ALERTBOX.init_pos 			= {25, -41.5, 0} --L-R,U-D,F-B
ALERTBOX.init_rot 			= {0, 0, 0}
ALERTBOX.element_params 		= {"MFD_OPACITY","LUFD_ALERT_PAGE"}--this may not be bneeded check when more pages done for backlight on page 7 SMS fc3 bs
ALERTBOX.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},}--MENU PAGE = 1
ALERTBOX.level 				= 2
ALERTBOX.h_clip_relation     = h_clip_relations.COMPARE
vertices(ALERTBOX, 190)
Add(ALERTBOX)


APURUN 					= CreateElement "ceStringPoly"
APURUN.name 			= "lgen"
APURUN.material 		= UFD_YEL --FONT_RPM--
APURUN.value 			= "APU SPOOL"
APURUN.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
APURUN.alignment 		= "CenterCenter"
APURUN.formats 			= {"%s"}
APURUN.h_clip_relation  = h_clip_relations.COMPARE
APURUN.level 			= 2
APURUN.init_rot 		= {0, 0, 0}
APURUN.init_pos 		= {0, 30, 0}
APURUN.element_params = {"LUFD_ALERT_PAGE","APU_SPOOL","UFD_OPACITY"} --HOPE THIS WORKS G_OP_BACK
APURUN.controllers	= 	{{"parameter_in_range",0,0.9,1.1}, {"parameter_in_range",1,0.1,1.1}, {"opacity_using_parameter",2}}
 Add(APURUN)
-----------------------------------------------------
------------------------------------------------------------------------------------------------------------------------APU-READY
APUREADY 					= CreateElement "ceStringPoly"
APUREADY.name 			= "lgen"
APUREADY.material 		= UFD_GRN --FONT_RPM--
APUREADY.value 			= "APU READY"
APUREADY.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
APUREADY.alignment 		= "CenterCenter"
APUREADY.formats 			= {"%s"}
APUREADY.h_clip_relation  = h_clip_relations.COMPARE
APUREADY.level 			= 2
APUREADY.init_rot 		= {0, 0, 0}
APUREADY.init_pos 		= {0, 30, 0}
APUREADY.element_params = {"LUFD_ALERT_PAGE","APU_READY","UFD_OPACITY"} --HOPE THIS WORKS G_OP_BACK
APUREADY.controllers	= 	{{"parameter_in_range",0,0.9,1.1}, {"parameter_in_range",1,0.1,1.1}, {"opacity_using_parameter",2}}
 Add(APUREADY)
-----------------------------------------------------
Lgen 					= CreateElement "ceStringPoly"
Lgen.name 			= "lgen"
Lgen.material 		= UFD_RED --FONT_RPM--
Lgen.value 			= "L GEN OUT"
Lgen.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
Lgen.alignment 		= "CenterCenter"
Lgen.formats 			= {"%s"}
Lgen.h_clip_relation  = h_clip_relations.COMPARE
Lgen.level 			= 2
Lgen.init_rot 		= {0, 0, 0}
Lgen.init_pos 		= {0, 24, 0}
Lgen.element_params 	= {"LUFD_ALERT_PAGE","L_GEN_OUT","UFD_OPACITY"}
Lgen.controllers		= 	{{"parameter_in_range",0,0.9,1.1}, {"parameter_in_range",1,0.1,1.1}, {"opacity_using_parameter",2}}
Add(Lgen)
------------------------------------------------------
Rgen 					= CreateElement "ceStringPoly"
Rgen.name 			= "rgen"
Rgen.material 		= UFD_RED --FONT_RPM--
Rgen.value 			= "R GEN OUT"
Rgen.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
Rgen.alignment 		= "CenterCenter"
Rgen.formats 			= {"%s"}
Rgen.h_clip_relation  = h_clip_relations.COMPARE
Rgen.level 			= 2
Rgen.init_rot 		= {0, 0, 0}
Rgen.init_pos 		= {0, 18, 0}
Rgen.element_params 	= {"LUFD_ALERT_PAGE","R_GEN_OUT","UFD_OPACITY"}
Rgen.controllers		= 	{{"parameter_in_range",0,0.9,1.1}, {"parameter_in_range",1,0.1,1.1}, {"opacity_using_parameter",2}}
Add(Rgen)
------------------------------------------------------
hyd 					= CreateElement "ceStringPoly"
hyd.name 			= "hyd"
hyd.material 		= UFD_RED --FONT_RPM--
hyd.value 			= "HYDRAULIC"
hyd.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
hyd.alignment 		= "CenterCenter"
hyd.formats 			= {"%s"}
hyd.h_clip_relation  = h_clip_relations.COMPARE
hyd.level 			= 2
hyd.init_rot 		= {0, 0, 0}
hyd.init_pos 		= {0, 12, 0}
hyd.element_params 	= {"LUFD_ALERT_PAGE","HYD_LIGHT","UFD_OPACITY"}
hyd.controllers		= 	{{"parameter_in_range",0,0.9,1.1}, {"parameter_in_range",1,0.1,1.1}, {"opacity_using_parameter",2}}
Add(hyd)
------------------------------------------------------
oilpress 					= CreateElement "ceStringPoly"
oilpress.name 			= "oil"
oilpress.material 		= UFD_RED --FONT_RPM--
oilpress.value 			= "OIL PRESS"
oilpress.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
oilpress.alignment 		= "CenterCenter"
oilpress.formats 			= {"%s"}
oilpress.h_clip_relation  = h_clip_relations.COMPARE
oilpress.level 				= 2
oilpress.init_rot 			= {0, 0, 0}
oilpress.init_pos 			= {0, 6, 0}
oilpress.element_params 	= {"LUFD_ALERT_PAGE","OIL_LIGHT","UFD_OPACITY"}
oilpress.controllers		= 	{{"parameter_in_range",0,0.9,1.1}, {"parameter_in_range",1,0.1,1.1}, {"opacity_using_parameter",2}}
Add(oilpress)
------------------------------------------------------
canopy 					= CreateElement "ceStringPoly"
canopy.name 			= "canopy"
canopy.material 		= UFD_YEL --FONT_RPM--
canopy.value 			= "CANOPY UNLOCK"
canopy.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
canopy.alignment 		= "CenterCenter"
canopy.formats 			= {"%s"}
canopy.h_clip_relation  = h_clip_relations.COMPARE
canopy.level 			= 2
canopy.init_rot 		= {0, 0, 0}
canopy.init_pos 		= {0, 0, 0}
canopy.element_params 	= {"LUFD_ALERT_PAGE","CANOPY_LIGHT","UFD_OPACITY"} --get_param_handle
canopy.controllers		= 	{{"parameter_in_range",0,0.9,1.1}, {"parameter_in_range",1,0.1,1.1}, {"opacity_using_parameter",2}}
Add(canopy)
------------------------------------------------------------------------------------------------------------------------Master Caution Warning Light
master_caution 					= CreateElement "ceStringPoly"
master_caution.name 			= "master_caution"
master_caution.material 		= UFD_YEL --FONT_RPM--
master_caution.value 			= "MASTER CAUTION"
master_caution.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
master_caution.alignment 		= "CenterCenter"
master_caution.formats 			= {"%s"}
master_caution.h_clip_relation  = h_clip_relations.COMPARE
master_caution.level 			= 2
master_caution.init_pos 		= {0, -6, 0}
master_caution.init_rot 		= {0, 0, 0}
master_caution.element_params 	= {"LUFD_ALERT_PAGE","CAUTION_LIGHT","UFD_OPACITY"} --get_param_handle
master_caution.controllers		= 	{{"parameter_in_range",0,0.9,1.1}, {"parameter_in_range",1,0.1,1.1}, {"opacity_using_parameter",2}}
Add(master_caution)
--Bingo
BingoFuel 					= CreateElement "ceStringPoly"
BingoFuel.name 				= "bingo"
BingoFuel.material 			= UFD_YEL --FONT_RPM--
BingoFuel.value 			= "BINGO FUEL"
BingoFuel.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
BingoFuel.alignment 		= "CenterCenter"
BingoFuel.formats 			= {"%s"}
BingoFuel.h_clip_relation  = h_clip_relations.COMPARE
BingoFuel.level 			= 2
BingoFuel.init_rot 		= {0, 0, 0}
BingoFuel.init_pos 		= {0, -12, 0}
BingoFuel.element_params 	= {"LUFD_ALERT_PAGE","BINGO_LIGHT","UFD_OPACITY"} --get_param_handle
BingoFuel.controllers		= 	{{"parameter_in_range",0,0.9,1.1}, {"parameter_in_range",1,0.1,1.1}, {"opacity_using_parameter",2}}
Add(BingoFuel)




-------------------------------------------------------------
GPOWER 					= CreateElement "ceStringPoly"
GPOWER.name 				= "chaff"
GPOWER.material 			= UFD_GRN --FONT_RPM--
GPOWER.value 			= "GROUND POWER"
GPOWER.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
GPOWER.alignment 		= "CenterCenter"
GPOWER.formats 			= {"%s"}
GPOWER.h_clip_relation  = h_clip_relations.COMPARE
GPOWER.level 			= 2
GPOWER.init_rot 		= {0, 0, 0}
GPOWER.init_pos 		= {0, -30, 0}
GPOWER.element_params 	= {"LUFD_ALERT_PAGE","GROUND_POWER","UFD_OPACITY"} --get_param_handle
GPOWER.controllers		= 	{	{"parameter_in_range",0,0.9,1.1},
								{"parameter_in_range",1,0.9,1.1}, 
								{"opacity_using_parameter",2}
							}
Add(GPOWER)



