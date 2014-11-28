-- Modules
local application = require "mjolnir.application"
local appfinder   = require "mjolnir.cmsj.appfinder"
local hotkey      = require "mjolnir.hotkey"
local fnutils     = require "mjolnir.fnutils"
local window      = require "mjolnir.window"
local alert       = require "mjolnir.alert"
local tiling      = require "mjolnir.tiling"
local screen      = require "mjolnir.screen"
local grid        = require "mjolnir.bg.grid"

-- Set grid size.
grid.GRIDWIDTH  = 6
grid.GRIDHEIGHT = 2
grid.MARGINX = 0
grid.MARGINY = 0

-- Set up hotkey combinations
local mash      = {"cmd", "alt", "ctrl"}
local mashshift = {"cmd", "alt", "shift"}
local hyper     = {"cmd", "alt", "ctrl"}

-- Reload
hotkey.bind(hyper, "R", function()
  alert.show "Reloading Mjolnir"
  mjolnir.reload()
  alert.show "Mjolnir reloaded!"
end)

-- App focus
function findAndActivate(name) appfinder.app_from_name(name):activate() end

hotkey.bind(hyper, "x", function() findAndActivate("iTerm") end)
hotkey.bind(hyper, "c", function() findAndActivate("Google Chrome") end)
hotkey.bind(hyper, "e", function() findAndActivate("Eclipse") end)

hotkey.bind(mash, ';', function() grid.snap(window.focusedwindow()) end)
hotkey.bind(mash, "'", function() fnutils.map(window.visiblewindows(), grid.snap) end)
hotkey.bind(mash, '=', function() grid.adjustwidth( 1) end)
hotkey.bind(mash, '-', function() grid.adjustwidth(-1) end)
hotkey.bind(mashshift, '=', function() grid.adjustheight(1) end)
hotkey.bind(mashshift, '-', function() grid.adjustheight(-1) end)

-- Tiling motions
hotkey.bind(hyper, "M", grid.maximize_window)
hotkey.bind(mash, 'N', grid.pushwindow_nextscreen)
hotkey.bind(mash, 'P', grid.pushwindow_prevscreen)

hotkey.bind(mash, 'J', grid.pushwindow_down)
hotkey.bind(mash, 'K', grid.pushwindow_up)
hotkey.bind(mash, 'H', grid.pushwindow_left)
hotkey.bind(mash, 'L', grid.pushwindow_right)

hotkey.bind(mash, 'U', grid.resizewindow_taller)
hotkey.bind(mash, 'O', grid.resizewindow_wider)
hotkey.bind(mash, 'I', grid.resizewindow_thinner)
hotkey.bind(mash, 'Y', grid.resizewindow_shorter)

hotkey.bind(hyper, "Left", function()
  local win = window.focusedwindow()
  local f = screen.mainscreen():frame()
  
  f.w = f.w / 2
  win:setframe(f)
end)

hotkey.bind(hyper, "Up", function()
  local win = window.focusedwindow()
  local f = screen.mainscreen():frame()
  
  f.h = f.h / 2
  win:setframe(f)
end)

hotkey.bind(hyper, "Right", function()
  local win = window.focusedwindow()
  local f = screen.mainscreen():frame()
  
  f.x = f.x + (f.w / 2)
  f.w = f.w / 2
  win:setframe(f)
end)

hotkey.bind(hyper, "Down", function()
  local win = window.focusedwindow()
  local f = screen.mainscreen():frame()
  
  f.y = f.y + (f.h / 2)
  f.h = f.h / 2
  win:setframe(f)
end)


-- Tiling cycle plugin
-- https://github.com/nathankot/mjolnir.tiling
--hotkey.bind(hyper, "space", function() tiling.promote() end)

hotkey.bind(hyper, "space", function() tiling.cyclelayout() end)

-- If you want to set the layouts that are enabled
tiling.set('layouts', {
  'fullscreen', 'main-vertical'
})

alert.show "Mjolnir loaded!"

-- TODO
-- check this out: https://github.com/Linell/mjolnir-config/blob/master/init.lua