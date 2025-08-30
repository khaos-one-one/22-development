-----------------------------------------------------AESA RADAR SUITE FOR THE F-22A Raptor--------------------------------------------------------------------------
---------------------------------------------------  TYPE OF RADAR = AN/APG-77(v)1 AESA WIP---------------------------------------------------------------------------
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."Systems/electrical_system_api.lua")


local scale = 500000.0
TDC_range_carret_size 	= 9000 --5
render_debug_info 		= false

--------------------------------------------------RADAR COVERS FRONT SIDES AND REAR-------------------------------------------------------------

perfomance = 
{
	roll_compensation_limits	= {math.rad(-180.0), math.rad(180.0)}, -- No idea on APG77 Roll  speeds in terms of Stabilisation. 
	pitch_compensation_limits	= {math.rad(-45.0), math.rad(45.0)},   -- No idea on APG77 Pitch speeds in terms of Stabilisation. 

	tracking_azimuth   			= { -math.rad(90),math.rad (90)},      -- Tracking horizontal  90 +  90 = 180 degrees Forward and sides. 
	tracking_elevation 			= { -math.rad(60),math.rad (60)},      -- Tracking Vertical up/down  60+60 120 degrees.

	
	scan_volume_azimuth 	    = math.rad(295),                       --Horizontal. 180 for front and sides and 360 to include rear facing Scan detection.
	scan_volume_elevation	    = math.rad(160),                        --Scan Vertical. 
	scan_beam				    = math.rad(65),                        --How norrow the beam is.
	scan_speed				    = math.rad (0.025),                    --(0.025), --APG77 radar scan speed 0.025.  others 3*60
	
	
	
	
	max_available_distance  = 460000.0,                                --400km/ Meters --Detection range. cant go above 30+ miles ( solved ).
    dead_zone 				= 150,                                     --Closest detection range? 150
	
	ground_clutter =
	{   
		--spot RCS = A + B * random + C * random 

		air		   	   = {0 ,0,0},
		sea		   	   = {0 ,0,0},
		land 	   	   = {0 ,0,0},
		shore          = {0 ,0,0},
		city           = {0 ,0,0},
		road           = {0 ,0,0},
		lake           = {0 ,0,0},
		railway        = {0 ,0,0},
		
	    airfield       = {0 ,0,0},
		artificial 	   = {0 ,0,0},
		rays_density   = 0.01,
		max_distance   = 460000.0,
	}
	
}


------------------------------------------------------------------------------

dev 	    	= GetSelf()
DEBUG_ACTIVE 	= false



update_time_step 	= 0.01		--0.166 --once every 6 times a sec
device_timer_dt		= 0.01

make_default_activity(update_time_step) 



