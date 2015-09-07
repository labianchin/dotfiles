#!/bin/bash

defaults write /Library/Preferences/com.apple.alf \
  globalstate -int 1
defaults write /Library/Preferences/com.apple.alf \
  allowsignedenabled -bool false
defaults write /Library/Preferences/com.apple.alf \
  loggingenabled -bool true
defaults write /Library/Preferences/com.apple.alf \
  stealthenabled -bool true