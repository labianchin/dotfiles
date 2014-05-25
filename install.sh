#!/bin/bash

dir=$(cd $(dirname "$0"); pwd) # dotfiles directory

#Initialize submodules
git submodule init; git submodule update;

BKP=~/dotfiles_old       # old dotfiles backup directory
# list of files/folders to symlink in homedir
files="vimrc vim zshrc oh-my-zsh myterminalrc gitconfig tmux.conf tmux-osx.conf"
xfiles="gvimrc xbindkeysrc conkyrc gtk-bookmarks"
macfiles="slate"

case `uname -s` in
  Darwin)
	  files="$files $macfiles"
    ;;
  Linux)
	  [[ "$(ps --no-headers -C X)" ]] && files="$files $xfiles"
    ;;
esac

# create dotfiles_old in homedir
echo "Creating $BKP for backup of any existing dotfiles in ~"
mkdir -p $BKP
echo "...done"

echo "Creates ~/.dotfiles"
DOTFILES=~/.dotfiles
mv $DOTFILES "$BKP"
ln -s $dir $DOTFILES

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
echo "=== Installing all of these dotfiles ==="
echo $files
echo "=== ==="
for file in $files; do
    mv ~/.$file "$BKP"
    echo "Creating symlink to $file in home directory."
    ln -s $DOTFILES/$file ~/.$file
done
echo "Adding myterminalrc to bashrc"
echo "source ~/.myterminalrc" | tee -a ~/.bashrc

case `uname -s` in
  Darwin)
	echo "Running osx specific configuration for mac preferences"
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
[[ ! -f "$HOME/.vim/bundle/vundle/autoload/vundle.vim" ]] && mkdir -p ~/.vim/bundle && git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
vim +BundleInstall +qall #installs vim bundles

echo "Updating oh-my-zsh"
bash ~/.oh-my-zsh/tools/upgrade.sh
