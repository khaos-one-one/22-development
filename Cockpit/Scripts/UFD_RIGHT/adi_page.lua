dofile(LockOn_Options.script_path.."UFD_RIGHT/definitions.lua")
dofile(LockOn_Options.script_path.."fonts.lua")
dofile(LockOn_Options.script_path.."materials.lua")

local function vertices(object, height, half_or_double)
    local width = height
    
    if half_or_double == true then --
        width = 11
    end

    if half_or_double == false then
        width = height * 2
    end

    local half_width = width / 2
    local half_height = height / 2
    local x_positive = half_width
    local x_negative = half_width * -1.0
    local y_positive = half_height
    local y_negative = half_height * -1.0

    object.vertices =
    {
        {x_negative, y_positive},
        {x_positive, y_positive},
        {x_positive, y_negative},
        {x_negative, y_negative}
    }

    object.indices = {0, 1, 2, 2, 3, 0}

    object.tex_coords =
    {
        {0, 0},
        {1, 0},
        {1, 1},
        {0, 1}
    }
end

local IndicationTexturesPath = LockOn_Options.script_path.."../IndicationTextures/"--I dont think this is correct might have to add scripts.
local MainColor 			= {255, 255, 255, 255}--RGBA
local GreenColor 		    = {0, 255, 0, 255}--RGBA
local WhiteColor 			= {255, 255, 255, 255}--RGBA
local RedColor 				= {255, 0, 0, 255}--RGBA
local BlackColor 			= {0, 0, 0, 255}--RGBA
local ScreenColor			= {3, 3, 3, 255}--RGBA 5-5-5
local ADIbottom				= {8, 8, 8, 255}--RGBA
local TealColor				= {0, 175, 175, 255}--RGBA
local TrimColor				= {255, 255, 255, 255}--RGBA
local BOXColor				= {10, 10, 10, 255}--RGBA
local LogoColor				= {12, 12, 12, 255}

local MASK_BOX	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mask_box.dds", 	ScreenColor)--SYSTEM TEST
local MASK_BOX1	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mask_box.dds", 	ADIbottom)--SYSTEM TEST
local MASK_BOXW	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mask_box.dds", 	WhiteColor)--SYSTEM TEST
local PFD_PAGE_1 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/pfd_page_1.dds", GreenColor)
local FCS_PAGE	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/fcs_page.dds", 	GreenColor)
local ADI_TOP	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/adi_half.dds", 	TealColor)
local ADI_BOT	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/adi_half.dds", 	ADIbottom)
local ADI_LINE	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/adi_line.dds", 	WhiteColor)
local ADI_CENTER = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/adi_center.dds", WhiteColor)
local LADDER_TOP = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/ladder_top.dds", BlackColor)
local LADDER_BOT = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/ladder_bot.dds", WhiteColor)
local ADI_TRIM 	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/adi_trim.dds",   WhiteColor)
local ADI_FUEL 	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/adi_fuel.dds",   GreenColor)
local FUEL_LINE	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mask_box.dds", 	TealColor)--SYSTEM TEST
local FUEL_LINE_M = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mask_box.dds", 	BlackColor)--SYSTEM TEST

local BLACK_MASK = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mask_box.dds", 	BlackColor)
local ADI_TRIM_MASK = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/adi_trim.dds",   BlackColor)
local ADI_CENTER_MASK = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/adi_center.dds", BlackColor)
local LADDER_BOT_MASK = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/ladder_bot.dds", BlackColor)
local FUEL_LINE_MASK	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mask_box.dds", 	BlackColor)--SYSTEM TEST
local FUEL_LINE_MASK2	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mask_box.dds", 	RedColor)--SYSTEM TEST

local ClippingPlaneSize = 50 --Clipping Masks   --50
local ClippingWidth 	= 75--Clipping Masks	--85
local PFD_MASK_BASE1 	= MakeMaterial(nil,{255,0,0,255})--Clipping Masks
local PFD_MASK_BASE2 	= MakeMaterial(nil,{0,0,255,255})--Clipping Masks
local ADI_MASK 	 		= MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/adi_mask.dds", WhiteColor)
local ADI_MASK2 	 	= MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/adi_mask.dds", WhiteColor)
local MFD_LOGO 		= MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/22_logo.dds", LogoColor)

--Clipping Masks
local total_field_of_view           = CreateElement "ceMeshPoly"
total_field_of_view.name            = "total_field_of_view"
total_field_of_view.primitivetype   = "triangles"
total_field_of_view.vertices        = {
										{-1 * ClippingWidth,-1 * ClippingPlaneSize},
										{1 * ClippingWidth,-1 * ClippingPlaneSize},
										{1 * ClippingWidth,1 * ClippingPlaneSize},
										{-1 * ClippingWidth,1 * ClippingPlaneSize},										
									}
total_field_of_view.material        = PFD_MASK_BASE1
total_field_of_view.indices         = {0,1,2,2,3,0}
total_field_of_view.init_pos        = {0, 0, 0}
total_field_of_view.init_rot        = { 0, 0, 0} -- degree NOT rad
total_field_of_view.h_clip_relation = h_clip_relations.REWRITE_LEVEL
total_field_of_view.level           = 1
total_field_of_view.collimated      = false
total_field_of_view.isvisible       = false
Add(total_field_of_view)

local clipPoly               = CreateElement "ceMeshPoly"
clipPoly.name                = "clipPoly-1"
clipPoly.primitivetype       = "triangles"
clipPoly.init_pos            = {0, 0, 0}
clipPoly.init_rot            = { 0, 0 , 0} -- degree NOT rad
clipPoly.vertices            = {
								{-1 * ClippingWidth,-1 * ClippingPlaneSize},
								{1 * ClippingWidth,-1 * ClippingPlaneSize},
								{1 * ClippingWidth,1 * ClippingPlaneSize},
								{-1 * ClippingWidth,1 * ClippingPlaneSize},										
									}
clipPoly.indices             = {0,1,2,2,3,0}
clipPoly.material            = PFD_MASK_BASE2
clipPoly.h_clip_relation     = h_clip_relations.INCREASE_IF_LEVEL
clipPoly.level               = 1
clipPoly.collimated          = false
clipPoly.isvisible           = false
Add(clipPoly)
-------------------------------------------------------------------------------------------------------------------------------------
--TEST
BGROUND                    = CreateElement "ceTexPoly"
BGROUND.name    			= "BG"
BGROUND.material			= MASK_BOX
BGROUND.change_opacity 		= false
BGROUND.collimated 			= false
BGROUND.isvisible 			= true
BGROUND.init_pos 			= {0, 0, 0} --maybe its x,y,z z being depth.. again who the fuck knows?
BGROUND.init_rot 			= {0, 0, 0}
--BGROUND.indices 			= {0, 1, 2, 2, 3, 0}
BGROUND.element_params 		= {"UFD_OPACITY"} --HOPE THIS WORKS G_OP_BACK
BGROUND.controllers			= {{"opacity_using_parameter",0}}
BGROUND.level 				= 2
BGROUND.h_clip_relation     = h_clip_relations.COMPARE
vertices(BGROUND,200)

Add(BGROUND)

LOGO 					    = CreateElement "ceTexPoly"
LOGO.name 				    = "LOGO"
LOGO.material 			    = MFD_LOGO 
LOGO.change_opacity 	= false
LOGO.collimated 		= false
LOGO.isvisible 			= true
LOGO.init_pos 			= {0, 0, 0} --L-R,U-D,F-B
LOGO.init_rot 			= {0, 0, 0}
LOGO.element_params 		= {"MFD_OPACITY","RUFD_BLANK_PAGE"}--this may not be bneeded check when more pages done for backlight on page 7 SMS fc3 bs
LOGO.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},}--MENU PAGE = 1
LOGO.level 				= 2
LOGO.h_clip_relation     = h_clip_relations.COMPARE
vertices(LOGO, 80)
Add(LOGO)


