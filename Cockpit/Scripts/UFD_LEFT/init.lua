dofile(LockOn_Options.common_script_path.."devices_defs.lua")

indicator_type = indicator_types.COMMON
purposes 	 = {render_purpose.GENERAL}
init_pageID		= 1

-------PAGE IDs-------
BASE    = 1
STATUS	= 2
ALERT	= 3

page_subsets  = {
[BASE]    		= LockOn_Options.script_path.."UFD_LEFT/base_page.lua",
[STATUS]    		= LockOn_Options.script_path.."UFD_LEFT/status_page.lua",
[ALERT]    		= LockOn_Options.script_path.."UFD_LEFT/alert_page.lua",

}
pages = 
{
	{
	 BASE,
	 STATUS,
	 ALERT,
	 },
}

