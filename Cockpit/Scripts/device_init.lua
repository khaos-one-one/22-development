-- Scripts/device_init.lua
mount_vfs_texture_archives("Bazar/Textures/AvionicsCommon")
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.common_script_path.."tools.lua")
dofile(LockOn_Options.script_path.."materials.lua") 

layoutGeometry = {}

MainPanel = {"ccMainPanel", LockOn_Options.script_path.."mainpanel_init.lua"}

attributes = {
  --  "support_for_cws",
}

creators = {}
creators[devices.AVIONICS]          = {"avLuaDevice", LockOn_Options.script_path.."Systems/Avionics.lua"}
creators[devices.ELECTRICAL_SYSTEM] = {"avSimpleElectricSystem", LockOn_Options.script_path.."Systems/ELECTRICAL_SYSTEM.lua"}
creators[devices.LIGHTING_SYSTEM] 	= {"avLuaDevice", LockOn_Options.script_path.."Systems/Lighting_System.lua"}
creators[devices.ENGINE_SYSTEM]     = {"avLuaDevice", LockOn_Options.script_path.."Systems/Engine_System.lua"}
creators[devices.WEAPON_SYSTEM]     = {"avSimpleWeaponSystem", LockOn_Options.script_path.."Systems/Weapon_System.lua"}
creators[devices.ECMS]     = {"avSimpleWeaponSystem", LockOn_Options.script_path.."Systems/ECMS.lua"}
--creators[devices.WEAPON_SYSTEM] 	= {"avSimplestWeaponSystem", LockOn_Options.script_path .."Systems/weapon_system.lua"}
creators[devices.MFD_SYSTEM]        = {"avLuaDevice", LockOn_Options.script_path.."Systems/MFD_System.lua"}
creators[devices.PMFD_SYSTEM]       = {"avLuaDevice", LockOn_Options.script_path.."Systems/PMFD_System.lua"}
creators[devices.ICP_SYSTEM]        = {"avLuaDevice", LockOn_Options.script_path.."Systems/ICP_System.lua"}
--creators[devices.NAVIGATION]        = {"avLuaDevice", LockOn_Options.script_path.."Systems/Navigation.lua"}
creators[devices.HUD]        		= {"avLuaDevice", LockOn_Options.script_path.."HUD/Device/Device.lua"}
creators[devices.HMD]             	= {"avLuaDevice",LockOn_Options.script_path.."HMD/Device/device.lua"}
creators[devices.RWR]				= {"avSimpleRWR",LockOn_Options.script_path.."RWR/Device/RWR_init.lua"}
creators[devices.RADAR]				= {"avSimpleRadar",LockOn_Options.script_path.."RADAR/Device/Radar_init.lua"}
creators[devices.CANOPY]          = {"avLuaDevice"           ,LockOn_Options.script_path.."Systems/canopy.lua"}
--creators[devices.FLIR]		        = {"LR::avSimplestFLIR"    ,LockOn_Options.script_path.."FLIR/device.lua"}



indicators = {}
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."UFD_LEFT/init.lua",
    nil,
    {
        {"LEFT-PFD-CENTER", "LEFT-PFD-DOWN", "LEFT-PFD-RIGHT"}
    }
}
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."UFD_RIGHT/init.lua",
    nil,
    {
        {"RIGHT-PFD-CENTER", "RIGHT-PFD-DOWN", "RIGHT-PFD-RIGHT"}
    }
}
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."ICP/init.lua",
    nil,
    {
        {"ICP_DISPLAY_CENTER", "ICP_DISPLAY_BOTTOM", "ICP_DISPLAY_RIGHT"}
    }
}
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."MFD_CENTER/init.lua",
    nil,
    {
        {"MFD-CENTER", "MFD-DOWN", "MFD-RIGHT"}
    }
}
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."MFD_RIGHT/init.lua",
    nil,
    {
        {"RIGHT-MFD-CENTER", "RIGHT-MFD-DOWN", "RIGHT-MFD-RIGHT"}
    }
}
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."MFD_LEFT/init.lua",
    nil,
    {
        {"LEFT-MFD-CENTER", "LEFT-MFD-DOWN", "LEFT-MFD-RIGHT"}
    }
}
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."PMFD_CENTER/init.lua",
    nil,
    {
        {"PMFD-CENTER", "PMFD-DOWN", "PMFD-RIGHT"}
    }
}

-- HUD
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."HUD/Indicator/init.lua",
 nil,
  {	
	{}, --No actual connector 
	{sx_l =  0.0,  
	 sy_l =  0.0, 
	 sz_l =  0.0,  
	 sh   =  0,  
	 sw   =  0,  
	 rz_l =  0, 
	 rx_l =  0,
	 ry_l =  0}
 }
}

-- HMD
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."HMD/Indicator/init.lua",--init script
 	nil,
  	{	
		{},          -- initial geometry anchor , triple of connector names 
		{sx_l =  0,  -- center position correction in meters (forward , backward)
		sy_l =  0.0,  -- center position correction in meters (up , down)
		sz_l =  0.0,  -- center position correction in meters (left , right)
		sh   =  0,  -- half height correction 
		sw   =  0,  -- half width correction 
		rz_l =  0,  -- rotation corrections  
		rx_l =  0,
		ry_l =  0}
 	}
} 

--indicators[#indicators + 1] = {"LR::ccCamera", LockOn_Options.script_path.."FLIR/indicator.lua", devices.FLIR,	{{}}}

--[[ - DRAWS ON THE FUCKING HUD?????
  indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."RWR/indicator/init.lua",--init script
 nil,
  {	
	{"RWR-CENTER","RWR-DOWN","RWR-RIGHT"}, -- initial geometry anchor , triple of connector names 
	{sx_l =  0,  
	 sy_l =  0,  
	 sz_l =  0,  
	 sh   =  0,  
	 sw   =  0,  
	 rz_l =  0,  
	 rx_l =  0,
	 ry_l =  0}
  }
}
]]


dofile(LockOn_Options.common_script_path.."KNEEBOARD/declare_kneeboard_device.lua")