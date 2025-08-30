dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."Systems/electrical_system_api.lua")
dofile(LockOn_Options.script_path.."utils.lua")

local update_time_step = 0.02  --每秒50次刷新
local sensor_data = get_base_data()
make_default_activity(update_time_step)
local terrain = require('terrain')
--[[
local tablePrinted = {}
local pr=0
local file = io.open("e:\\00_00_00_海外组_学习\\test.txt", "w")
assert(file)
function printTableItem(k, v, level)
    for i = 1, level do
        file:write("\t")
    end
    file:write(tostring(k) .. " = " .. tostring(v) .. "\r\n")
    if type(v) == "table" then
        if not tablePrinted[v] then
            tablePrinted[v] = true
            for k, v in pairs(v) do
                printTableItem(k, v, level + 1)
            end
        end
    end
end

--]]

local towns = get_terrain_related_data('towns')

local dev = GetSelf()
dev:listen_command(Keys.PlaneZoomIn)
dev:listen_command(Keys.PlaneZoomOut)
local params_h = {
    maxRange = {get_param_handle('MAX_RANGE'),40},
    HSI_SCALE_UP = {get_param_handle('HSI_SCALE_UP'),0},
    HSI_SCALE_DN = {get_param_handle('HSI_SCALE_DN'),0},
    HSI_MAP = {get_param_handle('HSI_MAP'),0},
    HDG_TYPE = {get_param_handle('HDG_TYPE'),0},
    GPS_LAT = {get_param_handle('GPS_LAT'),'N00-00-00.00'},
    GPS_LON = {get_param_handle('GPS_LON'),'E000-00-00.00'},
    GPS_ALT = {get_param_handle('GPS_ALT'),0},
    GPS_LAT_M = {get_param_handle('GPS_LAT_M'),0},
    GPS_LON_M = {get_param_handle('GPS_LON_M'),0},
    GPS_LAT_M_SC = {get_param_handle('GPS_LAT_M_SC'),0},
    GPS_LON_M_SC = {get_param_handle('GPS_LON_M_SC'),0},
}
local ATKMode_h = get_param_handle('ATK_MODE')
WPT_POS = {}
local c = 0
local function updateGPS()
    local pos_x_loc, alt, pos_y_loc= sensor_data.getSelfCoordinates()
    local coord = lo_to_geo_coords(pos_x_loc, pos_y_loc)
    local lat_m,lon_m = terrain.convertLatLonToMeters(coord.lat,coord.lon)
    local scale = 40/params_h.maxRange[2]
    params_h.GPS_LAT_M_SC[2] = lat_m*scale
    params_h.GPS_LON_M_SC[2] = lon_m*scale
    params_h.GPS_LAT_M[2] = lat_m
    params_h.GPS_LON_M[2] = lon_m
    -- temp_dbg:set(coord.lat)
    params_h.GPS_LAT[2]=DD_to_DMS(coord.lat,1)
    params_h.GPS_LON[2]=DD_to_DMS(coord.lon,2)
    params_h.GPS_ALT[2]=alt
end

function post_initialize()
    local pos_x_loc, alt, pos_y_loc= sensor_data.getSelfCoordinates()
    local coord = lo_to_geo_coords(pos_x_loc, pos_y_loc)
    local lat_m,lon_m = terrain.convertLatLonToMeters(42.530195,43.150121)
    local height = terrain.GetHeight(lat_m,lon_m)
    --DebugPrint(height)
    --printTableItem('test',{lat={lat,DD_to_DMS(lat,1)},lon={lon,DD_to_DMS(lon,2)},},0)
end

function SetCommand(command,value)
	if command == MFD_click_cmd.HSI_SCALE_DN then
        params_h.HSI_SCALE_DN[2] = value
        if value == 1 then
            params_h.maxRange[2] = Limit(params_h.maxRange[2]*0.5,5,320)
        end
    elseif command == MFD_click_cmd.HSI_SCALE_UP then
        params_h.HSI_SCALE_UP[2] = value
        if value == 1 then
            params_h.maxRange[2] = Limit(params_h.maxRange[2]*2,5,320)
        end
    elseif command == MFD_click_cmd.HSI_MAP and value == 1 then
        params_h.HSI_MAP[2] = 1 - params_h.HSI_MAP[2]
    elseif command == MFD_click_cmd.HSI_HDG_MODE and value == 1 then
        params_h.HDG_TYPE[2] = 1 - params_h.HDG_TYPE[2]
    elseif command == Keys.PlaneZoomIn and ATKMode_h:get()~=2 then
        dev:performClickableAction(MFD_click_cmd.HSI_SCALE_DN,1)
        dev:performClickableAction(MFD_click_cmd.HSI_SCALE_DN,0)
    elseif command == Keys.PlaneZoomOut and ATKMode_h:get()~=2 then
        dev:performClickableAction(MFD_click_cmd.HSI_SCALE_UP,1)
        dev:performClickableAction(MFD_click_cmd.HSI_SCALE_UP,0)
    end
end

function update()
    updateGPS()
	for k, v in pairs(params_h) do
        v[1]:set(v[2])
    end
end

need_to_be_closed = false
