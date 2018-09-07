#!/bin/sh

# Some things taken from here
# https://github.com/mathiasbynens/dotfiles/blob/master/.osx
# https://github.com/ptb/Mac-OS-X-Lion-Setup/blob/master/setup.sh
# https://github.com/kevinSuttle/macOS-Defaults/blob/master/REFERENCE.md
# TODO: https://github.com/superlumic/superlumic-config/blob/master/kevin.yml

# Set the colours you can use
black='\033[0;30m'
white='\033[0;37m'
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
magenta='\033[0;35m'
cyan='\033[0;36m'


#  Reset text attributes to normal + without clearing screen.
alias Reset="tput sgr0"

# Color-echo.
# arg $1 = message
# arg $2 = Color
cecho() {
  echo "${2}${1}"
  Reset # Reset to normal.
  return
}

# Ask for the administrator password upfront
sudo -v
 
# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo ""
cecho "##############################################" $white
cecho "#  This script will make your ï£¿ Mac awesome." $white
cecho "#   Follow the prompts and you'll be fine." $white
cecho "#" $white
cecho "#            ~ Happy Hacking ~" $white
cecho "#############################################" $white
echo ""


###############################################################################
# General UI/UX
###############################################################################

echo ""

# Enable Airplay menu bar item
#defaults write 'com.apple.systemuiserver' 'NSStatusItem Visible com.apple.menuextra.airplay' -bool true
#defaults write 'com.apple.systemuiserver' 'menuExtras' -array-add '/System/Library/CoreServices/Menu Extras/Displays.menu'
# Enable Battery menu bar item
defaults write 'com.apple.systemuiserver' 'NSStatusItem Visible com.apple.menuextra.battery' -bool true
defaults write 'com.apple.systemuiserver' 'menuExtras' -array-add '/System/Library/CoreServices/Menu Extras/Battery.menu'

# Enable Clock menu bar item
defaults write 'com.apple.systemuiserver' 'NSStatusItem Visible com.apple.menuextra.clock' -bool true
defaults write 'com.apple.systemuiserver' 'menuExtras' -array-add '/System/Library/CoreServices/Menu Extras/Clock.menu'
# Enable Network menu bar item
defaults write 'com.apple.systemuiserver' 'NSStatusItem Visible com.apple.menuextra.airport' -bool true
defaults write 'com.apple.systemuiserver' 'menuExtras' -array-add '/System/Library/CoreServices/Menu Extras/AirPort.menu'

# Enable Volume menu bar item
defaults write 'com.apple.systemuiserver' 'NSStatusItem Visible com.apple.menuextra.volume' -bool true
defaults write 'com.apple.systemuiserver' 'menuExtras' -array-add '/System/Library/CoreServices/Menu Extras/Volume.menu'


echo ""
echo "Disabling OS X Gate Keeper"
echo "(You'll be able to install any app you want from here on, not just Mac App Store apps)"
sudo spctl --master-disable
sudo defaults write /var/db/SystemPolicy-prefs.plist enabled -string no
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Use a dark menu bar / dock
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

echo ""
echo "Increasing the window resize speed for Cocoa applications"
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

echo ""
echo "Expanding the save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

echo ""
echo "Automatically quit printer app once the print jobs complete"
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
echo ""
echo "Displaying ASCII control characters using caret notation in standard text views"
defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true


echo ""
echo "Saving to disk (not to iCloud) by default"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

echo ""
echo "Reveal IP address, hostname, OS version, etc. when clicking the clock in the login window"
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

echo ""
echo "Remove duplicates in the â€œOpen Withâ€ menu"
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user



###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input
###############################################################################

echo ""
echo "Increasing sound quality for Bluetooth headphones/headsets"
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

echo ""
echo "Enabling full keyboard access for all controls (e.g. enable Tab in modal dialogs)"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

echo ""
echo "Disabling press-and-hold for keys in favor of a key repeat"
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

echo ""
echo "Setting a blazingly fast keyboard repeat rate (ain't nobody got time fo special chars while coding!)"
defaults write NSGlobalDomain KeyRepeat -int 0

echo ""
echo "Disabling auto-correct"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

echo ""
echo "Setting trackpad & mouse speed to a reasonable number"
defaults write -g com.apple.trackpad.scaling 2
defaults write -g com.apple.mouse.scaling 2.5

echo ""
echo "Turn off keyboard illumination when computer is not used for 5 minutes"
defaults write com.apple.BezelServices kDimTime -int 300

