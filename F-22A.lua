--[[
    Grinnelli Designs F-22A Raptor
    Copyright (C) 2024, Joseph Grinnelli
    
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    
    You should have received a copy of the GNU General Public License
    along with this program.  If not, see https://www.gnu.org/licenses.
--]]

declare_weapon({category = CAT_SHELLS, name = "M61_A2_HEI", user_name = _("20mm HEI"),
	model_name    = "tracer_bullet_yellow",
	v0    			= 1050.0,
	Dv0   			= 0.0060,
	Da0   			= 0.0015,
	Da1   			= 0.0,
	mass  			= 0.360,		--0.100,
	round_mass 		= 0.700,		--0.260,
	explosive     	= 0.360, 		--0.110, 0.0170 kg in real
	cartridge_mass 	= 0.120,		
	life_time     	= 30,
	caliber     	= 20.0,
	AP_cap_caliber 	= 20.0,			--AP rounds	
	s         		= 0.0,
	j         		= 0.0,
	l         		= 0.0,
	charTime    	= 0,
	cx        		= {0.2,1.27,0.65,0.26,2.35},
	k1        		= 2.3e-08,
	tracer_off    	= -1,
	scale_tracer  	= 0,
	scale_smoke		= 1.0,	
	cartridge 		= 0,
});

	declare_weapon({category = CAT_SHELLS, name = "M61_A2_HEIT_Y", user_name = _("20mm HEI-T"),
	model_name    = "tracer_bullet_yellow",
	v0    			= 1050.0,
	Dv0   			= 0.0060,
	Da0   			= 0.0015,
	Da1   			= 0.0,
	mass  			= 0.180,		--0.360,
	round_mass 		= 0.700,		--0.260,
	explosive     	= 0.360, 		--0.110, 0.0170 kg in real
	cartridge_mass 	= 0.120,		
	life_time     	= 30,
	caliber     	= 20.0,
	AP_cap_caliber 	= 20.0,			--AP rounds	
	s         		= 0.0,
	j         		= 0.0,
	l         		= 0.0,
	charTime    	= 0,
	cx        		= {0.2,1.27,0.65,0.26,2.35},
	k1        		= 2.3e-08,
	tracer_on     	= 0.00,
	tracer_off    	= 3,
	scale_tracer  	= 1,
	scale_smoke		= 1.0,	
	cartridge 		= 0,
});

	declare_weapon({category = CAT_SHELLS, name = "M61_A2_HEIT_R", user_name = _("20mm HEI-T"),
	model_name    = "tracer_bullet_red",
	v0    			= 1050.0,
	Dv0   			= 0.0060,
	Da0   			= 0.0015,
	Da1   			= 0.0,
	mass  			= 0.360,		--0.100,
	round_mass 		= 0.700,		--0.260,
	explosive     	= 0.360, 		--0.110, 0.0170 kg in real
	cartridge_mass 	= 0.120,		
	life_time     	= 30,
	caliber     	= 20.0,
	AP_cap_caliber 	= 20.0,			--AP rounds	
	s         		= 0.0,
	j         		= 0.0,
	l         		= 0.0,
	charTime    	= 0,
	cx        		= {0.2,1.27,0.65,0.26,2.35},
	k1        		= 2.3e-08,
	tracer_on     	= 0.000,
	tracer_off    	= 3,
	scale_tracer  	= 1,
	scale_smoke		= 1.0,	
	cartridge 		= 0,
});

declare_weapon({category = CAT_SHELLS, name = "M61_A2_SAPHEI", user_name = _("20mm SAPHEI"),
	model_name    = "tracer_bullet_yellow",
	v0    			= 1050.0,
	Dv0   			= 0.0060,
	Da0   			= 0.0015,
	Da1   			= 0.0,
	mass  			= 0.360,		--0.100,
	round_mass 		= 0.700,		--0.260,
	explosive     	= 0.360, 		--0.110, 0.0170 kg in real
	cartridge_mass 	= 0.120,		
	life_time     	= 30,
	caliber     	= 20.0,
	AP_cap_caliber 	= 30.0,			--AP rounds	
	s         		= 0.0,
	j         		= 0.0,
	l         		= 0.0,
	charTime    	= 0,
	cx        		= {0.2,1.27,0.65,0.26,2.35},
	k1        		= 2.3e-08,
	tracer_off    	= -1,
	scale_tracer  	= 0,
	scale_smoke		= 1.0,	
	cartridge 		= 0,
});

	declare_weapon({category = CAT_SHELLS, name = "M61_A2_SAPHEIT", user_name = _("20mm SAPHEI-T"),
	model_name    = "tracer_bullet_red",
	v0    			= 1050.0,
	Dv0   			= 0.0060,
	Da0   			= 0.0015,
	Da1   			= 0.0,
	mass  			= 0.360,		--0.100,
	round_mass 		= 0.700,		--0.260,
	explosive     	= 0.360, 		--0.110, 0.0170 kg in real
	cartridge_mass 	= 0.120,		
	life_time     	= 30,
	caliber     	= 20.0,
	AP_cap_caliber 	= 30.0,			--AP rounds	
	s         		= 0.0,
	j         		= 0.0,
	l         		= 0.0,
	charTime    	= 0,
	cx        		= {0.2,1.27,0.65,0.26,2.35},
	k1        		= 2.3e-08,
	tracer_on     	= 0.00,
	tracer_off    	= 3,
	scale_tracer  	= 1,
	scale_smoke		= 1.0,	
	cartridge 		= 0,
});

declare_weapon({category = CAT_SHELLS, name = "M61_A2_AP", user_name = _("20mm AP"),
	model_name    = "tracer_bullet_yellow",
	v0    			= 1050.0,
	Dv0   			= 0.0060,
	Da0   			= 0.0015,
	Da1   			= 0.0,
	mass  			= 0.360,		--0.100,
	round_mass 		= 0.700,		--0.260,
	explosive     	= 0.110, 		--0.110, 0.0170 kg in real
	cartridge_mass 	= 0.120,		
	life_time     	= 30,
	caliber     	= 20.0,
	AP_cap_caliber 	= 40.0,			--AP rounds	
	s         		= 0.0,
	j         		= 0.0,
	l         		= 0.0,
	charTime    	= 0,
	cx        		= {0.2,1.27,0.65,0.26,2.35},
	k1        		= 2.3e-08,
	tracer_off    	= -1,
	scale_tracer  	= 0,
	scale_smoke		= 1.0,	
	cartridge 		= 0,
});

