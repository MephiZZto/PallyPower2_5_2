local L = AceLibrary("AceLocale-2.2"):new("PallyPower");

PallyPower.options = {
	type = "group",
	args = {
		config = {
		        name = L["BAS"],
			type = "execute",
			desc = L["BAS_DESC"],
			func = function() PallyPowerConfig_Toggle() end,
		},
		report = {
			name = L["BRPT"],
			type = "execute",
			desc = L["BRPT_DESC"],
			func = function() PallyPower:Report() end,
		},
		buffscale = {
			name = L["BSC"],
			type = "range",
			desc = L["BSC_DESC"],
			min = 0.5,
			max = 1.5,
			step = 0.05,
			get = "BuffScale",
			set = "BuffScale",
		},
		configscale = {
			name = L["CSC"],
			type = "range",
			desc = L["CSC_DESC"],
			min = 0.5,
			max = 1.5,
			step = 0.05,
			get = "ConfigScale",
			set = "ConfigScale",	
		},
		reset = {
			name = L["RESET"],
			type = "execute",
			desc = L["RESET_DESC"],
			func = function() PallyPower:Reset() end,			
			},
		smart = {
			name = L["SBUFF"],
			type = "toggle",
			desc = L["SBUFF_DESC"],
			get = "ToggleSmartBuffs",
			set = "ToggleSmartBuffs",
			map = {
				[false]=L["DISABLED"], 
				[true] = L["ENABLED"]
			},
		},
  		rfbuff = {
			name = L["RFBUFF"],
			type = "toggle",
			desc = L["RFBUFF_DESC"],
			get = "ToggleRF",
			set = "ToggleRF",
			map = {
				[false]=L["DISABLED"],
				[true] = L["ENABLED"]
			},
		},
  		freeassign = {
			name = L["FREEASSIGN"],
			type = "toggle",
			desc = L["FREEASSIGN_DESC"],
			get = "ToggleFA",
			set = "ToggleFA",
			map = {
				[false]=L["DISABLED"],
				[true] = L["ENABLED"]
			},
		},
		autobuff = {
			name = L["AUTOBUFF"],
			type = "group",
			desc = L["AUTOBUFF_DESC"],
			args = {
				autokey1 = {
					name = L["AUTOKEY1"],
					desc = L["AUTOKEY1_DESC"],
					type = "text",
					validate = "keybinding",
					set = function(value)
						PallyPower:UnbindKeys()
						PallyPower.opt.autobuff.autokey1 = value
						PallyPower:BindKeys()
					end,
					get = function() return PallyPower.opt.autobuff.autokey1 end
				},
				autokey2 = {
					name = L["AUTOKEY2"],
					desc = L["AUTOKEY2_DESC"],
					type = "text",
					validate = "keybinding",
					set = function(value)
						PallyPower:UnbindKeys()
						PallyPower.opt.autobuff.autokey2 = value
						PallyPower:BindKeys()
					end,
					get = function() return PallyPower.opt.autobuff.autokey2 end
				},
				autobutton = {
					name = L["AUTOBTN"],
					type = "toggle",
					desc = L["AUTOBTN_DESC"],
					set = "ToggleAutoButton",
					get = "ToggleAutoButton",
					map = {
						[false] = L["DISABLED"], 
						[true] = L["ENABLED"]
					},
				},
				waitforpeople = {
					name = L["WAIT"],
					type = "toggle",
					desc = L["WAIT_DESC"],
					set = "ToggleWaitPeople",
					get = "ToggleWaitPeople",
					map = {
						[false] = L["DISABLED"], 
						[true] = L["ENABLED"]
					},
				},
			},
		},
		display = {
			name = L["DISP"],
			type = "group",
			desc = L["DISP_DESC"],
			args = {
				columns = {
					name = L["DISPCOL"],
					type = "range",
					desc = L["DISPCOL_DESC"],
					min = 1,
					max = 10,
					step = 1,
					get = "displayColumns",
					set = "displayColumns",	
				},
				rows = {
					name = L["DISPROWS"],
					type = "range",
					desc = L["DISPROWS_DESC"],
					min = 1,
					max = 10,
					step = 1,
					get = "displayRows",
					set = "displayRows",	
				},
				gapping = {
					name = L["DISPGAP"],
					type = "range",
					desc = L["DISPGAP_DESC"],
					min = 0,
					max = 5,
					step = 1,
					get = "displayGapping",
					set = "displayGapping",	
				},
				calign = {
					name = L["DISPCL"],
					type = "text",
					desc = L["DISPCL_DESC"],
					get = "displayAlignClassButtons",
					set = "displayAlignClassButtons",
					validate = {
							"1", 
							"3", 
							"7", 
							"9"},
				},
				palign = {
					name = L["DISPPL"],
					type = "text",
					desc = L["DISPCL_DESC"],
					get = "displayAlignPlayerButtons",
					set = "displayAlignPlayerButtons",
					validate = {	
							"top", 
							"right", 
							"bottom", 
							"left", 
							"compact-left", 
							"compact-right",
					},
				},
				pbuttons = {
					name = L["HIDEPB"],
					type = "toggle",
					desc = L["HIDEPB_DESC"],
					get = "TogglePlayerButtons",
					set = "TogglePlayerButtons",
					map = {
						[false]=L["DISABLED"], 
						[true] = L["ENABLED"]
					},
				},
				handle = {
					name = L["HIDEDH"],
					type = "toggle",
					desc = L["HIDEDH_DESC"],
					get = "ToggleDragHandle",
					set = "ToggleDragHandle",
					map = {
						[false]=L["DISABLED"], 
						[true] = L["ENABLED"]
					},
				},
				showparty = {
					name = L["SHOWPARTY"],
					type = "toggle",
					desc = L["SHOWPARTY_DESC"],
					get = "ToggleShowParty",
					set = "ToggleShowParty",
					map = {
						[false]=L["DISABLED"], 
						[true] = L["ENABLED"]
					},
				},
				showsingle = {
					name = L["SHOWSINGLE"],
					type = "toggle",
					desc = L["SHOWSINGLE_DESC"],
					get = "ToggleShowSingle",
					set = "ToggleShowSingle",
					map = {
						[false]=L["DISABLED"], 
						[true] = L["ENABLED"]
					},
				},

			},      -- display args
		}, -- main args
	},
}