# now using karabiner-elements
#echo ""
#echo "Making Caps Lock as control"
#ioreg -n IOHIDKeyboard -r | grep -E 'VendorID"|ProductID' | awk '{ print $4 }' | paste -s -d'-\n' - | xargs -I{} /usr/bin/defaults -currentHost write -g "com.apple.keyboard.modifiermapping.{}-0" -array "<dict><key>HIDKeyboardModifierMappingDst</key><integer>2</integer><key>HIDKeyboardModifierMappingSrc</key><integer>0</integer></dict>"

#echo ""
#echo "Setting a blazingly fast keyboard repeat rate" 
#defaults write NSGlobalDomain KeyRepeat -int 0.02

#echo ""
#echo "Setting a shorter Delay until key repeat" 
#defaults write NSGlobalDomain InitialKeyRepeat -int 12

###############################################################################
# Screen
###############################################################################

echo ""
echo "Requiring password immediately after sleep or screen saver begins"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0


echo ""
echo "Enabling subpixel font rendering on non-Apple LCDs"
defaults write NSGlobalDomain AppleFontSmoothing -int 1


# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

echo ""
echo "Enabling HiDPI display modes (requires restart)"
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

###############################################################################
# Finder
###############################################################################

echo ""
echo "Showing icons for hard drives, servers, and removable media on the desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true

echo ""
echo "Showing all files in Finder by default"
defaults write NSGlobalDomain AppleShowAllFiles -bool true
chflags nohidden ~/Library

echo ""
echo "Showing all filename extensions in Finder by default"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo ""
echo "Showing status bar in Finder by default"
defaults write com.apple.finder ShowStatusBar -bool true

echo ""
echo "Allowing text selection in Quick Look/Preview in Finder by default"
defaults write com.apple.finder QLEnableTextSelection -bool true

echo ""
echo "Displaying full POSIX path as Finder window title"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

echo ""
echo "Disabling the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo ""
echo "Use column view in all Finder windows by default"
defaults write com.apple.finder FXPreferredViewStyle Clmv

echo ""
echo "Avoiding the creation of .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

echo ""
echo "Disabling disk image verification"
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

###############################################################################
# Dock & Mission Control
###############################################################################

# Wipe all (default) app icons from the Dock
# This is only really useful when setting up a new Mac, or if you don't use
# the Dock to launch apps.
#defaults write com.apple.dock persistent-apps -array

echo ""
echo "Setting the icon size of Dock items to 36 pixels for optimal size/screen-realestate"
defaults write com.apple.dock tilesize -int 36

echo ""
echo "Speeding up Mission Control animations and grouping windows by application"
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock "expose-group-by-app" -bool true

echo ""
echo "Setting Dock to auto-hide and removing the auto-hiding delay"
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0
# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true


# Reset Launchpad, but keep the desktop wallpaper intact
find "${HOME}/Library/Application Support/Dock" -name "*-*.db" -maxdepth 1 -delete

# Dockbar top of screen
defaults write com.apple.Dock orientation -string top
# Dockbar on the left
defaults write com.apple.dock pinning -string start

echo ""
echo "Reversing scroll"
defaults write -g com.apple.swipescrolldirection -boolean false

echo ""
echo "Enabling F keys"
defaults write -g com.apple.keyboard.fnState -boolean true

echo ""
echo "Enabling tap to click"
# Enable tap to click (Trackpad) for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# enable three finger drag
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerSwipeGesture -int 1
defaults write NSGlobalDomain com.apple.trackpad.threeFingerSwipeGesture -int 1

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

###############################################################################
# Spotlight                                                                   #
###############################################################################

