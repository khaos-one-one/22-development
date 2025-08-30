dofile(LockOn_Options.script_path.."PMFD_CENTER/definitions.lua")
dofile(LockOn_Options.script_path.."fonts.lua")
dofile(LockOn_Options.script_path.."materials.lua")
dofile(LockOn_Options.script_path.."RADAR/Indicator/definitions.lua")
SetScale(FOV)

local MakeTSD = require("TSD_base").MakeTSD

local WhiteColor = {255,255,255,255}
local BlueColor = {0,56,218,255}
local CircleColor = {0,56,218,255}
local ScreenColor = {3,3,3,255}
local NAV_COL_MAGENTA = MakeMaterial(nil,{255,0,255,255})
local NAV_COL_BLUE    = MakeMaterial(nil,BlueColor)
local NAV_COL_WHITE   = MakeMaterial(nil,WhiteColor)



local CENTER_ICON = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/map_center.dds", WhiteColor)
local HEADING_BOX = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/Heading_Box.dds", CircleColor)
local MASK_BOX = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mask_box.dds", ScreenColor)

local function osb_pos(i)
    if i>=1 and i<=5 then
        local x_map = {posBut6x,posBut7x,posBut8x,posBut9x,posBut10x}
        return {x_map[i], posTop, 0}
    elseif i>=6 and i<=10 then
        local y_map = {posBut1y,posBut2y,posBut3y,posBut4y,posBut5y}
        return {posRight, y_map[i-5], 0}
    elseif i>=11 and i<=15 then
        local x_map = {posBut16x,posBut17x,posBut18x,posBut19x,posBut20x}
        return {x_map[i-10], posBottom, 0}
    elseif i>=16 and i<=20 then
        local y_map = {posBut11y,posBut12y,posBut13y,posBut14y,posBut15y}
        return {posLeft, y_map[i-15], 0}
    end
    return {0,0,0}
end
    if i>=6 and i<=10 then return {0.975, ys[i-5], 0} end
    if i>=11 and i<=15 then return {xs[i-10], -0.975, 0} end
    if i>=16 and i<=20 then return {-0.975, ys[i-15], 0} end
    return {0,0,0}
end

local clip_mat = MakeMaterial(nil,{0,0,0,255})
local clip = CreateElement "ceMeshPoly"
clip.name = "tsd_clip"
clip.primitivetype = "triangles"
clip.vertices = {{-1.05,-1.05},{-1.05,1.05},{1.05,1.05},{1.05,-1.05}}
clip.indices = {0,1,2,2,3,0}
clip.material = clip_mat
clip.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
clip.level = 1
clip.collimated = false
clip.isvisible = false
Add(clip)

local BGROUND = CreateElement "ceTexPoly"
BGROUND.name = "BG"
BGROUND.material = MASK_BOX
BGROUND.change_opacity = false
BGROUND.collimated = false
BGROUND.isvisible = true
BGROUND.init_pos = {0,0,0}
BGROUND.init_rot = {0,0,0}
BGROUND.element_params = {"MFD_OPACITY","PMFD_RDR_PAGE"}
BGROUND.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
BGROUND.level = 2
BGROUND.h_clip_relation = h_clip_relations.COMPARE
vertices(BGROUND,3)
Add(BGROUND)

local MODE_TXT = CreateElement "ceStringPoly"
MODE_TXT.name = "MODE_TXT"
MODE_TXT.material = UFD_FONT
MODE_TXT.value = "MODE"
MODE_TXT.stringdefs = {0.0050,0.0050,0.0004,0.001}
MODE_TXT.alignment = "CenterCenter"
MODE_TXT.formats = {"%s"}
MODE_TXT.h_clip_relation = h_clip_relations.COMPARE
MODE_TXT.level = 2
MODE_TXT.init_pos = osb_pos(16)
MODE_TXT.init_rot = {0,0,0}
MODE_TXT.element_params = {"MFD_OPACITY","PMFD_RDR_PAGE"}
MODE_TXT.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(MODE_TXT)

local PULSE_TXT = CreateElement "ceStringPoly"
PULSE_TXT.name = "PULSE_TXT"
PULSE_TXT.material = UFD_FONT
PULSE_TXT.value = "PRF"
PULSE_TXT.stringdefs = {0.0050,0.0050,0.0004,0.001}
PULSE_TXT.alignment = "CenterCenter"
PULSE_TXT.formats = {"%s"}
PULSE_TXT.h_clip_relation = h_clip_relations.COMPARE
PULSE_TXT.level = 2
PULSE_TXT.init_pos = osb_pos(17)
PULSE_TXT.init_rot = {0,0,0}
PULSE_TXT.element_params = {"MFD_OPACITY","PMFD_RDR_PAGE"}
PULSE_TXT.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(PULSE_TXT)

local Rpwr_TXT = CreateElement "ceStringPoly"
Rpwr_TXT.name = "Rpwr_TXT"
Rpwr_TXT.material = UFD_FONT
Rpwr_TXT.value = "POWER"
Rpwr_TXT.stringdefs = {0.0050,0.0050,0.0004,0.001}
Rpwr_TXT.alignment = "CenterCenter"
Rpwr_TXT.formats = {"%s"}
Rpwr_TXT.h_clip_relation = h_clip_relations.COMPARE
Rpwr_TXT.level = 2
Rpwr_TXT.init_pos = osb_pos(15)
Rpwr_TXT.init_rot = {0,0,0}
Rpwr_TXT.element_params = {"MFD_OPACITY","PMFD_RDR_PAGE"}
Rpwr_TXT.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(Rpwr_TXT)

local MENU = CreateElement "ceStringPoly"
MENU.name = "MENU"
MENU.material = UFD_YEL
MENU.value = "MENU"
MENU.stringdefs = {0.0050,0.0050,0.0004,0.001}
MENU.alignment = "CenterCenter"
MENU.formats = {"%s"}
MENU.h_clip_relation = h_clip_relations.COMPARE
MENU.level = 2
MENU.init_pos = osb_pos(13)
MENU.init_rot = {0,0,0}
MENU.element_params = {"MFD_OPACITY","PMFD_RDR_PAGE"}
MENU.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(MENU)

local RNG_MINUS_TXT = CreateElement "ceStringPoly"
RNG_MINUS_TXT.name = "RNG_MINUS_TXT"
RNG_MINUS_TXT.material = UFD_FONT
RNG_MINUS_TXT.value = "RNG−"
RNG_MINUS_TXT.stringdefs = {0.0050,0.0050,0.0004,0.001}
RNG_MINUS_TXT.alignment = "CenterCenter"
RNG_MINUS_TXT.formats = {"%s"}
RNG_MINUS_TXT.h_clip_relation = h_clip_relations.COMPARE
RNG_MINUS_TXT.level = 2
RNG_MINUS_TXT.init_pos = osb_pos(18)
RNG_MINUS_TXT.init_rot = {0,0,0}
RNG_MINUS_TXT.element_params = {"MFD_OPACITY","PMFD_RDR_PAGE"}
RNG_MINUS_TXT.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(RNG_MINUS_TXT)

local RNG_PLUS_TXT = Copy(RNG_MINUS_TXT)
RNG_PLUS_TXT.name = "RNG_PLUS_TXT"
RNG_PLUS_TXT.value = "RNG+"
RNG_PLUS_TXT.init_pos = osb_pos(19)
Add(RNG_PLUS_TXT)

local p_declutter = get_param_handle("RDR_DECLUTTER_INDEX")
local p_aaag = get_param_handle("RADAR_AAAG_INDEX")
local p_agmode = get_param_handle("RADAR_AG_MODE_INDEX")
if (p_declutter:get() or 0) == 0 then p_declutter:set(1) end
if (p_aaag:get() or 0) == 0 then p_aaag:set(1) end
if (p_agmode:get() or 0) == 0 then p_agmode:set(1) end

