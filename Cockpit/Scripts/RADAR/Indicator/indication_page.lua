dofile(LockOn_Options.script_path.."RADAR/Indicator/definitions.lua")


RS = RADAR_SCALE / 20
--0.00001
ud_scale 	= 0.00001 * 0.9		* RS	
lr_scale 	= 0.095	  * 0.9	* 2	* RS	
life_time 	= 5 
life_time_low = 0

local Meters_to_nm = 0.000539957


-------------------------------------------------------------





function AddRadarRangeScale(radar_range_scale_name, radar_scale_value)


--Sets Radar Scale Value 10
local radar_scale_multi = 0
local contact_scale_multi = 0
local actual_radar_scale = radar_scale_value

	if(actual_radar_scale == 80) then
		radar_scale_multi = 1.0
		contact_scale_multi = 0.165 --0.33
	elseif(actual_radar_scale == 40)then
		--radar_scale_multi = 2.0
		radar_scale_multi = 1.0
		contact_scale_multi = 0.33 --0.50
	elseif(actual_radar_scale == 20)then
		--radar_scale_multi = 1.0
		radar_scale_multi = 1.0
		contact_scale_multi = 0.66 --1.0
	elseif(actual_radar_scale == 10)then
		--radar_scale_multi = 0.5
		radar_scale_multi = 1.0
		contact_scale_multi = 1.15 --1.95
	elseif(actual_radar_scale == 5)then
		radar_scale_multi = 1.0
		contact_scale_multi = 2.30 --1.95
	end

local RSC = RS * radar_scale_multi -- RadarScaleCursor??
local udc_scale = ud_scale * contact_scale_multi --ContactScale




--------------------------------------------------------------------------------------------------------------------------
local x_size = 0.02 *1 --0.01 *2 how long
local y_size = 0.02 *2 --0.01 *2 how fat


	for ia = 1,900 do

		if ia  < 10 then
			i = "_0".. ia .."_"
		else
			i = "_".. ia .."_"
		end
		 -----------------------------------------------RADAR CONTACT SHAPE--------------------------------------------

		local	radar_contact			   		= CreateElement "ceMeshPoly"
				radar_contact.name		   		= "radar_contact" .. i .. "name"
				radar_contact.primitivetype		= "triangles"	--"lines"--
				radar_contact.vertices	   		= {		
												
													
													{-x_size, 0},
                                                    {0, y_size},                  -- diamond shape
                                                    {x_size, 0},
                                                    {0, -y_size},




											      }
				radar_contact.indices	   		=   { 0, 1, 2, 0, 2, 3 }    --{ 0,1,2,	0,2,3}
				radar_contact.init_pos	   		= {0, -1.0*RSC, 0} --position of shape, forward/back/up/down
				radar_contact.material    	 	= MFCD_ORANGE
				radar_contact.isdraw			= true
				radar_contact.isvisible			= true
				radar_contact.h_clip_relation 	= h_clip_relations.COMPARE
				radar_contact.level 			= RADAR_DEFAULT_LEVEL
				radar_contact.collimated		= false--true
				radar_contact.parent_element 	= radar_range_scale_name
				radar_contact.controllers     	= {
													
													{"move_left_right_using_parameter"	,1,lr_scale},
													{"move_up_down_using_parameter"		,2,udc_scale},
													{"parameter_in_range",40,80,400000.0},
													{"parameter_in_range",3,life_time_low,life_time},
													{"change_color_when_parameter_equal_to_number", 4, 1, 0.1,1.0,0.6}, -- war 1.0,1.0,0.0
													{"parameter_in_range",6,-1,3},
													} 
				radar_contact.element_params  	= {	
													"RADAR_CONTACT"..i.."ELEVATION",
													"RADAR_CONTACT"..i.."AZIMUTH",
													"RADAR_CONTACT"..i.."RANGE",
													"RADAR_CONTACT"..i.."TIME",
													"RADAR_CONTACT"..i.."FRIENDLY",
													"RADAR_CONTACT"..i.."RCS",
													"RADAR_MODE",
												  }
			Add(radar_contact)

	end



	------------------------------------------------------------------------------------------------------------------------------------------------------------





