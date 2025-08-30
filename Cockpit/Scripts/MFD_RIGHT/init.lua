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
RWR		= 9
BLANK   = 10
ECMS	= 11

page_subsets  = {
	[MENU]   		= LockOn_Options.script_path.."MFD_RIGHT/menu_page.lua",
	[ENG]    		= LockOn_Options.script_path.."MFD_RIGHT/eng_page.lua",
	[FCS]   		= LockOn_Options.script_path.."MFD_RIGHT/fcs_page.lua",
	[FUEL]    		= LockOn_Options.script_path.."MFD_RIGHT/fuel_page.lua",
	[NAV]   		= LockOn_Options.script_path.."MFD_RIGHT/nav_page.lua",
	[BAY]    		= LockOn_Options.script_path.."MFD_RIGHT/bay_page.lua",
	[CHK]   		= LockOn_Options.script_path.."MFD_RIGHT/checklist_page.lua",
	[HSI]    		= LockOn_Options.script_path.."MFD_RIGHT/hsi_page.lua",
	[RWR]    		= LockOn_Options.script_path.."MFD_RIGHT/rwr_page.lua",
	[BLANK]    		= LockOn_Options.script_path.."MFD_RIGHT/blank_page.lua",
	[ECMS]    		= LockOn_Options.script_path.."MFD_RIGHT/ecms_page.lua",

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
		RWR, 
		BLANK,
		ECMS,
	
	 },
}