----------------------------------------------------------------
ADFUEL                    = CreateElement "ceTexPoly"
ADFUEL.name    			= "fuel_grid"
ADFUEL.material			= ADI_FUEL
ADFUEL.change_opacity 		= false
ADFUEL.collimated 			= false
ADFUEL.isvisible 			= true
ADFUEL.init_pos 			= {0, 0, 0} --maybe its x,y,z z being depth.. again who the fuck knows?
ADFUEL.init_rot 			= {0, 0, 0}
ADFUEL.element_params 		= {"R_ADI_OPACITY","UFD_OPACITY",} --HOPE THIS WORKS G_OP_BACK
ADFUEL.controllers			= {{"parameter_in_range",0,0.9,1.1},
								{"opacity_using_parameter",1},
								}
ADFUEL.level 				= 2
ADFUEL.h_clip_relation      = h_clip_relations.COMPARE
vertices(ADFUEL,200)

Add(ADFUEL)

--BARO TEXT
BARO 					= CreateElement "ceStringPoly"
BARO.name 				= "apu spool"
BARO.material 			= UFD_GRN
BARO.value 				= "BARO 29.92  J:3.5  B:2.5"
BARO.stringdefs 		= {0.0050, 0.0050, 0.0004, 0.001}
BARO.alignment 			= "LeftCenter"
BARO.formats 			= {"%s"}
BARO.h_clip_relation    = h_clip_relations.COMPARE
BARO.level 				= 2
BARO.init_pos 			= {-60, -43.5, 0} --= {-40, -43, 0}
BARO.init_rot 			= {0, 0, 0}
BARO.element_params 	= {"R_ADI_OPACITY","UFD_OPACITY",} --HOPE THIS WORKS G_OP_BACK
BARO.controllers		= {{"parameter_in_range",0,0.9,1.1},
								{"opacity_using_parameter",1},
								}
Add(BARO)
----------------------------------------------------------------------------------------
I 					= CreateElement "ceStringPoly"
I.name 				= "internal"
I.material 			= UFD_GRN
I.value 				= "I:"
I.stringdefs 		= {0.0050, 0.0050, 0.0004, 0.001}
I.alignment 			= "CenterCenter"
I.formats 			= {"%s"}
I.h_clip_relation    = h_clip_relations.COMPARE
I.level 				= 2
I.init_pos 			= {36, 38, 0}
I.init_rot 			= {0, 0, 0}
I.element_params 	= {"R_ADI_OPACITY","UFD_OPACITY",} --HOPE THIS WORKS G_OP_BACK
I.controllers		= {{"parameter_in_range",0,0.9,1.1},
								{"opacity_using_parameter",1},
								}
Add(I)
----------------------------------------------------------------------------------------
T 					= CreateElement "ceStringPoly"
T.name 				= "tanks"
T.material 			= UFD_GRN
T.value 				= "T:"
T.stringdefs 		= {0.0050, 0.0050, 0.0004, 0.001}
T.alignment 			= "CenterCenter"
T.formats 			= {"%s"}
T.h_clip_relation    = h_clip_relations.COMPARE
T.level 				= 2
T.init_pos 			= {36, 30	, 0}
T.init_rot 			= {0, 0, 0}
T.element_params 	= {"R_ADI_OPACITY","UFD_OPACITY",} --HOPE THIS WORKS G_OP_BACK
T.controllers		= {{"parameter_in_range",0,0.9,1.1},
								{"opacity_using_parameter",1},
								}
Add(T)
----------------------------------------------------------------------------------------
F1 					= CreateElement "ceStringPoly"
F1.name 				= "fuel numb"
F1.material 			= UFD_GRN
F1.value 				= "20"
F1.stringdefs 		= {0.0050, 0.0050, 0.0004, 0.001}
F1.alignment 			= "CenterCenter"
F1.formats 			= {"%s"}
F1.h_clip_relation    = h_clip_relations.COMPARE
F1.level 				= 2
F1.init_pos 			= {58, 20	, 0}
F1.init_rot 			= {0, 0, 0}
F1.element_params 	= {"R_ADI_OPACITY","UFD_OPACITY",} --HOPE THIS WORKS G_OP_BACK
F1.controllers		= {{"parameter_in_range",0,0.9,1.1},
								{"opacity_using_parameter",1},
								}
Add(F1)
----------------------------------------------------------------------------------------
F2 					= CreateElement "ceStringPoly"
F2.name 				= "fuel numb"
F2.material 			= UFD_GRN
F2.value 				= "10"
F2.stringdefs 		= {0.0050, 0.0050, 0.0004, 0.001}
F2.alignment 			= "CenterCenter"
F2.formats 			= {"%s"}
F2.h_clip_relation    = h_clip_relations.COMPARE
F2.level 				= 2
F2.init_pos 			= {58, 5, 0}
F2.init_rot 			= {0, 0, 0}
F2.element_params 	= {"R_ADI_OPACITY","UFD_OPACITY",} --HOPE THIS WORKS G_OP_BACK
F2.controllers		= {{"parameter_in_range",0,0.9,1.1},
								{"opacity_using_parameter",1},
								}
Add(F2)
----------------------------------------------------------------------------------------
F3 					= CreateElement "ceStringPoly"
F3.name 				= "fuel numb"
F3.material 			= UFD_GRN
F3.value 				= "8"
F3.stringdefs 		= {0.0050, 0.0050, 0.0004, 0.001}
F3.alignment 			= "CenterCenter"
F3.formats 			= {"%s"}
F3.h_clip_relation    = h_clip_relations.COMPARE
F3.level 				= 2
F3.init_pos 			= {58, -5, 0}
F3.init_rot 			= {0, 0, 0}
F3.element_params 	= {"R_ADI_OPACITY","UFD_OPACITY",} --HOPE THIS WORKS G_OP_BACK
F3.controllers		= {{"parameter_in_range",0,0.9,1.1},
								{"opacity_using_parameter",1},
								}
Add(F3)
----------------------------------------------------------------------------------------
F4 					= CreateElement "ceStringPoly"
F4.name 				= "fuel numb"
F4.material 			= UFD_GRN
F4.value 				= "6"
F4.stringdefs 		= {0.0050, 0.0050, 0.0004, 0.001}
F4.alignment 			= "CenterCenter"
F4.formats 			= {"%s"}
F4.h_clip_relation    = h_clip_relations.COMPARE
F4.level 				= 2
F4.init_pos 			= {58, -15, 0}
F4.init_rot 			= {0, 0, 0}
F4.element_params 	= {"R_ADI_OPACITY","UFD_OPACITY",} --HOPE THIS WORKS G_OP_BACK
F4.controllers		= {{"parameter_in_range",0,0.9,1.1},
								{"opacity_using_parameter",1},
								}
Add(F4)
----------------------------------------------------------------------------------------
F5 					= CreateElement "ceStringPoly"
F5.name 				= "fuel numb"
F5.material 			= UFD_GRN
F5.value 				= "4"
F5.stringdefs 		= {0.0050, 0.0050, 0.0004, 0.001}
F5.alignment 			= "CenterCenter"
F5.formats 			= {"%s"}
F5.h_clip_relation    = h_clip_relations.COMPARE
F5.level 				= 2
F5.init_pos 			= {58, -25, 0}
F5.init_rot 			= {0, 0, 0}
F5.element_params 	= {"R_ADI_OPACITY","UFD_OPACITY",} --HOPE THIS WORKS G_OP_BACK
F5.controllers		= {{"parameter_in_range",0,0.9,1.1},
								{"opacity_using_parameter",1},
								}