local x_size = 0.01 *3 --0.01 *2 how long
local y_size = 0.01 *01 --0.01 *2 how fat


	for ia = 1,900 do

		if ia  < 10 then
			i = "_0".. ia .."_"
		else
			i = "_".. ia .."_"
		end
		 -----------------------------------------------RADAR CONTACT SHAPE 2--------------------------------------------

		local	radar_contact			   		= CreateElement "ceMeshPoly"
				radar_contact.name		   		= "radar_contact" .. i .. "name"
				radar_contact.primitivetype		= "triangles"	--"lines"--
				radar_contact.vertices	   		= {		
													{-x_size , -y_size},
													{-x_size , y_size},
													{ x_size , y_size},
													{ x_size ,-y_size},	
													                                 ---------- Vertical line
													{-x_size , -y_size},
													{-x_size , y_size},
													{ x_size , y_size},
													{ x_size ,-y_size},	


													{-x_size , -y_size},
													{-x_size , y_size},
													{ x_size , y_size},
													{ x_size ,-y_size},	


											      }
				radar_contact.indices	   		= { 0,1,2,	0,2,3}
				radar_contact.init_pos	   		= { 0, -2.0*RSC, 0}
				radar_contact.material    	 	= MFCD_ORANGE
				radar_contact.isdraw			= true
				radar_contact.isvisible			= true
				radar_contact.h_clip_relation 	= h_clip_relations.COMPARE
				radar_contact.level 			= RADAR_DEFAULT_LEVEL
				radar_contact.collimated		= false--true
				radar_contact.parent_element 	= radar_range_scale_name
				radar_contact.controllers     	= {
													
													{"move_left_right_using_parameter"	,1,lr_scale},
													{"move_up_down_using_parameter"		,2,udc_scale},
													{"parameter_in_range",40,80,400000.0},
													{"parameter_in_range",3,life_time_low,life_time},
													{"change_color_when_parameter_equal_to_number", 4, 1, 0.1,1.0,0.6}, 
													{"parameter_in_range",6,-1,3},
													} 
				radar_contact.element_params  	= {	
													"RADAR_CONTACT"..i.."ELEVATION",
													"RADAR_CONTACT"..i.."AZIMUTH",
													"RADAR_CONTACT"..i.."RANGE",
													"RADAR_CONTACT"..i.."TIME",
													"RADAR_CONTACT"..i.."FRIENDLY",
													"RADAR_CONTACT"..i.."RCS",
													"RADAR_MODE",
												  }
			Add(radar_contact)

	end









----------------------------------------------------------------------------------------------------------------------------------------------------------------


local x_size = 0.007  --how wide
local y_size = 0.05   --how Long
                                         -------------RADAR BRACKET---------------------

local	radar_cursor			   		= CreateElement "ceMeshPoly"
		radar_cursor.name		   		= "radar_cursor" 
		radar_cursor.primitivetype		= "triangles"
		radar_cursor.vertices	   		= {	
											{-x_size-0.04 , -y_size},
											{-x_size-0.04 , y_size},
											{ x_size-0.04 , y_size},
											{ x_size-0.04 ,-y_size},	
											
											{-x_size+0.04 , -y_size},
											{-x_size+0.04 , y_size},
											{ x_size+0.04 , y_size},
											{ x_size+0.04 ,-y_size},	
											}
		radar_cursor.indices	   		= { 0,1,2,	0,2,3	,4,5,6,4,6,7}
		radar_cursor.init_pos	   		= {0, -2.0*RSC, 0} 
		radar_cursor.material    	 	= MFCD_ORANGE
		radar_cursor.isdraw				= true
		radar_cursor.isvisible			= true
		radar_cursor.h_clip_relation 	= h_clip_relations.COMPARE
		radar_cursor.level 				= RADAR_DEFAULT_LEVEL 
		radar_cursor.collimated			= false--true
		radar_cursor.parent_element		= radar_range_scale_name
		radar_cursor.controllers     	= {
											{"move_up_down_using_parameter"		,0, udc_scale},
											{"move_left_right_using_parameter"	,1, lr_scale},
											{"parameter_in_range",2,-0.1,2.1},
											{"parameter_in_range",3,-1,1},											
										  } 
		radar_cursor.element_params  	= {	
											"RADAR_TDC_RANGE",
											"RADAR_TDC_AZIMUTH",
											"RADAR_MODE",
											"PLM_MODE_STATE",
										  }
	Add(radar_cursor)
	
	