local DCLTR_ALL = CreateElement "ceStringPoly"
DCLTR_ALL.name = "DCLTR_ALL"
DCLTR_ALL.material = UFD_FONT
DCLTR_ALL.value = "DCLTR ALL"
DCLTR_ALL.stringdefs = {0.0050,0.0050,0.0004,0.001}
DCLTR_ALL.alignment = "CenterCenter"
DCLTR_ALL.formats = {"%s"}
DCLTR_ALL.h_clip_relation = h_clip_relations.COMPARE
DCLTR_ALL.level = 2
DCLTR_ALL.init_pos = osb_pos(4)
DCLTR_ALL.init_rot = {0,0,0}
DCLTR_ALL.element_params = {"MFD_OPACITY","PMFD_RDR_PAGE","RDR_DECLUTTER_INDEX"}
DCLTR_ALL.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.9,1.1}}
Add(DCLTR_ALL)

local DCLTR_RDR = Copy(DCLTR_ALL)
DCLTR_RDR.name = "DCLTR_RDR"
DCLTR_RDR.value = "DCLTR RDR"
DCLTR_RDR.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,1.9,2.1}} 
DCLTR_RDR.init_pos = osb_pos(4)
Add(DCLTR_RDR)

local DCLTR_NAV = Copy(DCLTR_ALL)
DCLTR_NAV.name = "DCLTR_NAV"
DCLTR_NAV.value = "DCLTR NAV"
DCLTR_NAV.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,2.9,3.1}}
DCLTR_NAV.init_pos = osb_pos(4)
Add(DCLTR_NAV)

local AA_TXT = CreateElement "ceStringPoly"
AA_TXT.name = "AA_TXT"
AA_TXT.material = UFD_FONT
AA_TXT.value = "A/A"
AA_TXT.stringdefs = {0.0050,0.0050,0.0004,0.001}
AA_TXT.alignment = "CenterCenter"
AA_TXT.formats = {"%s"}
AA_TXT.h_clip_relation = h_clip_relations.COMPARE
AA_TXT.level = 2
AA_TXT.init_pos = osb_pos(5)
AA_TXT.init_rot = {0,0,0}
AA_TXT.element_params = {"MFD_OPACITY","PMFD_RDR_PAGE","RADAR_AAAG_INDEX"}
AA_TXT.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.9,1.1}}
Add(AA_TXT)

local AG_TXT = Copy(AA_TXT)
AG_TXT.name = "AG_TXT"
AG_TXT.value = "A/G"
AG_TXT.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,1.9,2.1}}
AG_TXT.init_pos = osb_pos(5)
Add(AG_TXT)

local HEAD_BOX = CreateElement "ceTexPoly"
HEAD_BOX.name = "HEADING_BOX"
HEAD_BOX.material = HEADING_BOX
HEAD_BOX.change_opacity = false
HEAD_BOX.collimated = false
HEAD_BOX.isvisible = true
HEAD_BOX.init_pos = {0,-0.08,0}
HEAD_BOX.parent_element = "HEAD_ANCHOR"
Add(HEAD_BOX)

local HEAD_VAL = CreateElement "ceStringPoly"
HEAD_VAL.name = "HEAD_VAL"
HEAD_VAL.material = UFD_FONT
HEAD_VAL.init_pos = {0.064,-0.036,0}
HEAD_VAL.parent_element = "HEAD_ANCHOR"
Add(HEAD_VAL)

local RadarRangesNM = {20,40,80,120,300}
local currentRadarIndex = 1

local TSD = MakeTSD({id = "TSD_Radar", level = 2, visibilities = {{"PMFD_RDR_PAGE",1}}})

local function rebuildRadarRings()
    local outerNM = RadarRangesNM[currentRadarIndex]
    local ringDists = {}
    for i=1,5 do ringDists[i] = outerNM * i / 5 end
    TSD:RemoveRangeRings()
    TSD:RemoveRangeRingLabels()
    TSD:AddRangeRings(ringDists,false)
    TSD:AddRangeRingLabels(ringDists,{offsetX=0,offsetY=-12},"UFD_FONT")
    TSD:ChangeRange(outerNM)
end

rebuildRadarRings()

TSD:AddScanZone({outerRadiusCtrl = "TSD_RadarOuterRange", innerRadius = 0, halfAngle = 45, material = "SCAN_ZONE", level = 2.1, opacityParam = "PMFD_RDR_PAGE"})
TSD:AddCompassRose({font = "UFD_FONT", tickStep = 30, majorTickEvery = 90, headingParam = "TRUE_HEADING", level = 2.2, opacityParam = "PMFD_RDR_PAGE"})

local ICON = CreateElement "ceTexPoly"
ICON.name = "OWN_SHIP_ICON"
ICON.material = CENTER_ICON
ICON.change_opacity = false
ICON.collimated = false
ICON.isvisible = true
ICON.init_pos = {0,0,0}
ICON.init_rot = {0,0,0}
ICON.element_params = {"MFD_OPACITY","PMFD_RDR_PAGE"}
ICON.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
ICON.level = 2.3
ICON.h_clip_relation = h_clip_relations.COMPARE
vertices(ICON,0.16)
ICON.parent_element = TSD.root
Add(ICON)

local HEAD_ANCHOR = CreateElement "ceSimple"
HEAD_ANCHOR.name = "HEAD_ANCHOR"
HEAD_ANCHOR.init_pos = osb_pos(3)
Add(HEAD_ANCHOR)

RS = RADAR_SCALE
ud_scale = 0.00001 * 0.9 * RS
lr_scale = 0.095 * 0.9 * 2 * RS
life_time = 10
life_time_low = 0

local x_size = 0.01 * 2
local y_size = 0.01 * 2

for ia=1,900 do
    local i
    if ia < 10 then i = "_0"..ia.."_" else i = "_"..ia.."_" end
    local radar_contact = CreateElement "ceMeshPoly"
    radar_contact.name = "radar_contact"..i.."name"
    radar_contact.primitivetype = "triangles"
    radar_contact.vertices = {{-x_size,-y_size},{-x_size,y_size},{x_size,y_size},{x_size,-y_size}}
    radar_contact.indices = {0,1,2,0,2,3}
    radar_contact.init_pos = {0,-0.90*RS,0}
    radar_contact.material = MFCD_GREEN
    radar_contact.isdraw = true
    radar_contact.isvisible = true
    radar_contact.h_clip_relation = h_clip_relations.COMPARE
    radar_contact.level = RADAR_DEFAULT_LEVEL
    radar_contact.collimated = true
    radar_contact.controllers = {
        {"move_left_right_using_parameter",1,lr_scale},
        {"move_up_down_using_parameter",2,ud_scale},
        {"parameter_in_range",2,30,60000},
        {"parameter_in_range",3,life_time_low,life_time},
        {"parameter_in_range",7,0.9,1.1},
        {"parameter_in_range",8,0.9,2.1},
        {"change_color_when_parameter_equal_to_number",9,1,0.0,1.0,0.0},
        {"change_color_when_parameter_equal_to_number",9,2,1.0,1.0,0.0},
        {"change_color_when_parameter_equal_to_number",9,3,1.0,0.0,0.0},
        {"change_color_when_parameter_equal_to_number",5,1,0.0,1.0,0.0}
    }
    radar_contact.element_params = {
        "RADAR_CONTACT"..i.."ELEVATION",
        "RADAR_CONTACT"..i.."AZIMUTH",
        "RADAR_CONTACT"..i.."RANGE",
        "RADAR_CONTACT"..i.."TIME",
        "RADAR_CONTACT"..i.."FRIENDLY",
        "RADAR_CONTACT"..i.."RCS",
        "RADAR_AAAG_INDEX",
        "RDR_DECLUTTER_INDEX",
        "RADAR_CONTACT"..i.."IFF"
    }
    radar_contact.parent_element = TSD.root
    Add(radar_contact)
end

x_size = 0.006
y_size = 0.05

