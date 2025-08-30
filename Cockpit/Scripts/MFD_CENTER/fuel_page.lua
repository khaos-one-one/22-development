dofile(LockOn_Options.script_path.."MFD_CENTER/definitions.lua")
dofile(LockOn_Options.script_path.."fonts.lua")
dofile(LockOn_Options.script_path.."materials.lua")
SetScale(FOV)

local function vertices(object, height, half_or_double)
    local width = height
    
    if half_or_double == true then --
        width = 0.98
    end

    if half_or_double == false then
        width = 0.12 --change this 
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
local BlackColor  			= {0, 0, 0, 255}--RGBA
local WhiteColor 			= {255, 255, 255, 255}--RGBA
local MainColor 			= {255, 255, 255, 255}--RGBA
local GreenColor 		    = {0, 255, 0, 255}--RGBA
local YellowColor 			= {255, 255, 0, 255}--RGBA
local OrangeColor           = {255, 255, 0, 255}--RGBA
local RedColor 				= {255, 0, 0, 255}--RGBA
local TealColor 			= {0, 100, 100, 255}--RGBA
local ScreenColor			= {3, 3, 3, 255}--RGBA

--------------------------------------------------------------------------------------------------------------------------------------------
local REFLECT	 = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/reflection.dds", ScreenColor)
local FUEL_MASK     = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/fuel_mask.dds", BlackColor)
local FUEL_BOX      = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/fuel_box.dds", BlackColor)
local FUEL_IND      = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/fuel_ind.dds", WhiteColor)
local FUEL_PAGE     = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/fuel_frame.dds", GreenColor)
local FUEL_JETT     = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/fuel_frame_jett.dds", WhiteColor)

local FUEL_BOX_BL   = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/fuel_box.dds", ScreenColor)
local FUEL_MASK_BL  = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/fuel_mask.dds", ScreenColor)
local MASK_BOX	    = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mask_box.dds", ScreenColor)
local TEAL  	    = MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/mask_box.dds", TealColor)
local FUEL_IQT  	= MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/fuel_iqt.dds", TealColor)
local FUEL_TQT  	= MakeMaterial(LockOn_Options.script_path.."../Scripts/IndicationTextures/fuel_tqt.dds", TealColor)

--------------------------------------------------------------------------------------------------------------------------------------------
local ClippingPlaneSize = 1.1 --Clipping Masks
local ClippingWidth 	= 1.1 --Clipping Masks
local PFD_MASK_BASE1 	= MakeMaterial(nil,{255,0,0,255})--Clipping Masks
local PFD_MASK_BASE2 	= MakeMaterial(nil,{0,255,0,255})--Clipping Masks
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
total_field_of_view.init_rot        = { 0, 0, 0}
total_field_of_view.h_clip_relation = h_clip_relations.REWRITE_LEVEL
total_field_of_view.level           = 1
total_field_of_view.collimated      = false
total_field_of_view.isvisible       = false
Add(total_field_of_view)
--Clipping Masks
local clipPoly               = CreateElement "ceMeshPoly"
clipPoly.name                = "clipPoly-1"
clipPoly.primitivetype       = "triangles"
clipPoly.init_pos            = {0, 0, 0}
clipPoly.init_rot            = { 0, 0 , 0}
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
-----------------------------------------------------------------------------------------BASE BACKLIGHT
BGROUND                    = CreateElement "ceTexPoly"
BGROUND.name    			= "BG"
BGROUND.material			= REFLECT
BGROUND.change_opacity 		= false
BGROUND.collimated 			= false
BGROUND.isvisible 			= true
BGROUND.init_pos 			= {0, 0, 0}
BGROUND.init_rot 			= {0, 0, 0}
BGROUND.element_params 		= {"MFD_OPACITY","CMFD_FUEL_PAGE"}
BGROUND.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
BGROUND.level 				= 2
BGROUND.h_clip_relation     = h_clip_relations.COMPARE
vertices(BGROUND,2)
Add(BGROUND)
-----------------------------------------------------------------------------------------------TEAL FUEL QUANT------------------------------------------------------------------------------------------------
FUELQTY                    = CreateElement "ceTexPoly"
FUELQTY.name    			= "FUELQTY"
FUELQTY.material			= FUEL_IQT
FUELQTY.change_opacity 		= false
FUELQTY.collimated 			= false
FUELQTY.isvisible 			= true
FUELQTY.init_pos 			= {0, -1.1, 0}
FUELQTY.init_rot 			= {0, 0, 0}
FUELQTY.element_params 		= {"MFD_OPACITY","CMFD_FUEL_PAGE","FUEL"}
FUELQTY.controllers			= {
                                {"opacity_using_parameter",0},
                                {"parameter_in_range",1,0.9,1.1},
                                {"move_up_down_using_parameter",2,0.00000580,0} 
                            }
