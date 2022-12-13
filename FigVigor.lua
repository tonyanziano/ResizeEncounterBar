-- get refs to Ace libs

local configDialog = LibStub('AceConfigDialog-3.0')

-- register the addon with Ace

FigVigor = LibStub('AceAddon-3.0'):NewAddon('FigVigor', 'AceConsole-3.0')

-- register slash commands

FigVigor:RegisterChatCommand('figor', 'ToggleOptionsDialog')
FigVigor:RegisterChatCommand('vigor', 'ToggleOptionsDialog')
FigVigor:RegisterChatCommand('figvigor', 'ToggleOptionsDialog')

function FigVigor:ToggleOptionsDialog()
  if configDialog.OpenFrames['FigVigor'] then
    configDialog:Close('FigVigor')
  else
    configDialog:Open('FigVigor')
  end
end

-- register addon config

local optionsConfig = {
  name = 'FigVigor',
  handler = FigVigor,
  type = 'group',
  args = {
    vigorScale = {
      name = 'Vigor frame scale',
      type = 'range',
      order = 10,
      min = 0.2,
      max = 1.5,
      isPercent = true,
      get = function() return FigVigor.db.global.vigorScale end,
      set = function(info, val)
        FigVigor.db.global.vigorScale = val
        FigVigor:RedrawVigorFrame()
      end
    }
  }
}
LibStub('AceConfig-3.0'):RegisterOptionsTable('FigVigor', optionsConfig, nil)

local optionsDefaults = {
  global = {
    vigorLock = true,
    vigorScale = 1
  }
}

-- main code

function FigVigor:RedrawVigorFrame()
  EncounterBar:SetScale(FigVigor.db.global.vigorScale)
end

function FigVigor:OnInitialize()
  -- register DB / persistent storage
  self.db = LibStub('AceDB-3.0'):New('FigVigorDB', optionsDefaults)

  -- redraw after loading config
  self:RedrawVigorFrame()
end