local radar_cursor = CreateElement "ceMeshPoly"
radar_cursor.name = "radar_cursor"
radar_cursor.primitivetype = "triangles"
radar_cursor.vertices = {
    {-x_size-0.04,-y_size},
    {-x_size-0.04, y_size},
    { x_size-0.04, y_size},
    { x_size-0.04,-y_size},
    {-x_size+0.04,-y_size},
    {-x_size+0.04, y_size},
    { x_size+0.04, y_size},
    { x_size+0.04,-y_size}
}
radar_cursor.indices = {0,1,2,0,2,3,4,5,6,4,6,7}
radar_cursor.init_pos = {0,-0.90*RS,0}
radar_cursor.material = MFCD_GREEN
radar_cursor.isdraw = true
radar_cursor.isvisible = true
radar_cursor.h_clip_relation = h_clip_relations.COMPARE
radar_cursor.level = RADAR_DEFAULT_LEVEL
radar_cursor.collimated = true
radar_cursor.controllers = {
    {"move_up_down_using_parameter",0,ud_scale},
    {"move_left_right_using_parameter",1,lr_scale},
    {"parameter_in_range",3,0.9,2.1}
}
radar_cursor.element_params = {"RADAR_TDC_RANGE","RADAR_TDC_AZIMUTH","RADAR_MODE","RDR_DECLUTTER_INDEX"}
radar_cursor.parent_element = TSD.root
Add(radar_cursor)

x_size = 0.03
y_size = 0.03

local radar_STT = CreateElement "ceMeshPoly"
radar_STT.name = "radar_STT"
radar_STT.primitivetype = "triangles"
radar_STT.vertices = {{-x_size,-y_size},{-x_size,y_size},{x_size,y_size},{x_size,-y_size}}
radar_STT.indices = {0,1,2,0,2,3}
radar_STT.init_pos = {0,-0.90*RS,0}
radar_STT.material = MFCD_GREEN
radar_STT.isdraw = true
radar_STT.isvisible = true
radar_STT.h_clip_relation = h_clip_relations.COMPARE
radar_STT.level = RADAR_DEFAULT_LEVEL
radar_STT.collimated = true
radar_STT.controllers = {
    {"move_up_down_using_parameter",0,ud_scale},
    {"move_left_right_using_parameter",1,lr_scale},
    {"parameter_in_range",3,2.9,3.1},
    {"parameter_in_range",4,0.9,1.1}
}
radar_STT.element_params = {"RADAR_STT_RANGE","RADAR_STT_AZIMUTH","RADAR_STT_ELEVATION","RADAR_MODE","RADAR_AAAG_INDEX"}
radar_STT.parent_element = TSD.root
Add(radar_STT)

local radar_STT_backview = CreateElement "ceMeshPoly"
radar_STT_backview.name = "radar_STT_backview"
radar_STT_backview.primitivetype = "triangles"
radar_STT_backview.vertices = {
    {-x_size,-y_size},{-x_size,y_size},{x_size,y_size},{x_size,-y_size},
    {-y_size,-x_size},{-y_size,x_size},{y_size,x_size},{y_size,-x_size}
}
radar_STT_backview.indices = {0,1,2,0,2,3,4,5,6,4,6,7}
radar_STT_backview.init_pos = {0,0.0,0}
radar_STT_backview.material = MFCD_GREEN
radar_STT_backview.isdraw = true
radar_STT_backview.isvisible = true
radar_STT_backview.h_clip_relation = h_clip_relations.COMPARE
radar_STT_backview.level = RADAR_DEFAULT_LEVEL
radar_STT_backview.collimated = true
radar_STT_backview.controllers = {
    {"move_up_down_using_parameter",2,lr_scale},
    {"move_left_right_using_parameter",1,lr_scale},
    {"parameter_in_range",3,2.9,3.1},
    {"parameter_in_range",4,0.9,1.1}
}
radar_STT_backview.element_params = {"RADAR_STT_RANGE","RADAR_STT_AZIMUTH","RADAR_STT_ELEVATION","RADAR_MODE","RADAR_AAAG_INDEX"}
radar_STT_backview.parent_element = TSD.root
Add(radar_STT_backview)

local radar_cursor_range = CreateElement "ceStringPoly"
radar_cursor_range.name = "radar_cursor_range"
radar_cursor_range.material = HUD_FONT
radar_cursor_range.init_pos = {-0.1,0.0,0}
radar_cursor_range.stringdefs = txt_m_stringdefs
radar_cursor_range.alignment = "RightCenter"
radar_cursor_range.value = "0"
radar_cursor_range.formats = {"%.0f"}
radar_cursor_range.UseBackground = false
radar_cursor_range.element_params = {"RADAR_TDC_RANGE"}
radar_cursor_range.controllers = {{"text_using_parameter",0,0}}
radar_cursor_range.parent_element = "radar_cursor"
radar_cursor_range.use_mipfilter = true
radar_cursor_range.h_clip_relation = h_clip_relations.COMPARE
radar_cursor_range.level = RADAR_DEFAULT_LEVEL
Add(radar_cursor_range)

local radar_cursor_upper_alt = Copy(radar_cursor_range)
radar_cursor_upper_alt.name = "radar_cursor_upper_alt"
radar_cursor_upper_alt.init_pos = {0.25,0.05,0}
radar_cursor_upper_alt.alignment = "RightCenter"
radar_cursor_upper_alt.element_params = {"RADAR_TDC_ELEVATION_AT_RANGE_UPPER"}
radar_cursor_upper_alt.controllers = {{"text_using_parameter",0,0}}
Add(radar_cursor_upper_alt)

local radar_cursor_lower_alt = Copy(radar_cursor_range)
radar_cursor_lower_alt.name = "radar_cursor_lower_alt"
radar_cursor_lower_alt.init_pos = {0.25,-0.05,0}
radar_cursor_lower_alt.element_params = {"RADAR_TDC_ELEVATION_AT_RANGE_LOWER"}
radar_cursor_lower_alt.controllers = {{"text_using_parameter",0,0}}
Add(radar_cursor_lower_alt)

local AG_MODE_GMTI = CreateElement "ceStringPoly"
AG_MODE_GMTI.name = "AG_MODE_GMTI"
AG_MODE_GMTI.material = UFD_FONT
AG_MODE_GMTI.value = "GMTI"
AG_MODE_GMTI.stringdefs = {0.0050,0.0050,0.0004,0.001}
AG_MODE_GMTI.alignment = "CenterCenter"
AG_MODE_GMTI.formats = {"%s"}
AG_MODE_GMTI.h_clip_relation = h_clip_relations.COMPARE
AG_MODE_GMTI.level = 2
AG_MODE_GMTI.init_pos = osb_pos(7)
AG_MODE_GMTI.element_params = {"MFD_OPACITY","PMFD_RDR_PAGE","RADAR_AAAG_INDEX","RADAR_AG_MODE_INDEX"}
AG_MODE_GMTI.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,1.9,2.1},{"parameter_in_range",3,0.9,1.1}}
Add(AG_MODE_GMTI)

local AG_MODE_SAR = Copy(AG_MODE_GMTI)
AG_MODE_SAR.name = "AG_MODE_SAR"
AG_MODE_SAR.value = "SAR"
AG_MODE_SAR.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,1.9,2.1},{"parameter_in_range",3,1.9,2.1}}
Add(AG_MODE_SAR)

local AG_MODE_EXP1 = Copy(AG_MODE_GMTI)
AG_MODE_EXP1.name = "AG_MODE_EXP1"
AG_MODE_EXP1.value = "EXP1"
AG_MODE_EXP1.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,1.9,2.1},{"parameter_in_range",3,2.9,3.1}}
Add(AG_MODE_EXP1)

local AG_MODE_EXP2 = Copy(AG_MODE_GMTI)
AG_MODE_EXP2.name = "AG_MODE_EXP2"
AG_MODE_EXP2.value = "EXP2"
AG_MODE_EXP2.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,1.9,2.1},{"parameter_in_range",3,3.9,4.1}}
Add(AG_MODE_EXP2)

local AG_MODE_SEA = Copy(AG_MODE_GMTI)
AG_MODE_SEA.name = "AG_MODE_SEA"
AG_MODE_SEA.value = "SEA"
AG_MODE_SEA.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,1.9,2.1},{"parameter_in_range",3,4.9,5.1}}
AG_MODE_SEA.init_pos = osb_pos(7)
Add(AG_MODE_SEA)

