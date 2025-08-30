dofile(LockOn_Options.common_script_path.."devices_defs.lua")

indicator_type = indicator_types.COMMON
purposes 	 = {render_purpose.GENERAL}
init_pageID		= 1

-------PAGE IDs-------
ADI    = 1

--INDICATION = 2

page_subsets  = {
[ADI]    		= LockOn_Options.script_path.."UFD_RIGHT/adi_page.lua",

--[INDICATION]    = LockOn_Options.script_path.."LDDI/indication_page.lua",
}
pages = 
{
	{
	 ADI,

	 --INDICATION
	 },
}

