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
local IND_BOX	    = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/ind_box.dds", WhiteColor)

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
--BGROUND.element_params 		= {"UFD_OPACITY", "LUFD_BASE_PAGE"} --HOPE THIS WORKS G_OP_BACK
BGROUND.element_params 		= {"UFD_OPACITY", } --HOPE THIS WORKS G_OP_BACK
BGROUND.controllers			= {{"opacity_using_parameter",0}}
BGROUND.level 				= 2
BGROUND.h_clip_relation     = h_clip_relations.COMPARE
vertices(BGROUND,200)

Add(BGROUND)


--Flaps
FlapsM 					= CreateElement "ceStringPoly"
FlapsM.name 				= "flap"
FlapsM.material 			= UFD_YEL --FONT_RPM--
FlapsM.value 			= "FLAPS"
FlapsM.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
FlapsM.alignment 		= "CenterCenter"
FlapsM.formats 			= {"%s"}
FlapsM.h_clip_relation  = h_clip_relations.COMPARE
FlapsM.level 			= 2
FlapsM.init_rot 		= {0, 0, 0}
FlapsM.init_pos 		= {0, -12, 0}
FlapsM.element_params 	= {"LUFD_BASE_PAGE","FLAPS_MOVE","UFD_OPACITY"} --get_param_handle
FlapsM.controllers	= 	{{"parameter_in_range",0,0.9,1.1}, {"parameter_in_range",1,0.1,1.1}, {"opacity_using_parameter",2}}
Add(FlapsM)
--Flaps
Flaps 					= CreateElement "ceStringPoly"
Flaps.name 				= "flap"
Flaps.material 			= UFD_TEAL --FONT_RPM--
Flaps.value 			= "FLAPS"
Flaps.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
Flaps.alignment 		= "CenterCenter"
Flaps.formats 			= {"%s"}
Flaps.h_clip_relation  = h_clip_relations.COMPARE
Flaps.level 			= 2
Flaps.init_rot 		= {0, 0, 0}
Flaps.init_pos 		= {0, -12, 0}
Flaps.element_params 	= {"LUFD_BASE_PAGE","FLAPS_DOWN","UFD_OPACITY"} --get_param_handle
Flaps.controllers		= 	{{"parameter_in_range",0,0.9,1.1}, {"parameter_in_range",1,0.1,1.1}, {"opacity_using_parameter",2}}
Add(Flaps)
--Speed Brake	
SpdBrake 					= CreateElement "ceStringPoly"
SpdBrake.name 				= "spd"
SpdBrake.material 			= UFD_TEAL --FONT_RPM--
SpdBrake.value 			= "SPD BRK OUT"
SpdBrake.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
SpdBrake.alignment 		= "CenterCenter"
SpdBrake.formats 			= {"%s"}
SpdBrake.h_clip_relation  = h_clip_relations.COMPARE
SpdBrake.level 			= 2
SpdBrake.init_rot 		= {0, 0, 0}
SpdBrake.init_pos 		= {0, -18, 0}
SpdBrake.element_params 	= {"LUFD_BASE_PAGE","SPD_BRK_LIGHT","UFD_OPACITY"} --get_param_handle
SpdBrake.controllers		= 	{{"parameter_in_range",0,0.9,1.1}, {"parameter_in_range",1,0.1,1.1}, {"opacity_using_parameter",2}}
Add(SpdBrake)
--AAR	
AARReady 					= CreateElement "ceStringPoly"
AARReady.name 				= "aar"
AARReady.material 			= UFD_TEAL --FONT_RPM--
AARReady.value 			= "AAR READY"
AARReady.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
AARReady.alignment 		= "CenterCenter"
AARReady.formats 			= {"%s"}
AARReady.h_clip_relation  = h_clip_relations.COMPARE
AARReady.level 			= 2
AARReady.init_rot 		= {0, 0, 0}
AARReady.init_pos 		= {0, -24, 0}
AARReady.element_params 	= {"LUFD_BASE_PAGE","AAR_LIGHT","UFD_OPACITY"} --get_param_handle
AARReady.controllers		= 	{{"parameter_in_range",0,0.9,1.1}, {"parameter_in_range",1,0.1,1.1}, {"opacity_using_parameter",2}}
Add(AARReady)
------------
--CHAFF
CHAFF 					= CreateElement "ceStringPoly"
CHAFF.name 				= "chaff"
CHAFF.material 			= UFD_YEL --FONT_RPM--
CHAFF.value 			= "CHAFF"
CHAFF.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
CHAFF.alignment 		= "CenterCenter"
CHAFF.formats 			= {"%s"}
CHAFF.h_clip_relation  = h_clip_relations.COMPARE
CHAFF.level 			= 2
CHAFF.init_rot 			= {0, 0, 0}
CHAFF.init_pos 			= {-20, -36, 0}
CHAFF.element_params 	= {"LUFD_BASE_PAGE","CHAFF_DISPENSING","UFD_OPACITY"} --get_param_handle
CHAFF.controllers		= 	{{"parameter_in_range",0,0.9,1.1}, {"parameter_compare_with_number", 1, 1}, {"opacity_using_parameter",2}}
Add(CHAFF)
--Flare
FLARE 					= CreateElement "ceStringPoly"
FLARE.name 				= "chaff"
FLARE.material 			= UFD_YEL --FONT_RPM--
FLARE.value 			= "FLARE"
FLARE.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
FLARE.alignment 		= "CenterCenter"
FLARE.formats 			= {"%s"}
FLARE.h_clip_relation  = h_clip_relations.COMPARE
FLARE.level 			= 2
FLARE.init_rot 		= {0, 0, 0}
FLARE.init_pos 		= {20, -36, 0}
FLARE.element_params 	= {"LUFD_BASE_PAGE","FLARE_DISPENSING","UFD_OPACITY"} --get_param_handle
FLARE.controllers		= 	{{"parameter_in_range",0,0.9,1.1}, {"parameter_compare_with_number", 1, 1}, {"opacity_using_parameter",2}}
Add(FLARE)
-------------------------------------------------------------
JAMMER 					= CreateElement "ceStringPoly"
JAMMER.name 				= "chaff"
JAMMER.material 			= UFD_YEL --FONT_RPM--
JAMMER.value 			= "ECM"
JAMMER.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
JAMMER.alignment 		= "CenterCenter"
JAMMER.formats 			= {"%s"}
JAMMER.h_clip_relation  = h_clip_relations.COMPARE
JAMMER.level 			= 2
JAMMER.init_rot 		= {0, 0, 0}
JAMMER.init_pos 		= {0, -36, 0}
JAMMER.element_params 	= {"LUFD_BASE_PAGE","ECM_ARG","UFD_OPACITY"} --get_param_handle
JAMMER.controllers		= 	{{"parameter_in_range",0,0.9,1.1}, {"parameter_in_range",1,0.9,1.1}, {"opacity_using_parameter",2}}
Add(JAMMER)
-------------------------------------------------------------