---------------------------------------------------TARGET LOCK SHAPE-------------------------------------------------------------------------------------------------
	
local x_size = 0.02 *2 --  how long
local y_size = 0.02 *3 --  how wide
 
 
 
local	radar_STT_backview			   		= CreateElement "ceMeshPoly"--"ceCircle"
		radar_STT_backview.name		   		= "radar_STT_backview" 
		radar_STT_backview.primitivetype	= "triangles"	--"lines"--
		radar_STT_backview.vertices	   		= {	
											
		                                            {-x_size, 0},
                                                    {0, y_size},                  -- diamond shape
                                                    {x_size, 0},
                                                    {0, -y_size},


														








											
											}
		radar_STT_backview.indices	   		= { 0, 1, 2, 0, 2, 3 }            
		radar_STT_backview.init_pos	   		= {0.0, 0.3, 0.0}
		radar_STT_backview.material    	 	= MFCD_ORANGE
		radar_STT_backview.isdraw			= true
		radar_STT_backview.isvisible		= true
	
		radar_STT_backview.h_clip_relation 	= h_clip_relations.COMPARE
		radar_STT_backview.level 			= RADAR_DEFAULT_LEVEL 
		radar_STT_backview.collimated		= true--true
		radar_STT_backview.parent_element	= radar_range_scale_name
		radar_STT_backview.controllers     	= {
												{"move_up_down_using_parameter"		,2,lr_scale},
												{"move_left_right_using_parameter"	,1,lr_scale},
												{"parameter_in_range",3,2.9,3.1},
												{"change_color_when_parameter_equal_to_number", 4, 1, 0.1,1.0,0.6},												
											  } 
		radar_STT_backview.element_params  	= {	
												"RADAR_STT_RANGE",
												"RADAR_STT_AZIMUTH",
												"RADAR_STT_ELEVATION",
												"RADAR_MODE",
												"RADAR_STT_FRIENDLY",
											  }
	Add(radar_STT_backview)



-------------------------------------------------------TARGET LOCK SHAPE 2------------------------------------------------------------------------------------------------------------------------
 x_size = 0.004 -- how wide
 y_size = 0.06	-- how long
local	radar_STT_backview			   		= CreateElement "ceMeshPoly"
		radar_STT_backview.name		   		= "radar_STT_backview" 
		radar_STT_backview.primitivetype	= "triangles"	--"lines"--
		radar_STT_backview.vertices	   		= {	
											{-x_size , -y_size},
											{-x_size , y_size},
											{ x_size , y_size},
											{ x_size ,-y_size},	
											
											--{-y_size , -x_size},
											--{-y_size , x_size},
											--{ y_size , x_size},
											--{ y_size ,-x_size},	
											
											}
		radar_STT_backview.indices	   		= { 0,1,2,	0,2,3,4,5,6,4,6,7}--{0, 1, 2, 0, 2, 3} 
		radar_STT_backview.init_pos	   		= {0.0, 0.2, 0.2}
		radar_STT_backview.material    	 	= MFCD_ORANGE--MFCD_GREEN
		radar_STT_backview.isdraw			= true
		radar_STT_backview.isvisible		= true
	
		radar_STT_backview.h_clip_relation 	= h_clip_relations.COMPARE
		radar_STT_backview.level 			= RADAR_DEFAULT_LEVEL 
		radar_STT_backview.collimated		= true
		radar_STT_backview.controllers     	= {
												{"move_up_down_using_parameter"		,2,lr_scale},
												{"move_left_right_using_parameter"	,1,lr_scale},
												{"parameter_in_range",3,2.9,3.1},	
											  } 
		radar_STT_backview.element_params  	= {	
												"RADAR_STT_RANGE",
												"RADAR_STT_AZIMUTH",
												"RADAR_STT_ELEVATION",
												"RADAR_MODE",
											  }
	Add(radar_STT_backview)













