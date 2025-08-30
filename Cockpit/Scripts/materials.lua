-- Scripts/materials.lua
dofile(LockOn_Options.common_script_path.."Fonts/fonts_cmn.lua")
dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")
dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."fonts.lua")

----- MATERIALS -------
materials = {}
materials["DBG_GREY"]    = {5, 5, 5, 255}
materials["DBG_BLACK"]   = {0, 0, 0, 255}
materials["DBG_BLUE"]    = {0, 0, 100, 255}
materials["DBG_GREEN"]   = {0, 255, 0, 255}
materials["DBG_RED"]     = {255, 0, 0, 255}
materials["DBG_WHITE"]   = {255, 255, 255, 120}
materials["DBG_CYAN"]    = {1, 244, 244, 255}
materials["DBG_CLEAR"]   = {0, 0, 0, 0}
materials["BLOB_COLOR"] = {0,128,0,192}
materials["GUNSIGHT_GLASS"] = {0,120,0,128}
materials["TEST_COLOR"] = {50,250,0,255}
materials["HUD_COLLIMATOR"] 		= {255,192,203,5}
materials["HUD_DAY_COLOR"]          = {0,200,0,200}

materials["N_MATERIAL"] 	= {255,255,255,255}

----- TEXTURES -------

textures = {}

----- FONTS -------

local IndicationFontPath = LockOn_Options.script_path.."../Textures/Fonts/"

fontdescription = {}

stringdefs = {0.012,0.75 * 0.012, 0, 0}
mfd_stringdefs = {0.012,0.75 * 0.012, 0, 0}

mfd_str_arw = {0.008,0.008, 0, 0}
mfd_str_btn = {0.006,0.006, 0, 0}
mfd_str_wrn = {0.006,0.006, 0, 0}
mfd_str_mfd_ind = {0.005,0.0026, 0, 0}


fontdescription["F22_HUD"] = {
    texture = IndicationFontPath.."F22_HUD.dds",
    size = {8, 8},
    resolution = {2048, 2048},
    default = {141, 256},
    chars =
    {
        [1]   = {32, 141, 256}, -- [space]
        [2]   = {42, 141, 256}, -- *
        [3]   = {43, 141, 256}, -- +
        [4]   = {45, 141, 256}, -- -
        [5]   = {46, 141, 256}, -- .
        [6]   = {47, 141, 256}, -- /
        [7]   = {48, 141, 256}, -- 0
        [8]   = {49, 141, 256}, -- 1
        [9]   = {50, 141, 256}, -- 2
        [10]  = {51, 141, 256}, -- 3
        [11]  = {52, 141, 256}, -- 4
        [12]  = {53, 141, 256}, -- 5
        [13]  = {54, 141, 256}, -- 6
        [14]  = {55, 141, 256}, -- 7
        [15]  = {56, 141, 256}, -- 8
        [16]  = {57, 141, 256}, -- 9
        [17]  = {58, 141, 256}, -- :
        [18]  = {65, 141, 256}, -- A
        [19]  = {66, 141, 256}, -- B
        [20]  = {67, 141, 256}, -- C
        [21]  = {68, 141, 256}, -- D
        [22]  = {69, 141, 256}, -- E
        [23]  = {70, 141, 256}, -- F
        [24]  = {71, 141, 256}, -- G
        [25]  = {72, 141, 256}, -- H
        [26]  = {73, 141, 256}, -- I
        [27]  = {74, 141, 256}, -- J
        [28]  = {75, 141, 256}, -- K
        [29]  = {76, 141, 256}, -- L
        [30]  = {77, 141, 256}, -- M
        [31]  = {78, 141, 256}, -- N
        [32]  = {79, 141, 256}, -- O
        [33]  = {80, 141, 256}, -- P
        [34]  = {81, 141, 256}, -- Q
        [35]  = {82, 141, 256}, -- R
        [36]  = {83, 141, 256}, -- S
        [37]  = {84, 141, 256}, -- T
        [38]  = {85, 141, 256}, -- U
        [39]  = {86, 141, 256}, -- V
        [40]  = {87, 141, 256}, -- W
        [41]  = {88, 141, 256}, -- X
        [42]  = {89, 141, 256}, -- Y
        [43]  = {90, 141, 256}, -- Z
		[44]  = {37, 141, 256}, -- %
		[45]  = {100, 141, 256}, -- degree - use a "d"
		[46]  = {35, 141, 256}, -- alpha - use #
		[47]  = {33, 141, 256}, -- !
		[48]  = {103, 141, 256}, -- pound symbol - use g
		[49]  = {101, 141, 256}, -- ' - use an e
		[50]  = {102, 141, 256}, -- " - use an f
    }
}

    fonts = {}
	fonts["F22_HUD"]                = {fontdescription["F22_HUD"], 10, {  8, 252,   15, 255}}