FUELQTY.level 				= 2
FUELQTY.h_clip_relation     = h_clip_relations.COMPARE
vertices(FUELQTY,2)
Add(FUELQTY)
-------------------------------------------------------------------------------------------------TEAL FUEL QUANT2------------------------------------------------------------------------------------------------
FUELQTY2                    = CreateElement "ceTexPoly"
FUELQTY2.name    			= "FUELQTY2"
FUELQTY2.material			= FUEL_IQT
FUELQTY2.change_opacity 	= false
FUELQTY2.collimated 		= false
FUELQTY2.isvisible 			= true
FUELQTY2.init_pos 			= {0, -1.8, 0} 
FUELQTY2.init_rot 			= {0, 0, 0}
FUELQTY2.element_params 		= {"MFD_OPACITY","CMFD_FUEL_PAGE","FUEL"}
FUELQTY2.controllers			= {
                                {"opacity_using_parameter",0},
                                {"parameter_in_range",1,0.9,1.1},
                                {"move_up_down_using_parameter",2,0.00000580,0}	
                            }
FUELQTY2.level 				= 2
FUELQTY2.h_clip_relation     = h_clip_relations.COMPARE
vertices(FUELQTY2,2)
Add(FUELQTY2)
-----------------------------------------------------------------------------------------------TEAL-FUEL-TANK-QUANT------------------------------------------------------------------------------------------------
FUELQTY_TANK                        = CreateElement "ceTexPoly"
FUELQTY_TANK.name    			    = "FUELQTY_TANK"
FUELQTY_TANK.material			    = FUEL_TQT
FUELQTY_TANK.change_opacity 	    = false
FUELQTY_TANK.collimated 		    = false
FUELQTY_TANK.isvisible 		        = true
FUELQTY_TANK.init_pos 			    = {0, -0.59, 0}
FUELQTY_TANK.init_rot 			    = {0, 0, 0}
FUELQTY_TANK.element_params 	    = {"MFD_OPACITY","CMFD_FUEL_PAGE","FUELT"}
FUELQTY_TANK.controllers		    =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},
                                            {"move_up_down_using_parameter",2,0.00000405,0},
											{"parameter_in_range",2,0.1,8400},
                                        }