local MAP_UP_TXT_HDG = CreateElement "ceStringPoly"
MAP_UP_TXT_HDG.name = "MAP_UP_TXT_HDG"
MAP_UP_TXT_HDG.material = UFD_FONT
MAP_UP_TXT_HDG.value = "HDG UP"
MAP_UP_TXT_HDG.stringdefs = {0.0050,0.0050,0.0004,0.001}
MAP_UP_TXT_HDG.alignment = "CenterCenter"
MAP_UP_TXT_HDG.formats = {"%s"}
MAP_UP_TXT_HDG.h_clip_relation = h_clip_relations.COMPARE
MAP_UP_TXT_HDG.level = 2
MAP_UP_TXT_HDG.init_pos = osb_pos(8)
MAP_UP_TXT_HDG.element_params = {"MFD_OPACITY","PMFD_RDR_PAGE","MAP_UP_INDEX"}
MAP_UP_TXT_HDG.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.9,1.1}}
Add(MAP_UP_TXT_HDG)

local MAP_UP_TXT_N = Copy(MAP_UP_TXT_HDG)
MAP_UP_TXT_N.name = "MAP_UP_TXT_N"
MAP_UP_TXT_N.value = "N UP"
MAP_UP_TXT_N.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,1.9,2.1}}
Add(MAP_UP_TXT_N)

local FRZ_TXT = CreateElement "ceStringPoly"
FRZ_TXT.name = "FRZ_TXT"
FRZ_TXT.material = UFD_FONT
FRZ_TXT.value = "FRZ"
FRZ_TXT.stringdefs = {0.0050,0.0050,0.0004,0.001}
FRZ_TXT.alignment = "CenterCenter"
FRZ_TXT.formats = {"%s"}
FRZ_TXT.h_clip_relation = h_clip_relations.COMPARE
FRZ_TXT.level = 2
FRZ_TXT.init_pos = osb_pos(9)
FRZ_TXT.element_params = {"MFD_OPACITY","PMFD_RDR_PAGE"}
FRZ_TXT.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
Add(FRZ_TXT)

local TWS_TXT = CreateElement "ceStringPoly"
TWS_TXT.name = "TWS_TXT"
TWS_TXT.material = UFD_FONT
TWS_TXT.value = "TWS"
TWS_TXT.stringdefs = {0.0050,0.0050,0.0004,0.001}
TWS_TXT.alignment = "CenterCenter"
TWS_TXT.formats = {"%s"}
TWS_TXT.h_clip_relation = h_clip_relations.COMPARE
TWS_TXT.level = 2
TWS_TXT.init_pos = osb_pos(16)
TWS_TXT.element_params = {"MFD_OPACITY","PMFD_RDR_PAGE","RADAR_MODE_INDEX"}
TWS_TXT.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.9,1.1}}
Add(TWS_TXT)

local RWS_TXT = Copy(TWS_TXT)
RWS_TXT.name = "RWS_TXT"
RWS_TXT.value = "RWS"
RWS_TXT.controllers = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,1.9,2.1}}
Add(RWS_TXT)

local xg = 0.012
local yg = 0.012

for ia=1,256 do
    local i
    if ia < 10 then i = "_0"..ia.."_" elseif ia < 100 then i = "_"..ia.."_" else i = "_"..ia.."_" end
    local g = CreateElement "ceMeshPoly"
    g.name = "GMTI_RET"..i
    g.primitivetype = "triangles"
    g.vertices = {{-xg,-yg},{-xg,yg},{xg,yg},{xg,-yg}}
    g.indices = {0,1,2,0,2,3}
    g.init_pos = {0,-0.90*RS,0}
    g.material = MFCD_GREEN
    g.isdraw = true
    g.isvisible = true
    g.h_clip_relation = h_clip_relations.COMPARE
    g.level = RADAR_DEFAULT_LEVEL
    g.collimated = true
    g.controllers = {
        {"move_left_right_using_parameter",1,lr_scale},
        {"move_up_down_using_parameter",2,ud_scale},
        {"parameter_in_range",5,0.9,1.1},       -- RADAR_AG_MODE_INDEX == 1 (GMTI)
        {"parameter_in_range",6,0.9,2.1},       -- Declutter ALL/RDR
        {"parameter_in_range",7,1.9,2.1}        -- RADAR_AAAG_INDEX == 2 (A/G)
    }
    g.element_params = {
        "GMTI_CONTACT"..i.."AZIMUTH",
        "GMTI_CONTACT"..i.."RANGE",
        "GMTI_CONTACT"..i.."VEL_KTS",
        "GMTI_CONTACT"..i.."STRENGTH",
        "RADAR_AG_MODE_INDEX",
        "RDR_DECLUTTER_INDEX",
        "RADAR_AAAG_INDEX"
    }
    g.parent_element = TSD.root
    Add(g)
end

local RDR_SAR_RT = rawget(_G,"RDR_SAR_RT") or MASK_BOX

local SAR_VIDEO = CreateElement "ceTexPoly"
SAR_VIDEO.name = "SAR_VIDEO"
SAR_VIDEO.material = RDR_SAR_RT
SAR_VIDEO.init_pos = {0,0,0}
SAR_VIDEO.level = 2.05
SAR_VIDEO.h_clip_relation = h_clip_relations.COMPARE
vertices(SAR_VIDEO,1.8)
SAR_VIDEO.indices = {0,1,2,2,3,0}
SAR_VIDEO.element_params = {"RADAR_AAAG_INDEX","RADAR_AG_MODE_INDEX","RDR_DECLUTTER_INDEX"}
SAR_VIDEO.controllers = {{"parameter_in_range",0,1.9,2.1},{"parameter_in_range",1,1.9,4.1},{"parameter_in_range",2,0.9,2.1}}
SAR_VIDEO.parent_element = TSD.root
Add(SAR_VIDEO)

local xsea = 0.012
local ysea = 0.012
for ia=1,256 do
    local i
    if ia < 10 then i = "_0"..ia.."_" elseif ia < 100 then i = "_"..ia.."_" else i = "_"..ia.."_" end
    local s = CreateElement "ceMeshPoly"
    s.name = "SEA_RET"..i
    s.primitivetype = "triangles"
    s.vertices = {{-xsea,-ysea},{-xsea,ysea},{xsea,ysea},{xsea,-ysea}}
    s.indices = {0,1,2,0,2,3}
    s.init_pos = {0,-0.90*RS,0}
    s.material = COL_YELLOW
    s.h_clip_relation = h_clip_relations.COMPARE
    s.level = RADAR_DEFAULT_LEVEL
    s.collimated = true
    s.controllers = {
        {"move_left_right_using_parameter",1,lr_scale},
        {"move_up_down_using_parameter",2,ud_scale},
        {"parameter_in_range",5,4.9,5.1},
        {"parameter_in_range",6,0.9,2.1},
        {"parameter_in_range",7,1.9,2.1}
    }
    s.element_params = {
        "SEA_CONTACT"..i.."AZIMUTH",
        "SEA_CONTACT"..i.."RANGE",
        "SEA_CONTACT"..i.."STRENGTH",
        "SEA_CONTACT"..i.."CLASS",
        "RADAR_AG_MODE_INDEX",
        "RDR_DECLUTTER_INDEX",
        "RADAR_AAAG_INDEX"
    }
    s.parent_element = TSD.root
    Add(s)
end