declare_weapon({category = CAT_SHELLS, name = "M61_A2_PR", user_name = _("20mm TRG"),
	model_name    = "tracer_bullet_yellow",
	v0    			= 1050.0,
	Dv0   			= 0.0060,
	Da0   			= 0.0015,
	Da1   			= 0.0,
	mass  			= 0.360,		--0.100,
	round_mass 		= 0.700,		--0.260,
	explosive     	= 0.110, 		--0.110, 0.0170 kg in real
	cartridge_mass 	= 0.120,		
	explosive     	= 0.001,		--0.110, 0.0170 kg in real
	life_time     	= 30,
	caliber     	= 20.0,
	AP_cap_caliber 	= 0.0,			--AP rounds	
	s         		= 0.0,
	j         		= 0.0,
	l         		= 0.0,
	charTime    	= 0,
	cx        		= {0.2,1.27,0.65,0.26,2.35},
	k1        		= 2.3e-08,
	tracer_off    	= -1,
	scale_tracer  	= 0,
	scale_smoke		= 1.0,	
	cartridge 		= 0,
});

	declare_weapon({category = CAT_SHELLS, name = "M61_A2_PRT", user_name = _("20mm TRG-T"),
	model_name    = "tracer_bullet_yellow",
	v0    			= 1050.0,
	Dv0   			= 0.0060,
	Da0   			= 0.0015,
	Da1   			= 0.0,
	mass  			= 0.360,		--0.100,
	round_mass 		= 0.700,		--0.260,
	explosive     	= 0.001,		--0.110, 0.0170 kg in real
	cartridge_mass 	= 0.120,		
	life_time     	= 30,
	caliber     	= 20.0,
	AP_cap_caliber 	= 0.0,			--AP rounds	
	s         		= 0.0,
	j         		= 0.0,
	l         		= 0.0,
	charTime    	= 0,
	cx        		= {0.2,1.27,0.65,0.26,2.35},
	k1        		= 2.3e-08,
	tracer_on     	= 0.0,
	tracer_off    	= 3,
	scale_tracer  	= 1,
	scale_smoke		= 1.0,	
	cartridge 		= 0,
});

local function M61A2_cannon(tbl)

    tbl.category = CAT_GUN_MOUNT
    tbl.name =  "m61_a2"	
    tbl.display_name =  _("M61-A2 Cannon")
    tbl.supply      =
    {
        shells = {"M61_A2_HEI", "M61_A2_HEIT_Y", "M61_A2_HEIT_R", "M61_A2_SAPHEI", "M61_A2_SAPHEIT", "M61_A2_AP", "M61_A2_PR", "M61_A2_PRT"},
        mixes  = {{1},{2},{3},{4},{5},{6},{7},{8}},
        count  = 480, 
    }
    if tbl.mixes then
       tbl.supply.mixes = tbl.mixes
       tbl.mixes        = nil
    end
    tbl.gun =
    {
        max_burst_length    = 480,
        rates               = {6000,4000},	--Set variable rate of fire
        recoil_coeff        = 0.7*1.3,
        barrels_count       = 6,
    }
    if tbl.rates then
       tbl.gun.rates        =  tbl.rates
       tbl.rates            = nil
    end

    tbl.ejector_pos             = {0.10000, 0.500000, -0.000000}
    tbl.ejector_pos_connector   = "Gun_point"
    tbl.ejector_dir             = {0, 0, 0}
    tbl.supply_position         = {0,  0, 0}
    tbl.aft_gun_mount           = false
    tbl.effective_fire_distance = 3000
    tbl.muzzle_pos              = {0.50000, 0.500000, -0.000000}
    tbl.muzzle_pos_connector    = "Gun_point"
    tbl.azimuth_initial         = 0
    tbl.elevation_initial       = 0
    tbl.smoke_dir               = {0.50000, 0.500000, -0.000000}
    if  tbl.effects == nil then
        tbl.effects = {{ name = "FireEffect", arg = tbl.effect_arg_number or 350 },{name = "SmokeEffect", smoke_exhaust = "PNT_GUN_SMOKE" , add_speed = {10,0,0}}}
    end
    return declare_weapon(tbl)
	
end


