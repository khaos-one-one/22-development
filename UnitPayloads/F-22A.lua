--[[
    Grinnelli Designs F-22A Raptor
    Copyright (C) 2024, Joseph Grinnelli
    
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    
    You should have received a copy of the GNU General Public License
    along with this program.  If not, see https://www.gnu.org/licenses.
--]]
local unitPayloads = {
	["name"] = "F-22A",
	["payloads"] = {
		[1] = {
			["displayName"] = "01) CCM, 2xAIM9X",
			["name"] = "01) CCM, 2xAIM9X",
			["pylons"] = {
				[1] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 3,
				},
				[2] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 13,
				},
				[3] = {
					["CLSID"] = "{5CE2FF2A-645A-4197-B48D-8720AC69394F}",
					["num"] = 12,
				},
				[4] = {
					["CLSID"] = "{5CE2FF2A-645A-4197-B48D-8720AC69394F}",
					["num"] = 4,
				},
			},
			["tasks"] = {
				[1] = 11,
			},
		},		
		[2] = {
			["displayName"] = "02) CCM, 2xAIM9X BLK II",
			["name"] = "02) CCM, 2xAIM9X BLK II",
			["pylons"] = {
				[1] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 3,
				},
				[2] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 13,
				},
				[3] = {
					["CLSID"] = "{AIM9X-BLKII}",
					["num"] = 12,
				},
				[4] = {
					["CLSID"] = "{AIM9X-BLKII}",
					["num"] = 4,
				},
			},
			["tasks"] = {
				[1] = 11,
			},
		},
		[3] = {
			["displayName"] = "03) 2xAIM9X BLK II, 6xAIM-260 JATM",
			["name"] = "03) 2xAIM9X BLK II, 6xAIM-260 JATM",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{AIM-260A}",
					["num"] = 10,
				},
				[2] = {
					["CLSID"] = "{AIM-260A}",
					["num"] = 9,
				},
				[3] = {
					["CLSID"] = "{AIM-260A}",
					["num"] = 7,
				},
				[4] = {
					["CLSID"] = "{AIM9X-BLKII}",
					["num"] = 4,
				},
				[5] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 3,
				},
				[6] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 13,
				},
				[7] = {
					["CLSID"] = "{AIM9X-BLKII}",
					["num"] = 12,
				},
				[8] = {
					["CLSID"] = "{AIM-260A}",
					["num"] = 11,
				},
				[9] = {
					["CLSID"] = "{AIM-260A}",
					["num"] = 6,
				},
				[10] = {
					["CLSID"] = "{AIM-260A}",
					["num"] = 5,
				},
			},
			["tasks"] = {
				[1] = 11,
			},
		},
		[4] = {
			["displayName"] = "04) 2xAIM9X BLK II, 6xAIM-120D-3",
			["name"] = "04) 2xAIM9X BLK II, 6xAIM-120D-3",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{AIM-120D-3}",
					["num"] = 10,
				},
				[2] = {
					["CLSID"] = "{AIM-120D-3}",
					["num"] = 9,
				},
				[3] = {
					["CLSID"] = "{AIM-120D-3}",
					["num"] = 7,
				},
				[4] = {
					["CLSID"] = "{AIM9X-BLKII}",
					["num"] = 4,
				},
				[5] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 3,
				},
				[6] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 13,
				},
				[7] = {
					["CLSID"] = "{AIM9X-BLKII}",
					["num"] = 12,
				},
				[8] = {
					["CLSID"] = "{AIM-120D-3}",
					["num"] = 11,
				},
				[9] = {
					["CLSID"] = "{AIM-120D-3}",
					["num"] = 6,
				},
				[10] = {
					["CLSID"] = "{AIM-120D-3}",
					["num"] = 5,
				},
			},
			["tasks"] = {
				[1] = 11,
			},
		},
		[5] = {
			["displayName"] = "05) 2xAIM9X BLK II, 6xAIM-120C-8",
			["name"] = "05) 2xAIM9X BLK II, 6xAIM-120C-8",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{AIM-120C-8}",
					["num"] = 10,
				},
				[2] = {
					["CLSID"] = "{AIM-120C-8}",
					["num"] = 9,
				},
				[3] = {
					["CLSID"] = "{AIM-120C-8}",
					["num"] = 7,
				},
				[4] = {
					["CLSID"] = "{AIM9X-BLKII}",
					["num"] = 4,
				},
				[5] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 3,
				},
				[6] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 13,
				},
				[7] = {
					["CLSID"] = "{AIM9X-BLKII}",
					["num"] = 12,
				},
				[8] = {
					["CLSID"] = "{AIM-120C-8}",
					["num"] = 11,
				},
				[9] = {
					["CLSID"] = "{AIM-120C-8}",
					["num"] = 6,
				},
				[10] = {
					["CLSID"] = "{AIM-120C-8}",
					["num"] = 5,
				},
			},
			["tasks"] = {
				[1] = 11,
			},
		},
		[6] = {
			["displayName"] = "06) 2xAIM9X, 6xAIM-120C-7",
			["name"] = "06) 2xAIM9X, 6xAIM-120C-7",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{AIM-120C-7}",
					["num"] = 10,
				},
				[2] = {
					["CLSID"] = "{AIM-120C-7}",
					["num"] = 9,
				},
				[3] = {
					["CLSID"] = "{AIM-120C-7}",
					["num"] = 7,
				},
				[4] = {
					["CLSID"] = "{5CE2FF2A-645A-4197-B48D-8720AC69394F}",
					["num"] = 4,
				},
				[5] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 3,
				},
				[6] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 13,
				},
				[7] = {
					["CLSID"] = "{5CE2FF2A-645A-4197-B48D-8720AC69394F}",
					["num"] = 12,
				},
				[8] = {
					["CLSID"] = "{AIM-120C-7}",
					["num"] = 11,
				},
				[9] = {
					["CLSID"] = "{AIM-120C-7}",
					["num"] = 6,
				},
				[10] = {
					["CLSID"] = "{AIM-120C-7}",
					["num"] = 5,
				},
			},
			["tasks"] = {
				[1] = 11,
			},
		},
		[7] = {
			["displayName"] = "07) 2xAIM9X, 6xAIM-120C-5",
			["name"] = "07) 2xAIM9X, 6xAIM-120C-5",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}",
					["num"] = 10,
				},
				[2] = {
					["CLSID"] = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}",
					["num"] = 9,
				},
				[3] = {
					["CLSID"] = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}",
					["num"] = 7,
				},
				[4] = {
					["CLSID"] = "{5CE2FF2A-645A-4197-B48D-8720AC69394F}",
					["num"] = 4,
				},
				[5] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 3,
				},
				[6] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 13,
				},
				[7] = {
					["CLSID"] = "{5CE2FF2A-645A-4197-B48D-8720AC69394F}",
					["num"] = 12,
				},
				[8] = {
					["CLSID"] = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}",
					["num"] = 11,
				},
				[9] = {
					["CLSID"] = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}",
					["num"] = 6,
				},
				[10] = {
					["CLSID"] = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}",
					["num"] = 5,
				},
			},
			["tasks"] = {
				[1] = 11,
			},
		},
		[8] = {
			["displayName"] = "08) 2xAIM9M, 6xAIM-120B",
			["name"] = "08) 2xAIM9M, 6xAIM-120B",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{C8E06185-7CD6-4C90-959F-044679E90751}",
					["num"] = 10,
				},
				[2] = {
					["CLSID"] = "{C8E06185-7CD6-4C90-959F-044679E90751}",
					["num"] = 9,
				},
				[3] = {
					["CLSID"] = "{C8E06185-7CD6-4C90-959F-044679E90751}",
					["num"] = 7,
				},
				[4] = {
					["CLSID"] = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}",
					["num"] = 4,
				},
				[5] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 3,
				},
				[6] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 13,
				},
				[7] = {
					["CLSID"] = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}",
					["num"] = 12,
				},
				[8] = {
					["CLSID"] = "{C8E06185-7CD6-4C90-959F-044679E90751}",
					["num"] = 11,
				},
				[9] = {
					["CLSID"] = "{C8E06185-7CD6-4C90-959F-044679E90751}",
					["num"] = 6,
				},
				[10] = {
					["CLSID"] = "{C8E06185-7CD6-4C90-959F-044679E90751}",
					["num"] = 5,
				},
			},
			["tasks"] = {
				[1] = 11,
			},
		},	
		[9] = {
			["displayName"] = "09) 2xAIM9X BLK II, 2xMAKO-AA, 4xAIM-120/260",
			["name"] = "09) 2xAIM9X BLK II, 2xMAKO-AA, 4xAIM-120/260",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{AIM-120D-3}",
					["num"] = 10,
				},
				[2] = {
					["CLSID"] = "{MAKO_A2A_C}",
					["num"] = 9,
				},
				[3] = {
					["CLSID"] = "{MAKO_A2A_C}",
					["num"] = 7,
				},
				[4] = {
					["CLSID"] = "{AIM9X-BLKII}",
					["num"] = 4,
				},
				[5] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 3,
				},
				[6] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 13,
				},
				[7] = {
					["CLSID"] = "{AIM9X-BLKII}",
					["num"] = 12,
				},
				[8] = {
					["CLSID"] = "{AIM-120D-3}",
					["num"] = 6,
				},
				[9] = {
					["CLSID"] = "{AIM-120D-3}",
					["num"] = 11,
				},
				[10] = {
					["CLSID"] = "{AIM-120D-3}",
					["num"] = 5,
				},
			},
			["tasks"] = {
				[1] = 11,
			},
		},	
		[10] = {
			["displayName"] = "10) 2xAIM9X BLK II, 4xMAKO-AA",
			["name"] = "10) 2xAIM9X BLK II, 4xMAKO-AA",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{MAKO_A2A_C}",
					["num"] = 10,
				},
				[2] = {
					["CLSID"] = "{MAKO_A2A_C}",
					["num"] = 9,
				},
				[3] = {
					["CLSID"] = "{MAKO_A2A_C}",
					["num"] = 7,
				},
				[4] = {
					["CLSID"] = "{AIM9X-BLKII}",
					["num"] = 4,
				},
				[5] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 3,
				},
				[6] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 13,
				},
				[7] = {
					["CLSID"] = "{AIM9X-BLKII}",
					["num"] = 12,
				},
				[8] = {
					["CLSID"] = "{MAKO_A2A_C}",
					["num"] = 6,
				},
			},
			["tasks"] = {
				[1] = 11,
			},
		},		
		[11] = {
			["displayName"] = "11) 2xAIM9M CAPTIVE",
			["name"] = "11) 2xAIM9M CAPTIVE",
			["pylons"] = {
				[1] = {
					["CLSID"] = "CATM-9M",
					["num"] = 4,
				},
				[2] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 13,
				},
				[3] = {
					["CLSID"] = "CATM-9M",
					["num"] = 12,
				},
				[4] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 3,
				},
			},
			["tasks"] = {
				[1] = 11,
			},
		},	
		[12] = {
			["displayName"] = "12) 2xIRDS POD",
			["name"] = "12) 2xIRDS POD",
			["pylons"] = {
				[1] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 13,
				},
				[2] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 3,
				},
				[3] = {
					["CLSID"] = "{F22_IRDS}",
					["num"] = 1,
				},
				[4] = {
					["CLSID"] = "{F22_IRDS}",
					["num"] = 15,
				},
			},
			["tasks"] = {
				[1] = 11,
			},
		},		
		[13] = {
			["displayName"] = "13) 2xLDTP FUEL TANK",
			["name"] = "13) 2xLDTP FUEL TANK",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{LDTP_FUEL_Tank}",
					["num"] = 13,
				},
				[2] = {
					["CLSID"] = "{LDTP_FUEL_Tank}",
					["num"] = 3,
				},
			},
			["tasks"] = {
				[1] = 11,
			},
		},		
		[14] = {
			["displayName"] = "14) 2xFUEL TANK",
			["name"] = "14) 2xFUEL TANK",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{E1F29B21-F291-4589-9FD8-3272EEC69506}",
					["num"] = 13,
				},
				[2] = {
					["CLSID"] = "{E1F29B21-F291-4589-9FD8-3272EEC69506}",
					["num"] = 3,
				},
			},
			["tasks"] = {
				[1] = 11,
			},
		},	
		[15] = {
			["displayName"] = "15) 2xFUEL TANK+AAMs",
			["name"] = "15) 2xFUEL TANK+AAMs",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{E1F29B21-F291-4589-9FD8-3272EEC69506}",
					["num"] = 13,
				},
				[2] = {
					["CLSID"] = "{E1F29B21-F291-4589-9FD8-3272EEC69506}",
					["num"] = 3,
				},
				[3] = {
					["CLSID"] = "{LAU_115_2xAIM-120D-3}",
					["num"] = 14,
				},
				[4] = {
					["CLSID"] = "{LAU_115_2xAIM-120D-3}",
					["num"] = 2,
				},
			},
			["tasks"] = {
				[1] = 11,
			},
		},	
		[16] = {
			["displayName"] = "16) Airshow Configuration",
			["name"] = "16) Airshow Configuration",
			["pylons"] = {
				[1] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 3,
				},
				[2] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 13,
				},
				[3] = {
					["CLSID"] = "{A4BCC903-06C8-47bb-9937-A30FEDB4E744}",
					["num"] = 8,
				},
			},
			["tasks"] = {
				[1] = 11,
			},
		},	
		[17] = {
			["displayName"] = "17) 2x9X/9XBLK II, 2xAIM-120/260, 2xGBU-32",
			["name"] = "17) 2x9X/9XBLK II, 2xAIM-120/260, 2xGBU-32",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{GBU_32_V_2B}",
					["num"] = 7,
					["settings"] = {
						["NFP_PRESID"] = "MDRN_B_A_PGM_TWINWELL_USN",
						["NFP_PRESVER"] = 1,
						["NFP_VIS_DrawArgNo_56"] = 0.5,
						["NFP_VIS_DrawArgNo_57"] = 1,
						["NFP_fuze_type_nose"] = "EMPTY_NOSE",
						["NFP_fuze_type_tail"] = "FMU139CB_LD",
						["arm_delay_ctrl_FMU139CB_LD"] = 4,
						["function_delay_ctrl_FMU139CB_LD"] = 0,
					},
				},
				[2] = {
					["CLSID"] = "{AIM-120D-3}",
					["num"] = 11,
				},
				[3] = {
					["CLSID"] = "{AIM-120D-3}",
					["num"] = 5,
				},
				[4] = {
					["CLSID"] = "{GBU_32_V_2B}",
					["num"] = 9,
					["settings"] = {
						["NFP_PRESID"] = "MDRN_B_A_PGM_TWINWELL_USN",
						["NFP_PRESVER"] = 1,
						["NFP_VIS_DrawArgNo_56"] = 0.5,
						["NFP_VIS_DrawArgNo_57"] = 1,
						["NFP_fuze_type_nose"] = "EMPTY_NOSE",
						["NFP_fuze_type_tail"] = "FMU139CB_LD",
						["arm_delay_ctrl_FMU139CB_LD"] = 4,
						["function_delay_ctrl_FMU139CB_LD"] = 0,
					},
				},
				[5] = {
					["CLSID"] = "{AIM9X-BLKII}",
					["num"] = 12,
				},
				[6] = {
					["CLSID"] = "{AIM9X-BLKII}",
					["num"] = 4,
				},
				[7] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 13,
				},
				[8] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 3,
				},
			},
			["tasks"] = {
				[1] = 32,
			},
		},
		[18] = {
			["displayName"] = "18) 2x9X/9XBLK II, 2xAIM-120/260, 2xGBU-39",
			["name"] = "18) 2x9X/9XBLK II, 2xAIM-120/260, 2xGBU-39",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{4_SDB_IWB}",
					["num"] = 7,
				},
				[2] = {
					["CLSID"] = "{AIM-120D-3}",
					["num"] = 11,
				},
				[3] = {
					["CLSID"] = "{AIM-120D-3}",
					["num"] = 5,
				},
				[4] = {
					["CLSID"] = "{4_SDB_IWB}",
					["num"] = 9,
				},
				[5] = {
					["CLSID"] = "{AIM9X-BLKII}",
					["num"] = 12,
				},
				[6] = {
					["CLSID"] = "{AIM9X-BLKII}",
					["num"] = 4,
				},
				[7] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 13,
				},
				[8] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 3,
				},
			},
			["tasks"] = {
				[1] = 32,
			},
		},
		[19] = {
			["displayName"] = "19) 2x9X/9XBLK II, 4xMAKO MULTI MISSION ARM/AA",
			["name"] = "19) 2x9X/9XBLK II, 4xMAKO MULTI MISSION ARM/AA",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{MAKO_A2G_C}",
					["num"] = 7,
				},
				[2] = {
					["CLSID"] = "{MAKO_A2G_C}",
					["num"] = 9,
				},
				[3] = {
					["CLSID"] = "{AIM9X-BLKII}",
					["num"] = 12,
				},
				[4] = {
					["CLSID"] = "{AIM9X-BLKII}",
					["num"] = 4,
				},
				[5] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 13,
				},
				[6] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 3,
				},
				[7] = {
					["CLSID"] = "{MAKO_A2G_C}",
					["num"] = 10,
				},
				[8] = {
					["CLSID"] = "{MAKO_A2G_C}",
					["num"] = 6,
				},
			},
			["tasks"] = {
				[1] = 32,
			},
		},	
		[20] = {
			["displayName"] = "20) 2x9X/9XBLK II, 2xMAKO MULTI MISSION ARM/AA, 4xAIM-120/260",
			["name"] = "20) 2x9X/9XBLK II, 2xMAKO MULTI MISSION ARM/AA, 4xAIM-120/260",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{MAKO_A2G_C}",
					["num"] = 7,
				},
				[2] = {
					["CLSID"] = "{MAKO_A2G_C}",
					["num"] = 9,
				},
				[3] = {
					["CLSID"] = "{AIM9X-BLKII}",
					["num"] = 12,
				},
				[4] = {
					["CLSID"] = "{AIM9X-BLKII}",
					["num"] = 4,
				},
				[5] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 13,
				},
				[6] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 3,
				},
				[7] = {
					["CLSID"] = "{AIM-120D-3}",
					["num"] = 10,
				},
				[8] = {
					["CLSID"] = "{AIM-120D-3}",
					["num"] = 6,
				},
				[9] = {
					["CLSID"] = "{AIM-120D-3}",
					["num"] = 11,
				},
				[10] = {
					["CLSID"] = "{AIM-120D-3}",
					["num"] = 5,
				},
			},
			["tasks"] = {
				[1] = 32,
			},
		},		
	},
	["tasks"] = {
	},
	["unitType"] = "F-22A",
}
return unitPayloads
		