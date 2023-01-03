-- get refs to Ace libs

local configDialog = LibStub('AceConfigDialog-3.0')

-- register the addon with Ace

ResizeEncounterBar = LibStub('AceAddon-3.0'):NewAddon('ResizeEncounterBar', 'AceConsole-3.0')

-- register slash commands

ResizeEncounterBar:RegisterChatCommand('figor', 'ToggleOptionsDialog')
ResizeEncounterBar:RegisterChatCommand('vigor', 'ToggleOptionsDialog')
ResizeEncounterBar:RegisterChatCommand('reb', 'ToggleOptionsDialog')

function ResizeEncounterBar:ToggleOptionsDialog()
  if configDialog.OpenFrames['ResizeEncounterBar'] then
    configDialog:Close('ResizeEncounterBar')
  else
    configDialog:Open('ResizeEncounterBar')
  end
end

-- register addon config

local optionsConfig = {
  name = 'ResizeEncounterBar',
  handler = ResizeEncounterBar,
  type = 'group',
  args = {
    vigorScale = {
      name = 'EncounterBar frame scale',
      type = 'range',
      order = 10,
      min = 0.2,
      max = 1.5,
      isPercent = true,
      get = function() return ResizeEncounterBar.db.global.vigorScale end,
      set = function(info, val)
        ResizeEncounterBar.db.global.vigorScale = val
        ResizeEncounterBar:RedrawEncounterBarFrame()
      end
    }
  }
}
LibStub('AceConfig-3.0'):RegisterOptionsTable('ResizeEncounterBar', optionsConfig, nil)

local optionsDefaults = {
  global = {
    vigorLock = true,
    vigorScale = 1
  }
}

-- main code

function ResizeEncounterBar:RedrawEncounterBarFrame()
  EncounterBar:SetScale(ResizeEncounterBar.db.global.vigorScale)
end

function ResizeEncounterBar:OnInitialize()
  -- register DB / persistent storage
  self.db = LibStub('AceDB-3.0'):New('ResizeEncounterBarDB', optionsDefaults)

  -- redraw after loading config
  self:RedrawEncounterBarFrame()
end
