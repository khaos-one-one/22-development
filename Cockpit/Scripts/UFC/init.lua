dofile(LockOn_Options.common_script_path.."devices_defs.lua")

indicator_type = indicator_types.COMMON
purposes 	 = {render_purpose.GENERAL}
init_pageID		= 1

PAGE1    = 1

page_subsets  =
{
	[PAGE1]   		= LockOn_Options.script_path.."UFC/page_1.lua",
}

pages = 
{
	{
		PAGE1,
	 },
}