FUELQTY_TANK.level 			        = 2
FUELQTY_TANK.h_clip_relation        = h_clip_relations.COMPARE
vertices(FUELQTY_TANK,2)
Add(FUELQTY_TANK)
--------------------------------------------------------------------------------------------------ALL-BLACK-MASK-NO-OPACITY-----------------------
FUEL_BLK                    = CreateElement "ceTexPoly"
FUEL_BLK.name    			= "BG"
FUEL_BLK.material			= FUEL_MASK
FUEL_BLK.change_opacity 	= false
FUEL_BLK.collimated 		= false
FUEL_BLK.isvisible 			= true
FUEL_BLK.init_pos 			= {0, 0, 0} 
FUEL_BLK.init_rot 			= {0, 0, 0}
FUEL_BLK.element_params 	= {"CMFD_FUEL_PAGE","MAIN_POWER"}
FUEL_BLK.controllers		= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
FUEL_BLK.level 				= 2
FUEL_BLK.h_clip_relation    = h_clip_relations.COMPARE
vertices(FUEL_BLK,2)
Add(FUEL_BLK)
--------------------------------------------------------------------------------------ALL-BLACK-MASK-WITH-BACKLIGHT-MATERIAL
BGROUND1                    = CreateElement "ceTexPoly"
BGROUND1.name    			= "BG"
BGROUND1.material			= FUEL_MASK_BL
BGROUND1.change_opacity 	= false
BGROUND1.collimated 		= false
BGROUND1.isvisible 			= true
BGROUND1.init_pos 			= {0, 0, 0} --L-R,U-D,F-B
BGROUND1.init_rot 			= {0, 0, 0}
BGROUND1.element_params 	= {"MFD_OPACITY","CMFD_FUEL_PAGE"}
BGROUND1.controllers		= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
BGROUND1.level 				= 2
BGROUND1.h_clip_relation    = h_clip_relations.COMPARE
vertices(BGROUND1,2)
Add(BGROUND1)
-------------------------------------------------------------------------FUEL PAGE GREEN LINES
FUELFRAME                    = CreateElement "ceTexPoly"
FUELFRAME.name    			= "FUELFRAME"
FUELFRAME.material			= FUEL_PAGE
FUELFRAME.change_opacity 		= false
FUELFRAME.collimated 			= false
FUELFRAME.isvisible 			= true
FUELFRAME.init_pos 			= {0, 0, 0} 
FUELFRAME.init_rot 			= {0, 0, 0}
FUELFRAME.element_params 		= {"MFD_OPACITY","CMFD_FUEL_PAGE"}
FUELFRAME.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
FUELFRAME.level 				= 2
FUELFRAME.h_clip_relation     = h_clip_relations.COMPARE
vertices(FUELFRAME,2)
Add(FUELFRAME)
-------------------------------------------------------------------------FUEL JETT
FUELFRAME_JETT                    = CreateElement "ceTexPoly"
FUELFRAME_JETT.name    				= "FUELFRAME_JETT"
FUELFRAME_JETT.material				= FUEL_JETT
FUELFRAME_JETT.change_opacity 		= false
FUELFRAME_JETT.collimated 			= false
FUELFRAME_JETT.isvisible 			= true
FUELFRAME_JETT.init_pos 			= {0, 0.515, 0} 
FUELFRAME_JETT.init_rot 			= {0, 0, 0}
FUELFRAME_JETT.element_params 		= {"MFD_OPACITY","CMFD_FUEL_PAGE"}
FUELFRAME_JETT.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
FUELFRAME_JETT.level 				= 2
FUELFRAME_JETT.h_clip_relation     = h_clip_relations.COMPARE
vertices(FUELFRAME_JETT,2)
Add(FUELFRAME_JETT)
--------------------------------------------------------------------------------------------------ALL-BLACK-MASK-NO-OPACITY-----------------------
FUEL_BX                    = CreateElement "ceTexPoly"
FUEL_BX.name    			= "FUEL_BX"
FUEL_BX.material			= FUEL_BOX
FUEL_BX.change_opacity 		= false
FUEL_BX.collimated 			= false
FUEL_BX.isvisible 			= true
FUEL_BX.init_pos 			= {0, 0, 0} 
FUEL_BX.init_rot 			= {0, 0, 0}
FUEL_BX.element_params 		= {"CMFD_FUEL_PAGE","MAIN_POWER"}
FUEL_BX.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
FUEL_BX.level 				= 2
FUEL_BX.h_clip_relation     = h_clip_relations.COMPARE
vertices(FUEL_BX,2)
Add(FUEL_BX)
--------------------------------------------------------------------------------------------------ALL-BLACK-MASK-NO-OPACITY-----------------------
FUEL_BX_BL                    = CreateElement "ceTexPoly"
FUEL_BX_BL.name    			= "FUEL_BX_BL"
FUEL_BX_BL.material			= FUEL_BOX_BL
FUEL_BX_BL.change_opacity 		= false
FUEL_BX_BL.collimated 			= false
FUEL_BX_BL.isvisible 			= true
FUEL_BX_BL.init_pos 			= {0, 0, 0} 
FUEL_BX_BL.init_rot 			= {0, 0, 0}
FUEL_BX_BL.element_params 		= {"MFD_OPACITY","CMFD_FUEL_PAGE"}
FUEL_BX_BL.controllers			= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
FUEL_BX_BL.level 				= 2
FUEL_BX_BL.h_clip_relation     = h_clip_relations.COMPARE
vertices(FUEL_BX_BL,2)
Add(FUEL_BX_BL)
--------------------------------------------------------------------------------------------------FUEL-PAGE-TINY-NUMBERS
TANK_LABELS                    = CreateElement "ceTexPoly"
TANK_LABELS.name    			= "TANK_LABELS"
TANK_LABELS.material			= FUEL_IND
TANK_LABELS.change_opacity 	= false
TANK_LABELS.collimated 		= false
TANK_LABELS.isvisible 			= true
TANK_LABELS.init_pos 			= {0, 0, 0} 
TANK_LABELS.init_rot 			= {0, 0, 0}
TANK_LABELS.element_params 	= {"MFD_OPACITY","CMFD_FUEL_PAGE"}
TANK_LABELS.controllers		= {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1}}
TANK_LABELS.level 				= 2
TANK_LABELS.h_clip_relation    = h_clip_relations.COMPARE
vertices(TANK_LABELS,2)
Add(TANK_LABELS)
--------------------------------------------------------------------------------------------------------------------INTERNAL TEXT
--INT TEXT
INTERNAL_TEXT 					    = CreateElement "ceStringPoly"
INTERNAL_TEXT.name 				    = "INTERNAL_TEXT"
INTERNAL_TEXT.material 			    = UFD_GRN
INTERNAL_TEXT.value 				= "TOTAL:"
INTERNAL_TEXT.stringdefs 		    = {0.004, 0.004, 0.0004, 0.001}
INTERNAL_TEXT.alignment 			= "LeftCenter"
INTERNAL_TEXT.formats 			    = {"%s"}
INTERNAL_TEXT.h_clip_relation       = h_clip_relations.COMPARE
INTERNAL_TEXT.level 				= 2
INTERNAL_TEXT.init_pos 			    = {0.50, -0.70, 0}
INTERNAL_TEXT.init_rot 			    = {0, 0, 0}
INTERNAL_TEXT.element_params 	    = {"MFD_OPACITY","CMFD_FUEL_PAGE"}
INTERNAL_TEXT.controllers		    =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},
						                }