----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--                                                      STT-Lock
	local 	stt_cursor_range	 				= CreateElement "ceStringPoly"
			stt_cursor_range.name			  	= "stt_cursor_range"
			stt_cursor_range.material        	= HUD_FONT
			stt_cursor_range.init_pos		  	= {-0.1, 0.3, 0.0} 
			stt_cursor_range.stringdefs      	= txt_m_stringdefs
			stt_cursor_range.alignment       	= "RightCenter"
			stt_cursor_range.value				= "test"
			stt_cursor_range.formats		  	= {"%.0f"}
			stt_cursor_range.UseBackground		= false
			stt_cursor_range.element_params  	= {"RADAR_STT_ELEVATION", "RADAR_STT_AZIMUTH", "RADAR_MODE", "STT_RANGE_IN_NM",}
			stt_cursor_range.controllers     	= {{"text_using_parameter",3,0}, {"move_up_down_using_parameter",0, lr_scale}, {"move_left_right_using_parameter",1, lr_scale}, {"parameter_in_range",2,2.9,3.1},}
			stt_cursor_range.parent_element 	= radar_range_scale_name
			stt_cursor_range.use_mipfilter 		= true
			stt_cursor_range.collimated 		= false 
			stt_cursor_range.h_clip_relation 	= h_clip_relations.COMPARE
			stt_cursor_range.level 				= RADAR_DEFAULT_LEVEL
	Add(stt_cursor_range)		
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	

