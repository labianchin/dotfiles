
brew install lua luarocks
echo 'rocks_servers = { "http://rocks.moonscript.org" }' > ~/.luarocks/config.lua

luarocks install mjolnir.hotkey
luarocks install mjolnir.application
luarocks install mjonir.window
luarocks install mjolnir.alert
luarocks install mjolnir.screen
luarocks install mjolnir.cmsj.appfinder
luarocks install mjolnir.fnutils
luarocks install mjolnir.tiling
luarocks install mjolnir.bg.grid