--Page Displays

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
STATUSTXT.element_params = {"LUFD_BASE_PAGE","UFD_OPACITY"} --HOPE THIS WORKS G_OP_BACK
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
NAVTXT.element_params = {"LUFD_BASE_PAGE","UFD_OPACITY"} --HOPE THIS WORKS G_OP_BACK
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
ALERTTXT.element_params = {"LUFD_BASE_PAGE","UFD_OPACITY","CHECK_ENGINE_LIGHT"} --HOPE THIS WORKS G_OP_BACK
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
ALERTTXTON.element_params = {"LUFD_BASE_PAGE","UFD_OPACITY","CHECK_ENGINE_LIGHT"} --HOPE THIS WORKS G_OP_BACK
ALERTTXTON.controllers	= 	{{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1},{"parameter_in_range",2,0.9,1.1},}
Add(ALERTTXTON)

STATUSBOX 					    = CreateElement "ceTexPoly"
STATUSBOX.name 				    = "STATUSBOX"
STATUSBOX.material 			    = IND_BOX 
STATUSBOX.change_opacity 	= false
STATUSBOX.collimated 		= false
STATUSBOX.isvisible 			= true
STATUSBOX.init_pos 			= {-23.5, -42.5, 0} --L-R,U-D,F-B
STATUSBOX.init_rot 			= {0, 0, 0}
STATUSBOX.element_params 		= {"UFD_OPACITY","LUFD_BASE_PAGE"}--this may not be bneeded check when more pages done for backlight on page 7 SMS fc3 bs
STATUSBOX.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},}--MENU PAGE = 1
STATUSBOX.level 				= 2
STATUSBOX.h_clip_relation     = h_clip_relations.COMPARE
vertices(STATUSBOX, 130)
Add(STATUSBOX)

