#!/bin/bash
# macos policies enable
spctl --master-disable
defaults write com.apple.finder CreateDesktop -bool false
defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 1
defaults write com.apple.screencapture location ~/Pictures/screenshots/

killall Dock
killall Finder
