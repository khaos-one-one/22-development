dofile(LockOn_Options.common_script_path.."devices_defs.lua")

indicator_type = indicator_types.COMMON
purposes 	 = {render_purpose.GENERAL}
init_pageID		= 1

-------PAGE IDs-------
-- 0=MENU, 1=ENG, 2=FCS, 3=FUEL, 4=ADI, 5=BAY, 6=CHKLIST, 7=SMS, 8=HSI   
MENU    = 1
ENG		= 2
FCS 	= 3
FUEL	= 4
NAV		= 5
BAY		= 6
CHK		= 7
HSI		= 8
SMS		= 9
BLANK   = 10
STARTUP	= 11

page_subsets  = {
	[MENU]   		= LockOn_Options.script_path.."MFD_LEFT/menu_page.lua",
	[ENG]    		= LockOn_Options.script_path.."MFD_LEFT/eng_page.lua",
	[FCS]   		= LockOn_Options.script_path.."MFD_LEFT/fcs_page.lua",
	[FUEL]    		= LockOn_Options.script_path.."MFD_LEFT/fuel_page.lua",
	[NAV]   		= LockOn_Options.script_path.."MFD_LEFT/nav_page.lua",
	[BAY]    		= LockOn_Options.script_path.."MFD_LEFT/bay_page.lua",
	[CHK]   		= LockOn_Options.script_path.."MFD_LEFT/checklist_page.lua",
	[HSI]    		= LockOn_Options.script_path.."MFD_LEFT/hsi_page.lua",
	[SMS]    		= LockOn_Options.script_path.."MFD_LEFT/sms_page.lua",
	[BLANK]			= LockOn_Options.script_path.."MFD_LEFT/blank_page.lua",
	[STARTUP]			= LockOn_Options.script_path.."MFD_LEFT/startup_page.lua",


}
pages = 
{
	{
	 
		MENU,
		ENG,
		FCS, 
		FUEL,
		NAV, 
		BAY, 
		CHK, 
		HSI, 
		SMS, 
		BLANK,
		STARTUP,
		
	
	 },
}