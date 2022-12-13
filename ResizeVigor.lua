-- get refs to Ace libs

local configDialog = LibStub('AceConfigDialog-3.0')

-- register the addon with Ace

ResizeVigor = LibStub('AceAddon-3.0'):NewAddon('ResizeVigor', 'AceConsole-3.0')

-- register slash commands

ResizeVigor:RegisterChatCommand('figor', 'ToggleOptionsDialog')
ResizeVigor:RegisterChatCommand('vigor', 'ToggleOptionsDialog')
ResizeVigor:RegisterChatCommand('resizevigor', 'ToggleOptionsDialog')

function ResizeVigor:ToggleOptionsDialog()
  if configDialog.OpenFrames['ResizeVigor'] then
    configDialog:Close('ResizeVigor')
  else
    configDialog:Open('ResizeVigor')
  end
end

-- register addon config

local optionsConfig = {
  name = 'ResizeVigor',
  handler = ResizeVigor,
  type = 'group',
  args = {
    vigorScale = {
      name = 'Vigor frame scale',
      type = 'range',
      order = 10,
      min = 0.2,
      max = 1.5,
      isPercent = true,
      get = function() return ResizeVigor.db.global.vigorScale end,
      set = function(info, val)
        ResizeVigor.db.global.vigorScale = val
        ResizeVigor:RedrawVigorFrame()
      end
    }
  }
}
LibStub('AceConfig-3.0'):RegisterOptionsTable('ResizeVigor', optionsConfig, nil)

local optionsDefaults = {
  global = {
    vigorLock = true,
    vigorScale = 1
  }
}

-- main code

function ResizeVigor:RedrawVigorFrame()
  EncounterBar:SetScale(ResizeVigor.db.global.vigorScale)
end

function ResizeVigor:OnInitialize()
  -- register DB / persistent storage
  self.db = LibStub('AceDB-3.0'):New('ResizeVigorDB', optionsDefaults)

  -- redraw after loading config
  self:RedrawVigorFrame()
end