Add(F5)
----------------------------------------------------------------------------------------
F6 					= CreateElement "ceStringPoly"
F6.name 				= "fuel numb"
F6.material 			= UFD_GRN
F6.value 				= "2"
F6.stringdefs 		= {0.0050, 0.0050, 0.0004, 0.001}
F6.alignment 			= "CenterCenter"
F6.formats 			= {"%s"}
F6.h_clip_relation    = h_clip_relations.COMPARE
F6.level 				= 2
F6.init_pos 			= {58, -35, 0}
F6.init_rot 			= {0, 0, 0}
F6.element_params 	= {"R_ADI_OPACITY","UFD_OPACITY",} --HOPE THIS WORKS G_OP_BACK
F6.controllers		= {{"parameter_in_range",0,0.9,1.1},
								{"opacity_using_parameter",1},
								}
Add(F6)
----------------------------------------------------------------------------------------
local ClippingPlaneSize1 = 41.5 --Clipping Masks   --50
local ClippingWidth1 	= 45.5 --Clipping Masks	--85
-------------------------------------------------------------------
local FUELQT				= CreateElement "ceStringPoly"
FUELQT.name				= "rad Alt"
FUELQT.material			= UFD_GRN
FUELQT.init_pos			= {40, 38, 0} --L-R,U-D,F-B
FUELQT.alignment			= "LeftCenter"
FUELQT.stringdefs			= {0.005, 0.005, 0, 0.0} --either 004 or 005
FUELQT.additive_alpha		= true
FUELQT.collimated			= false
FUELQT.isdraw				= true	
FUELQT.use_mipfilter		= true
FUELQT.h_clip_relation		= h_clip_relations.COMPARE
FUELQT.level				= 2
FUELQT.element_params		= {"UFD_OPACITY","FUEL","R_ADI_OPACITY"}
FUELQT.formats				= {"%.0f"}--= {"%02.0f"}
FUELQT.controllers			= {{"opacity_using_parameter",0},{"text_using_parameter",1,0},{"parameter_in_range",2,0.9,1.1}}
Add(FUELQT)
-------------------------------------------------------------------
-------------------------------------------------------------------
local FUELTQT				= CreateElement "ceStringPoly"
FUELTQT.name				= "tank"
FUELTQT.material			= UFD_GRN
FUELTQT.init_pos			= {40, 30, 0} --L-R,U-D,F-B
FUELTQT.alignment			= "LeftCenter"
FUELTQT.stringdefs			= {0.005, 0.005, 0, 0.0} --either 004 or 005
FUELTQT.additive_alpha		= true
FUELTQT.collimated			= false
FUELTQT.isdraw				= true	
FUELTQT.use_mipfilter		= true
FUELTQT.h_clip_relation		= h_clip_relations.COMPARE
FUELTQT.level				= 2
FUELTQT.element_params		= {"UFD_OPACITY","FUELTANK","R_ADI_OPACITY"}
FUELTQT.formats				= {"%.0f"}--= {"%02.0f"}
FUELTQT.controllers			= {{"opacity_using_parameter",0},{"text_using_parameter",1,0},{"parameter_in_range",2,0.9,1.1}}
Add(FUELTQT)
----------------------------------------------------------------------------
local total_field_of_view1           = CreateElement "ceMeshPoly"
total_field_of_view1.name            = "total_field_of_view"
total_field_of_view1.primitivetype   = "triangles"
total_field_of_view1.vertices        = {
										{-1 * ClippingWidth,-1 * ClippingPlaneSize},
										{1 *  ClippingWidth,-1 * ClippingPlaneSize},
										{1 *  ClippingWidth,1 *  ClippingPlaneSize},
										{-1 * ClippingWidth,1 *  ClippingPlaneSize},										
									}
total_field_of_view1.material        = PFD_MASK_BASE1--PFD_MASK_BASE1
total_field_of_view1.indices         = {0,1,2,2,3,0}
total_field_of_view1.init_pos        = {0, 0, 0}
total_field_of_view1.init_rot        = { 0, 0, 0} -- degree NOT rad
total_field_of_view1.h_clip_relation = h_clip_relations.REWRITE_LEVEL
total_field_of_view1.level           = 3
total_field_of_view1.collimated      = false
total_field_of_view1.isvisible       = false
Add(total_field_of_view1)
-----------------
local clipPoly1               = CreateElement "ceMeshPoly"
clipPoly1.name                = "clipPoly-11"
clipPoly1.primitivetype       = "triangles"
clipPoly1.init_pos            = {-16.2, 4.4, 0}
clipPoly1.init_rot            = { 0, 0 , 0} -- degree NOT rad
clipPoly1.vertices            = {
								{-1 * ClippingWidth1,-1 * ClippingPlaneSize1},
								{1 *  ClippingWidth1,-1 * ClippingPlaneSize1},
								{1 *  ClippingWidth1,1 *  ClippingPlaneSize1},
								{-1 * ClippingWidth1,1 *  ClippingPlaneSize1},										
									}
clipPoly1.indices             = {0,1,2,2,3,0}
clipPoly1.material            = PFD_MASK_BASE2
clipPoly1.h_clip_relation     = h_clip_relations.INCREASE_IF_LEVEL
clipPoly1.level               = 3
clipPoly1.collimated          = false
clipPoly1.isvisible           = false
Add(clipPoly1)
--------------
ADIUP                    = CreateElement "ceTexPoly"
ADIUP.name    			 = "up"
ADIUP.material			 = ADI_TOP
ADIUP.change_opacity 		= false
ADIUP.collimated 			= false
ADIUP.isvisible 			= true
ADIUP.init_pos 			= {-16.2, 4.4, 0} --maybe its x,y,z z being depth.. again who the fuck knows?
ADIUP.init_rot 			= {0, 0, 0}
--ADIUP.indices 			= {0, 1, 2, 2, 3, 0}
ADIUP.level 				= 4
ADIUP.h_clip_relation     = h_clip_relations.COMPARE
ADIUP.element_params 	  = {"R_ADI_OPACITY","ADIROLL","ADIPITCH","UFD_OPACITY",} --HOPE THIS WORKS G_OP_BACK
ADIUP.controllers		  = {
							{"parameter_in_range",0,0.9,1.1},
							{"rotate_using_parameter",1,1,0},
							{"move_up_down_using_parameter",2,-0.037,0},--needs to be checked with a ladder scale
							{"opacity_using_parameter",3},
						  }
vertices(ADIUP,400)

Add(ADIUP)
-- ----------------
ADIDN                    = CreateElement "ceTexPoly"
ADIDN.name    			 = "bot"
ADIDN.material			 = ADI_BOT
ADIDN.change_opacity 		= false
ADIDN.collimated 			= false
ADIDN.isvisible 			= true
ADIDN.init_pos 			= {-16.2, 4.4, 0} --maybe its x,y,z z being depth.. again who the fuck knows?
ADIDN.init_rot 			= {180, 0, 0}
ADIDN.level 				= 4
ADIDN.h_clip_relation     = h_clip_relations.COMPARE
ADIDN.element_params 	  = {"R_ADI_OPACITY","ADIROLL","ADIPITCH","UFD_OPACITY",} --HOPE THIS WORKS G_OP_BACK
ADIDN.controllers		  = {
							{"parameter_in_range",0,0.9,1.1},
							{"rotate_using_parameter",1,1,0},
							{"move_up_down_using_parameter",2,0.037,0},--needs to be checked with a ladder scale
							{"opacity_using_parameter",3},
						  }
vertices(ADIDN,400)