Add(INTERNAL_TEXT)
--------------------------------------------------------------------------------------------------------------------INTERNAL NUMBER
INTERNAL_NUMBER				        = CreateElement "ceStringPoly"
INTERNAL_NUMBER.name				= "INTERNAL_NUMBER"
INTERNAL_NUMBER.material			= UFD_GRN
INTERNAL_NUMBER.init_pos			= {0.90, -0.70, 0} 
INTERNAL_NUMBER.alignment			= "RightCenter"
INTERNAL_NUMBER.stringdefs			= {0.004, 0.004, 0, 0.0} 
INTERNAL_NUMBER.additive_alpha		= true
INTERNAL_NUMBER.collimated			= false
INTERNAL_NUMBER.isdraw				= true	
INTERNAL_NUMBER.use_mipfilter		= true
INTERNAL_NUMBER.h_clip_relation		= h_clip_relations.COMPARE
INTERNAL_NUMBER.level				= 2
INTERNAL_NUMBER.element_params		= {"MFD_OPACITY","FUEL","CMFD_FUEL_PAGE"}
INTERNAL_NUMBER.formats				= {"%05.0f"}
INTERNAL_NUMBER.controllers			= {{"opacity_using_parameter",0},{"text_using_parameter",1,0},{"parameter_in_range",2,0.9,1.1}}
Add(INTERNAL_NUMBER)
--------------------------------------------------------------------------------------------------------------------TANK TEXT
--TANK TEXT
TANK_TEXT 					        = CreateElement "ceStringPoly"
TANK_TEXT.name 				        = "TANK_TEXT"
TANK_TEXT.material 			        = UFD_FONT
TANK_TEXT.value 				    = "EXTRL:"
TANK_TEXT.stringdefs 		        = {0.004, 0.004, 0.0004, 0.001}
TANK_TEXT.alignment 			    = "LeftCenter"
TANK_TEXT.formats 			        = {"%s"}
TANK_TEXT.h_clip_relation           = h_clip_relations.COMPARE
TANK_TEXT.level 				    = 2
TANK_TEXT.init_pos 			        = {0.50, -0.77, 0}
TANK_TEXT.init_rot 			        = {0, 0, 0}
TANK_TEXT.element_params 	        = {"MFD_OPACITY","CMFD_FUEL_PAGE"}
TANK_TEXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},
						                }
