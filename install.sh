#!/bin/bash

#Operating System
os=$(uname)

#--------------------#
# Check dependencies #
#--------------------#
deps=("zsh" "vim" "python3")
for dep in $deps 
do 
    if ! [ -x "$(command -v $dep)" ]; then
        echo Installing $dep.
        if [ $os == "Darwin" ]; then
            brew install $dep
            $HOME/.dotfiles/confs/macconf.sh
        elif [ $os == "Linux" ]; then
            sudo apt-get install $dep
        fi
    fi
done

#--------------------#
# Install extensions #
#--------------------#
# FZF
git clone https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all > /dev/null 2>&1
# Oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
touch $HOME/.z
# vim-plug
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

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
ln -sf "$PWD/themes/molokai.vim" "$HOME/.vim/colors/molokai.vim"
ln -sf "$PWD/themes/mh_edit.zsh-theme" "$HOME/.oh-my-zsh/themes/mh_edit.zsh-theme"

#--------------------#
# Download Scripts   #
#--------------------#
mkdir -p $HOME/Scripts/gists
python3 $HOME/.dotfiles/confs/getgists.py

#--------------------#
# Postinstall confs  #
#--------------------#
# vim plugins
vim +PlugInstall +qall +so %
# Set zsh default
chsh -s /bin/zsh