Add(ADIDN)
----------------
ADILAD                    	= CreateElement "ceTexPoly" --need to fix aith more code
ADILAD.name    				= "ladderup"
ADILAD.material			 	= LADDER_TOP
ADILAD.change_opacity 		= false
ADILAD.collimated 			= false
ADILAD.isvisible 			= true
ADILAD.init_pos 			= {-16.2, 4.4, 0} --maybe its x,y,z z being depth.. again who the fuck knows?
ADILAD.init_rot 			= {0, 0, 0}
ADILAD.level 				= 4
ADILAD.h_clip_relation     = h_clip_relations.COMPARE
ADILAD.element_params 	  = {"R_ADI_OPACITY","ADIROLL","ADIPITCH",} --HOPE THIS WORKS G_OP_BACK
ADILAD.controllers		  = {
							{"opacity_using_parameter",0},
							{"rotate_using_parameter",1,1,0},
							{"move_up_down_using_parameter",2,-0.037,0},--needs to be checked with a ladder scale -0.094   -0.037
							--{"opacity_using_parameter",3},
						  }
vertices(ADILAD,200)

Add(ADILAD)
-----------------------------------
ADILAD1MASK                    	= CreateElement "ceTexPoly"
ADILAD1MASK.name    				= "ladderdn"
ADILAD1MASK.material			 	= LADDER_BOT_MASK
ADILAD1MASK.change_opacity 		= false
ADILAD1MASK.collimated 			= false
ADILAD1MASK.isvisible 			= true
ADILAD1MASK.init_pos 			= {-16.2, 4.4, 0} --maybe its x,y,z z being depth.. again who the fuck knows?
ADILAD1MASK.init_rot 			= {0, 0, 0}
ADILAD1MASK.level 				= 4
ADILAD1MASK.h_clip_relation     = h_clip_relations.COMPARE
ADILAD1MASK.element_params 	  = {"R_ADI_OPACITY","ADIROLL","ADIPITCH"} --HOPE THIS WORKS G_OP_BACK
ADILAD1MASK.controllers		  = {
							{"parameter_in_range",0,0.9,1.1},
							{"rotate_using_parameter",1,1,0},
							{"move_up_down_using_parameter",2,-0.037,0},--needs to be checked with a ladder scale
							--{"opacity_using_parameter",3}
						  }

vertices(ADILAD1MASK,200)

Add(ADILAD1MASK)
-----------------------------------
ADILAD1                    	= CreateElement "ceTexPoly"
ADILAD1.name    				= "ladderdn"
ADILAD1.material			 	= LADDER_BOT
ADILAD1.change_opacity 		= false
ADILAD1.collimated 			= false
ADILAD1.isvisible 			= true
ADILAD1.init_pos 			= {-16.2, 4.4, 0} --maybe its x,y,z z being depth.. again who the fuck knows?
ADILAD1.init_rot 			= {0, 0, 0}
ADILAD1.level 				= 4
ADILAD1.h_clip_relation     = h_clip_relations.COMPARE
ADILAD1.element_params 	  = {"R_ADI_OPACITY","ADIROLL","ADIPITCH","UFD_OPACITY",} --HOPE THIS WORKS G_OP_BACK
ADILAD1.controllers		  = {
							{"parameter_in_range",0,0.9,1.1},
							{"rotate_using_parameter",1,1,0},
							{"move_up_down_using_parameter",2,-0.037,0},--needs to be checked with a ladder scale
							{"opacity_using_parameter",3}
						  }

vertices(ADILAD1,200)

Add(ADILAD1)
----------------------------
ADICENTMASK                    	= CreateElement "ceTexPoly"
ADICENTMASK.name    				= "cen"
ADICENTMASK.material			 	= ADI_CENTER_MASK
ADICENTMASK.change_opacity 		= false
ADICENTMASK.collimated 			= false
ADICENTMASK.isvisible 			= true
ADICENTMASK.init_pos 			= {-16.2, 4.4, 0} --maybe its x,y,z z being depth.. again who the fuck knows?
ADICENTMASK.init_rot 			= {0, 0, 0}
ADICENTMASK.indices 				= {0, 1, 2, 2, 3, 0}
ADICENTMASK.level 				= 4
ADICENTMASK.h_clip_relation     = h_clip_relations.COMPARE
ADICENTMASK.element_params 	  = {"R_ADI_OPACITY"} --HOPE THIS WORKS G_OP_BACK
ADICENTMASK.controllers		  = {
							--{"parameter_in_range",0,0.9,1.1},
							{"opacity_using_parameter",0}
							--{"rotate_using_parameter",1,1,0},
							--{"move_up_down_using_parameter",2,-0.094,0},--needs to be checked with a ladder scale
							--{"parameter_in_range",0,0.9,1.1}
						  }
ADICENTMASK.tex_coords =
{
    {0, 0},
    {1, 0},
    {1, 1},
    {0, 1}
}

-- local xPos = 20
-- local xNeg = -20
-- local yPos = 20
-- local yNeg = -20

ADICENTMASK.vertices = 
{
    {-20, 20},
    {20, 20},
    {20, -20},
    {-20, -20}
}

Add(ADICENTMASK)
---------------------------
ADICENT                    	= CreateElement "ceTexPoly"
ADICENT.name    				= "cen"
ADICENT.material			 	= ADI_CENTER
ADICENT.change_opacity 		= false
ADICENT.collimated 			= false
ADICENT.isvisible 			= true
ADICENT.init_pos 			= {-16.2, 4.4, 0} --maybe its x,y,z z being depth.. again who the fuck knows?
ADICENT.init_rot 			= {0, 0, 0}
ADICENT.indices 				= {0, 1, 2, 2, 3, 0}
ADICENT.level 				= 4
ADICENT.h_clip_relation     = h_clip_relations.COMPARE
ADICENT.element_params 	  = {"R_ADI_OPACITY","UFD_OPACITY",} --HOPE THIS WORKS G_OP_BACK
ADICENT.controllers		  = {
							{"parameter_in_range",0,0.9,1.1},
							{"opacity_using_parameter",1}
							--{"rotate_using_parameter",1,1,0},
							--{"move_up_down_using_parameter",2,-0.094,0},--needs to be checked with a ladder scale
							--{"parameter_in_range",0,0.9,1.1}
						  }
ADICENT.tex_coords =
{
    {0, 0},
    {1, 0},
    {1, 1},
    {0, 1}
}

-- local xPos = 20
-- local xNeg = -20
-- local yPos = 20
-- local yNeg = -20

ADICENT.vertices = 
{
    {-20, 20},
    {20, 20},
    {20, -20},
    {-20, -20}
}

Add(ADICENT)
------------------------------------------------------
local total_field_of_view2           = CreateElement "ceMeshPoly"
total_field_of_view2.name            = "total_field_of_view"
total_field_of_view2.primitivetype   = "triangles"
total_field_of_view2.vertices        = {
										{-1 * ClippingWidth,-1 * ClippingPlaneSize},
										{1 *  ClippingWidth,-1 * ClippingPlaneSize},
										{1 *  ClippingWidth,1 *  ClippingPlaneSize},
										{-1 * ClippingWidth,1 *  ClippingPlaneSize},										
									}
total_field_of_view2.material        = PFD_MASK_BASE1--PFD_MASK_BASE1
total_field_of_view2.indices         = {0,1,2,2,3,0}
total_field_of_view2.init_pos        = {0, 0, 0}
total_field_of_view2.init_rot        = { 0, 0, 0} -- degree NOT rad
total_field_of_view2.h_clip_relation = h_clip_relations.REWRITE_LEVEL
total_field_of_view2.level           = 5
total_field_of_view2.collimated      = false
total_field_of_view2.isvisible       = false
Add(total_field_of_view2)
-----------------
local clipPoly2               = CreateElement "ceMeshPoly"
clipPoly2.name                = "clipPoly-11"
clipPoly2.primitivetype       = "triangles"
clipPoly2.init_pos            = {-16.2, 4.4, 0}
clipPoly2.init_rot            = { 0, 0 , 0} -- degree NOT rad
clipPoly2.vertices            = {
								{-1 * ClippingWidth1,-1 * ClippingPlaneSize1},
								{1 *  ClippingWidth1,-1 * ClippingPlaneSize1},
								{1 *  ClippingWidth1,1 *  ClippingPlaneSize1},
								{-1 * ClippingWidth1,1 *  ClippingPlaneSize1},										
									}