-- RWR overlay: bearing-only ticks on a fixed ring (shows on DCLTR ALL/RDR)
local function add_rwr()
    for ia=1,64 do
        local i = (ia < 10) and ("_0"..ia.."_") or ("_"..ia.."_")
        local anchor = CreateElement "ceSimple"
        anchor.name = "RWR_ANCHOR"..i
        anchor.init_pos = {0,0,0}
        anchor.element_params = {"RWR_CONTACT"..i.."_AZIMUTH"}
        anchor.controllers = {{"rotate_using_parameter",0,0.0174533}}
        Add(anchor)
        local sam = CreateElement "ceMeshPoly"
        sam.name = "RWR_SAM"..i
        sam.primitivetype = "triangles"
        sam.vertices = {{0,-0.04},{-0.04,0},{0,0.04},{0.04,0}}
        sam.indices = {0,1,2,0,2,3}
        sam.init_pos = {0,0.90,0}
        sam.material = COL_RED
        sam.level = 2.25
        sam.h_clip_relation = h_clip_relations.COMPARE
        sam.element_params = {"RWR_CONTACT"..i.."_POWER","RWR_CONTACT"..i.."_SAM","RDR_DECLUTTER_INDEX"}
        sam.controllers = {{"parameter_in_range",0,0.05,10.0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.9,2.1}}
        sam.parent_element = anchor.name
        Add(sam)
        local box = CreateElement "ceMeshPoly"
        box.name = "RWR_BOX"..i
        box.primitivetype = "triangles"
        box.vertices = {{-0.03,-0.03},{-0.03,0.03},{0.03,0.03},{0.03,-0.03}}
        box.indices = {0,1,2,0,2,3}
        box.init_pos = {0,0.90,0}
        box.material = COL_YELLOW
        box.level = 2.25
        box.h_clip_relation = h_clip_relations.COMPARE
        box.element_params = {"RWR_CONTACT"..i.."_POWER","RWR_CONTACT"..i.."_SAM","RDR_DECLUTTER_INDEX","RWR_CONTACT"..i.."_enemy_contact","RWR_CONTACT"..i.."_L16_enemy_contact"}
        box.controllers = {{"parameter_in_range",0,0.05,10.0},{"parameter_in_range",1,-0.1,0.1},{"parameter_in_range",2,0.9,2.1},{"change_color_when_parameter_equal_to_number",3,1,1.0,0.0,0.0},{"change_color_when_parameter_equal_to_number",4,1,1.0,0.63,0.0}}
        box.parent_element = anchor.name
        Add(box)
        local circ = CreateElement "ceMeshPoly"
        circ.name = "RWR_CIRC"..i
        circ.primitivetype = "triangles"
        circ.vertices = {{-0.03,0},{-0.0212,0.0212},{0,0.03},{0.0212,0.0212},{0.03,0},{0.0212,-0.0212},{0,-0.03},{-0.0212,-0.0212}}
        circ.indices = {0,1,2,0,2,3,0,3,4,0,4,5,0,5,6,0,6,7}
        circ.init_pos = {0,0.90,0}
        circ.material = COL_DARKGREEN
        circ.level = 2.25
        circ.h_clip_relation = h_clip_relations.COMPARE
        circ.element_params = {"RWR_CONTACT"..i.."_POWER","RWR_CONTACT"..i.."_SAM","RDR_DECLUTTER_INDEX","RWR_CONTACT"..i.."_friendly_contact","RWR_CONTACT"..i.."_L16_friendly_contact"}
        circ.controllers = {{"parameter_in_range",0,0.05,10.0},{"parameter_in_range",1,-0.1,0.1},{"parameter_in_range",2,0.9,2.1},{"parameter_in_range",3,0.9,1.1},{"change_color_when_parameter_equal_to_number",4,1,0.47,0.78,1.0}}
        circ.parent_element = anchor.name
        Add(circ)
        local lbl = CreateElement "ceStringPoly"
        lbl.name = "RWR_LBL"..i
        lbl.material = COL_YELLOW
        lbl.stringdefs = {0.0045,0.0045,0.00035,0.0009}
        lbl.alignment = "CenterCenter"
        lbl.init_pos = {0,0.95,0}
        lbl.level = 2.25
        lbl.element_params = {"RWR_CONTACT"..i.."_CODE","RWR_CONTACT"..i.."_POWER","RDR_DECLUTTER_INDEX","RWR_CONTACT"..i.."_friendly_contact","RWR_CONTACT"..i.."_enemy_contact","RWR_CONTACT"..i.."_L16_friendly_contact","RWR_CONTACT"..i.."_L16_enemy_contact"}
        lbl.formats = {"%02.0f"}
        lbl.controllers = {{"text_using_parameter",0,0},{"parameter_in_range",1,0.05,10.0},{"parameter_in_range",2,0.9,2.1},{"change_color_when_parameter_equal_to_number",3,1,0.0,0.7,0.0},{"parameter_in_range",3,0.9,1.1},{"change_color_when_parameter_equal_to_number",5,1,1.0,0.0,0.0},{"change_color_when_parameter_equal_to_number",6,1,0.47,0.78,1.0},{"change_color_when_parameter_equal_to_number",7,1,1.0,0.63,0.0}}
        lbl.parent_element = anchor.name
        Add(lbl)
    end
end
add_rwr()

for i=1,40 do
    local r = 0.014
    local k = 0.0099
    local w = CreateElement "ceMeshPoly"
    w.name = "NAV_WP"..i.."_CIR_NAV"
    w.primitivetype = "triangles"
    w.vertices = {{-r,0},{-k,k},{0,r},{k,k},{r,0},{k,-k},{0,-r},{-k,-k}}
    w.indices = {0,1,2,0,2,3,0,3,4,0,4,5,0,5,6,0,6,7}
    w.init_pos = {0,0,0}
    w.material = NAV_COL_BLUE
    w.h_clip_relation = h_clip_relations.COMPARE
    w.level = RADAR_DEFAULT_LEVEL
    w.collimated = true
    w.element_params = {"NAV_WP_"..i.."_X_M","NAV_WP_"..i.."_Y_M","RDR_DECLUTTER_INDEX"}
    w.controllers = {{"move_left_right_using_parameter",0,lr_scale},{"move_up_down_using_parameter",1,ud_scale},{"parameter_in_range",2,2.9,3.1}}
    w.parent_element = TSD.root
    Add(w)

    local wn = CreateElement "ceStringPoly"
    wn.name = "NAV_WP"..i.."_NUM_NAV"
    wn.material = UFD_FONT
    wn.stringdefs = {0.0042,0.0042,0.00032,0.0008}
    wn.alignment = "LeftCenter"
    wn.value = tostring(i)
    wn.init_pos = {0.020,0.020,0}
    wn.element_params = {"RDR_DECLUTTER_INDEX"}
    wn.controllers = {{"parameter_in_range",0,2.9,3.1}}
    wn.parent_element = w.name
    Add(wn)
end

for t=1,32 do
    local b = CreateElement "ceMeshPoly"
    b.name = "NAV_TCN"..t.."_NAV"
    b.primitivetype = "triangles"
    b.vertices = {{-0.014,-0.014},{-0.014,0.014},{0.014,0.014},{0.014,-0.014}}
    b.indices = {0,1,2,0,2,3}
    b.init_pos = {0,0,0}
    b.material = NAV_COL_MAGENTA
    b.h_clip_relation = h_clip_relations.COMPARE
    b.level = RADAR_DEFAULT_LEVEL
    b.collimated = true
    b.element_params = {"NAV_TCN_"..t.."_X_M","NAV_TCN_"..t.."_Y_M","NAV_TCN_"..t.."_VALID","RDR_DECLUTTER_INDEX"}
    b.controllers = {{"move_left_right_using_parameter",0,lr_scale},{"move_up_down_using_parameter",1,ud_scale},{"parameter_in_range",2,0.9,1.1},{"parameter_in_range",3,2.9,3.1}}
    b.parent_element = TSD.root
    Add(b)

    local bt = CreateElement "ceStringPoly"
    bt.name = "NAV_TCN"..t.."_LBL_NAV"
    bt.material = UFD_FONT
    bt.stringdefs = {0.0042,0.0042,0.00032,0.0008}
    bt.alignment = "CenterCenter"
    bt.value = "T"
    bt.init_pos = {0,0,0}
    bt.element_params = {"RDR_DECLUTTER_INDEX","NAV_TCN_"..t.."_VALID"}
    bt.controllers = {{"parameter_in_range",0,2.9,3.1},{"parameter_in_range",1,0.9,1.1}}
    bt.parent_element = b.name
    Add(bt)
