#!/bin/bash

#Operating System
os=$(uname)

#--------------------#
# Check dependencies #
#--------------------#
packages="cat packages.txt"
if [ $os == "Darwin" ]; then
	$packages | xargs brew install
	$HOME/.dotfiles/confs/conf.sh
elif [ $os == "Linux" ]; then
	$packages | xargs sudo apt-get install
fi

#--------------------#
# Install extensions #
#--------------------#
# Oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
touch $HOME/.z
# vim-plug
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# FZF
git clone https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all > /dev/null 2>&1

#--------------------#
# Symlink confs      #
#--------------------#
ln -sf "$PWD/confs/vimrc" "$HOME/.vimrc"
ln -sf "$PWD/confs/zshrc" "$HOME/.zshrc"
if [ $os == "Darwin" ]; then
    # Tell iTerm2 to use the custom preferences in the directory
    defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
    # Specify the preferences directory
    defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$HOME/.dotfiles/confs/iterm2"
fi 

#--------------------#
# Symlink themes     #
#--------------------#
mkdir -p "$HOME/.vim/colors"
ln -sf "$PWD/themes/gruvbox.vim" "$HOME/.vim/colors/gruvbox.vim"

#--------------------#
# Postinstall confs  #
#--------------------#
# vim plugins
vim +PlugInstall +qall +so %
# Set zsh default
chsh -s /bin/zsh