clipPoly2.indices             = {0,1,2,2,3,0}
clipPoly2.material            = PFD_MASK_BASE2
clipPoly2.h_clip_relation     = h_clip_relations.INCREASE_IF_LEVEL
clipPoly2.level               = 5
clipPoly2.collimated          = false
clipPoly2.isvisible           = false
Add(clipPoly2)
-----------------------------------------------
-----------------------------------------------
BGROUND1                    	= CreateElement "ceTexPoly" --top left box
BGROUND1.name    				= "BG"
BGROUND1.material				= BLACK_MASK
BGROUND1.change_opacity 		= false
BGROUND1.collimated 			= false
BGROUND1.isvisible 				= true
BGROUND1.init_pos 				= {-51, 36.3, 0}
BGROUND1.init_rot 				= {0, 0, 0}
BGROUND1.indices 				= {0, 1, 2, 2, 3, 0}
BGROUND1.element_params 		= {"R_ADI_OPACITY"} --HOPE THIS WORKS G_OP_BACK
BGROUND1.controllers			= {{"opacity_using_parameter",0}}
BGROUND1.level 					= 6
BGROUND1.h_clip_relation     	= h_clip_relations.COMPARE

BGROUND1.tex_coords =
{
    {0, 0},
    {1, 0},
    {1, 1},
    {0, 1}
}

local levelHeight = 19 --50 was big
local levelWidth = 	24
local halfWidth = levelWidth / 2
local halfHeight = levelHeight / 2
local xPos = halfWidth
local xNeg = halfWidth * -1.0
local yPos = halfHeight
local yNeg = halfHeight * -1.0

BGROUND1.vertices = 
{
    {xNeg, yPos},
    {xPos, yPos},
    {xPos, yNeg},
    {xNeg, yNeg}
}

Add(BGROUND1)
--------------------------------------------------
local LENGRPM				= CreateElement "ceStringPoly"
LENGRPM.name				= "rad Alt"
LENGRPM.material			= UFD_GRN
LENGRPM.init_pos			= {-47, 40, 0} --L-R,U-D,F-B
LENGRPM.alignment			= "RightCenter"
LENGRPM.stringdefs			= {0.005, 0.005, 0, 0.0} --either 004 or 005
LENGRPM.additive_alpha		= true
LENGRPM.collimated			= false
LENGRPM.isdraw				= true	
LENGRPM.use_mipfilter		= true
LENGRPM.h_clip_relation		= h_clip_relations.COMPARE
LENGRPM.level				= 6
LENGRPM.element_params		= {"UFD_OPACITY","RPM_L","R_ADI_OPACITY"}
LENGRPM.formats				= {"%.0f"}--= {"%02.0f"}
LENGRPM.controllers			= {{"opacity_using_parameter",0},{"text_using_parameter",1,0},{"parameter_in_range",2,0.9,1.1}}
Add(LENGRPM)
-----------------------------------------------------------------------------------------
ENGPCTL 					= CreateElement "ceStringPoly"
ENGPCTL.name 				= "fuel numb"
ENGPCTL.material 			= UFD_GRN
ENGPCTL.value 				= "%"
ENGPCTL.stringdefs 			= {0.005, 0.005, 0, 0.0} --either 004 or 005
ENGPCTL.alignment 			= "CenterCenter"
ENGPCTL.formats 			= {"%s"}
ENGPCTL.h_clip_relation    	= h_clip_relations.COMPARE
ENGPCTL.level 				= 6
ENGPCTL.init_pos 			= {-44, 40, 0}
ENGPCTL.init_rot 			= {0, 0, 0}
ENGPCTL.element_params 	= {"R_ADI_OPACITY","UFD_OPACITY",} --HOPE THIS WORKS G_OP_BACK
ENGPCTL.controllers		= {
								{"parameter_in_range",0,0.9,1.1},
								{"opacity_using_parameter",1},
								}
Add(ENGPCTL)
----------------------------------------------------------------------------------------------------------------------
ENGDEGL 					= CreateElement "ceStringPoly"
ENGDEGL.name 				= "fuel numb"
ENGDEGL.material 			= UFD_GRN
ENGDEGL.value 				= "d"
ENGDEGL.stringdefs 			= {0.005, 0.005, 0, 0.0} --either 004 or 005
ENGDEGL.alignment 			= "CenterCenter"
ENGDEGL.formats 			= {"%s"}
ENGDEGL.h_clip_relation    	= h_clip_relations.COMPARE
ENGDEGL.level 				= 6
ENGDEGL.init_pos 			= {-44, 33, 0}
ENGDEGL.init_rot 			= {0, 0, 0}
ENGDEGL.element_params 	= {"R_ADI_OPACITY","UFD_OPACITY",} --HOPE THIS WORKS G_OP_BACK
ENGDEGL.controllers		= {
								{"parameter_in_range",0,0.9,1.1},
								{"opacity_using_parameter",1},
								}
Add(ENGDEGL)
local LENGEGT				= CreateElement "ceStringPoly"
LENGEGT.name				= "rad Alt"
LENGEGT.material			= UFD_GRN
LENGEGT.init_pos			= {-47, 33, 0} --L-R,U-D,F-B
LENGEGT.alignment			= "RightCenter"
LENGEGT.stringdefs			= {0.005, 0.005, 0, 0.0} --either 004 or 005
LENGEGT.additive_alpha		= true
LENGEGT.collimated			= false
LENGEGT.isdraw				= true	
LENGEGT.use_mipfilter		= true
LENGEGT.h_clip_relation		= h_clip_relations.COMPARE
LENGEGT.level				= 6
LENGEGT.element_params		= {"UFD_OPACITY","EGT_L","R_ADI_OPACITY"}
LENGEGT.formats				= {"%.0f"}--= {"%02.0f"}
LENGEGT.controllers			= {{"opacity_using_parameter",0},{"text_using_parameter",1,0},{"parameter_in_range",2,0.9,1.1}}
Add(LENGEGT)
-----------------------------------------------------------------------------------------
----------------------------------
---------------------------------------------------------------
BGROUND1a                    = CreateElement "ceTexPoly" --top center box
BGROUND1a.name    			= "BG"
BGROUND1a.material			= BLACK_MASK
BGROUND1a.change_opacity 		= false
BGROUND1a.collimated 			= false
BGROUND1a.isvisible 			= true
BGROUND1a.init_pos 			= {-16.8, 42, 0}
BGROUND1a.init_rot 			= {0, 0, 0}
BGROUND1a.indices 			= {0, 1, 2, 2, 3, 0}
BGROUND1a.element_params 		= {"R_ADI_OPACITY","R_ADI_OPACITY"}
BGROUND1a.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
BGROUND1a.level 				= 6
BGROUND1a.h_clip_relation     = h_clip_relations.COMPARE

BGROUND1a.tex_coords =
{
    {0, 0},
    {1, 0},
    {1, 1},
    {0, 1}
}

local levelHeight = 10 --50 was big
local levelWidth = 	15
local halfWidth = levelWidth / 2
local halfHeight = levelHeight / 2
local xPos = halfWidth
local xNeg = halfWidth * -1.0
local yPos = halfHeight
local yNeg = halfHeight * -1.0

BGROUND1a.vertices = 
{
    {xNeg, yPos},
    {xPos, yPos},
    {xPos, yNeg},
    {xNeg, yNeg}
}