end

for t=1,64 do
    local b = CreateElement "ceMeshPoly"
    b.name = "NAV_BCN"..t.."_NAV"
    b.primitivetype = "triangles"
    b.vertices = {{-0.014,-0.014},{-0.014,0.014},{0.014,0.014},{0.014,-0.014}}
    b.indices = {0,1,2,0,2,3}
    b.init_pos = {0,0,0}
    b.material = NAV_COL_MAGENTA
    b.h_clip_relation = h_clip_relations.COMPARE
    b.level = RADAR_DEFAULT_LEVEL
    b.collimated = true
    b.element_params = {"NAV_BCN_"..t.."_X_M","NAV_BCN_"..t.."_Y_M","NAV_BCN_"..t.."_VALID","RDR_DECLUTTER_INDEX"}
    b.controllers = {{"move_left_right_using_parameter",0,lr_scale},{"move_up_down_using_parameter",1,ud_scale},{"parameter_in_range",2,0.9,1.1},{"parameter_in_range",3,2.9,3.1}}
    b.parent_element = TSD.root
    Add(b)

    local bt = CreateElement "ceStringPoly"
    bt.name = "NAV_BCN"..t.."_LBL_NAV"
    bt.material = UFD_FONT
    bt.stringdefs = {0.0042,0.0042,0.00032,0.0008}
    bt.alignment = "CenterCenter"
    bt.value = "B"
    bt.init_pos = {0,0,0}
    bt.element_params = {"RDR_DECLUTTER_INDEX","NAV_BCN_"..t.."_VALID"}
    bt.controllers = {{"parameter_in_range",0,2.9,3.1},{"parameter_in_range",1,0.9,1.1}}
    bt.parent_element = b.name
    Add(bt)
end

for k=1,39 do
    local a = CreateElement "ceSimple"
    a.name = "NAV_LEG"..k.."_ANCH_NAV"
    a.init_pos = {0,0,0}
    a.element_params = {"NAV_LEG_"..k.."_X_M","NAV_LEG_"..k.."_Y_M","NAV_LEG_"..k.."_HDG_DEG","RDR_DECLUTTER_INDEX"}
    a.controllers = {{"move_left_right_using_parameter",0,lr_scale},{"move_up_down_using_parameter",1,ud_scale},{"rotate_using_parameter",2,0.0174533},{"parameter_in_range",3,2.9,3.1}}
    a.parent_element = TSD.root
    Add(a)
    for j=1,40 do
        local d = CreateElement "ceMeshPoly"
        d.name = "NAV_LEG"..k.."_D"..j.."_NAV"
        d.primitivetype = "triangles"
        d.vertices = {{-0.006,-0.0028},{-0.006,0.0028},{0.006,0.0028},{0.006,-0.0028}}
        d.indices = {0,1,2,0,2,3}
        d.init_pos = {0,0,0}
        d.material = NAV_COL_MAGENTA
        d.level = RADAR_DEFAULT_LEVEL
        d.h_clip_relation = h_clip_relations.COMPARE
        d.element_params = {"NAV_LEG_"..k.."_STEP_M"}
        d.controllers = {{"move_up_down_using_parameter",0,ud_scale*j}}
        d.parent_element = a.name
        Add(d)
    end
end


for r=1,8 do
    local ra = CreateElement "ceSimple"
    ra.name = "RWY"..r.."_ANCH_NAV"
    ra.init_pos = {0,0,0}
    ra.element_params = {"NAV_RWY_"..r.."_X_M","NAV_RWY_"..r.."_Y_M","NAV_RWY_"..r.."_HDG_DEG","RDR_DECLUTTER_INDEX"}
    ra.controllers = {{"move_left_right_using_parameter",0,lr_scale},{"move_up_down_using_parameter",1,ud_scale},{"rotate_using_parameter",2,0.0174533},{"parameter_in_range",3,2.9,3.1}}
    ra.parent_element = TSD.root
    Add(ra)

    for j=1,64 do
        local e = CreateElement "ceMeshPoly"
        e.name = "RWY"..r.."_EDGE_L_"..j.."_NAV"
        e.primitivetype = "triangles"
        e.vertices = {{-0.012,-0.0016},{-0.012,0.0016},{0.012,0.0016},{0.012,-0.0016}}
        e.indices = {0,1,2,0,2,3}
        e.init_pos = {0,0,0}
        e.material = NAV_COL_BLUE
        e.level = 2.24
        e.h_clip_relation = h_clip_relations.COMPARE
        e.element_params = {"NAV_RWY_"..r.."_EDGE_STEP_M","NAV_RWY_"..r.."_HALF_WID_M"}
        e.controllers = {{"move_up_down_using_parameter",0,ud_scale*j},{"move_left_right_using_parameter",1,lr_scale}}
        e.parent_element = ra.name
        Add(e)

        local er = CreateElement "ceMeshPoly"
        er.name = "RWY"..r.."_EDGE_R_"..j.."_NAV"
        er.primitivetype = "triangles"
        er.vertices = {{-0.012,-0.0016},{-0.012,0.0016},{0.012,0.0016},{0.012,-0.0016}}
        er.indices = {0,1,2,0,2,3}
        er.init_pos = {0,0,0}
        er.material = NAV_COL_BLUE
        er.level = 2.24
        er.h_clip_relation = h_clip_relations.COMPARE
        er.element_params = {"NAV_RWY_"..r.."_EDGE_STEP_M","NAV_RWY_"..r.."_HALF_WID_M"}
        er.controllers = {{"move_up_down_using_parameter",0,ud_scale*j},{"move_left_right_using_parameter",1,-lr_scale}}
        er.parent_element = ra.name
        Add(er)
    end

    for j=1,48 do
        local c = CreateElement "ceMeshPoly"
        c.name = "RWY"..r.."_CL_"..j.."_NAV"
        c.primitivetype = "triangles"
        c.vertices = {{-0.006,-0.002},{-0.006,0.002},{0.006,0.002},{0.006,-0.002}}
        c.indices = {0,1,2,0,2,3}
        c.init_pos = {0,0,0}
        c.material = NAV_COL_WHITE
        c.level = 2.25
        c.h_clip_relation = h_clip_relations.COMPARE
        c.element_params = {"NAV_RWY_"..r.."_CL_STEP_M"}
        c.controllers = {{"move_up_down_using_parameter",0,ud_scale*j}}
        c.parent_element = ra.name
        Add(c)
    end

    local tbar = CreateElement "ceMeshPoly"
    tbar.name = "RWY"..r.."_T_NAV"
    tbar.primitivetype = "triangles"
    tbar.vertices = {{-0.03,-0.003},{-0.03,0.003},{0.03,0.003},{0.03,-0.003}}
    tbar.indices = {0,1,2,0,2,3}
    tbar.init_pos = {0,0,0}
    tbar.material = NAV_COL_WHITE
    tbar.level = 2.26
    tbar.h_clip_relation = h_clip_relations.COMPARE
    tbar.element_params = {"NAV_RWY_"..r.."_HALF_LEN_M","NAV_RWY_"..r.."_ACTIVE","TSD_RadarOuterRange"}
    tbar.controllers = {{"move_up_down_using_parameter",0,ud_scale},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,19.5,20.5}}
    tbar.parent_element = ra.name
    Add(tbar)
end


local NAV_INFO = CreateElement "ceStringPoly"
NAV_INFO.name = "NAV_INFO"
NAV_INFO.material = UFD_FONT
NAV_INFO.stringdefs = {0.0042,0.0042,0.00032,0.0008}
NAV_INFO.alignment = "LeftCenter"
NAV_INFO.init_pos = {-0.82,-0.70,0}
NAV_INFO.level = 2.6
NAV_INFO.element_params = {"RDR_DECLUTTER_INDEX"}
NAV_INFO.controllers = {{"parameter_in_range",0,2.9,3.1}}
NAV_INFO.value = ""
Add(NAV_INFO)