Add(TANK_TEXT)
--------------------------------------------------------------------------------------------------------------------TANK NUMBER
TANK_NUMBER				        = CreateElement "ceStringPoly"
TANK_NUMBER.name				= "TANK_NUMBER"
TANK_NUMBER.material			= UFD_FONT
TANK_NUMBER.init_pos			= {0.90, -0.77, 0} 
TANK_NUMBER.alignment			= "RightCenter"
TANK_NUMBER.stringdefs			= {0.004, 0.004, 0, 0.0} 
TANK_NUMBER.additive_alpha		= true
TANK_NUMBER.collimated			= false
TANK_NUMBER.isdraw				= true	
TANK_NUMBER.use_mipfilter		= true
TANK_NUMBER.h_clip_relation		= h_clip_relations.COMPARE
TANK_NUMBER.level				= 2
TANK_NUMBER.element_params		= {"MFD_OPACITY","FUELTANK","CMFD_FUEL_PAGE"}
TANK_NUMBER.formats				= {"%05.0f"}
TANK_NUMBER.controllers			= {{"opacity_using_parameter",0},{"text_using_parameter",1,0},{"parameter_in_range",2,0.9,1.1}}
Add(TANK_NUMBER)

--------------------------------------------------------BINGO------------------------------------------------------
BINGO_txt 					= CreateElement "ceStringPoly"
BINGO_txt.name 				= "BINGO_txt"
BINGO_txt.material 			= UFD_YEL
BINGO_txt.value 				= "BINGO FUEL"
BINGO_txt.stringdefs 		= {0.004, 0.004, 0.0004, 0.001}
BINGO_txt.alignment 			= "CenterCenter"
BINGO_txt.formats 			= {"%s"}
BINGO_txt.h_clip_relation  	= h_clip_relations.COMPARE
BINGO_txt.level 				= 2
BINGO_txt.init_pos 			= {0.60, 0.28, 0}
BINGO_txt.init_rot 			= {0, 0, 0}
BINGO_txt.element_params 	= {"MFD_OPACITY","BINGO_LIGHT","CMFD_FUEL_PAGE"}
BINGO_txt.controllers		= {{"parameter_in_range",2,0.9,1.1}, {"parameter_in_range",1,0.1,1.1}, {"opacity_using_parameter",0}}
Add(BINGO_txt)
--------------------------------------------------------------------------------------------------------------------BINGO TEXT
--TANK TEXT
BINGO_TEXT 					        = CreateElement "ceStringPoly"
BINGO_TEXT.name 				    = "BINGO_TEXT"
BINGO_TEXT.material 			    = UFD_GRN
BINGO_TEXT.value 				    = "BINGO QTY:"
BINGO_TEXT.stringdefs 		        = {0.004, 0.004, 0.0004, 0.001}
BINGO_TEXT.alignment 			    = "LeftCenter"
BINGO_TEXT.formats 			        = {"%s"}
BINGO_TEXT.h_clip_relation          = h_clip_relations.COMPARE
BINGO_TEXT.level 				    = 2
BINGO_TEXT.init_pos 			    = {0.43, 0.45, 0}
BINGO_TEXT.init_rot 			    = {0, 0, 0}
BINGO_TEXT.element_params 	        = {"MFD_OPACITY","CMFD_FUEL_PAGE"}
BINGO_TEXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},
						                }
