#!/bin/bash

function disable_daemon {
  echo "Disabling ${1}"
  sudo launchctl unload -w /System/Library/LaunchDaemons/${1}.plist
}

disable_daemon com.apple.apsd # ApplePushService daemon for Apple Push Notification service.
disable_daemon com.apple.AssetCacheLocatorService # Cached Asset Locator?
disable_daemon com.apple.awacsd # Facilitates connections between devices using Back to My Mac.
disable_daemon com.apple.awdd
disable_daemon com.apple.CrashReporterSupportHelper
disable_daemon com.apple.GameController.gamecontrollerd
disable_daemon com.apple.SubmitDiagInfo
disable_daemon com.apple.TMCacheDelete

# https://cirrusj.github.io/Yosemite-Stop-Launch/