local NAV_TCN_TXT = CreateElement "ceStringPoly"
NAV_TCN_TXT.name = "NAV_TCN_TXT"
NAV_TCN_TXT.material = UFD_FONT
NAV_TCN_TXT.stringdefs = {0.0042,0.0042,0.00032,0.0008}
NAV_TCN_TXT.alignment = "LeftCenter"
NAV_TCN_TXT.formats = {"TCN %03.0f"}
NAV_TCN_TXT.element_params = {"NAV_TCN"}
NAV_TCN_TXT.controllers = {{"text_using_parameter",0,0}}
NAV_TCN_TXT.parent_element = "NAV_INFO"
NAV_TCN_TXT.init_pos = {0,0,0}
NAV_TCN_TXT.level = 2.6
Add(NAV_TCN_TXT)

local NAV_RWY_TXT = Copy(NAV_TCN_TXT)
NAV_RWY_TXT.name = "NAV_RWY_TXT"
NAV_RWY_TXT.formats = {"RWY %02.0f"}
NAV_RWY_TXT.element_params = {"NAV_ACTIVE_RWY"}
NAV_RWY_TXT.init_pos = {0,-0.04,0}
Add(NAV_RWY_TXT)

local NAV_HDG_TXT = Copy(NAV_TCN_TXT)
NAV_HDG_TXT.name = "NAV_HDG_TXT"
NAV_HDG_TXT.formats = {"HDG %03.0f"}
NAV_HDG_TXT.element_params = {"NAV_ACTIVE_HEADING"}
NAV_HDG_TXT.init_pos = {0,-0.08,0}
Add(NAV_HDG_TXT)

local NAV_WIND_TXT = Copy(NAV_TCN_TXT)
NAV_WIND_TXT.name = "NAV_WIND_TXT"
NAV_WIND_TXT.formats = {"WND %03.0f/%02.0f"}
NAV_WIND_TXT.element_params = {"NAV_WIND_DIR_DEG","NAV_WIND_SPD_KTS"}
NAV_WIND_TXT.init_pos = {0,-0.12,0}
Add(NAV_WIND_TXT)

local NAV_ALT_TXT = Copy(NAV_TCN_TXT)
NAV_ALT_TXT.name = "NAV_ALT_TXT"
NAV_ALT_TXT.formats = {"ALT %0.0fft"}
NAV_ALT_TXT.element_params = {"NAV_RWY_ALT_FT"}
NAV_ALT_TXT.init_pos = {0,-0.16,0}
Add(NAV_ALT_TXT)



local TDC_LEFT_ANCH = CreateElement "ceSimple"
TDC_LEFT_ANCH.name = "TDC_LEFT_ANCH"
TDC_LEFT_ANCH.init_pos = osb_pos(1)
Add(TDC_LEFT_ANCH)

local TDC_RNG_L = CreateElement "ceStringPoly"
TDC_RNG_L.name = "TDC_RNG_L"
TDC_RNG_L.material = UFD_FONT
TDC_RNG_L.stringdefs = {0.0042,0.0042,0.00032,0.0008}
TDC_RNG_L.alignment = "LeftCenter"
TDC_RNG_L.value = "R"
TDC_RNG_L.init_pos = {-0.06,-0.10,0}
TDC_RNG_L.parent_element = "TDC_LEFT_ANCH"
TDC_RNG_L.level = 2.6
Add(TDC_RNG_L)

local TDC_RNG_L_VAL = CreateElement "ceStringPoly"
TDC_RNG_L_VAL.name = "TDC_RNG_L_VAL"
TDC_RNG_L_VAL.material = UFD_FONT
TDC_RNG_L_VAL.stringdefs = {0.0042,0.0042,0.00032,0.0008}
TDC_RNG_L_VAL.alignment = "LeftCenter"
TDC_RNG_L_VAL.formats = {"%.0f"}
TDC_RNG_L_VAL.element_params = {"RADAR_TDC_RANGE"}
TDC_RNG_L_VAL.controllers = {{"text_using_parameter",0,0}}
TDC_RNG_L_VAL.init_pos = {-0.03,-0.10,0}
TDC_RNG_L_VAL.parent_element = "TDC_LEFT_ANCH"
TDC_RNG_L_VAL.level = 2.6
Add(TDC_RNG_L_VAL)

local TDC_ELEV_L = Copy(TDC_RNG_L)
TDC_ELEV_L.name = "TDC_ELEV_L"
TDC_ELEV_L.value = "E"
TDC_ELEV_L.init_pos = {-0.06,-0.14,0}
Add(TDC_ELEV_L)

local TDC_ELEV_L_VAL = Copy(TDC_RNG_L_VAL)
TDC_ELEV_L_VAL.name = "TDC_ELEV_L_VAL"
TDC_ELEV_L_VAL.element_params = {"RADAR_TDC_ELEVATION_DEG"}
TDC_ELEV_L_VAL.init_pos = {-0.03,-0.14,0}
Add(TDC_ELEV_L_VAL)

local SCAN_RNG_L = Copy(TDC_RNG_L)
SCAN_RNG_L.name = "SCAN_RNG_L"
SCAN_RNG_L.value = "SR"
SCAN_RNG_L.init_pos = {0.02,-0.10,0}
Add(SCAN_RNG_L)

local SCAN_RNG_L_VAL = Copy(TDC_RNG_L_VAL)
SCAN_RNG_L_VAL.name = "SCAN_RNG_L_VAL"
SCAN_RNG_L_VAL.element_params = {"RADAR_SCAN_RANGE_NM"}
SCAN_RNG_L_VAL.init_pos = {0.05,-0.10,0}
Add(SCAN_RNG_L_VAL)

local SCAN_ELEV_L = Copy(TDC_RNG_L)
SCAN_ELEV_L.name = "SCAN_ELEV_L"
SCAN_ELEV_L.value = "SE"
SCAN_ELEV_L.init_pos = {0.02,-0.14,0}
Add(SCAN_ELEV_L)

local SCAN_ELEV_L_VAL = Copy(TDC_RNG_L_VAL)
SCAN_ELEV_L_VAL.name = "SCAN_ELEV_L_VAL"
SCAN_ELEV_L_VAL.element_params = {"RADAR_SCAN_ELEV_DEG"}
SCAN_ELEV_L_VAL.init_pos = {0.05,-0.14,0}
Add(SCAN_ELEV_L_VAL)

local TDC_RIGHT_ANCH = CreateElement "ceSimple"
TDC_RIGHT_ANCH.name = "TDC_RIGHT_ANCH"
TDC_RIGHT_ANCH.init_pos = osb_pos(20)
Add(TDC_RIGHT_ANCH)

local TDC_RNG_R = Copy(TDC_RNG_L)
TDC_RNG_R.name = "TDC_RNG_R"
TDC_RNG_R.alignment = "RightCenter"
TDC_RNG_R.init_pos = {0.06,-0.10,0}
TDC_RNG_R.parent_element = "TDC_RIGHT_ANCH"
Add(TDC_RNG_R)

local TDC_RNG_R_VAL = Copy(TDC_RNG_L_VAL)
TDC_RNG_R_VAL.name = "TDC_RNG_R_VAL"
TDC_RNG_R_VAL.alignment = "RightCenter"
TDC_RNG_R_VAL.init_pos = {0.03,-0.10,0}
TDC_RNG_R_VAL.parent_element = "TDC_RIGHT_ANCH"
Add(TDC_RNG_R_VAL)

local TDC_ELEV_R = Copy(TDC_ELEV_L)
TDC_ELEV_R.name = "TDC_ELEV_R"
TDC_ELEV_R.alignment = "RightCenter"
TDC_ELEV_R.init_pos = {0.06,-0.14,0}
TDC_ELEV_R.parent_element = "TDC_RIGHT_ANCH"
Add(TDC_ELEV_R)