function PallyPower:BuffScale(value)
	if not value then return self.opt.buffscale end
	self.opt.buffscale = value;
	PallyPower:UpdateLayout();
end

function PallyPower:ConfigScale(value)
	if not value then return self.opt.configscale end
	self.opt.configscale = value;
end

function PallyPower:displayRows(value)
	if not value then return self.opt.display.rows end
	self.opt.display.rows = value;
	PallyPower:UpdateLayout();
end

function PallyPower:displayColumns(value)
	if not value then return self.opt.display.columns end
	self.opt.display.columns = value;
	PallyPower:UpdateLayout();
end

function PallyPower:displayGapping(value)
	if not value then return self.opt.display.gapping end
	self.opt.display.gapping = value
	PallyPower:UpdateLayout();
end

function PallyPower:displayAlignClassButtons(value)
	if not value then return self.opt.display.alignClassButtons end
	self.opt.display.alignClassButtons = value
	PallyPower:UpdateLayout();
end

function PallyPower:displayAlignPlayerButtons(value)
	if not value then return self.opt.display.alignPlayerButtons end
	self.opt.display.alignPlayerButtons = value;
	PallyPower:UpdateLayout();
end

function PallyPower:ToggleSmartBuffs(value)
	if type(value) == "nil" then return self.opt.smartbuffs end
	self.opt.smartbuffs = value;
end

function PallyPower:ToggleRF(value)
	if type(value) == "nil" then return self.opt.rfbuff end
	self.opt.rfbuff = value
	PallyPower:UpdateLayout()
end

function PallyPower:ToggleFA(value)
	if type(value) == "nil" then return self.opt.freeassign end
	self.opt.freeassign = value
	PallyPower:UpdateLayout()
end

function PallyPower:ToggleShowParty(value)
	if type(value) == "nil" then return self.opt.ShowInParty end
	self.opt.ShowInParty = value;
end

function PallyPower:ToggleShowSingle(value)
	if type(value) == "nil" then return self.opt.ShowWhenSingle end
	self.opt.ShowWhenSingle = value;
end

function PallyPower:ToggleDragHandle(value)
	if type(value) == "nil" then return self.opt.display.hideDragHandle end
	self.opt.display.hideDragHandle = value;
	PallyPower:UpdateLayout();
end

function PallyPower:TogglePlayerButtons(value)
	if type(value) == "nil" then return self.opt.display.hidePlayerButtons end
	self.opt.display.hidePlayerButtons = value;
	PallyPower:UpdateLayout();
end

function PallyPower:ToggleAutoButton(value)
	if type(value) == "nil" then return self.opt.autobuff.autobutton end
	self.opt.autobuff.autobutton = value;
	PallyPower:UpdateLayout();
end

function PallyPower:ToggleWaitPeople(value)
	if type(value) == "nil" then return self.opt.autobuff.waitforpeople end
	self.opt.autobuff.waitforpeople = value;
end