Add(BINGO_TEXT)
--------------------------------------------------------------------------------------------------------------------BINGO TEXT
BINGOQTY_TEXT 					    = CreateElement "ceStringPoly"
BINGOQTY_TEXT.name 				    = "BINGOQTY_TEXT"
BINGOQTY_TEXT.material 			    = UFD_FONT
BINGOQTY_TEXT.value 				= "            3500"
BINGOQTY_TEXT.stringdefs 		    = {0.004, 0.004, 0.0004, 0.001}
BINGOQTY_TEXT.alignment 			= "LeftCenter"
BINGOQTY_TEXT.formats 			    = {"%s"}
BINGOQTY_TEXT.h_clip_relation       = h_clip_relations.COMPARE
BINGOQTY_TEXT.level 				= 2
BINGOQTY_TEXT.init_pos 			    = {0.38, 0.45, 0}
BINGOQTY_TEXT.init_rot 			    = {0, 0, 0}
BINGOQTY_TEXT.element_params 	    	= {"MFD_OPACITY","CMFD_FUEL_PAGE"}
BINGOQTY_TEXT.controllers		    	=   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},
						                }
Add(BINGOQTY_TEXT)
--------------------------------------------------------------------------------------------------------------------
FUELDUMP_TEXT 					    = CreateElement "ceStringPoly"
FUELDUMP_TEXT.name 				    = "FUELDUMP_TEXT"
FUELDUMP_TEXT.material 			    = UFD_GRN
FUELDUMP_TEXT.value 					= "FUEL DUMP"
FUELDUMP_TEXT.stringdefs 		    = {0.004, 0.004, 0.0004, 0.001}
FUELDUMP_TEXT.alignment 				= "Leftcenter"
FUELDUMP_TEXT.formats 			    = {"%s"}
FUELDUMP_TEXT.h_clip_relation       	= h_clip_relations.COMPARE
FUELDUMP_TEXT.level 					=	 2
FUELDUMP_TEXT.init_pos 			    = {-0.95, 0.4, 0}
FUELDUMP_TEXT.init_rot 			    = {0, 0, 0}
FUELDUMP_TEXT.element_params 	    = {"MFD_OPACITY","CMFD_FUEL_PAGE"}
FUELDUMP_TEXT.controllers		    =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},
						                }
Add(FUELDUMP_TEXT)
--------------------------------------------------------------------------------------------------------------------
ACTIVE_TEXT 					        = CreateElement "ceStringPoly"
ACTIVE_TEXT.name 				        = "ACTIVE_TEXT"
ACTIVE_TEXT.material 			        = UFD_RED
ACTIVE_TEXT.value 				    = "ACTIVE"
ACTIVE_TEXT.stringdefs 		        = {0.004, 0.004, 0.0004, 0.001}
ACTIVE_TEXT.alignment 			    = "Leftcenter"
ACTIVE_TEXT.formats 			        = {"%s"}
ACTIVE_TEXT.h_clip_relation           = h_clip_relations.COMPARE
ACTIVE_TEXT.level 				    = 2
ACTIVE_TEXT.init_pos 			        = {-0.61, 0.4, 0}
ACTIVE_TEXT.init_rot 			        = {0, 0, 0}
ACTIVE_TEXT.element_params 	        = {"MFD_OPACITY","DUMP_FUEL","CMFD_FUEL_PAGE"}
ACTIVE_TEXT.controllers		        = {{"opacity_using_parameter",0},{"parameter_in_range",1,0.9,1.1},{"parameter_in_range",2,0.9,1.1},}
Add(ACTIVE_TEXT)
--------------------------------------------------------------------------------------------------------------------LEFT FF TEXT
L_EFF_TEXT 					        = CreateElement "ceStringPoly"
L_EFF_TEXT.name 				    = "L_EFF_TEXT"
L_EFF_TEXT.material 			    = UFD_GRN
L_EFF_TEXT.value 				    = "L EFF:"
L_EFF_TEXT.stringdefs 		        = {0.004, 0.004, 0.0004, 0.001}
L_EFF_TEXT.alignment 			    = "LeftCenter"
L_EFF_TEXT.formats 			        = {"%s"}
L_EFF_TEXT.h_clip_relation          = h_clip_relations.COMPARE
L_EFF_TEXT.level 				    = 2
L_EFF_TEXT.init_pos 			    = {-0.90, -0.70, 0}
L_EFF_TEXT.init_rot 			    = {0, 0, 0}
L_EFF_TEXT.element_params 	        = {"MFD_OPACITY","CMFD_FUEL_PAGE"}
L_EFF_TEXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},
						                }
