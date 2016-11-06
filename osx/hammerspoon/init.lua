-- Based and inspired on:
-- https://github.com/jasonm23/.hammerspoon/blob/master/main.moon
-- https://github.com/mgee/hammerspoon-config/blob/143b2581152cc65b269415936fc4be8df5bdfcde/init.lua
-- https://github.com/Linell/hammerspoon-config
-- TODO: keyboard detect and change karabiner: https://gist.github.com/gabamnml/8bf6e00d34219caa9037
-- TODO: do look here: https://github.com/trishume/dotfiles/blob/master/hammerspoon/hammerspoon.symlink/init.lua
-- TODO: wifi restart

require 'action'

-- Set up hotkey combinations
local mash      = {"cmd", "alt", "ctrl"}
local mashshift = {"cmd", "alt", "shift"}
sys_name  = "Hammerspoon"
local myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", hs.reload):start()

hs.window.animationDuration = 0.15

expose = hs.expose.new(hs.window.filter.new():setDefaultFilter({allowTitles=1}),{
  showThumbnails                  = false
})

hs.grid.setMargins({0, 0})
hs.grid.setGrid('6x4', nil)

function reloadAndAlert()
  hs.alert.show("Reloading " .. sys_name)
  hs.reload()
  hs.alert.show(sys_name .. " reloaded!")
end
function launchOrActivateApp(appName)
  hs.application.launchOrFocus(appName)
end

appShortcuts = {
  ['X'] = 'iTerm',
  ['C'] = 'Google Chrome',
  ['K'] = 'KeeWeb',
  ['S'] = 'Slack',
  ['Y'] = 'Spotify',
  ['B'] = 'Firefox',
  ['V'] = 'MacVim',
  --['E'] = 'Emacs',
  ['F'] = 'Finder',
  ['M'] = 'Activity Monitor',
}

-- Bindings
function defineKeybindings()
  for key, app in pairs(appShortcuts) do
    hs.hotkey.bind(mash, key, function() launchOrActivateApp(app) end)
  end
  hs.hotkey.bind(mash, "R", reloadAndAlert)

  hs.hotkey.bind(mash, 'UP',    function() Action.Grid(0, 0, 1, 1/2)(hs.window.focusedWindow()) end)
  hs.hotkey.bind(mash, 'DOWN',  function() Action.Grid(0, 1/2, 1, 1/2)(hs.window.focusedWindow()) end)
  hs.hotkey.bind(mash, 'LEFT',  function() Action.Grid(0, 0, 1/2, 1)(hs.window.focusedWindow()) end)
  hs.hotkey.bind(mash, 'RIGHT', function() Action.Grid(1/2, 0, 1/2, 1)(hs.window.focusedWindow()) end)
  --hs.hotkey.bind(mash, 'SPACE', function() Profile.detectAndChange() end)
  hs.hotkey.bind(mash, 'E',     function() expose:toggleShow() end)
  hs.hotkey.bind(mash, 'G',     function() hs.grid.toggleShow() end)
  hs.hotkey.bind(mash, '.',     hs.hints.windowHints)

  -- screen quarter
  hs.hotkey.bind(mash, 'Q',    function() Action.MoveToUnit(0, 0, 1/2, 1/2)(hs.window.focusedWindow()) end)
  hs.hotkey.bind(mash, 'W',    function() Action.MoveToUnit(1/2, 0, 1/2, 1/2)(hs.window.focusedWindow()) end)
  hs.hotkey.bind(mash, 'A',    function() Action.MoveToUnit(0, 1/2, 1/2, 1/2)(hs.window.focusedWindow()) end)
  hs.hotkey.bind(mash, 'S',    function() Action.MoveToUnit(1/2, 1/2, 1/2, 1/2)(hs.window.focusedWindow()) end)
  hs.hotkey.bind(mash, 'D',    function() Action.MoveToUnit(1/4, 1/4, 1/2, 1/2)(hs.window.focusedWindow()) end)

  hs.hotkey.bind(mash, ';', function() grid.snap(hs.window.focusedWindow()) end)
  hs.hotkey.bind(mash, "'", function() hs.fnutils.map(hs.window.visibleWindows(), hs.grid.snap) end)
  hs.hotkey.bind(mash, "M", hs.grid.maximizeWindow)
  hs.hotkey.bind(mash, 'N', hs.grid.pushWindowNextScreen)
  hs.hotkey.bind(mash, 'P', hs.grid.pushWindowPrevScreen)

  -- Tiling motions
  hs.hotkey.bind(mashshift, 'J', hs.grid.pushWindowDown)
  hs.hotkey.bind(mashshift, 'K', hs.grid.pushWindowUp)
  hs.hotkey.bind(mashshift, 'H', hs.grid.pushWindowLeft)
  hs.hotkey.bind(mashshift, 'L', hs.grid.pushWindowRight)
  hs.hotkey.bind(mash, 'U', hs.grid.resizeWindowTaller)
  hs.hotkey.bind(mash, 'O', hs.grid.resizeWindowWider)
  hs.hotkey.bind(mash, 'I', hs.grid.resizeWindowThinner)
  hs.hotkey.bind(mash, 'Y', hs.grid.resizeWindowShorter)
end

defineKeybindings()
hs.alert.show(sys_name .. " loaded!", 3)