Radar = 	{
				mode_h 		    = get_param_handle("RADAR_MODE"),
				szoe_h 		    = get_param_handle("SCAN_ZONE_ORIGIN_ELEVATION"),
				szoa_h 		    = get_param_handle("SCAN_ZONE_ORIGIN_AZIMUTH"),
				
				opt_pb_stab_h 	= get_param_handle("RADAR_PITCH_BANK_STABILIZATION"),
				opt_bank_stab_h = get_param_handle("RADAR_BANK_STABILIZATION"),
				opt_pitch_stab_h= get_param_handle("RADAR_PITCH_STABILIZATION"),
				
				
				tdc_azi_h 		= get_param_handle("RADAR_TDC_AZIMUTH"),
				tdc_range_h 	= get_param_handle("RADAR_TDC_RANGE"),
				tdc_closet_h	= get_param_handle("CLOSEST_RANGE_RESPONSE"),
				
				tdc_rcsize_h	= get_param_handle("RADAR_TDC_RANGE_CARRET_SIZE"),
				tdc_acqzone_h   = get_param_handle("ACQUSITION_ZONE_VOLUME_AZIMUTH"),
				

				
				stt_azimuth_h 	        = get_param_handle("RADAR_STT_AZIMUTH"),
				stt_elevation_h         = get_param_handle("RADAR_STT_ELEVATION"),
				
				sz_azimuth_h 	        = get_param_handle("SCAN_ZONE_ORIGIN_AZIMUTH"),
				sz_elevation_h 	        = get_param_handle("SCAN_ZONE_ORIGIN_ELEVATION"),
				
				tdc_ele_up_h 	        = get_param_handle("RADAR_TDC_ELEVATION_AT_RANGE_UPPER"),
				tdc_ele_down_h        	= get_param_handle("RADAR_TDC_ELEVATION_AT_RANGE_LOWER"),
				
				ws_ir_slave_azimuth_h	= get_param_handle("WS_IR_MISSILE_SEEKER_DESIRED_AZIMUTH"),
				ws_ir_slave_elevation_h	= get_param_handle("WS_IR_MISSILE_SEEKER_DESIRED_ELEVATION"),
				
				iff_status_h			= get_param_handle("IFF_INTERROGATOR_STATUS"),
				bit_h 					= get_param_handle("RADAR_BIT"),
				BATTERY 		        = get_param_handle("BATTERY"),
----------------------------------------------------------------------------------
			    roll                    = get_param_handle("RADAR_ROLL"),
	            pitch                   = get_param_handle("RADAR_PITCH"),

	            range                   = get_param_handle("RADAR_RANGE"),
	            closure                 = get_param_handle("RADAR_CLOSURE"),

}
power_bus_handle = "MAIN_POWER"
function post_initialize()

        GetDevice(devices.RADAR):set_power(true)
		render_debug_info = false
		--print_message_to_user("RADAR Init")
		
		

		
		dev:listen_command(88)		--iCommandPlaneRadarLeft
		dev:listen_command(89)		--iCommandPlaneRadarRight
		dev:listen_command(90)		--iCommandPlaneRadarUp
		dev:listen_command(91)		--iCommandPlaneRadarDown
		-------------
		
		dev:listen_command(100)		--iCommandPlaneChangeLock
		
		dev:listen_command(139)		--scanzone left // iCommandSelecterLeft
		dev:listen_command(140)		--scanzone right // iCommandSelecterRight
		
		dev:listen_command(141)		--scanzone up//iCommandSelecterUp
		dev:listen_command(142)		--scanzone down//iCommandSelecterDown
		
		dev:listen_command(394)		--change PRF (radar puls freqency)//iCommandPlaneChangeRadarPRF
	
		dev:listen_command(509)		--lock start//iCommandPlane_LockOn_start
		dev:listen_command(510)		--lock finish//iCommandPlane_LockOn_finish
		
		dev:listen_command(285)		--Change radar mode RWS/TWS //iCommandPlaneRadarChangeMode
		
		dev:listen_command(2025)	--iCommandPlaneRadarHorizontal
		dev:listen_command(2026)	--iCommandPlaneRadarVertical
		dev:listen_command(2031)	--iCommandPlaneSelecterHorizontal
		dev:listen_command(2032)	--iCommandPlaneSelecterVertical
		
		dev:listen_command(262)		--iCommandDecreaseRadarScanArea
		dev:listen_command(263)		--iCommandIncreaseRadarScanArea
		
		dev:listen_command(5061)	--Keys.radar_plm_mode_toggle
		
		dev:listen_command(5062)	--Keys.iff_ident_spring_switch
		dev:listen_command(5068)	--Keys.iff_ident_system_mode_cw
		dev:listen_command(5069)	--Keys.iff_ident_system_mode_ccw
		dev:listen_command(5070)	--Keys.iff_mode_off
		dev:listen_command(5071)	--Keys.iff_mode_stdby
		dev:listen_command(5072)	--Keys.iff_mode_low
		dev:listen_command(5073)	--Keys.iff_mode_norm
		dev:listen_command(5074)	--Keys.iff_mode_emergency
		
		

		Radar.opt_pb_stab_h:set(1)
		Radar.opt_pitch_stab_h:set(1)
		Radar.opt_bank_stab_h:set(1)
		

	
end