Add(L_EFF_TEXT)
--------------------------------------------------------------------------------------------------------------------RIGHT FF TEXT
R_EFF_TEXT 					        = CreateElement "ceStringPoly"
R_EFF_TEXT.name 				    = "R_EFF_TEXT"
R_EFF_TEXT.material 			    = UFD_GRN
R_EFF_TEXT.value 				    = "R EFF:"
R_EFF_TEXT.stringdefs 		        = {0.004, 0.004, 0.0004, 0.001}
R_EFF_TEXT.alignment 			    = "LeftCenter"
R_EFF_TEXT.formats 			        = {"%s"}
R_EFF_TEXT.h_clip_relation          = h_clip_relations.COMPARE
R_EFF_TEXT.level 				    = 2
R_EFF_TEXT.init_pos 			    = {-0.90, -0.77, 0}
R_EFF_TEXT.init_rot 			    = {0, 0, 0}
R_EFF_TEXT.element_params 	        = {"MFD_OPACITY","CMFD_FUEL_PAGE"}
R_EFF_TEXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},
						                }
Add(R_EFF_TEXT)

--------------------------------------------------------------------------------------------------------------------LEFT FF NUMBER
L_EFF_NUMBER				        = CreateElement "ceStringPoly"
L_EFF_NUMBER.name				= "L_EFF_NUMBER"
L_EFF_NUMBER.material			= UFD_FONT
L_EFF_NUMBER.init_pos			= {-0.50, -0.70, 0} 
L_EFF_NUMBER.alignment			= "RightCenter"
L_EFF_NUMBER.stringdefs			= {0.004, 0.004, 0, 0.0} 
L_EFF_NUMBER.additive_alpha		= true
L_EFF_NUMBER.collimated			= false
L_EFF_NUMBER.isdraw				= true	
L_EFF_NUMBER.use_mipfilter		= true
L_EFF_NUMBER.h_clip_relation		= h_clip_relations.COMPARE
L_EFF_NUMBER.level				= 2
L_EFF_NUMBER.element_params		= {"MFD_OPACITY","L_FF_VALUE","CMFD_FUEL_PAGE"}
L_EFF_NUMBER.formats				= {"%.0f"}
L_EFF_NUMBER.controllers			= {{"opacity_using_parameter",0},{"text_using_parameter",1,0},{"parameter_in_range",2,0.9,1.1}}
Add(L_EFF_NUMBER)
--------------------------------------------------------------------------------------------------------------------RIGHT FF NUMBER
R_EFF_NUMBER				    = CreateElement "ceStringPoly"
R_EFF_NUMBER.name				= "R_EFF_NUMBER"
R_EFF_NUMBER.material			= UFD_FONT
R_EFF_NUMBER.init_pos			= {-0.50, -0.77, 0}
R_EFF_NUMBER.alignment			= "RightCenter"
R_EFF_NUMBER.stringdefs			= {0.004, 0.004, 0, 0.0}
R_EFF_NUMBER.additive_alpha		= true
R_EFF_NUMBER.collimated			= false
R_EFF_NUMBER.isdraw				= true	
R_EFF_NUMBER.use_mipfilter		= true
R_EFF_NUMBER.h_clip_relation		= h_clip_relations.COMPARE
R_EFF_NUMBER.level				= 2
R_EFF_NUMBER.element_params		= {"MFD_OPACITY","R_FF_VALUE","CMFD_FUEL_PAGE"}
R_EFF_NUMBER.formats				= {"%.0f"}
R_EFF_NUMBER.controllers			= {{"opacity_using_parameter",0},{"text_using_parameter",1,0},{"parameter_in_range",2,0.9,1.1}}
Add(R_EFF_NUMBER)

