#!/bin/bash

#--------------------#
# Check dependencies #
#--------------------#
deps=("zsh" "vim" "chunkwm" "skhd")
for dep in $deps 
do 
    if ! [ -x "$(command -v $dep)" ]; then
        echo Installing $dep.
        brew install $dep 
    fi
done

#--------------------#
# Install extensions #
#--------------------#
# Install FZF
git clone https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all > /dev/null 2>&1
# Install Oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
touch $HOME/.z
# Install vim-plug
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

#--------------------#
# Symlink confs      #
#--------------------#
ln -sf "$PWD/confs/vimrc" "$HOME/.vimrc"
ln -sf "$PWD/confs/zshrc" "$HOME/.zshrc"

#--------------------#
# Symlink themes     #
#--------------------#
mkdir -p "$HOME/.vim/colors"
ln -sf "$PWD/themes/molokai.vim" "$HOME/.vim/colors/molokai.vim"
ln -sf "$PWD/themes/mymh.zsh-theme" "$HOME/.oh-my-zsh/themes/mymh.zsh-theme"

#--------------------#
# Postinstall confs  #
#--------------------#
# Install vim plugins
vim +PlugInstall +qall +so %
# Set zsh default
chsh -s /bin/zsh