# Hide Spotlight tray-icon (and subsequent helper)
#sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search
# Disable Spotlight indexing for any volume that gets mounted and has not yet
# been indexed before.
# Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"
# Change indexing order and disable some search results
# Yosemite-specific search results (remove them if your are using OS X 10.9 or older):
# 	MENU_DEFINITION
# 	MENU_CONVERSION
# 	MENU_EXPRESSION
# 	MENU_SPOTLIGHT_SUGGESTIONS (send search queries to Apple)
# 	MENU_WEBSEARCH             (send search queries to Apple)
# 	MENU_OTHER
defaults write com.apple.spotlight orderedItems -array \
	'{"enabled" = 1;"name" = "APPLICATIONS";}' \
	'{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
	'{"enabled" = 1;"name" = "DIRECTORIES";}' \
	'{"enabled" = 1;"name" = "PDF";}' \
	'{"enabled" = 1;"name" = "FONTS";}' \
	'{"enabled" = 1;"name" = "DOCUMENTS";}' \
	'{"enabled" = 0;"name" = "MESSAGES";}' \
	'{"enabled" = 1;"name" = "CONTACT";}' \
	'{"enabled" = 1;"name" = "EVENT_TODO";}' \
	'{"enabled" = 1;"name" = "IMAGES";}' \
	'{"enabled" = 1;"name" = "BOOKMARKS";}' \
	'{"enabled" = 1;"name" = "MUSIC";}' \
	'{"enabled" = 0;"name" = "MOVIES";}' \
	'{"enabled" = 1;"name" = "PRESENTATIONS";}' \
	'{"enabled" = 1;"name" = "SPREADSHEETS";}' \
	'{"enabled" = 0;"name" = "SOURCE";}' \
	'{"enabled" = 1;"name" = "MENU_DEFINITION";}' \
	'{"enabled" = 0;"name" = "MENU_OTHER";}' \
	'{"enabled" = 1;"name" = "MENU_CONVERSION";}' \
	'{"enabled" = 1;"name" = "MENU_EXPRESSION";}' \
	'{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
	'{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'
# Load new settings before rebuilding the index
killall mds > /dev/null 2>&1
# Make sure indexing is enabled for the main volume
sudo mdutil -i on / > /dev/null
# Rebuild the index from scratch
#sudo mdutil -E / > /dev/null




###############################################################################
# Terminal
###############################################################################

echo ""
echo "Enabling UTF-8 ONLY in Terminal.app and setting the Pro theme by default"
defaults write com.apple.terminal StringEncodings -array 4
defaults write com.apple.Terminal "Default Window Settings" -string "Pro"
defaults write com.apple.Terminal "Startup Window Settings" -string "Pro"


# https://github.com/herrbischoff/awesome-osx-command-line
# https://github.com/mathiasbynens/dotfiles/blob/master/.macos
echo "Config keyboard input source options..." 
# Input Sources > Select next source in Input menu : enabled
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 61 "<dict><key>enabled</key><true/></dict>"
# Enable Key Repeat
defaults write -g ApplePressAndHoldEnabled -bool false
# Sets a fast repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
echo "Config lang and region date"
# Set language and text formats
defaults write NSGlobalDomain AppleLanguages -array "en"
defaults write NSGlobalDomain AppleLocale -string "en_US@currency=SEK"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# Require password 5 seconds after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 5

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true


###############################################################################
# Kill affected applications
###############################################################################

echo ""
cecho "Done!" $white
echo ""
echo ""
cecho "###############################################################################" $white
echo ""
echo ""
cecho "Note that some of these changes require a logout/restart to take effect." $white
cecho "Killing some open applications in order to take effect." $white
echo ""

for app in "Activity Monitor" "Address Book" "Calendar" "Contacts" "cfprefsd" \
  "Dock" "Finder" "Mail" "Messages" "Safari" "SystemUIServer" \
  "Terminal" "Transmission"; do
  killall "${app}" > /dev/null 2>&1
done


echo "TODOs"
echo "Go to security privacy and enable some apps"


# https://github.com/pansen/dotfiles/blob/master/macports/.osx
#echo "keep the wifi connected, even if the computer is locked"
#sudo /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport en0 prefs DisconnectOnLogout=NO

sudo launchctl config user path "/usr/local/bin:$PATH"

# https://www.jamf.com/jamf-nation/discussions/19685/parentalcontrolsd-cpu-ram-usage
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.familycontrols.plist
rm -rf "/Library/Application Support/Apple/ParentalControls"
pkill -9 parentalcontrolsd


# security
# https://github.com/drduh/macOS-Security-and-Privacy-Guide#firewall
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode on
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on
#sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setallowsigned off
#sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setallowsignedapp off
sudo pkill -HUP socketfilterfw


defaults -currentHost write ~/Library/Preferences/com.apple.alf globalstate -bool true
defaults write ~/Library/Preferences/com.apple.screensaver askForPassword -bool true
defaults write ~/Library/Preferences/com.apple.alf stealthenabled -bool true
defaults -currentHost write /Library/Preferences/com.apple.alf allowsignedenabled -bool false

defaults -currentHost write /Library/Preferences/SystemConfiguration/com.apple.finder AppleShowAllFiles -bool true
defaults write /Library/Preferences/com.apple.driver.AppleIRController DeviceEnabled -bool false