x_size = 0.004
y_size = 0.08	
	
	local 	radar_cursor_range	 				= CreateElement "ceStringPoly"
			radar_cursor_range.name			  	= "radar_cursor_range"
			radar_cursor_range.material        	= HUD_FONT
			radar_cursor_range.init_pos		  	= {-0.1, -1.7*RSC, 0} --{-0.1,0.0,0} 
			radar_cursor_range.stringdefs      	= txt_m_stringdefs
			radar_cursor_range.alignment       	= "RightCenter"
			radar_cursor_range.value			= "test"
			radar_cursor_range.formats		  	= {"%.0f"}
			radar_cursor_range.UseBackground	= false
			radar_cursor_range.element_params  	= {"RADAR_TDC_RANGE", "RADAR_TDC_AZIMUTH", "RADAR_MODE", "TDC_RANGE_IN_NM", "PLM_MODE_STATE",}
			radar_cursor_range.controllers     	= {{"text_using_parameter",3,0}, {"move_up_down_using_parameter",0, udc_scale}, {"move_left_right_using_parameter"	,1, lr_scale}, {"parameter_in_range",2,-0.1,2.1}, {"parameter_in_range", 4, -1, 1}}
			radar_cursor_range.parent_element 	= radar_range_scale_name
			radar_cursor_range.use_mipfilter 	= true
			radar_cursor_range.collimated 		= false 
			radar_cursor_range.h_clip_relation 	= h_clip_relations.COMPARE
			radar_cursor_range.level 			= RADAR_DEFAULT_LEVEL
		Add(radar_cursor_range)		
	
	
	

	local	radar_range_step					= Copy(radar_cursor_range)
			radar_range_step.name				= "radar_range_step"
			radar_range_step.init_pos			= {-0.1, -2.4*RSC, 0}
			radar_range_step.alignment			= "RightCenter"
			radar_range_step.element_params		= {"RADAR_RANGE_SCALE", "RADAR_TDC_RANGE", "RADAR_TDC_AZIMUTH", "RADAR_MODE", "PLM_MODE_STATE",}
			radar_range_step.controllers		= {{"text_using_parameter",0,0}, {"move_up_down_using_parameter",1, udc_scale}, {"move_left_right_using_parameter"	,2, lr_scale}, {"parameter_in_range",3,-0.1,2.1}, {"parameter_in_range",4,-1,1},}
		Add(radar_range_step)
	
	
	
	local	radar_elev_deg					= Copy(radar_cursor_range)
			radar_elev_deg.name				= "radar_elev_deg"
			radar_elev_deg.init_pos			= {0.3, -2.0*RSC, 0}
			radar_elev_deg.alignment		= "RightCenter"
			radar_elev_deg.element_params	= {"SCAN_ZONE_ELEVATION_DEG", "RADAR_TDC_RANGE", "RADAR_TDC_AZIMUTH", "RADAR_MODE", "PLM_MODE_STATE",}
			radar_elev_deg.controllers		= {{"text_using_parameter",0,0}, {"move_up_down_using_parameter",1, udc_scale}, {"move_left_right_using_parameter"	,2, lr_scale}, {"parameter_in_range",3,-0.1,2.1}, {"parameter_in_range",4,0-1,1},}
		Add(radar_elev_deg)
	
	
	
	
	local 	radar_bearing_L15	 				= CreateElement "ceStringPoly"
			radar_bearing_L15.name			  	= "radar_bearing_L15"
			radar_bearing_L15.material        	= HUD_FONT
			radar_bearing_L15.init_pos		  	= {-1.1*RS,3.4*RS,0}
			radar_bearing_L15.stringdefs      	= txt_m_stringdefs
			radar_bearing_L15.alignment       	= "CenterBottom"
			radar_bearing_L15.value				= "15"
			radar_bearing_L15.formats		  	= {"%.0f"}
			radar_bearing_L15.UseBackground		= false
			radar_bearing_L15.use_mipfilter 	= true
			radar_bearing_L15.collimated		= false 
			radar_bearing_L15.element_params	= {"PLM_MODE_STATE", "RADAR_MODE"}
			radar_bearing_L15.controllers		= {{"parameter_in_range",0,-1,1}, {"parameter_in_range",1,-1,3},}
			radar_bearing_L15.parent_element	= radar_range_scale_name
			radar_bearing_L15.h_clip_relation 	= h_clip_relations.COMPARE
			radar_bearing_L15.level 			= RADAR_DEFAULT_LEVEL
		Add(radar_bearing_L15)		
	
	local 	radar_bearing_R15				= Copy(radar_bearing_L15)
			radar_bearing_R15.name			= "radar_bearing_R15"
			radar_bearing_R15.init_pos		= {1.1*RS,3.4*RS,0}
		Add(radar_bearing_R15)	
		
	local 	radar_bearing_L45				= Copy(radar_bearing_L15)
			radar_bearing_L45.name			= "radar_bearing_L45"
			radar_bearing_L45.value			= "45"
			radar_bearing_L45.init_pos		= {-2.9*RS,1.15*RS,0}
		Add(radar_bearing_L45)		
	
	local 	radar_bearing_R45				= Copy(radar_bearing_L15)
			radar_bearing_R45.name			= "radar_bearing_R45"
			radar_bearing_R45.value			= "45"
			radar_bearing_R45.init_pos		= {2.9*RS,1.15*RS,0}
		Add(radar_bearing_R45)
	
	
	local 	plm_mode_symbol					= CreateElement "ceStringPoly"
			plm_mode_symbol.name			= "PLM_mode_symbol"
			plm_mode_symbol.material		= HUD_FONT
			plm_mode_symbol.init_pos		= {0.0, 3.4*RS,0} 
			plm_mode_symbol.stringdefs		= txt_m_stringdefs
			plm_mode_symbol.alignment		= "CenterBottom"
			plm_mode_symbol.value			= "PLM MODE"
			plm_mode_symbol.use_mipfilter 	= true
			plm_mode_symbol.collimated		= false 
			plm_mode_symbol.element_params	= {"PLM_MODE_STATE",}
			plm_mode_symbol.controllers		= {{"parameter_in_range",0,0,2},}
			plm_mode_symbol.parent_element	= radar_range_scale_name
			plm_mode_symbol.h_clip_relation = h_clip_relations.COMPARE
			plm_mode_symbol.level 			= RADAR_DEFAULT_LEVEL
		Add(plm_mode_symbol)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

                                      ----------------RADAR AZIMUTH LIMIT Line shape---------------------------------


	
x_size = 0.02 --0.01
y_size = 0.25  --0.15	
	