Add(BGROUND1a)
----------------------------------------------------------------
--Heading Digital
local NAV				= CreateElement "ceStringPoly"
NAV.name				= "Navigation"
NAV.material			= UFD_FONT
NAV.init_pos			= {-16.8, 40.8, 0} --L-R,U-D,F-B
NAV.alignment			= "CenterCenter"
NAV.stringdefs			= {0.006, 0.006, 0, 0.0} --either 004 or 005
NAV.additive_alpha		= true
NAV.collimated			= false
NAV.isdraw				= true	
NAV.use_mipfilter		= true
NAV.h_clip_relation		= h_clip_relations.COMPARE
NAV.level				= 6
NAV.element_params		= {"R_ADI_OPACITY","NAV","UFD_OPACITY"}
NAV.formats				= {"%03.0f"}
NAV.controllers			= {{"parameter_in_range",0,0.9,1.1},{"text_using_parameter",1,0},{"opacity_using_parameter",2}}
Add(NAV)
----------------------------------------------------
BGROUND2                    = CreateElement "ceTexPoly" --top right box
BGROUND2.name    			= "BG"
BGROUND2.material			= BLACK_MASK
BGROUND2.change_opacity 		= false
BGROUND2.collimated 			= false
BGROUND2.isvisible 			= true
BGROUND2.init_pos 			= {18.75, 36.3, 0}
BGROUND2.init_rot 			= {0, 0, 0}
BGROUND2.indices 			= {0, 1, 2, 2, 3, 0}
BGROUND2.element_params 		= {"R_ADI_OPACITY"} --HOPE THIS WORKS G_OP_BACK
BGROUND2.controllers			= {{"opacity_using_parameter",0}}
BGROUND2.level 				= 6
BGROUND2.h_clip_relation     = h_clip_relations.COMPARE

BGROUND2.tex_coords =
{
    {0, 0},
    {1, 0},
    {1, 1},
    {0, 1}
}

local levelHeight = 19 --50 was big
local levelWidth = 	24
local halfWidth = levelWidth / 2
local halfHeight = levelHeight / 2
local xPos = halfWidth
local xNeg = halfWidth * -1.0
local yPos = halfHeight
local yNeg = halfHeight * -1.0

BGROUND2.vertices = 
{
    {xNeg, yPos},
    {xPos, yPos},
    {xPos, yNeg},
    {xNeg, yNeg}
}

Add(BGROUND2)
--------------------------------
--------------------------------------------------
local RENGRPM				= CreateElement "ceStringPoly"
RENGRPM.name				= "rad Alt"
RENGRPM.material			= UFD_GRN
RENGRPM.init_pos			= {20, 40, 0} --L-R,U-D,F-B
RENGRPM.alignment			= "RightCenter"
RENGRPM.stringdefs			= {0.005, 0.005, 0, 0.0} --either 004 or 005
RENGRPM.additive_alpha		= true
RENGRPM.collimated			= false
RENGRPM.isdraw				= true	
RENGRPM.use_mipfilter		= true
RENGRPM.h_clip_relation		= h_clip_relations.COMPARE
RENGRPM.level				= 6
RENGRPM.element_params		= {"UFD_OPACITY","RPM_R","R_ADI_OPACITY"}
RENGRPM.formats				= {"%.0f"}--= {"%02.0f"}
RENGRPM.controllers			= {{"opacity_using_parameter",0},{"text_using_parameter",1,0},{"parameter_in_range",2,0.9,1.1}}
Add(RENGRPM)
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
ENGPCTR 					= CreateElement "ceStringPoly"
ENGPCTR.name 				= "fuel numb"
ENGPCTR.material 			= UFD_GRN
ENGPCTR.value 				= "%"
ENGPCTR.stringdefs 			= {0.005, 0.005, 0, 0.0} --either 004 or 005
ENGPCTR.alignment 			= "CenterCenter"
ENGPCTR.formats 			= {"%s"}
ENGPCTR.h_clip_relation    	= h_clip_relations.COMPARE
ENGPCTR.level 				= 6
ENGPCTR.init_pos 			= {23, 40, 0}
ENGPCTR.init_rot 			= {0, 0, 0}
ENGPCTR.element_params 		= {"R_ADI_OPACITY","UFD_OPACITY",} --HOPE THIS WORKS G_OP_BACK
ENGPCTR.controllers			= {
								{"parameter_in_range",0,0.9,1.1},
								{"opacity_using_parameter",1},
								}
Add(ENGPCTR)
----------------------------------------------------------------------------------------------------------------------
ENGDEGR 					= CreateElement "ceStringPoly"
ENGDEGR.name 				= "fuel numb"
ENGDEGR.material 			= UFD_GRN
ENGDEGR.value 				= "d"
ENGDEGR.stringdefs 			= {0.005, 0.005, 0, 0.0} --either 004 or 005
ENGDEGR.alignment 			= "CenterCenter"
ENGDEGR.formats 			= {"%s"}
ENGDEGR.h_clip_relation    	= h_clip_relations.COMPARE
ENGDEGR.level 				= 6
ENGDEGR.init_pos 			= {23, 33, 0}
ENGDEGR.init_rot 			= {0, 0, 0}
ENGDEGR.element_params 	= {"R_ADI_OPACITY","UFD_OPACITY",} --HOPE THIS WORKS G_OP_BACK
ENGDEGR.controllers		= {
								{"parameter_in_range",0,0.9,1.1},
								{"opacity_using_parameter",1},
								}
Add(ENGDEGR)
--------------------------------------------------
local RENGEGT				= CreateElement "ceStringPoly"
RENGEGT.name				= "rad Alt"
RENGEGT.material			= UFD_GRN
RENGEGT.init_pos			= {20, 33, 0} --L-R,U-D,F-B
RENGEGT.alignment			= "RightCenter"
RENGEGT.stringdefs			= {0.005, 0.005, 0, 0.0} --either 004 or 005
RENGEGT.additive_alpha		= true
RENGEGT.collimated			= false
RENGEGT.isdraw				= true	
RENGEGT.use_mipfilter		= true
RENGEGT.h_clip_relation		= h_clip_relations.COMPARE
RENGEGT.level				= 6
RENGEGT.element_params		= {"UFD_OPACITY","EGT_R","R_ADI_OPACITY"}
RENGEGT.formats				= {"%.0f"}--= {"%02.0f"}
RENGEGT.controllers			= {{"opacity_using_parameter",0},{"text_using_parameter",1,0},{"parameter_in_range",2,0.9,1.1}}
Add(RENGEGT)
----------------------------------
BGROUND3                    = CreateElement "ceTexPoly" -- speed box left
BGROUND3.name    			= "BG"
BGROUND3.material			= BLACK_MASK
BGROUND3.change_opacity 		= false
BGROUND3.collimated 			= false
BGROUND3.isvisible 			= true
BGROUND3.init_pos 			= {-56, 4.4, 0}
BGROUND3.init_rot 			= {0, 0, 0}
BGROUND3.indices 			= {0, 1, 2, 2, 3, 0}
BGROUND3.element_params 		= {"R_ADI_OPACITY"} --HOPE THIS WORKS G_OP_BACK
BGROUND3.controllers			= {{"opacity_using_parameter",0}}
BGROUND3.level 				= 6
BGROUND3.h_clip_relation     = h_clip_relations.COMPARE

BGROUND3.tex_coords =
{
    {0, 0},
    {1, 0},
    {1, 1},
    {0, 1}
}

BGROUND3.vertices = 
{
    {-12, 5},
    {12, 5},
    {12, -5},
    {-12, -5}
}

