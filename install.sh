#!/usr/bin/env bash

set -o errexit
set -o nounset

dir=$(cd $(dirname "$0"); pwd) # dotfiles directory

BKP=~/dotfiles_old       # old dotfiles backup directory
# list of files/folders to symlink in homedir
files="vimrc vim zshrc myterminalrc gitconfig tmux.conf tmux-osx.conf"
xfiles="gvimrc xbindkeysrc conkyrc gtk-bookmarks"
macfiles="slate"

case `uname -s` in
  Darwin)
    files="$files $macfiles"
    ;;
  Linux)
    # has xorg running?
    [[ "$(ps --no-headers -C X)" ]] && files="$files $xfiles"
    ;;
esac

# create dotfiles_old in homedir
echo "Creating $BKP folder for backup of any existing dotfiles in ~"
mkdir -p $BKP
echo "...done"

echo "Creating ~/.dotfiles folder"
DOTFILES=~/.dotfiles
mv $DOTFILES "$BKP"
ln -s $dir $DOTFILES

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
echo "=== Installing all of these dotfiles ==="
echo $files
echo "=== ==="
for file in $files; do
    mv ~/.$file "$BKP"
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
      ln -s $prefdir/$file ~/Library/Preferences/
    done
    git config --global credential.helper osxkeychain
    ;;
  Linux)
    git config --global credential.helper cache
    ;;
esac

echo ""
bash ~/.vim/install_vim.sh

echo ""
function oh-my-zsh-install() {
  local ZSH="$HOME/.oh-my-zsh"
  echo "== ZSH configuration"
  if [[ ! -d $ZSH ]]; then
    echo "Installing oh-my-zsh"
    git clone https://github.com/robbyrussell/oh-my-zsh.git $ZSH
  else
    echo "Upgrading oh-my-zsh"
    env ZSH=$ZSH /bin/sh $ZSH/tools/upgrade.sh
  fi

  if grep -Fxq "$(which zsh)" /etc/shells
  then
    echo "ZSH ok"
  else
    echo "Warning: remember to change shell"
    echo "echo \$(which zsh) | sudo tee -a /etc/shells"
    echo "chsh -s \$(which zsh)"
    echo "Remember to logout and login again"
  fi
}
oh-my-zsh-install