--------------------------------------------------------------------------------------------------------------------MENU-BUTTON

MENUTEXT 					    = CreateElement "ceStringPoly"
MENUTEXT.name 				    = "MENUTEXT"
MENUTEXT.material 			    = UFD_FONT --UFD_YEL
MENUTEXT.value 				    = "MENU"
MENUTEXT.stringdefs 		        = {0.0050, 0.0050, 0.0004, 0.001}
MENUTEXT.alignment 			    = "CenterCenter"
MENUTEXT.formats 			    = {"%s"}
MENUTEXT.h_clip_relation         = h_clip_relations.COMPARE
MENUTEXT.level 				    = 2
MENUTEXT.init_pos 			    = {-0.565, 0.92, 0}
MENUTEXT.init_rot 			    = {0, 0, 0}
MENUTEXT.element_params 	        = {"MFD_OPACITY","CMFD_FUEL_PAGE"}
MENUTEXT.controllers		        =   {
                                            {"opacity_using_parameter",0},
                                            {"parameter_in_range",1,0.9,1.1},
						                }
Add(MENUTEXT)


---------------------------------------------------------------------------------------------------JETTISON TEXT YELLOW
JETTISON_YEL 					        = CreateElement "ceStringPoly"
JETTISON_YEL.name 				        = "JETTISON_YEL"
JETTISON_YEL.material 			        = UFD_YEL
JETTISON_YEL.value 				        = "TANK"
JETTISON_YEL.stringdefs 		        = {0.005, 0.005, 0.0004, 0.001}
JETTISON_YEL.alignment 			        = "CenterCenter"
JETTISON_YEL.formats 			        = {"%s"}
JETTISON_YEL.h_clip_relation            = h_clip_relations.COMPARE
JETTISON_YEL.level 				        = 2
JETTISON_YEL.init_pos 			        = {0.875, 0.10, 0}
JETTISON_YEL.init_rot 			        = {0, 0, 0}
JETTISON_YEL.element_params 	        = {"MFD_OPACITY","CMFD_FUEL_PAGE"}
JETTISON_YEL.controllers		        =   {
                                                {"opacity_using_parameter",0},
                                                {"parameter_in_range",1,0.9,1.1},
						                    }
Add(JETTISON_YEL)

---------------------------------------------------------------------------------------------------JETTISON TEXT YELLOW
JETTISON_YEL1 					        = CreateElement "ceStringPoly"
JETTISON_YEL1.name 				        = "JETTISON_YEL1"
JETTISON_YEL1.material 			        = UFD_YEL
JETTISON_YEL1.value 				    = "JETT"
JETTISON_YEL1.stringdefs 		        = {0.005, 0.005, 0.0004, 0.001}
JETTISON_YEL1.alignment 			    = "CenterCenter"
JETTISON_YEL1.formats 			        = {"%s"}
JETTISON_YEL1.h_clip_relation           = h_clip_relations.COMPARE
JETTISON_YEL1.level 				    = 2
JETTISON_YEL1.init_pos 			        = {0.875, 0.17, 0}
JETTISON_YEL1.init_rot 			        = {0, 0, 0}
JETTISON_YEL1.element_params 	        = {"MFD_OPACITY","CMFD_FUEL_PAGE"}
JETTISON_YEL1.controllers		        =   {
                                                {"opacity_using_parameter",0},
                                                {"parameter_in_range",1,0.9,1.1},
						                    }
Add(JETTISON_YEL1)
