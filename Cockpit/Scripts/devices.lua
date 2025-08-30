
local count = 0
local function counter()
	count = count + 1
	return count
end
-------DEVICE ID-------
devices = {}
devices["AVIONICS"]				= counter()
devices["ELECTRICAL_SYSTEM"]	= counter()
devices["LIGHTING_SYSTEM"]		= counter()
devices["ENGINE_SYSTEM"]		= counter()
devices["WEAPON_SYSTEM"]		= counter()
devices["ECMS"]					= counter()
devices["MFD_SYSTEM"]			= counter()
devices["PMFD_SYSTEM"]			= counter()
devices["ICP_SYSTEM"]			= counter()
devices["HUD"]              	= counter()
devices["HMD"]              	= counter()
devices["RWR"]					= counter()
devices["RADAR"]				= counter()
devices["CANOPY"]				= counter()
--devices["FLIR"]					= counter()
