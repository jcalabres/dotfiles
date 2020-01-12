#!/bin/bash
spctl --master-disable

defaults write com.apple.finder CreateDesktop -bool false
defaults write com.apple.screencapture location ~/Pictures/screenshots/
defaults write com.apple.screencapture type -string "png"
defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 1
defaults write com.apple.dock autohide-time-modifier -int 0;
defaults write com.apple.dock expose-animation-duration -float 0.12

killall Dock Finder
