#!/bin/bash


rm -r ~/.purple/logs
ln -s ~/Dropbox/im/purple_logs ~/.purple/
ln -s ~/Dropbox/cic ~/
ln -s ~/Dropbox/dev ~/


dir=~/Dropbox/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="vimrc gvimrc vim zshrc oh-my-zsh xbindkeysrc gitconfig tmux.conf conkyrc gtk-bookmarks termprefs.sh"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done


case `uname -s` in
  Darwin)
	mkdir -p ~/dotfiles_old/mac_preferences/
	prefdir=$dir/mac_preferences
	macpref=~/Library/Preferences
	for f in $prefdir/*
	do
		file=$(basename $f);
	    mv $macpref/$file ~/dotfiles_old/mac_preferences/
		echo "Creating symlink to $file mac preference"
		ln -s $prefdir/$file ~/Library/Preferences/
	done
    ;;
  Linux)
    ;;
esac

ln -s $dir/ssh_config ~/.ssh/config
vim +BundleInstall +qall #installs vim bundles