local	radar_SZ_AZIMUTH			   		= CreateElement "ceMeshPoly"
		radar_SZ_AZIMUTH.name		   		= "radar_SZ_AZIMUTH" 
		radar_SZ_AZIMUTH.primitivetype		= "triangles"	--"lines"--
		radar_SZ_AZIMUTH.vertices	   		= {	
										--{-x_size ,0},
										--{-x_size , y_size},
										--{ x_size , y_size},
										--{ x_size ,0},	
									  }
		radar_SZ_AZIMUTH.indices	   		= { 0,1,2,	0,2,3}--{0, 1, 2, 0, 2, 3} 
		radar_SZ_AZIMUTH.init_pos	   		= {0, -2.6*RS, 0} -- ALT {0, -0.85*RS, 0}
		radar_SZ_AZIMUTH.material    	 	= MFCD_ORANGE--MakeMaterial(nil,{10,10,255,150})
		radar_SZ_AZIMUTH.isdraw				= true
		radar_SZ_AZIMUTH.isvisible			= true
		radar_SZ_AZIMUTH.h_clip_relation 	= h_clip_relations.COMPARE
		radar_SZ_AZIMUTH.level 				= RADAR_DEFAULT_LEVEL 
		radar_SZ_AZIMUTH.collimated			= false--true
		radar_SZ_AZIMUTH.parent_element		= radar_range_scale_name
		--radar_SZ_AZIMUTH.parent_element	= "radar_STT"
		radar_SZ_AZIMUTH.controllers     	= {
												{"rotate_using_parameter",0,1}
											--{"parameter_in_range",0,0.9,1.1},
											--{"change_color_when_parameter_equal_to_number", 0, 1, 1.0,1.0,0.0},
											} 
		radar_SZ_AZIMUTH.element_params  	= {"SCAN_ZONE_ORIGIN_AZIMUTH",}
	Add(radar_SZ_AZIMUTH)	
	
local	radar_STT_closure_circle					= create_rad_texture(STT_CLOSING_CIRCLE, 0,0,1024,1024, 0.95)
		radar_STT_closure_circle.name				= "radar_stt_closure_circle_1"
		radar_STT_closure_circle.init_pos			= {- 0.05 * RS, 0.9 * RS, 0.0}
		radar_STT_closure_circle.parent_element		= radar_range_scale_name
		radar_STT_closure_circle.controllers		= {{"parameter_in_range", 0, 2, 4}, {"rotate_using_parameter", 1, 1},}
		radar_STT_closure_circle.element_params		= {"RADAR_MODE", "CLOSURE_CIRCLE_TURN",}
	AddRadElement(radar_STT_closure_circle)
	



local	radar_dlz_circle_1						= create_rad_texture(DLZ_CIRCLE_TEX, 0,0,1024,1024, 0.75)
		radar_dlz_circle_1.name					= "radar_dlz_circle_1"
		radar_dlz_circle_1.init_pos				= {- 0.05 * RS, 0.9 * RS, 0.0}
		radar_dlz_circle_1.parent_element		= radar_range_scale_name
		radar_dlz_circle_1.controllers			= {{"parameter_in_range", 0, 0, 2}, {"parameter_in_range", 1, 2, 4},}
		radar_dlz_circle_1.element_params		= {"DLZ_CIRCLE", "RADAR_MODE",}
	AddRadElement(radar_dlz_circle_1)

local	radar_dlz_circle_2						= create_rad_texture(DLZ_CIRCLE_TEX, 0,0,1024,1024, 0.85)
		radar_dlz_circle_2.name					= "radar_dlz_circle_2"
		radar_dlz_circle_2.init_pos				= {- 0.05 * RS, 0.9 * RS, 0.0}
		radar_dlz_circle_2.parent_element		= radar_range_scale_name
		radar_dlz_circle_2.controllers			= {{"parameter_in_range", 0, 1, 3}, {"parameter_in_range", 1, 2, 4},}
		radar_dlz_circle_2.element_params		= {"DLZ_CIRCLE", "RADAR_MODE",}
	AddRadElement(radar_dlz_circle_2)

local	radar_dlz_circle_3						= create_rad_texture(DLZ_CIRCLE_TEX, 0,0,1024,1024, 1.0)
		radar_dlz_circle_3.name					= "radar_dlz_circle_3"
		radar_dlz_circle_3.init_pos				= {- 0.05 * RS, 0.9 * RS, 0.0}
		radar_dlz_circle_3.parent_element		= radar_range_scale_name
		radar_dlz_circle_3.controllers			= {{"parameter_in_range", 0, 2, 4}, {"parameter_in_range", 1, 2, 4},}
		radar_dlz_circle_3.element_params		= {"DLZ_CIRCLE", "RADAR_MODE",}
	AddRadElement(radar_dlz_circle_3)