F_22A = 
{
      
		Name 			= 'F-22A',--AG
		DisplayName		= _('F-22A'),--AG
        Picture 		= "F-22A.png",
        Rate 			= "50",
        Shape			= "F-22A",--AG	
        WorldID			=  F_22A,     
	shape_table_data 	= 
	{
		{
			file  	 	= 'F-22A';--AG
			life  	 	= 20; -- lifebar
			vis   	 	= 2; -- visibility gain.
			desrt    	= 'F-22A_destr'; -- Name of destroyed object file name
			fire  	 	= { 300, 2}; -- Fire on the ground after destoyed: 300sec 2m
			username	= 'F-22A';--AG
			index       =  F_22A;
			classname   = "lLandPlane";
			positioning = "BYNORMAL";
		},
		{
			name  		= "F-22A_destr";
			file  		= "F-22A_destr";
			fire  		= { 240, 2};
		},
	},

	Countries = {"USA","USAF Aggressors"},
	
	mapclasskey 		= "P0091000024",
	attribute  			= {wsType_Air, wsType_Airplane, wsType_Fighter, F_22A, "Fighters", "Refuelable",},--AG WSTYPE_PLACEHOLDER
	Categories= {"{78EFB7A2-FD52-4b57-A6A6-3BF0E1D6555F}", "Interceptor",},
	
		M_empty						=	19700,--19700	-- kg Updated to reflect real F-22 values
		M_nominal					=	27900,--27637	-- kg Updated to reflect real F-22 values
		M_max						=	38000,--38000	-- kg Updated to reflect real F-22 values
		M_fuel_max					=	8200,--7937		-- kg Updated to reflect real F-22 values
		H_max						=	22000,--20000	-- m  Updated to reflect real F-22 values
		average_fuel_consumption	=	0.271,
		CAS_min						=	58,		-- Minimum CAS speed (m/s) (for AI)
		V_opt						=	220,	-- Cruise speed (m/s) (for AI)
		V_take_off					=	61,		-- Take off speed in m/s (for AI)
		V_land						=	71,		-- Land speed in m/s (for AI)
		has_afteburner				=	true,
		has_speedbrake				=	true,
		radar_can_see_ground		=	true,
		
		nose_gear_pos 				                = {5.981,	-1.8,	0.0},  -- = {5.981,	-1.906,	0.0}
	    nose_gear_amortizer_direct_stroke   		=  0,      -- down from nose_gear_pos !!!
	    nose_gear_amortizer_reversal_stroke  		= -0.317,  -- up 
	    nose_gear_amortizer_normal_weight_stroke 	= -0.199,  -- down from nose_gear_pos
	    nose_gear_wheel_diameter 	                =  0.587,  -- in m
		
		main_gear_pos 						 	    = {-0.472,	-1.74,	-1.676}, --{-0.472,	-1.6,	-1.676}
		main_gear_amortizer_direct_stroke	 	    =  -0.4,     -- 
	    main_gear_amortizer_reversal_stroke  	    =  -0.2,     --  up 
	    main_gear_amortizer_normal_weight_stroke  	=  -0.2,     --  down from main_gear_pos .2
	    main_gear_wheel_diameter 				    =   0.822, --  in m 841

	
		effects_presets =   {{effect = "OVERWING_VAPOR", file = current_mod_path.."/Effects/F-22A_overwingVapor.lua"}},

		AOA_take_off				=	0.16,	-- AoA in take off (for AI)
		stores_number				=	15,
		bank_angle_max				=	60,		-- Max bank angle (for AI)
		Ny_min						=	-3,		-- Min G (for AI)
		Ny_max						=	9,		-- Max G (for AI)
		tand_gear_max				=	3.73,	--XX  FA18 3.73, 
		V_max_sea_level				=	403,	-- Max speed at sea level in m/s (for AI)
		V_max_h						=	736.11,	-- Max speed at max altitude in m/s (for AI)
		wing_area					=	56.5,	-- wing area in m2
		thrust_sum_max 				= 	56800, 	-- ~312 kN in kgf
		thrust_sum_ab 				= 	70000,  	-- ~444 kN in kgf
		Vy_max						=	275,	-- Max climb speed in m/s (for AI)
		flaps_maneuver				=	1,
		Mach_max					=	2.25,	-- Max speed in Mach (for AI)
		range						=	2540,	-- Max range in km (for AI)
		RCS							=	0.0001,   -- Radar Cross Section m2 was 0.0001
		Ny_max_e					=	8,		-- Max G (for AI)
		detection_range_max			=	800,
		IR_emission_coeff			=	0.15,	-- Normal engine -- IR_emission_coeff = 1 is Su-27 without afterburner. It is reference. was /25
		IR_emission_coeff_ab		=	0.3,		-- With afterburner
		tanker_type					=	1,		--F14=2/S33=4/M29=0/S27=0/F15=1/F16=1/To=0/F18=2/A10A=1/M29K=4/M2000=2/F4=0/F5=0/
		wing_span					=	13.05,	--XX   wing spain in m 13.05 19.54 
		wing_type 					= 	0,		-- 0=FIXED_WING/ 1=VARIABLE_GEOMETRY/ 2=FOLDED_WING/ 3=ARIABLE_GEOMETRY_FOLDED
		length						=	19.1,	--XX
		height						=	4.88,	--XX
		crew_size					=	1, 		--XX
		engines_count				=	2, 		--XX
		wing_tip_pos 				= 	{-4.366,	0.45,	6.357},-- wingtip coords for visual effects
		
		EPLRS 					    = true,--can you be seen on the A-10C TAD Page?
		TACAN_AA					= true,--I think this will not work for a client slot but AI might add a TACAN for the unit.
		brakeshute_name				= 0,
		is_tanker					= false,
		air_refuel_receptacle_pos 	= {8.319, 0.803, 1.148},
		sound_name	=	"aircraft/F-22A/Sounds",

		engines_nozzles = 
		{
			[1] = 
			{
				pos = 	{-6.901,	0.000,	-1.45},
				elevation	=	0,          -- AFB cone elevation  
				diameter	=	1.3, --1.0,          --1.072 AFB cone diameter
				exhaust_length_ab	=	12.00, --8.629 lenght in m
				exhaust_length_ab_K	=	1,  --0.76 AB animation
				smokiness_level     = 	0.01,
				afterburner_circles_count = 8,
				afterburner_circles_pos = {0.2, 0.8},
				afterburner_circles_scale = 1.3,
				afterburner_effect_texture = "F22_burner",
			},
			[2] = 
			{
				pos = 	{-6.901,	0.000,	1.45},---6.701,	-0.215,	1.524  Tribwerke
				elevation	=	0,--0
				diameter	=	1.3, --1.0,--1.072
				exhaust_length_ab	=	12.00,--8.629
				exhaust_length_ab_K	=	1,--0.76
				smokiness_level     = 	0.01, 
				afterburner_circles_count = 8,
				afterburner_circles_pos = {0.2, 0.8},
				afterburner_circles_scale = 1.3,
				afterburner_effect_texture = "F22_burner",
			},
		},
		
		crew_members = 
		{
			[1] = 
			{
				ejection_seat_name	=	17,--17=FA-18 58=F-15
				drop_canopy_name	=	"F-22A_Canopy";  --need to update this .EDM file for it to work again.
				pos = 	{6.89,	1.34,	0},
			},
		},
	
		fires_pos = 
		{
			[1] = 	{ 0.931,	0.811,	 0}, -- Body center ?
			[2] = 	{-0.132,		0.390, 	 2.576}, --Left wing fire? {-2.0,		0.8, 	 3.4},
			[3] = 	{-0.132,		0.390,	-2.576}, --Right wing fire?
			[4] = 	{-0.82,	    0.265,	 2.774},
			[5] = 	{-0.82,	    0.265,	-2.774},
			[6] = 	{-0.82,	    0.255,	 4.274},
			[7] = 	{-0.82,	    0.255,	-4.274},
			[8] = 	{-4.593,	   0.242,	 0.639}, --engine fire L
			[9] = 	{-4.593,	   0.242,	-0.639}, --engine fire R
			[10] = 	{-0.515,	0.807,	 0.7},
			[11] = 	{-0.515,	0.807,	-0.7},
		},
	
		chaff_flare_dispenser = 
		{
			[1] = 
			{
				dir = 	{-1,	-1,	1},
				pos = 	{0.548,	-0.400,	1.445}, --	{0.548,	-0.396,	1.445}, --{-1.453,	-0.206,	1.467},
			}, 
			[2] = 
			{
				dir = 	{-1,	-1,	-1},
				pos = 	{0.548,	-0.400,	-1.445}, --{-3.776,	-2.0,	0.422},
			}, 
		}, 

		passivCounterm = {
			CMDS_Edit = true,
			SingleChargeTotal = 240,

			chaff = {default = 120, increment = 1, chargeSz = 1},

			flare = {default = 120, increment = 2, chargeSz = 2}
        },
	
        CanopyGeometry 	= {
            azimuth 	= {-145.0, 145.0},-- pilot view horizontal (AI)
            elevation 	= {-50.0, 90.0}-- pilot view vertical (AI)
        },

		Sensors 		= {
		RADAR 			= "AN/APG-77",
		IRST 			= "OLS-27",
		OPTIC 			= {"TADS DTV", "TADS DVO", "TADS FLIR"},
		RWR 			= "Abstract RWR" --AN/ALR-94
		},
		Countermeasures = {
			ECM 			= "AN/ALE-52"
		},

	AddPropAircraft = {
			{id = "BAY_DOOR_OPTION", control = 'checkbox', label = _('Close WeaponBay on Cold Start'), defValue = false},

	},

	Failures = {
			{ id = 'asc', 		label = _('ASC'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'autopilot', label = _('AUTOPILOT'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'hydro',  	label = _('HYDRO'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'l_engine',  label = _('L-ENGINE'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'r_engine',  label = _('R-ENGINE'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'radar',  	label = _('RADAR'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'mlws',  	label = _('MLWS'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'rws',  		label = _('RWS'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'ecm',   	label = _('ECM'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'hud',  		label = _('HUD'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'mfd',  		label = _('MFD'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },		
	},
	HumanRadio = {
		frequency 		= 127.5,
		editable 		= true,
		minFrequency	= 100.000,
		maxFrequency 	= 156.000,
		modulation 		= MODULATION_AM
	},

	net_animation = {
					 600,--center weapons bay
					 601,--left weapons bay
					 602,--right weapons bay
					 603,--LEF
					 604,--Taxi Lights
					 605,--Landing Lights
					 606,--Form Light
					 607,--Nav White
					 608,--AntiCol
					 609,--AAR Light
					 610,--engine right clamshell
					 611,--engine left clamshell
					 612,--Nav Lights
					 613,--Nav Lights
					 614,--Canon Door
					 615,--Canon Spin
					 616,--GPU Cart Vis
					 617,--GPU Movement
					 618,--GPU Beacon
					 619,--Canopy Cycle
					 620,--Garfield Window Cling
					 621,--Visor Color
					 622,--TVN Right
					 623,--TVN Left
					},

	--Guns = {gun_mount("M_61", { count = 480 },{muzzle_pos = {0.50000, 0.500000, -0.000000}})},   --M_61 is F-15C Mounted Gun
	Guns = {
		M61A2_cannon({muzzle_pos_connector   = "GUN_POINT",
			supply_position        = {0.0000, 0.00000, 0.000000},
			ejector_pos_connector  = "GUN_EJECTOR_01",
			ejector_dir            = {2,-2,0},
			elevation_initial = 0.0,
		}),
						
		},
									
		ammo_type_default = 2,
		ammo_type ={
			_("HEI High Explosive Incendiary"),
			_("HEI-T - High Explosive Incendiary-Tracer (Yellow)"),
			_("HEI-T - High Explosive Incendiary-Tracer (Red)"),	
			_("SAPHEI - High Explosive Armor Piercing"),
			_("SAPHEI-T - High Explosive Armor Piercing-Tracer"),
			_("AP - Armor Piercing"),
			_("TP Target Practice"),
			_("TP-T - Target Practice-Tracer"),
		},
	

	pylons_enumeration = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15},
	
	Pylons = {
	
        pylon(1, 0, 0, 0, 0,
            {
				use_full_connector_position = true,		
				connector = "Pylon2",					
				DisplayName = _("EX-1"),				
            },
            {	
                { CLSID = "{F22_IRDS}",arg_value = 1,attach_point_position = {-0.401,  0.049, -1.28}},					
            }
        ),	
        pylon(2, 0, 0, 0, 0,
            {
				use_full_connector_position = true,	
				connector = "Pylon2",				
				DisplayName = _("EX-2"),			
            },
            {	
		        { CLSID = "{LAU_115_2xAIM9X-II}"  ,attach_point_position = {-0.20, 0.15, 0}, arg_increment = 0.7},
                { CLSID = "{LAU_115_2xAIM-120C-7}",attach_point_position = {-0.30, 0.14, 0}, arg_increment = 0.7},		
                { CLSID = "{LAU_115_2xAIM-120C-8}",attach_point_position = {-0.30, 0.14, 0}, arg_increment = 0.7},	
                { CLSID = "{LAU_115_2xAIM-120D-3}",attach_point_position = {-0.30, 0.14, 0}, arg_increment = 0.7},		
                { CLSID = "{LAU_115_2xAIM-260A}"  ,attach_point_position = {-0.35, 0.14, 0}, arg_increment = 0.7},					
            }
        ),			
        pylon(3, 0, 1.342000, 0.183859, -3.17000,
            {
				use_full_connector_position = true,
				connector = "Pylon2",
				DisplayName = _("EX-3"),					
				arg 	  		= 309,
				arg_increment = 1,
            },
            {
				{ CLSID = "<CLEAN>" },				
				{ CLSID = "{LDTP_FUEL_Tank}",arg_value = 1,attach_point_position = {1.36,  -0.220, 0.00},  forbidden = {	
				{ station = 2, loadout = {"{LAU_115_2xAIM9X-II}"}},		
                { station = 2, loadout = {"{LAU_115_2xAIM-120C-7}"}},	
				{ station = 2, loadout = {"{LAU_115_2xAIM-120C-8}"}},
				{ station = 2, loadout = {"{LAU_115_2xAIM-120D-3}"}},
				{ station = 2, loadout = {"{LAU_115_2xAIM-260A}"}}}},					
			    { CLSID = "{E1F29B21-F291-4589-9FD8-3272EEC69506}",arg_value = 0, attach_point_position = {0.25,  0, 0}, Cx_gain = 2.0}, --FUEL TANK CORE		
				{ CLSID = "{LAU_115_2xAIM9X-II}"   ,attach_point_position = {-0.20, -0.16, 0.0}, arg_increment = 0.7},
		        { CLSID = "{LAU_115_2xAIM-120C-7}" ,attach_point_position = {-0.30, -0.16, 0.0}, arg_increment = 0.7},
				{ CLSID = "{LAU_115_2xAIM-120C-8}" ,attach_point_position = {-0.30, -0.16, 0.0}, arg_increment = 0.7},
				{ CLSID = "{LAU_115_2xAIM-120D-3}" ,attach_point_position = {-0.30, -0.16, 0.0}, arg_increment = 0.7},
				{ CLSID = "{LAU_115_2xAIM-260A}"   ,attach_point_position = {-0.35, -0.16, 0.0}, arg_increment = 0.7},				
            }
        ),
        pylon(4, 0, -0.210, -0.9, -1.487,
            {
				use_full_connector_position = true,
				connector = "Pylon1",				
				DisplayName = _("SB-1"),				
            },
            {
			    { CLSID = "CATM-9M", attach_point_position = {0.01, 0.030, 0.0}, Cx_gain_empty = 0.0, Cx_gain_item = 0},			
				{ CLSID = "{5CE2FF2A-645A-4197-B48D-8720AC69394F}", attach_point_position = {-0.02, -0.043, 0.0}, Cx_gain_empty = 0.0, Cx_gain_item = 0}, --AIM9X
				{ CLSID = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}", attach_point_position = {-0.07, -0.038, 0.0}, Cx_gain_empty = 0.0, Cx_gain_item = 0}, --AIM9M		
				{ CLSID = "{AIM9X-BLKII}", attach_point_position = {0.14, 0.02, 0.0}, Cx_gain_empty = 0.0, Cx_gain_item = 0},
            }
        ),
        pylon(5, 1, 1.2, -0.1, -2.95,
            {
				use_full_connector_position = true,
				connector = "Pylon3",				
				DisplayName = _("MB-1"),				
            },
            {
				{ CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}", attach_point_position = {0.18, -0.10, -0.1}, Cx_gain_empty = 0.0, Cx_gain_item = 0}, --AIM_120C
			    { CLSID = "{C8E06185-7CD6-4C90-959F-044679E90751}", attach_point_position = {0.17, -0.05, -0.1}, Cx_gain_empty = 0.0, Cx_gain_item = 0}, --AIM_120B
			    { CLSID = "{AIM-120C-7}", attach_point_position = {0.18, -0.10, -0.1}, Cx_gain_empty = 0.0, Cx_gain_item = 0},
				{ CLSID = "{AIM-120C-8}", attach_point_position = {0.18, -0.10, -0.1}, Cx_gain_empty = 0.0, Cx_gain_item = 0},
				{ CLSID = "{AIM-120D-3}", attach_point_position = {0.18, -0.10, -0.1}, Cx_gain_empty = 0.0, Cx_gain_item = 0},				
				{ CLSID = "{AIM-260A}"  , attach_point_position = {0.22, -0.11, -0.1}, Cx_gain_empty = 0.0, Cx_gain_item = 0},				
            }
        ),
        pylon(6, 1, 2.649, -0.48, -0.37,
            {
				use_full_connector_position = true,
				connector = "Pylon4",				
				DisplayName = _("MB-2"),					
				arg 	  		= 311,
				arg_increment = 1,
            },
            {	
				{ CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}", attach_point_position = {0.18, -0.11, -0.09}, Cx_gain_empty = 0.0, Cx_gain_item = 0}, --AIM_120C
			    { CLSID = "{C8E06185-7CD6-4C90-959F-044679E90751}", attach_point_position = {0.17, -0.05, -0.09}, Cx_gain_empty = 0.0, Cx_gain_item = 0}, --AIM_120B
			    { CLSID = "{AIM-120C-7}", attach_point_position = {0.18, -0.11, -0.09}, Cx_gain_empty = 0.0, Cx_gain_item = 0},
				{ CLSID = "{AIM-120C-8}", attach_point_position = {0.18, -0.11, -0.09}, Cx_gain_empty = 0.0, Cx_gain_item = 0},
				{ CLSID = "{AIM-120D-3}", attach_point_position = {0.18, -0.11, -0.09}, Cx_gain_empty = 0.0, Cx_gain_item = 0},	
                { CLSID = "{AIM-260A}"  , attach_point_position = {0.22, -0.11, -0.09}, Cx_gain_empty = 0.0, Cx_gain_item = 0},		
                { CLSID = "{MAKO_A2A_C}", attach_point_position = {-0.03,-0.08, -0.20}, Type = 1, Cx_gain_empty = 0.0, Cx_gain_item = 0,  forbidden = {
				{ station = 5, loadout = {"{AIM-260A}"}},		
                { station = 5, loadout = {"{AIM-120D-3}"}},	
				{ station = 5, loadout = {"{AIM-120C-8}"}},
				{ station = 5, loadout = {"{AIM-120C-7}"}},
				{ station = 5, loadout = {"{C8E06185-7CD6-4C90-959F-044679E90751}"}},
				{ station = 5, loadout = {"{40EF17B7-F508-45de-8566-6FFECC0C1AB8}"}}}},
                { CLSID = "{MAKO_A2G_C}", attach_point_position = {-0.03,-0.08, -0.20}, Type = 1, Cx_gain_empty = 0.0, Cx_gain_item = 0,  forbidden = {
				{ station = 5, loadout = {"{AIM-260A}"}},		
                { station = 5, loadout = {"{AIM-120D-3}"}},	
				{ station = 5, loadout = {"{AIM-120C-8}"}},
				{ station = 5, loadout = {"{AIM-120C-7}"}},
				{ station = 5, loadout = {"{C8E06185-7CD6-4C90-959F-044679E90751}"}},
				{ station = 5, loadout = {"{40EF17B7-F508-45de-8566-6FFECC0C1AB8}"}}}},				
            }
        ),
        pylon(7, 1, -2.083, -0.30, -0.37,
            {
				use_full_connector_position = true,
				connector = "Pylon5",				
				DisplayName = _("MB-3"),				
				arg 	  		= 312,
				arg_increment = 1,
            },
            {
				{ CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}",	Cx_gain_empty = 0.0, Cx_gain_item = 0,  forbidden = { --AIM_120C
				{ station = 6, loadout = {"{MAKO_A2A_C}"}},	
				{ station = 6, loadout = {"{MAKO_A2G_C}"}}}},				
			    { CLSID = "{C8E06185-7CD6-4C90-959F-044679E90751}", attach_point_position = {0.17, -0.05, 0.0}, Cx_gain_empty = 0.0, Cx_gain_item = 0,  forbidden = { --AIM_120B
				{ station = 6, loadout = {"{MAKO_A2A_C}"}},	
				{ station = 6, loadout = {"{MAKO_A2G_C}"}}}},				
			    { CLSID = "{AIM-120C-7}", Cx_gain_empty = 0.0, Cx_gain_item = 0,  forbidden = {
				{ station = 6, loadout = {"{MAKO_A2A_C}"}},	
				{ station = 6, loadout = {"{MAKO_A2G_C}"}}}},					
				{ CLSID = "{AIM-120C-8}", Cx_gain_empty = 0.0, Cx_gain_item = 0,  forbidden = {
				{ station = 6, loadout = {"{MAKO_A2A_C}"}},	
				{ station = 6, loadout = {"{MAKO_A2G_C}"}}}},					
				{ CLSID = "{AIM-120D-3}", Cx_gain_empty = 0.0, Cx_gain_item = 0,  forbidden = {	
				{ station = 6, loadout = {"{MAKO_A2A_C}"}},	
				{ station = 6, loadout = {"{MAKO_A2G_C}"}}}},				
				{ CLSID = "{AIM-260A}"  , attach_point_position = {0.22, -0.11,  0.00}, Cx_gain_empty = 0.0, Cx_gain_item = 0,  forbidden = {
				{ station = 6, loadout = {"{MAKO_A2A_C}"}},	
				{ station = 6, loadout = {"{MAKO_A2G_C}"}}}},
                { CLSID = "{MAKO_A2A_C}", attach_point_position = {0.03, -0.08, -0.05}, Type = 1, Cx_gain_empty = 0.0, Cx_gain_item = 0},	
 				{ CLSID = "{MAKO_A2G_C}", attach_point_position = {0.03, -0.08, -0.05}, Type = 1, Cx_gain_empty = 0.0, Cx_gain_item = 0},	
				{ CLSID = "{GBU_32_V_2B}", attach_point_position = {0.12, -0.10, -0.13}, Type = 1, Cx_gain_empty = 0.0, Cx_gain_item = 0,  forbidden = {	
				{ station = 6, loadout = {"{40EF17B7-F508-45de-8566-6FFECC0C1AB8}"}},	
				{ station = 6, loadout = {"{C8E06185-7CD6-4C90-959F-044679E90751}"}},	
				{ station = 6, loadout = {"{AIM-120C-7}"}},	
				{ station = 6, loadout = {"{AIM-120C-8}"}},		
				{ station = 6, loadout = {"{AIM-120D-3}"}},	
				{ station = 6, loadout = {"{AIM-260A}"}},
				{ station = 6, loadout = {"{MAKO_A2A_C}"}},				
				{ station = 6, loadout = {"{MAKO_A2G_C}"}}}},	
				{ CLSID = "{4_SDB_IWB}", attach_point_position = {0.03,  0.01, -0.18}, Type = 1, Cx_gain_empty = 0.0, Cx_gain_item = 0,  forbidden = {	
				{ station = 6, loadout = {"{40EF17B7-F508-45de-8566-6FFECC0C1AB8}"}},	
				{ station = 6, loadout = {"{C8E06185-7CD6-4C90-959F-044679E90751}"}},	
				{ station = 6, loadout = {"{AIM-120C-7}"}},	
				{ station = 6, loadout = {"{AIM-120C-8}"}},		
				{ station = 6, loadout = {"{AIM-120D-3}"}},	
				{ station = 6, loadout = {"{AIM-260A}"}},
				{ station = 6, loadout = {"{MAKO_A2A_C}"}},				
				{ station = 6, loadout = {"{MAKO_A2G_C}"}}}},				
            }
        ),
        pylon(8, 1, 1.6, -0.31, 0,
            {
				use_full_connector_position = true,	
				connector = "Pylon6",				
				DisplayName = _("SMK"),				
                connector = "Pylon4"				
            },
            {
				{ CLSID	= "{A4BCC903-06C8-47bb-9937-A30FEDB4E741}" }, --Smokewinder - red
			    { CLSID	= "{A4BCC903-06C8-47bb-9937-A30FEDB4E742}" }, --Smokewinder - green
			    { CLSID	= "{A4BCC903-06C8-47bb-9937-A30FEDB4E743}" }, --Smokewinder - blue
			    { CLSID	= "{A4BCC903-06C8-47bb-9937-A30FEDB4E744}" }, --Smokewinder - white
			    { CLSID	= "{A4BCC903-06C8-47bb-9937-A30FEDB4E745}" }, --Smokewinder - yellow
            }
        ),
        pylon(9, 1, -2.083, -0.30, 0.37,
            {
				use_full_connector_position = true,
				connector = "Pylon7",				
				DisplayName = _("MB-4"),				
				arg 	  		= 312,
				arg_increment = 1,
            },
            {
				{ CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}",	Cx_gain_empty = 0.0, Cx_gain_item = 0,  forbidden = { --AIM_120C
                { station = 10, loadout = {"{MAKO_A2A_C}"}},	
				{ station = 10, loadout = {"{MAKO_A2G_C}"}}}},					
			    { CLSID = "{C8E06185-7CD6-4C90-959F-044679E90751}", attach_point_position = {0.17, -0.05, 0.0}, Cx_gain_empty = 0.0, Cx_gain_item = 0,  forbidden = { --AIM_120B
                { station = 10, loadout = {"{MAKO_A2A_C}"}},	
				{ station = 10, loadout = {"{MAKO_A2G_C}"}}}},					
			    { CLSID = "{AIM-120C-7}", Cx_gain_empty = 0.0, Cx_gain_item = 0,  forbidden = {
                { station = 10, loadout = {"{MAKO_A2A_C}"}},	
				{ station = 10, loadout = {"{MAKO_A2G_C}"}}}},					
				{ CLSID = "{AIM-120C-8}", Cx_gain_empty = 0.0, Cx_gain_item = 0,  forbidden = {
                { station = 10, loadout = {"{MAKO_A2A_C}"}},	
				{ station = 10, loadout = {"{MAKO_A2G_C}"}}}},					
				{ CLSID = "{AIM-120D-3}", Cx_gain_empty = 0.0, Cx_gain_item = 0,  forbidden = {	
                { station = 10, loadout = {"{MAKO_A2A_C}"}},	
				{ station = 10, loadout = {"{MAKO_A2G_C}"}}}},					
				{ CLSID = "{AIM-260A}"  , attach_point_position = {0.22, -0.11, 0.00}, Cx_gain_empty = 0.0, Cx_gain_item = 0,  forbidden = {
                { station = 10, loadout = {"{MAKO_A2A_C}"}},	
				{ station = 10, loadout = {"{MAKO_A2G_C}"}}}},				
                { CLSID = "{MAKO_A2A_C}", attach_point_position = {0.03, -0.08, 0.05}, Type = 1, Cx_gain_empty = 0.0, Cx_gain_item = 0},	
                { CLSID = "{MAKO_A2G_C}", attach_point_position = {0.03, -0.08, 0.05}, Type = 1, Cx_gain_empty = 0.0, Cx_gain_item = 0},					
				{ CLSID = "{GBU_32_V_2B}", attach_point_position = {0.12, -0.10, 0.13}, Type = 1, Cx_gain_empty = 0.0, Cx_gain_item = 0,  forbidden = {		
				{ station = 10, loadout = {"{40EF17B7-F508-45de-8566-6FFECC0C1AB8}"}},	
				{ station = 10, loadout = {"{C8E06185-7CD6-4C90-959F-044679E90751}"}},	
				{ station = 10, loadout = {"{AIM-120C-7}"}},	
				{ station = 10, loadout = {"{AIM-120C-8}"}},		
				{ station = 10, loadout = {"{AIM-120D-3}"}},					
				{ station = 10, loadout = {"{AIM-260A}"}},
				{ station = 10, loadout = {"{MAKO_A2A_C}"}},				
				{ station = 10, loadout = {"{MAKO_A2G_C}"}}}},			
				{ CLSID = "{4_SDB_IWB}", attach_point_position = {0.03,  0.01, 0.18}, Type = 1, Cx_gain_empty = 0.0, Cx_gain_item = 0,  forbidden = {	
				{ station = 10, loadout = {"{40EF17B7-F508-45de-8566-6FFECC0C1AB8}"}},	
				{ station = 10, loadout = {"{C8E06185-7CD6-4C90-959F-044679E90751}"}},	
				{ station = 10, loadout = {"{AIM-120C-7}"}},	
				{ station = 10, loadout = {"{AIM-120C-8}"}},		
				{ station = 10, loadout = {"{AIM-120D-3}"}},					
				{ station = 10, loadout = {"{AIM-260A}"}},
				{ station = 10, loadout = {"{MAKO_A2A_C}"}},				
				{ station = 10, loadout = {"{MAKO_A2G_C}"}}}},					
            }
        ),
        pylon(10, 1, 2.649, -0.48, 0.37,
            {
				use_full_connector_position = true,
				connector = "Pylon8",				
				DisplayName = _("MB-5"),				
				arg 	  		= 311,
				arg_increment = 1,
            },
            {
				{ CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}", attach_point_position = {0.18, -0.11, 0.09}, Cx_gain_empty = 0.0, Cx_gain_item = 0}, --AIM_120C
			    { CLSID = "{C8E06185-7CD6-4C90-959F-044679E90751}", attach_point_position = {0.17, -0.05, 0.09}, Cx_gain_empty = 0.0, Cx_gain_item = 0}, --AIM_120B
			    { CLSID = "{AIM-120C-7}", attach_point_position = {0.18, -0.11,  0.09}, Cx_gain_empty = 0.0, Cx_gain_item = 0},
				{ CLSID = "{AIM-120C-8}", attach_point_position = {0.18, -0.11,  0.09}, Cx_gain_empty = 0.0, Cx_gain_item = 0},
				{ CLSID = "{AIM-120D-3}", attach_point_position = {0.18, -0.11,  0.09}, Cx_gain_empty = 0.0, Cx_gain_item = 0},
				{ CLSID = "{AIM-260A}"  , attach_point_position = {0.22, -0.11,  0.09}, Cx_gain_empty = 0.0, Cx_gain_item = 0},		
                { CLSID = "{MAKO_A2A_C}", attach_point_position = {-0.03,-0.08,  0.20}, Type = 1, Cx_gain_empty = 0.0, Cx_gain_item = 0,  forbidden = {
				{ station = 11, loadout = {"{AIM-260A}"}},		
                { station = 11, loadout = {"{AIM-120D-3}"}},	
				{ station = 11, loadout = {"{AIM-120C-8}"}},
				{ station = 11, loadout = {"{AIM-120C-7}"}},
				{ station = 11, loadout = {"{C8E06185-7CD6-4C90-959F-044679E90751}"}},
				{ station = 11, loadout = {"{40EF17B7-F508-45de-8566-6FFECC0C1AB8}"}}}},				
				{ CLSID = "{MAKO_A2G_C}", attach_point_position = {-0.03,-0.08,  0.20}, Type = 1, Cx_gain_empty = 0.0, Cx_gain_item = 0,  forbidden = {
				{ station = 11, loadout = {"{AIM-260A}"}},		
                { station = 11, loadout = {"{AIM-120D-3}"}},	
				{ station = 11, loadout = {"{AIM-120C-8}"}},
				{ station = 11, loadout = {"{AIM-120C-7}"}},
				{ station = 11, loadout = {"{C8E06185-7CD6-4C90-959F-044679E90751}"}},
				{ station = 11, loadout = {"{40EF17B7-F508-45de-8566-6FFECC0C1AB8}"}}}},					
            }
        ),
		pylon(11, 1, 1.2, -0.1, 2.95,
            {
				use_full_connector_position = true,
				connector = "Pylon9",				
				DisplayName = _("MB-6"),				
            },
            {
			
				{ CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}", attach_point_position = {0.18, -0.10, 0.1}, Cx_gain_empty = 0.0, Cx_gain_item = 0}, --AIM_120C
			    { CLSID = "{C8E06185-7CD6-4C90-959F-044679E90751}", attach_point_position = {0.17, -0.05, 0.1}, Cx_gain_empty = 0.0, Cx_gain_item = 0}, --AIM_120B
			    { CLSID = "{AIM-120C-7}", attach_point_position = {0.18, -0.10, 0.1}, Cx_gain_empty = 0.0, Cx_gain_item = 0},					
				{ CLSID = "{AIM-120C-8}", attach_point_position = {0.18, -0.10, 0.1}, Cx_gain_empty = 0.0, Cx_gain_item = 0},					
				{ CLSID = "{AIM-120D-3}", attach_point_position = {0.18, -0.10, 0.1}, Cx_gain_empty = 0.0, Cx_gain_item = 0},
				{ CLSID = "{AIM-260A}"  , attach_point_position = {0.22, -0.11, 0.1}, Cx_gain_empty = 0.0, Cx_gain_item = 0},           				
            }
        ),
		pylon(12, 0, -0.210, -0.9, 1.487,
            {
				use_full_connector_position = true,
				connector = "Pylon11",				
				DisplayName = _("SB-2"),				
            },
            {
                { CLSID = "CATM-9M", attach_point_position = {0.01, 0.020, 0.0}, Cx_gain_empty = 0.0, Cx_gain_item = 0},							
				{ CLSID = "{5CE2FF2A-645A-4197-B48D-8720AC69394F}", attach_point_position = {-0.02, -0.047, 0.0}, Cx_gain_empty = 0.0, Cx_gain_item = 0}, --AIM9X
				{ CLSID = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}", attach_point_position = {-0.07, -0.043, 0.0}, Cx_gain_empty = 0.0, Cx_gain_item = 0}, --AIM9M		
				{ CLSID = "{AIM9X-BLKII}", attach_point_position = {0.14, 0.01, 0.0}, Cx_gain_empty = 0.0, Cx_gain_item = 0},				
            }
        ),	
		pylon(13, 0, 1.342000, 0.183859, 3.17000,
            {
				use_full_connector_position = true,
				connector = "Pylon10",				
				DisplayName = _("EX-4"),				
				arg 	  		= 317,
				arg_increment = 1,
            },
            {
				{ CLSID = "<CLEAN>" },				
				{ CLSID = "{LDTP_FUEL_Tank}",arg_value = 1,attach_point_position = {1.36,  -0.227, 0.00},  forbidden = {
				{ station = 14, loadout = {"{LAU_115_2xAIM9X-II}"}},		
                { station = 14, loadout = {"{LAU_115_2xAIM-120C-7}"}},	
				{ station = 14, loadout = {"{LAU_115_2xAIM-120C-8}"}},
				{ station = 14, loadout = {"{LAU_115_2xAIM-120D-3}"}},
				{ station = 14, loadout = {"{LAU_115_2xAIM-260A}"}}}},					
			    { CLSID = "{E1F29B21-F291-4589-9FD8-3272EEC69506}",arg_value = 0, attach_point_position = {0.25,  0, 0}, Cx_gain = 2.0}, --FUEL TANK CORE												
				{ CLSID = "{LAU_115_2xAIM9X-II}"  ,attach_point_position = {-0.20, -0.16, 0.0}, arg_increment = 0.7},
		        { CLSID = "{LAU_115_2xAIM-120C-7}",attach_point_position = {-0.30, -0.16, 0.0}, arg_increment = 0.7},
				{ CLSID = "{LAU_115_2xAIM-120C-8}",attach_point_position = {-0.30, -0.16, 0.0}, arg_increment = 0.7},
				{ CLSID = "{LAU_115_2xAIM-120D-3}",attach_point_position = {-0.30, -0.16, 0.0}, arg_increment = 0.7},
				{ CLSID = "{LAU_115_2xAIM-260A}"  ,attach_point_position = {-0.35, -0.16, 0.0}, arg_increment = 0.7},					
            }
        ),
        pylon(14, 0, 0, 0, 0,
            {
				use_full_connector_position = true,	
				connector = "Pylon10",				
				DisplayName = _("EX-5"),			
            },
            {
		        { CLSID = "{LAU_115_2xAIM9X-II}"  ,attach_point_position = {-0.20, 0.15, 0}, arg_increment = 0.7},
                { CLSID = "{LAU_115_2xAIM-120C-7}",attach_point_position = {-0.30, 0.14, 0}, arg_increment = 0.7},		
                { CLSID = "{LAU_115_2xAIM-120C-8}",attach_point_position = {-0.30, 0.14, 0}, arg_increment = 0.7},	
                { CLSID = "{LAU_115_2xAIM-120D-3}",attach_point_position = {-0.30, 0.14, 0}, arg_increment = 0.7},		
                { CLSID = "{LAU_115_2xAIM-260A}"  ,attach_point_position = {-0.35, 0.14, 0}, arg_increment = 0.7},				
            }
        ),			
        pylon(15, 0, 0, 0, 0,
            {
				use_full_connector_position = true,	
				connector = "Pylon10",				
				DisplayName = _("EX-6"),			
            },
            {
                { CLSID = "{F22_IRDS}",arg_value = 1,attach_point_position = {-0.407,  0.040, 1.28}},		
            }
        ),						
},

	Tasks = {
        aircraft_task(CAP),
     	aircraft_task(Escort),
      	aircraft_task(FighterSweep),
		aircraft_task(Intercept),
		aircraft_task(Reconnaissance),
		aircraft_task(GroundAttack),
    },	
	DefaultTask = aircraft_task(CAP),

	SFM_Data = 
		{
			aerodynamics = 
		{
			Cy0			= 0, -- zero AoA lift coefficient
			Mzalfa		= 6, -- coefficients for pitch agility --4.355
			Mzalfadt	= 0.8, -- coefficients for pitch agility
			kjx			= 2.00, --2.95-- Inertia parametre X - Dimension (clean) airframe drag coefficient at X (Top) Simply the wing area in square meters (as that is a major factor in drag calculations) - smaller = massive inertia
			kjz			= 0.00125,-- Inertia parametre Z - Dimension (clean) airframe drag coefficient at Z (Front) Simply the wing area in square meters (as that is a major factor in drag calculations)
			Czbe		= -0.016,-- coefficient, along Z axis (perpendicular), affects yaw, negative value means force orientation in FC coordinate system
			cx_gear		= 0.0268,-- coefficient, drag, gear ??
			cx_flap		= 0.06,-- coefficient, drag, full flaps -- 0.006 for first 10 degrees
			cy_flap		= 0.4,-- coefficient, normal force, lift, flaps -- 0.095 for first 10 degrees
			cx_brk		= 0.08, -- coefficient, drag speedbrake (0.04 for speedbrake, extra 0.08 to emulate the spoilers (see spoilers.lua and airbrakes.lua))   
			table_data = 
			{
			--    M 	  Cx0		 Cya		 B			 B4	   Omxmax   Aldop  Cymax
				{0.0,	0.0215,		0.055,		0.08,		0.22,	0.65,	30.0,	1.2 	},
				{0.2,	0.0215,		0.055,		0.08,		0.22,	1.80,	30.0,	1.2     },
				{0.4,	0.0215,		0.055,		0.08,	   	0.22,	3.00,	30.0,	1.2     },
				{0.6,	0.0215,		0.055,		0.05,		0.28,	4.20,	25.0,	1.2     },
				{0.7,	0.0215,		0.055,		0.05,		0.28,	4.20,	25.0,	1.15    },
				{0.8,	0.0215,		0.055,		0.05,		0.28,	4.20,	21.7,	1.1     },
				{0.9,	0.0230,		0.058,		0.09,		0.20,	4.20,	20.1,	1.07    },
				{1.0,	0.0320,		0.062,		0.17,		0.15,	4.20,	18.9,	1.04    },
				{1.1,	0.0430,		0.062,	   	0.235,		0.09,	3.78,	17.4,	1.02    },
				{1.2,	0.0460,		0.062,	   	0.285,		0.08,	2.94,	17.0,	1.00 	},		
				{1.3,	0.0470,		0.06,	   	0.29,		0.10,	2.10,	16.0,	0.92 	},				
				{1.4,	0.0470,		0.056,	   	0.3,		0.136,	1.80,	15.0,	0.80 	},					
				{1.6,	0.0470,		0.052,	   	0.34,		0.21,	1.08,	13.0,	0.7 	},					
				{1.8,	0.0460,		0.042,	   	0.34,		2.43,	0.96,	12.0,	0.55 	},		
				{2.2,	0.0420,		0.037,	   	0.49,		3.5,	0.84,	10.0,	0.37 	},					
				{2.5,	0.0420,		0.033,		0.6,		4.7,	0.84,	9.0,	0.3 	},		
				{3.9,	0.0400,		0.023,		0.9,		6.0,	0.84,	7.0,	0.2		},
			},
		},

			
			engine = 
			{
				Nmg		=	67.5,--Idle thrust RPM
				MinRUD	=	0,--Always zero for current models
				MaxRUD	=	1,--Always one for current models
				MaksRUD	=	0.85,--MIL power setting or 1 for non-afterburning
				ForsRUD	=	0.91,--Fraction of throttle position for AB start, 1 if non-afterburning
				type	=	"TurboJet",
				hMaxEng	=	19.5, -- Max altitude for safe engine operation in km
				dcx_eng	=	0.0085,--Engine drag coefficient, but the current models use either 0.0085 or 0.0144.  Take your pick.-- 0.0114
				cemax	=	1.24,-- not used for fuel calulation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
				cefor	=	2.56,-- not used for fuel calulation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
				dpdh_m	=	6000, --  altitude coefficient for max thrust
				dpdh_f	=	14000.0,  --  altitude coefficient for AB thrust
				table_data = {
				--    M		 Pmax		 Pfor
					{0.0,	 130000,	212000},-- Pmax - Engine thrust at military power - kilo Newton
					{0.2,	 130000,	200000},-- Pfor - Engine thrust at AFB
					{0.4,	 130000,	205000},
					{0.6,	 130000,	207000},
					{0.7,	 130000,	210000},
					{0.8,	 130000,	220000},
					{0.9,	 130000,	235000},
					{1.0,	 130000,	250000},
					{1.1,	 130000,	258000},
					{1.2,	 130000,	268000},
					{1.3,	 130000,	285000},
					{1.4,	 85000,		300000},
					{1.6,	 70000,		320000},
					{1.8,	 60000,		360000},
					{2.2,	 50000,		370000},
					{2.5,	 50000,		390000},
					{3.9,	 82000,		310000},
				},

			},
		},
		

	Damage = {
		-- NOSE, COCKPIT & AVIONICS
		[0]  = {critical_damage = 5, args = {146}}, 								--[[damage_cells["NOSE_CENTER"] = 0]]
		[1]  = {critical_damage = 3, args = {296}}, 								--[[damage_cells["NOSE_LEFT_SIDE"] = 1]]
		[2]  = {critical_damage = 3, args = {297}}, 								--[[damage_cells["NOSE_RIGHT_SIDE"] = 2]]
		[3]  = {critical_damage = 8, args = {65}},  								--[[damage_cells["COCKPIT"] = 3]]
		[4]  = {critical_damage = 2, args = {298}}, 								--[[damage_cells["CABIN_LEFT_SIDE"] = 4]]
		[5]  = {critical_damage = 2, args = {301}}, 								--[[damage_cells["CABIN_RIGHT_SIDE"] = 5]]
		
		[12] = {critical_damage = 1, args = {161}},
		[37] = {critical_damage = 2, args = {228}},
		[38] = {critical_damage = 2, args = {218}},
		[40] = {critical_damage = 2, args = {241}, deps_cells = {54}},
		
		[54] = {critical_damage = 2, args = {247}},
		[59] = {critical_damage = 3, args = {148}},
-----		
		
		-- CONTROL SURFACES
		[53] = {critical_damage = 2, args = {248}},	
		[25] = {critical_damage = 2, args = {226}},	
		[51] = {critical_damage = 2, args = {240}},	
		[52] = {critical_damage = 2, args = {238}},	
		[26] = {critical_damage = 2, args = {216}},	
		[21] = {critical_damage =  5, args = {232}},	
		[33] = {critical_damage =  5, args = {230}},	
		[22] = {critical_damage =  5, args = {222}},	
		[34] = {critical_damage =  5, args = {220}},	
		[19] = {critical_damage =  5, args = {183}},	
		[20] = {critical_damage =  5, args = {185}},	

		-- ENGINE & FUEL TANKS
		[11] = {critical_damage = 1, args = {167}},	

		-- FUSELAGE & WINGS
		[39] = {critical_damage = 2, args = {244}, deps_cells = {53}},								
		[41] = {critical_damage = 10, args = {245}, deps_cells = {39,53}},			
		
		[43] = {critical_damage = 2, args = {243}, deps_cells = {39, 53}},		--[43] = {critical_damage = 10, args = {246}, deps_cells = {41,88}},	
		[44] = {critical_damage = 2, args = {242}, deps_cells = {40, 54}},		--note
		
		[23] = {critical_damage = 5, args = {223}},				
		[29] = {critical_damage = 5, args = {224}, deps_cells = {23, 25}},	    
		[35] = {critical_damage = 6, args = {225}, deps_cells = {23, 29, 25, 37}},	
		[36] = {critical_damage = 6, args = {215}, deps_cells = {24, 30, 26, 38}},	
		[30] = {critical_damage = 5, args = {214}, deps_cells = {24, 26}},	    
		[24] = {critical_damage = 5, args = {213}},				
		[9]  = {critical_damage = 3, args = {154}}, 								
		[82] = {critical_damage = 2, args = {152}},								
		[10] = {critical_damage = 3, args = {153}},								
		[55] = {critical_damage = 10, args = {159}},								
		[56] = {critical_damage = 2, args = {158}},								
		[57] = {critical_damage = 2, args = {157}},								
		[58] = {critical_damage = 10, args = {156}},								

		-- LANDING GEAR
		[8]  = {critical_damage = 3, args = {265}},	
		[15] = {critical_damage = 2, args = {267}}, 	
		[16] = {critical_damage = 2, args = {266}},	
		[83] = {critical_damage = 2, args = {134}},						
		[84] = {critical_damage = 2, args = {136}},						
		[85] = {critical_damage = 2, args = {135}},						

		-- WEAPONS
		[7]  = {critical_damage = 2, args = {249}},					
			
        
	 

	},


	DamageParts = 
	{  
		[1] = "F-22A-oblomok-wing-r", -- wing R
		[2] = "F-22A-oblomok-wing-l", -- wing L
		[3] = "F-22A-oblomok-noise", -- nose
		[4] = "F-22A-oblomok-tail-r", -- tail R
		[5] = "F-22A-oblomok-tail-l", -- tail L
	},

	lights_data = {
	typename = "collection",lights = {	
					[1] = { typename = "collection", lights = {}},
					[2] = { typename = "collection", lights = {}},
					[3]	= {	typename = "collection", lights = {}},
					[4] = { typename = "collection", lights = {}},

									}
					},
}

add_aircraft(F_22A)