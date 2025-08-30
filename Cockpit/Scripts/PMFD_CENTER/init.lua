dofile(LockOn_Options.common_script_path.."devices_defs.lua")

indicator_type = indicator_types.COMMON
purposes 	 = {render_purpose.GENERAL}
init_pageID		= 1

-------PAGE IDs-------
MENU   		= 1
TSD  		= 2
CONFIG		= 3
SYS			= 4
NAV 		= 5
SFM			= 6
BLANK		= 7
ENG 		= 8

--INDICATION = 2

page_subsets  = {
[MENU]    		= LockOn_Options.script_path.."PMFD_CENTER/menu_page.lua",
[TSD]			= LockOn_Options.script_path.."PMFD_CENTER/tsd_page.lua",
[CONFIG]		= LockOn_Options.script_path.."PMFD_CENTER/config_page.lua",
[SYS]			= LockOn_Options.script_path.."PMFD_CENTER/sys_page.lua",
[NAV]  		    = LockOn_Options.script_path.."PMFD_CENTER/nav_page.lua",
[SFM]  		    = LockOn_Options.script_path.."PMFD_CENTER/sfm_page.lua",
[BLANK]  		= LockOn_Options.script_path.."PMFD_CENTER/blank_page.lua",
[ENG]			= LockOn_Options.script_path.."PMFD_CENTER/eng_page.lua",
}

pages = 
{
	{
	 MENU,
	 TSD,
	 CONFIG,		
	 SYS,	
	 NAV,	
	 SFM,
	 BLANK,
	 ENG,
	},
}