local p_declutter = get_param_handle("RDR_DECLUTTER_INDEX")
local p_aaag      = get_param_handle("RADAR_AAAG_INDEX")
local p_rng_idx   = get_param_handle("RADAR_RANGE_INDEX")
local rng_steps   = {20,40,80,120,300}

if (p_declutter:get() or 0) == 0 then p_declutter:set(1) end
if (p_aaag:get() or 0) == 0 then p_aaag:set(1) end
if (p_rng_idx:get() or 0) == 0 then p_rng_idx:set(1) end

	local function step_range(delta)
		local i = p_rng_idx:get()
		i = i + delta
		if i < 1 then i = #rng_steps elseif i > #rng_steps then i = 1 end
		p_rng_idx:set(i)
		local nm = rng_steps[i]
		get_param_handle("TSD_RadarOuterRange"):set(nm)
		get_param_handle("RADAR_RANGE_NM"):set(nm)
		-- rings redraw is handled in page load; if you implement a page-rebuild signal, fire it here
	end

function SetCommand(cmd, val)
    if cmd == device_commands.RDR_RANGE_UP then
        step_range(+1)
    elseif cmd == device_commands.RDR_RANGE_DOWN then
        step_range(-1)
    elseif cmd == device_commands.RDR_DECLUTTER_CYCLE then
        local v = p_declutter:get() + 1
        if v > 3 then v = 1 end
        p_declutter:set(v)
    elseif cmd == device_commands.RDR_MODE_TOGGLE then
        local v = p_aaag:get()
        p_aaag:set(v == 1 and 2 or 1)
    end
end


---------------------------------------------------------------------
function SetCommand(command,value)
	--print_message_to_user(string.format("Radar SetCom: C %i   V%.8f",command,value))	
	if command == 141 and value == 0.0 then
		Radar.sz_elevation_h:set(Radar.sz_elevation_h:get() + 0.6)
	elseif command == 142 and value == 0.0 then
		Radar.sz_elevation_h:set(Radar.sz_elevation_h:get() - 0.6)
	end
	
	if command == 139 and value == 0.0 then
		Radar.sz_azimuth_h:set(Radar.sz_azimuth_h:get() + 0.6)
	elseif command == 140 and value == 0.0 then
		Radar.sz_azimuth_h:set(Radar.sz_azimuth_h:get() - 0.6)
	end
	
----------------------------------------------------------------------	
	
	if Radar.tdc_range_h:get() > scale*100 then
		Radar.tdc_range_h:set(scale*100)
	elseif Radar.tdc_range_h:get() < 0 then
		Radar.tdc_range_h:set(0)
	end
		
	if Radar.tdc_azi_h:get() > 0.5 then
		Radar.tdc_azi_h:set(0.5)
	elseif Radar.tdc_azi_h:get() < -0.5 then
		Radar.tdc_azi_h:set(-0.5)
	end
	
-------------------------------------------------
	
	if command == 2032  then
			Radar.tdc_range_h:set(Radar.tdc_range_h:get()- value*100000)
		
	end
	
	if command == 2031  then
			Radar.tdc_azi_h:set(Radar.tdc_azi_h:get()+ value*10)
	
	end

-------------------------------------------------	
	
	
	
end


function update()
	range_scale 		  	= scale
	Sensor_Data_Raw = get_base_data()
	--print_message_to_user(parameters.RADAR_MODE:get())
--print_message_to_user(electric_system:get_AC_Bus_1_voltage())

	
	Radar.tdc_ele_up_h:set(((Sensor_Data_Raw.getBarometricAltitude() + math.tan(Radar.sz_elevation_h:get() + (perfomance.scan_volume_elevation/2)  ) * Radar.tdc_range_h:get())))
	Radar.tdc_ele_down_h:set(((Sensor_Data_Raw.getBarometricAltitude() + math.tan(Radar.sz_elevation_h:get() - (perfomance.scan_volume_elevation/2)  ) * Radar.tdc_range_h:get())))
	
	
	
end


need_to_be_closed = false