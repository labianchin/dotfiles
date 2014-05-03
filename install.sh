#!/bin/bash

dir=$(cd $(dirname "$0"); pwd) # dotfiles directory

#Initialize submodules
git submodule init; git submodule update;

BKP=~/dotfiles_old       # old dotfiles backup directory
# list of files/folders to symlink in homedir
files="vimrc vim gvimrc zshrc oh-my-zsh myterminalrc gitconfig xbindkeysrc tmux.conf tmux-osx.conf conkyrc gtk-bookmarks"

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

echo "Creates ~/.dotfiles"
DOTFILES=~/.dotfiles
mv $DOTFILES "$BKP"
ln -s $dir $DOTFILES

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
    mv ~/.$file "$BKP"
    echo "Creating symlink to $file in home directory."
    ln -s $DOTFILES/$file ~/.$file
done
echo "Adding myterminalrc to bashrc"
echo "source ~/.myterminalrc" | tee -a ~/.bashrc

case `uname -s` in
  Darwin)
	mkdir -p $BPK/mac_preferences/
	prefdir=$DOTFILES/mac_preferences
	macpref=~/Library/Preferences
	for f in $prefdir/*; do
		file=$(basename $f);
	    mv $macpref/$file $BPK/mac_preferences/
		echo "Creating symlink to $file mac preference"
		ln -s $prefdir/$file ~/Library/Preferences/
	done
    ;;
  Linux)
    ;;
esac

#ln -s $dir/ssh_config ~/.ssh/config

echo "Installing vim bundles"
vim +BundleInstall +qall #installs vim bundles

echo "Updating oh-my-zsh"
bash ~/.oh-my-zsh/tools/upgrade.sh