Add(BGROUND3)
---------------------------------------------------------------------
--Indicated Airspeed
local IAS				= CreateElement "ceStringPoly"
IAS.name				= "Indicated Airspeed"
IAS.material			= UFD_FONT
IAS.init_pos			= {-60, 4.4, 0} --L-R,U-D,F-B
IAS.alignment			= "LeftCenter"
IAS.stringdefs			= {0.007, 0.007, 0, 0.0} --either 004 or 005
IAS.additive_alpha		= true
IAS.collimated			= false
IAS.isdraw				= true	
IAS.use_mipfilter		= true
IAS.h_clip_relation	= h_clip_relations.COMPARE
IAS.level				= 6
IAS.element_params		= {"UFD_OPACITY","IAS","R_ADI_OPACITY"}
IAS.formats				= {"%03.0f"} --{"%.0f"}
IAS.controllers			= {{"opacity_using_parameter",0},{"text_using_parameter",1,0},{"parameter_in_range",2,0.9,1.1}}
Add(IAS)
---------------------------------------------------------------------
BGROUND4                    = CreateElement "ceTexPoly" -- alt box right
BGROUND4.name    			= "BG"
BGROUND4.material			= BLACK_MASK
BGROUND4.change_opacity 		= false
BGROUND4.collimated 			= false
BGROUND4.isvisible 			= true
BGROUND4.init_pos 			= {17, 4.4, 0}
BGROUND4.init_rot 			= {0, 0, 0}
BGROUND4.indices 			= {0, 1, 2, 2, 3, 0}
BGROUND4.element_params 		= {"R_ADI_OPACITY"} --HOPE THIS WORKS G_OP_BACK
BGROUND4.controllers			= {{"opacity_using_parameter",0}}
BGROUND4.level 				= 6
BGROUND4.h_clip_relation     = h_clip_relations.COMPARE

BGROUND4.tex_coords =
{
    {0, 0},
    {1, 0},
    {1, 1},
    {0, 1}
}


BGROUND4.vertices = 
{
    {-12, 5},
    {12, 5},
    {12, -5},
    {-12, -5}
}

Add(BGROUND4)
-----------------------------------------------------
--Barometric Alt
local BARO				= CreateElement "ceStringPoly"
BARO.name				= "Baro Alt"
BARO.material			= UFD_FONT
BARO.init_pos			= {26.5, 4.4, 0} --L-R,U-D,F-B
BARO.alignment			= "RightCenter"
BARO.stringdefs			= {0.006, 0.006, 0, 0.0} --either 004 or 005
BARO.additive_alpha		= true
BARO.collimated			= false
BARO.isdraw				= true
BARO.use_mipfilter		= true
BARO.h_clip_relation	= h_clip_relations.COMPARE
BARO.level				= 6
BARO.element_params		= {"UFD_OPACITY","SMOOTH_ALT","R_ADI_OPACITY"}
BARO.formats			= {"%05.0f"}
BARO.controllers		= {{"opacity_using_parameter",0},{"text_using_parameter",1,0},{"parameter_in_range",2,0.9,1.1}}
Add(BARO)
-----------------------------------------------------
BGROUND5                    = CreateElement "ceTexPoly" -- alt box right lower
BGROUND5.name    			= "BG"
BGROUND5.material			= BLACK_MASK
BGROUND5.change_opacity 		= false
BGROUND5.collimated 			= false
BGROUND5.isvisible 			= true
BGROUND5.init_pos 			= {18.7, -33.5, 0}
BGROUND5.init_rot 			= {0, 0, 0}
BGROUND5.indices 			= {0, 1, 2, 2, 3, 0}
BGROUND5.element_params 		= {"R_ADI_OPACITY"} --HOPE THIS WORKS G_OP_BACK
BGROUND5.controllers			= {{"opacity_using_parameter",0}}
BGROUND5.level 				= 6
BGROUND5.h_clip_relation     = h_clip_relations.COMPARE

BGROUND5.tex_coords =
{
    {0, 0},
    {1, 0},
    {1, 1},
    {0, 1}
}

BGROUND5.vertices = 
{
    {-12, 5},
    {12, 5},
    {12, -5},
    {-12, -5}
}

Add(BGROUND5)
--------------------------------------------------------------------------
local RADALT				= CreateElement "ceStringPoly"
RADALT.name				= "rad Alt"
RADALT.material			= UFD_FONT
RADALT.init_pos			= {26, -32.5, 0} --L-R,U-D,F-B
RADALT.alignment			= "RightCenter"
RADALT.stringdefs			= {0.005, 0.005, 0, 0.0} --either 004 or 005
RADALT.additive_alpha		= true
RADALT.collimated			= false
RADALT.isdraw				= true	
RADALT.use_mipfilter		= true
RADALT.h_clip_relation	= h_clip_relations.COMPARE
RADALT.level				= 6
RADALT.element_params		= {"UFD_OPACITY","SMOOTH_RAD_ALT","R_ADI_OPACITY"}
RADALT.formats			= {"%05.0f"}
RADALT.controllers		= {{"opacity_using_parameter",0},{"text_using_parameter",1,0},{"parameter_in_range",2,0.9,1.1}}
Add(RADALT)

---------------------------------------------------------------------TRIM--STOP
ADITRIMMASK                    	= CreateElement "ceTexPoly"
ADITRIMMASK.name    				= "trim"
ADITRIMMASK.material			 	= ADI_TRIM_MASK
ADITRIMMASK.change_opacity 		= false
ADITRIMMASK.collimated 			= false
ADITRIMMASK.isvisible 			= true
ADITRIMMASK.init_pos 			= {0, 0, 0} --maybe its x,y,z z being depth.. again who the fuck knows?
ADITRIMMASK.init_rot 			= {0, 0, 0}
ADITRIMMASK.level 				= 6
ADITRIMMASK.h_clip_relation     = h_clip_relations.COMPARE
ADITRIMMASK.element_params 	  = {"R_ADI_OPACITY"} --HOPE THIS WORKS G_OP_BACK
ADITRIMMASK.controllers		  = {
							{"parameter_in_range",0,0.9,1.1},
							--{"rotate_using_parameter",1,1,0},
							--{"move_up_down_using_parameter",2,-0.094,0},--needs to be checked with a ladder scale
						  }
						  
vertices(ADITRIMMASK,199)

Add(ADITRIMMASK)
---------------------------------------------------------------------
ADITRIM                    	= CreateElement "ceTexPoly"
ADITRIM.name    				= "trim"
ADITRIM.material			 	= ADI_TRIM
ADITRIM.change_opacity 		= false
ADITRIM.collimated 			= false
ADITRIM.isvisible 			= true
ADITRIM.init_pos 			= {0, 0, 0} --maybe its x,y,z z being depth.. again who the fuck knows?
ADITRIM.init_rot 			= {0, 0, 0}
ADITRIM.level 				= 6
ADITRIM.h_clip_relation     = h_clip_relations.COMPARE
ADITRIM.element_params 	  = {"R_ADI_OPACITY","UFD_OPACITY",} --HOPE THIS WORKS G_OP_BACK
ADITRIM.controllers		  = {
							{"parameter_in_range",0,0.9,1.1},
							--{"rotate_using_parameter",1,1,0},
							--{"move_up_down_using_parameter",2,-0.094,0},--needs to be checked with a ladder scale
							{"opacity_using_parameter",1},
						  }
						  
vertices(ADITRIM,199)

Add(ADITRIM)
-------------------------------------------
local ClippingPlaneSize3 = 29 --Clipping Masks   --50
local ClippingWidth3 	= 5.40 --Clipping Masks	--85
--Clipping Masks
local total_field_of_view3           = CreateElement "ceMeshPoly"
total_field_of_view3.name            = "total_field_of_view"
total_field_of_view3.primitivetype   = "triangles"
total_field_of_view3.vertices        = {
										{-1 * ClippingWidth,-1 * ClippingPlaneSize},
										{1 *  ClippingWidth,-1 * ClippingPlaneSize},
										{1 *  ClippingWidth,1 *  ClippingPlaneSize},
										{-1 * ClippingWidth,1 *  ClippingPlaneSize},										
									}
