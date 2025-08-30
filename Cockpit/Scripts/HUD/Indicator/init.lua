dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")

indicator_type = indicator_types.COLLIMATOR
purposes = {render_purpose.GENERAL, render_purpose.HUD_ONLY_VIEW}



BASE = 1
NAV = 2

page_subsets = {
    [BASE] = LockOn_Options.script_path.."HUD/Indicator/base_page.lua",
    [NAV] = LockOn_Options.script_path.."HUD/Indicator/nav_page.lua"
}
pages = {
    {BASE},
    {NAV}
}
init_pageID = 2 

collimator_default_distance_factor = {0.6, 0.0, 0}

update_screenspace_diplacement(SelfWidth / SelfHeight, false)
dedicated_viewport_arcade = dedicated_viewport