UHFTXT 					= CreateElement "ceStringPoly"
UHFTXT.name 			= "UHFTXT"
UHFTXT.material 		= UFD_GRN --FONT_RPM--
UHFTXT.value 			= "UHF"
UHFTXT.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
UHFTXT.alignment 		= "CenterCenter"
UHFTXT.formats 			= {"%s"}
UHFTXT.h_clip_relation  = h_clip_relations.COMPARE
UHFTXT.level 			= 2
UHFTXT.init_rot 		= {0, 0, 0}
UHFTXT.init_pos 		= {-58, 42, 0}
UHFTXT.element_params = {"LUFD_BASE_PAGE","UFD_OPACITY"} --HOPE THIS WORKS G_OP_BACK
UHFTXT.controllers	= 	{{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
 Add(UHFTXT)
 
UHFVAL 					= CreateElement "ceStringPoly"
UHFVAL.name 			= "UHFVAL"
UHFVAL.material 		= UFD_GRN --FONT_RPM--
UHFVAL.value 			= "126.005"
UHFVAL.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
UHFVAL.alignment 		= "CenterCenter"
UHFVAL.formats 			= {"%s"}
UHFVAL.h_clip_relation  = h_clip_relations.COMPARE
UHFVAL.level 			= 2
UHFVAL.init_rot 		= {0, 0, 0}
UHFVAL.init_pos 		= {-52, 36, 0}
UHFVAL.element_params = {"LUFD_BASE_PAGE","UFD_OPACITY"} --HOPE THIS WORKS G_OP_BACK
UHFVAL.controllers	= 	{{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(UHFVAL)
 
VHFTXT 					= CreateElement "ceStringPoly"
VHFTXT.name 			= "VHFTXT"
VHFTXT.material 		= UFD_GRN --FONT_RPM--
VHFTXT.value 			= "VHF"
VHFTXT.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
VHFTXT.alignment 		= "CenterCenter"
VHFTXT.formats 			= {"%s"}
VHFTXT.h_clip_relation  = h_clip_relations.COMPARE
VHFTXT.level 			= 2
VHFTXT.init_rot 		= {0, 0, 0}
VHFTXT.init_pos 		= {58, 42, 0}
VHFTXT.element_params = {"LUFD_BASE_PAGE","UFD_OPACITY"} --HOPE THIS WORKS G_OP_BACK
VHFTXT.controllers	= 	{{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(VHFTXT)

VHFVALUE 					= CreateElement "ceStringPoly"
VHFVALUE.name 			= "VHFVALUE"
VHFVALUE.material 		= UFD_GRN --FONT_RPM--
VHFVALUE.value 			= "181.065"
VHFVALUE.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
VHFVALUE.alignment 		= "CenterCenter"
VHFVALUE.formats 			= {"%s"}
VHFVALUE.h_clip_relation  = h_clip_relations.COMPARE
VHFVALUE.level 			= 2
VHFVALUE.init_rot 		= {0, 0, 0}
VHFVALUE.init_pos 		= {52, 36, 0}
VHFVALUE.element_params = {"LUFD_BASE_PAGE","UFD_OPACITY"} --HOPE THIS WORKS G_OP_BACK
VHFVALUE.controllers	= 	{{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(VHFVALUE)

APTEXT 					= CreateElement "ceStringPoly"
APTEXT.name 			= "APTEXT"
APTEXT.material 		= UFD_GRN --FONT_RPM--
APTEXT.value 			= "A/P"
APTEXT.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
APTEXT.alignment 		= "CenterCenter"
APTEXT.formats 			= {"%s"}
APTEXT.h_clip_relation  = h_clip_relations.COMPARE
APTEXT.level 			= 2
APTEXT.init_rot 		= {0, 0, 0}
APTEXT.init_pos 		= {-58, 18, 0}
APTEXT.element_params = {"LUFD_BASE_PAGE","UFD_OPACITY"} --HOPE THIS WORKS G_OP_BACK
APTEXT.controllers	= 	{{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(APTEXT)

APSTATUS 					= CreateElement "ceStringPoly"
APSTATUS.name 			= "APSTATUS"
APSTATUS.material 		= UFD_GRN --FONT_RPM--
APSTATUS.value 			= "OFF"
APSTATUS.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
APSTATUS.alignment 		= "CenterCenter"
APSTATUS.formats 			= {"%s"}
APSTATUS.h_clip_relation  = h_clip_relations.COMPARE
APSTATUS.level 			= 2
APSTATUS.init_rot 		= {0, 0, 0}
APSTATUS.init_pos 		= {-46, 18, 0}
APSTATUS.element_params = {"LUFD_BASE_PAGE","UFD_OPACITY"} --HOPE THIS WORKS G_OP_BACK
APSTATUS.controllers	= 	{{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(APSTATUS)

TCNTEXT 					= CreateElement "ceStringPoly"
TCNTEXT.name 			= "TCNTEXT"
TCNTEXT.material 		= UFD_GRN --FONT_RPM--
TCNTEXT.value 			= "TCN"
TCNTEXT.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
TCNTEXT.alignment 		= "CenterCenter"
TCNTEXT.formats 			= {"%s"}
TCNTEXT.h_clip_relation  = h_clip_relations.COMPARE
TCNTEXT.level 			= 2
TCNTEXT.init_rot 		= {0, 0, 0}
TCNTEXT.init_pos 		= {-58, -10, 0}
TCNTEXT.element_params = {"LUFD_BASE_PAGE","UFD_OPACITY"} --HOPE THIS WORKS G_OP_BACK
TCNTEXT.controllers	= 	{{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(TCNTEXT)

TCNVAL 					= CreateElement "ceStringPoly"
TCNVAL.name 			= "TCNVAL"
TCNVAL.material 		= UFD_GRN --FONT_RPM--
TCNVAL.value 			= "77X L/R"
TCNVAL.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
TCNVAL.alignment 		= "CenterCenter"
TCNVAL.formats 			= {"%s"}
TCNVAL.h_clip_relation  = h_clip_relations.COMPARE
TCNVAL.level 			= 2
TCNVAL.init_rot 		= {0, 0, 0}
TCNVAL.init_pos 		= {-40, -10, 0}
TCNVAL.element_params = {"LUFD_BASE_PAGE","UFD_OPACITY"} --HOPE THIS WORKS G_OP_BACK
TCNVAL.controllers	= 	{{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(TCNVAL)

DATE				    = CreateElement "ceStringPoly"
DATE.name				= "DATE"
DATE.material			= UFD_GRN
DATE.init_pos			= {62, -10, 0} --L-R,U-D,F-B
DATE.alignment			= "RightCenter"
DATE.stringdefs		= {0.0040, 0.0040, 0.0004, 0.001}
DATE.additive_alpha	= true
DATE.collimated		= false
DATE.isdraw			= true	
DATE.use_mipfilter		= true
DATE.h_clip_relation	= h_clip_relations.COMPARE
DATE.level				= 2
DATE.element_params = {"LUFD_BASE_PAGE","DATE","UFD_OPACITY"}
DATE.formats			= {"%s"}--= {"%02.0f"}
DATE.controllers		=   {
                                        {"parameter_in_range",0,0.9,1.1},
                                        {"text_using_parameter",1,0},
                                        {"opacity_using_parameter",2}
                                    }                            
Add(DATE)

CLOCK				    = CreateElement "ceStringPoly"
CLOCK.name				= "CLOCK"
CLOCK.material			= UFD_GRN
CLOCK.init_pos			= {62, -16, 0} --L-R,U-D,F-B
CLOCK.alignment			= "RightCenter"
CLOCK.stringdefs		= {0.0040, 0.0040, 0.0004, 0.001}
CLOCK.additive_alpha	= true
CLOCK.collimated		= false
CLOCK.isdraw			= true	
CLOCK.use_mipfilter		= true
CLOCK.h_clip_relation	= h_clip_relations.COMPARE
CLOCK.level				= 2
CLOCK.element_params = {"LUFD_BASE_PAGE","CLOCK","UFD_OPACITY"}
CLOCK.formats			= {"%s"}--= {"%02.0f"}
CLOCK.controllers		=   {
                                        {"parameter_in_range",0,0.9,1.1},
                                        {"text_using_parameter",1,0},
                                        {"opacity_using_parameter",2}
                                    }                            
Add(CLOCK)

IFFTXT					= CreateElement "ceStringPoly"
IFFTXT.name 			= "IFFTXT"
IFFTXT.material 		= UFD_GRN --FONT_RPM--
IFFTXT.value 			= "IFF"
IFFTXT.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
IFFTXT.alignment 		= "CenterCenter"
IFFTXT.formats 			= {"%s"}
IFFTXT.h_clip_relation  = h_clip_relations.COMPARE
IFFTXT.level 			= 2
IFFTXT.init_rot 		= {0, 0, 0}
IFFTXT.init_pos 		= {44, -22, 0}
IFFTXT.element_params = {"LUFD_BASE_PAGE","UFD_OPACITY"} --HOPE THIS WORKS G_OP_BACK
IFFTXT.controllers	= 	{{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(IFFTXT)

IFFVAL					= CreateElement "ceStringPoly"
IFFVAL.name 			= "IFFVAL"
IFFVAL.material 		= UFD_GRN --FONT_RPM--
IFFVAL.value 			= "M3A"
IFFVAL.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
IFFVAL.alignment 		= "CenterCenter"
IFFVAL.formats 			= {"%s"}
IFFVAL.h_clip_relation  = h_clip_relations.COMPARE
IFFVAL.level 			= 2
IFFVAL.init_rot 		= {0, 0, 0}
IFFVAL.init_pos 		= {56, -22, 0}
IFFVAL.element_params = {"LUFD_BASE_PAGE","UFD_OPACITY"} --HOPE THIS WORKS G_OP_BACK
IFFVAL.controllers	= 	{{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(IFFVAL)


ILSTEXT 					= CreateElement "ceStringPoly"
ILSTEXT.name 			= "ILSTEXT"
ILSTEXT.material 		= UFD_GRN --FONT_RPM--
ILSTEXT.value 			= "ILS"
ILSTEXT.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
ILSTEXT.alignment 		= "CenterCenter"
ILSTEXT.formats 			= {"%s"}
ILSTEXT.h_clip_relation  = h_clip_relations.COMPARE
ILSTEXT.level 			= 2
ILSTEXT.init_rot 		= {0, 0, 0}
ILSTEXT.init_pos 		= {-58, -16, 0}
ILSTEXT.element_params = {"LUFD_BASE_PAGE","UFD_OPACITY"} --HOPE THIS WORKS G_OP_BACK
ILSTEXT.controllers	= 	{{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(ILSTEXT)

ILSVAL 					= CreateElement "ceStringPoly"
ILSVAL.name 			= "ILSVAL"
ILSVAL.material 		= UFD_GRN --FONT_RPM--
ILSVAL.value 			= "OFF"
ILSVAL.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
ILSVAL.alignment 		= "CenterCenter"
ILSVAL.formats 			= {"%s"}
ILSVAL.h_clip_relation  = h_clip_relations.COMPARE
ILSVAL.level 			= 2
ILSVAL.init_rot 		= {0, 0, 0}
ILSVAL.init_pos 		= {-46, -16, 0}
ILSVAL.element_params = {"LUFD_BASE_PAGE","UFD_OPACITY"} --HOPE THIS WORKS G_OP_BACK
ILSVAL.controllers	= 	{{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(ILSVAL)

STPTEXT 					= CreateElement "ceStringPoly"
STPTEXT.name 			= "STPTEXT"
STPTEXT.material 		= UFD_GRN --FONT_RPM--
STPTEXT.value 			= "STP"
STPTEXT.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
STPTEXT.alignment 		= "CenterCenter"
STPTEXT.formats 			= {"%s"}
STPTEXT.h_clip_relation  = h_clip_relations.COMPARE
STPTEXT.level 			= 2
STPTEXT.init_rot 		= {0, 0, 0}
STPTEXT.init_pos 		= {-58, -22, 0}
STPTEXT.element_params = {"LUFD_BASE_PAGE","UFD_OPACITY"} --HOPE THIS WORKS G_OP_BACK
STPTEXT.controllers	= 	{{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(STPTEXT)

STPVAL 					= CreateElement "ceStringPoly"
STPVAL.name 			= "STPTEXT"
STPVAL.material 		= UFD_GRN --FONT_RPM--
STPVAL.value 			= "000"
STPVAL.stringdefs 		= {0.0040, 0.0040, 0.0004, 0.001}
STPVAL.alignment 		= "CenterCenter"
STPVAL.formats 			= {"%s"}
STPVAL.h_clip_relation  = h_clip_relations.COMPARE
STPVAL.level 			= 2
STPVAL.init_rot 		= {0, 0, 0}
STPVAL.init_pos 		= {-46, -22, 0}
STPVAL.element_params = {"LUFD_BASE_PAGE","UFD_OPACITY"} --HOPE THIS WORKS G_OP_BACK
STPVAL.controllers	= 	{{"parameter_in_range",0,0.9,1.1}, {"opacity_using_parameter",1}}
Add(STPVAL)
