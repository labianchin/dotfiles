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

-- Set up hotkey combinations
local mash      = {"cmd", "alt", "ctrl"}
local mashshift = {"cmd", "alt", "shift"}
local hyper     = {"cmd", "alt", "ctrl"}

hotkey.bind(hyper, "R", function()
  alert.show "Reloading Mjolnir"
  mjolnir.reload()
  alert.show "Mjolnir reloaded!"
end)

-- App focus
function findAndActivate(name)
  appfinder.app_from_name(name):activate()
end

hotkey.bind(hyper, "x", function() findAndActivate("iTerm") end)
hotkey.bind(hyper, "c", function() findAndActivate("Google Chrome") end)
hotkey.bind(hyper, "e", function() findAndActivate("Eclipse") end)

-- Basic movement
-- y up-left
-- k up
-- u up-right
-- h leftgg
-- l right
-- b down-left
-- j down
-- n down-right

hotkey.bind(hyper, "Y", function()
  local win = window.focusedwindow()
  local f = win:frame()
  
  f.x = f.x - 10
  f.y = f.y - 10
  win:setframe(f)
end)

hotkey.bind(hyper, "K", function()
  local win = window.focusedwindow()
  local f = win:frame()
  
  f.y = f.y - 10
  win:setframe(f)
end)

hotkey.bind(hyper, "U", function()
  local win = window.focusedwindow()
  local f = win:frame()
  
  f.x = f.x + 10
  f.y = f.y - 10
  win:setframe(f)
end)

hotkey.bind(hyper, "H", function()
  local win = window.focusedwindow()
  local f = win:frame()
  
  f.x = f.x - 10
  win:setframe(f)
end)

hotkey.bind(hyper, "L", function()
  local win = window.focusedwindow()
  local f = win:frame()
  
  f.x = f.x + 10
  win:setframe(f)
end)

hotkey.bind(hyper, "B", function()
  local win = window.focusedwindow()
  local f = win:frame()
  
  f.x = f.x - 10
  f.y = f.y + 10
  win:setframe(f)
end)

hotkey.bind(hyper, "J", function()
  local win = window.focusedwindow()
  local f = win:frame()
  
  f.y = f.y + 10
  win:setframe(f)
end)

hotkey.bind(hyper, "N", function()
  local win = window.focusedwindow()
  local f = win:frame()
  
  f.x = f.x + 10
  f.y = f.y + 10
  win:setframe(f)
end)

-- Set grid size.
grid.GRIDWIDTH  = 6
grid.GRIDHEIGHT = 4
grid.MARGINX = 0
grid.MARGINY = 0

hotkey.bind(mash, ';', function() grid.snap(window.focusedwindow()) end)
hotkey.bind(mash, "'", function() fnutils.map(window.visiblewindows(), grid.snap) end)

-- Tiling motions
hotkey.bind(hyper, "M", grid.maximize_window)

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