local	radar_dlz_circle_4						= create_rad_texture(DLZ_CIRCLE_TEX, 0,0,1024,1024, 1.17)
		radar_dlz_circle_4.name					= "radar_dlz_circle_4"
		radar_dlz_circle_4.init_pos				= {- 0.05 * RS, 0.9 * RS, 0.0}
		radar_dlz_circle_4.parent_element		= radar_range_scale_name
		radar_dlz_circle_4.controllers			= {{"parameter_in_range", 0, 3, 5}, {"parameter_in_range", 1, 2, 4},}
		radar_dlz_circle_4.element_params		= {"DLZ_CIRCLE", "RADAR_MODE",}
	AddRadElement(radar_dlz_circle_4)

local	radar_dlz_circle_5						= create_rad_texture(DLZ_CIRCLE_TEX, 0,0,1024,1024, 1.37)
		radar_dlz_circle_5.name					= "radar_dlz_circle_5"
		radar_dlz_circle_5.init_pos				= {- 0.05 * RS, 0.9 * RS, 0.0}
		radar_dlz_circle_5.parent_element		= radar_range_scale_name
		radar_dlz_circle_5.controllers			= {{"parameter_in_range", 0, 4, 6}, {"parameter_in_range", 1, 2, 4},}
		radar_dlz_circle_5.element_params		= {"DLZ_CIRCLE", "RADAR_MODE",}
	AddRadElement(radar_dlz_circle_5)


	
end

local Range_20 					= CreateElement "ceSimple"
Range_20.name  					= "Range_20_Set"
Range_20.init_pos				= {0.0, -0.30, -0.4}						
Range_20.element_params   		= {"RADAR_RANGE_SCALE", "RADAR_POWER_ON"}       
Range_20.controllers       		= {{"parameter_in_range" ,0,9,11}, {"parameter_in_range" ,1,0,2} }
Add(Range_20)

AddRadarRangeScale("Range_20_Set", 20)

local Range_40 					= CreateElement "ceSimple"
Range_40.name  					= "Range_40_Set"
Range_40.init_pos				= {0.0, -0.30, -0.4}						
Range_40.element_params   		= {"RADAR_RANGE_SCALE", "RADAR_POWER_ON"}       
Range_40.controllers       		= {{"parameter_in_range" ,0,39,41}, {"parameter_in_range" ,1,0,2} }
Add(Range_40)

AddRadarRangeScale("Range_40_Set", 40)

local Range_80 					= CreateElement "ceSimple"
Range_80.name  					= "Range_80_Set"
Range_80.init_pos				= {0.0, -0.30, -0.4}
Range_80.element_params   		= {"RADAR_RANGE_SCALE", "RADAR_POWER_ON"}        
Range_80.controllers       		= {{"parameter_in_range" ,0,79,81}, {"parameter_in_range" ,1,0,2}  }
Add(Range_80)

AddRadarRangeScale("Range_80_Set", 80)

local Range_120 					= CreateElement "ceSimple"
Range_120.name  					= "Range_120_Set"
Range_120.init_pos				= {0.0, -0.30, -0.4}							
Range_120.element_params   		= {"RADAR_RANGE_SCALE", "RADAR_POWER_ON"}        
Range_120.controllers       		= {{"parameter_in_range" ,0,119,121}, {"parameter_in_range" ,1,0,2}  }
Add(Range_120)

AddRadarRangeScale("Range_120_Set", 120)

local Range_Max 					= CreateElement "ceSimple"
Range_Max.name  					= "Range_Max_Set"
Range_Max.init_pos				= {0.0, -0.30, -0.4}								
Range_Max.element_params   		= {"RADAR_RANGE_SCALE", "RADAR_POWER_ON"}           
Range_Max.controllers       		= {{"parameter_in_range" ,0,299,301}, {"parameter_in_range" ,1,0,2}  }
Add(Range_Max)

AddRadarRangeScale("Range_Max_Set", 300)

local PLM_MODE					= CreateElement "ceSimple"
PLM_MODE.name  					= "PLM_Mode_5"
PLM_MODE.init_pos				= {0.0, -0.30, -0.4}
PLM_MODE.element_params			= {"RADAR_RANGE_SCALE", "RADAR_POWER_ON"}
PLM_MODE.controllers			= {{"parameter_in_range" ,0,4,6}, {"parameter_in_range" ,1,0,2}  }
Add(PLM_MODE)

AddRadarRangeScale("PLM_Mode_5", 5)