local TDC_ELEV_R_VAL = Copy(TDC_ELEV_L_VAL)
TDC_ELEV_R_VAL.name = "TDC_ELEV_R_VAL"
TDC_ELEV_R_VAL.alignment = "RightCenter"
TDC_ELEV_R_VAL.init_pos = {0.03,-0.14,0}
TDC_ELEV_R_VAL.parent_element = "TDC_RIGHT_ANCH"
Add(TDC_ELEV_R_VAL)

local SCAN_RNG_R = Copy(SCAN_RNG_L)
SCAN_RNG_R.name = "SCAN_RNG_R"
SCAN_RNG_R.alignment = "RightCenter"
SCAN_RNG_R.init_pos = {-0.02,-0.10,0}
SCAN_RNG_R.parent_element = "TDC_RIGHT_ANCH"
Add(SCAN_RNG_R)

local SCAN_RNG_R_VAL = Copy(SCAN_RNG_L_VAL)
SCAN_RNG_R_VAL.name = "SCAN_RNG_R_VAL"
SCAN_RNG_R_VAL.alignment = "RightCenter"
SCAN_RNG_R_VAL.init_pos = {-0.05,-0.10,0}
SCAN_RNG_R_VAL.parent_element = "TDC_RIGHT_ANCH"
Add(SCAN_RNG_R_VAL)

local SCAN_ELEV_R = Copy(SCAN_ELEV_L)
SCAN_ELEV_R.name = "SCAN_ELEV_R"
SCAN_ELEV_R.alignment = "RightCenter"
SCAN_ELEV_R.init_pos = {-0.02,-0.14,0}
SCAN_ELEV_R.parent_element = "TDC_RIGHT_ANCH"
Add(SCAN_ELEV_R)

local SCAN_ELEV_R_VAL = Copy(SCAN_ELEV_L_VAL)
SCAN_ELEV_R_VAL.name = "SCAN_ELEV_R_VAL"
SCAN_ELEV_R_VAL.alignment = "RightCenter"
SCAN_ELEV_R_VAL.init_pos = {-0.05,-0.14,0}
SCAN_ELEV_R_VAL.parent_element = "TDC_RIGHT_ANCH"
Add(SCAN_ELEV_R_VAL)

local TRK_ANCH = CreateElement "ceSimple"
TRK_ANCH.name = "TRK_ANCH"
TRK_ANCH.init_pos = {0.62,0.55,0}
Add(TRK_ANCH)

local TRK_NAME = CreateElement "ceStringPoly"
TRK_NAME.name = "TRK_NAME"
TRK_NAME.material = UFD_FONT
TRK_NAME.stringdefs = {0.0050,0.0050,0.0004,0.001}
TRK_NAME.alignment = "LeftCenter"
TRK_NAME.value = ""
TRK_NAME.init_pos = {0,0,0}
TRK_NAME.parent_element = "TRK_ANCH"
TRK_NAME.level = 2.6
Add(TRK_NAME)

local TRK_TYPE_STT = CreateElement "ceStringPoly"
TRK_TYPE_STT.name = "TRK_TYPE_STT"
TRK_TYPE_STT.material = UFD_FONT
TRK_TYPE_STT.stringdefs = {0.0042,0.0042,0.00032,0.0008}
TRK_TYPE_STT.alignment = "LeftCenter"
TRK_TYPE_STT.value = "STT"
TRK_TYPE_STT.init_pos = {0,-0.04,0}
TRK_TYPE_STT.element_params = {"SELTRK_TYPE_IDX"}
TRK_TYPE_STT.controllers = {{"parameter_in_range",0,0.9,1.1}}
TRK_TYPE_STT.parent_element = "TRK_ANCH"
TRK_TYPE_STT.level = 2.6
Add(TRK_TYPE_STT)

local TRK_TYPE_TWS = Copy(TRK_TYPE_STT)
TRK_TYPE_TWS.name = "TRK_TYPE_TWS"
TRK_TYPE_TWS.value = "TWS"
TRK_TYPE_TWS.controllers = {{"parameter_in_range",0,1.9,2.1}}
Add(TRK_TYPE_TWS)

local TRK_NUM = CreateElement "ceStringPoly"
TRK_NUM.name = "TRK_NUM"
TRK_NUM.material = UFD_FONT
TRK_NUM.stringdefs = {0.0042,0.0042,0.00032,0.0008}
TRK_NUM.alignment = "LeftCenter"
TRK_NUM.formats = {"#%02.0f"}
TRK_NUM.element_params = {"SELTRK_NUM"}
TRK_NUM.controllers = {{"text_using_parameter",0,0}}
TRK_NUM.init_pos = {0.10,-0.04,0}
TRK_NUM.parent_element = "TRK_ANCH"
TRK_NUM.level = 2.6
Add(TRK_NUM)

local TRK_ALT = Copy(TRK_NUM)
TRK_ALT.name = "TRK_ALT"
TRK_ALT.formats = {"ALT %0.0fft"}
TRK_ALT.element_params = {"SELTRK_ALT_FT"}
TRK_ALT.init_pos = {0,-0.08,0}
Add(TRK_ALT)

local TRK_RNG = Copy(TRK_NUM)
TRK_RNG.name = "TRK_RNG"
TRK_RNG.formats = {"RNG %0.1fnm"}
TRK_RNG.element_params = {"SELTRK_RANGE_NM"}
TRK_RNG.init_pos = {0.28,-0.08,0}
Add(TRK_RNG)

local TRK_VEC_HOT = Copy(TRK_TYPE_STT)
TRK_VEC_HOT.name = "TRK_VEC_HOT"
TRK_VEC_HOT.value = "HOT"
TRK_VEC_HOT.init_pos = {0,-0.12,0}
TRK_VEC_HOT.element_params = {"SELTRK_VEC_IDX"}
TRK_VEC_HOT.controllers = {{"parameter_in_range",0,0.9,1.1}}
Add(TRK_VEC_HOT)

local TRK_VEC_COLD = Copy(TRK_VEC_HOT)
TRK_VEC_COLD.name = "TRK_VEC_COLD"
TRK_VEC_COLD.value = "COLD"
TRK_VEC_COLD.controllers = {{"parameter_in_range",0,1.9,2.1}}
Add(TRK_VEC_COLD)

local TRK_VEC_FLANK = Copy(TRK_VEC_HOT)
TRK_VEC_FLANK.name = "TRK_VEC_FLANK"
TRK_VEC_FLANK.value = "FLANK"
TRK_VEC_FLANK.controllers = {{"parameter_in_range",0,2.9,3.1}}
Add(TRK_VEC_FLANK)

local TRK_THREAT_ALERT = Copy(TRK_TYPE_STT)
TRK_THREAT_ALERT.name = "TRK_THREAT_ALERT"
TRK_THREAT_ALERT.value = "ALERT"
TRK_THREAT_ALERT.init_pos = {0.14,-0.12,0}
TRK_THREAT_ALERT.element_params = {"SELTRK_THREAT_IDX"}
TRK_THREAT_ALERT.controllers = {{"parameter_in_range",0,0.9,1.1}}
Add(TRK_THREAT_ALERT)

local TRK_THREAT_HIGH = Copy(TRK_THREAT_ALERT)
TRK_THREAT_HIGH.name = "TRK_THREAT_HIGH"
TRK_THREAT_HIGH.value = "HIGH"
TRK_THREAT_HIGH.controllers = {{"parameter_in_range",0,1.9,2.1}}
Add(TRK_THREAT_HIGH)

local TRK_THREAT_MED = Copy(TRK_THREAT_ALERT)
TRK_THREAT_MED.name = "TRK_THREAT_MED"
TRK_THREAT_MED.value = "MED"
TRK_THREAT_MED.controllers = {{"parameter_in_range",0,2.9,3.1}}
Add(TRK_THREAT_MED)

local TRK_THREAT_NONE = Copy(TRK_THREAT_ALERT)
TRK_THREAT_NONE.name = "TRK_THREAT_NONE"
TRK_THREAT_NONE.value = "NONE"
TRK_THREAT_NONE.controllers = {{"parameter_in_range",0,3.9,4.1}}
Add(TRK_THREAT_NONE)