total_field_of_view3.material        = PFD_MASK_BASE1
total_field_of_view3.indices         = {0,1,2,2,3,0}
total_field_of_view3.init_pos        = {0, 0, 0}
total_field_of_view3.init_rot        = { 0, 0, 0} -- degree NOT rad
total_field_of_view3.h_clip_relation = h_clip_relations.REWRITE_LEVEL
total_field_of_view3.level           = 7
total_field_of_view3.collimated      = false
total_field_of_view3.isvisible       = false
Add(total_field_of_view3)

local clipPoly3               = CreateElement "ceMeshPoly"
clipPoly3.name                = "clipPoly-3"
clipPoly3.primitivetype       = "triangles"
clipPoly3.init_pos            = {43, -7.8, 0}
clipPoly3.init_rot            = { 0, 0 , 0} -- degree NOT rad
clipPoly3.vertices            = {
								{-1 * ClippingWidth3,-1 * ClippingPlaneSize3},
								{1 *  ClippingWidth3,-1 * ClippingPlaneSize3},
								{1 *  ClippingWidth3,1 *  ClippingPlaneSize3},
								{-1 * ClippingWidth3,1 *  ClippingPlaneSize3},										
									}
clipPoly3.indices             = {0,1,2,2,3,0}
clipPoly3.material            = PFD_MASK_BASE2
clipPoly3.h_clip_relation     = h_clip_relations.INCREASE_IF_LEVEL
clipPoly3.level               = 7
clipPoly3.collimated          = false
clipPoly3.isvisible           = false
Add(clipPoly3)
----------------------------------------------------
FUELLINEM                    = CreateElement "ceTexPoly"
FUELLINEM.name    			= "BG"
FUELLINEM.material			= FUEL_LINE_M
FUELLINEM.change_opacity 		= false
FUELLINEM.collimated 			= false
FUELLINEM.isvisible 			= true
FUELLINEM.init_pos 			= {43, -77, 0} --maybe its x,y,z z being depth.. again who the fuck knows?
FUELLINEM.element_params 		= {"R_ADI_OPACITY"} --HOPE THIS WORKS G_OP_BACK
FUELLINEM.controllers			= {{"parameter_in_range",0,0.9,1.1}}
FUELLINEM.level 				= 8
FUELLINEM.h_clip_relation     = h_clip_relations.COMPARE
vertices(FUELLINEM,80,true)
----------------------------------------------------------------------------------------------------------
--888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
--888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
FUELLINEMASK                    	= CreateElement "ceTexPoly"
FUELLINEMASK.name    				= "BG"
FUELLINEMASK.material				= FUEL_LINE_MASK
FUELLINEMASK.change_opacity 		= false
FUELLINEMASK.collimated 			= false
FUELLINEMASK.isvisible 				= true
FUELLINEMASK.init_pos 				= {43, -77, 0} --maybe its x,y,z z being depth.. again who the fuck knows?
--FUELLINE.init_rot 			= {0, 0, 0}
FUELLINEMASK.element_params 		= {"FUELL","R_ADI_OPACITY"} --HOPE THIS WORKS G_OP_BACK
--FUELLINE.element_params 		= {"UFD_OPACITY","L_ADI_OPACITY"} --HOPE THIS WORKS G_OP_BACK
FUELLINEMASK.controllers			= 	{
								   			{"move_up_down_using_parameter",0,0.00081,0}, --{"move_up_down_using_parameter",0,0.00052,0},
								   			{"parameter_in_range",1,0.9,1.1}
								  		}
FUELLINEMASK.level 					= 8
FUELLINEMASK.h_clip_relation     	= h_clip_relations.COMPARE
vertices(FUELLINEMASK,80,true)

Add(FUELLINEMASK)
----------------------------------------------------------------------------------------------------------
FUELLINE                    = CreateElement "ceTexPoly"
FUELLINE.name    			= "BG"
FUELLINE.material			= FUEL_LINE
FUELLINE.change_opacity 		= false
FUELLINE.collimated 			= false
FUELLINE.isvisible 			= true
FUELLINE.init_pos 			= {43, -77, 0} --maybe its x,y,z z being depth.. again who the fuck knows?
--FUELLINE.init_rot 			= {0, 0, 0}
FUELLINE.element_params 		= {"UFD_OPACITY","FUELL","R_ADI_OPACITY"} --HOPE THIS WORKS G_OP_BACK
--FUELLINE.element_params 		= {"UFD_OPACITY","L_ADI_OPACITY"} --HOPE THIS WORKS G_OP_BACK
FUELLINE.controllers			= {{"opacity_using_parameter",0},
								   {"move_up_down_using_parameter",1,0.00081,0},
								   {"parameter_in_range",2,0.9,1.1}


								  }
FUELLINE.level 				= 8
FUELLINE.h_clip_relation     = h_clip_relations.COMPARE
vertices(FUELLINE,80,true)

Add(FUELLINE)
--888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
--888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888ORIGINAL END

--888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
--888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
FUELLINEMASKLOWER                    	= CreateElement "ceTexPoly"
FUELLINEMASKLOWER.name    				= "BG"
FUELLINEMASKLOWER.material				= FUEL_LINE_MASK
FUELLINEMASKLOWER.change_opacity 		= false
FUELLINEMASKLOWER.collimated 			= false
FUELLINEMASKLOWER.isvisible 				= true
FUELLINEMASKLOWER.init_pos 				= {43, -154, 0} --77 --maybe its x,y,z z being depth.. again who the fuck knows?
--FUELLINE.init_rot 			= {0, 0, 0}
FUELLINEMASKLOWER.element_params 		= {"FUELL","R_ADI_OPACITY"} --HOPE THIS WORKS G_OP_BACK
--FUELLINE.element_params 		= {"UFD_OPACITY","L_ADI_OPACITY"} --HOPE THIS WORKS G_OP_BACK
FUELLINEMASKLOWER.controllers			= 	{
								   			{"move_up_down_using_parameter",0,0.00081,0}, --{"move_up_down_using_parameter",0,0.00052,0},
								   			{"parameter_in_range",1,0.9,1.1}
								  		}
FUELLINEMASKLOWER.level 					= 8
FUELLINEMASKLOWER.h_clip_relation     	= h_clip_relations.COMPARE
vertices(FUELLINEMASKLOWER,80,true)

Add(FUELLINEMASKLOWER)
----------------------------------------------------------------------------------------------------------
FUELLINEL                    = CreateElement "ceTexPoly"
FUELLINEL.name    			= "BG"
FUELLINEL.material			= FUEL_LINE
FUELLINEL.change_opacity 		= false
FUELLINEL.collimated 			= false
FUELLINEL.isvisible 			= true
FUELLINEL.init_pos 			= {43, -154, 0} --maybe its x,y,z z being depth.. again who the fuck knows?
--FUELLINE.init_rot 			= {0, 0, 0}
FUELLINEL.element_params 		= {"UFD_OPACITY","FUELL","R_ADI_OPACITY"} --HOPE THIS WORKS G_OP_BACK
--FUELLINE.element_params 		= {"UFD_OPACITY","L_ADI_OPACITY"} --HOPE THIS WORKS G_OP_BACK
FUELLINEL.controllers			= {{"opacity_using_parameter",0},
								   {"move_up_down_using_parameter",1,0.00081,0},
								   {"parameter_in_range",2,0.9,1.1}


								  }
FUELLINEL.level 				= 8
FUELLINEL.h_clip_relation     = h_clip_relations.COMPARE
vertices(FUELLINEL,80,true)

Add(FUELLINEL)

