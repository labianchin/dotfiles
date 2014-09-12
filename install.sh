#!/usr/bin/env bash

set -o errexit
set -o nounset

readonly dir=$(cd $(dirname "$0"); pwd) # dotfiles directory

# list of files/folders to symlink in homedir
files="vimrc vim zshrc myterminalrc gitconfig tmux.conf tmux-osx.conf"
xfiles="gvimrc xbindkeysrc conkyrc gtk-bookmarks"
macfiles="slate"

readonly bkp_dir=~/dotfiles_old       # old dotfiles backup directory
echo "Creating $bkp_dir folder for backup of any existing dotfiles in home"
mkdir -p $bkp_dir

function symlink_files() {
  local source=$1
  local files=$2
  local backup=$3/
  # move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
  echo "=== Symlinking all of these dotfiles ==="
  echo $files
  echo "=== ==="
  for file in $files; do
      mv ~/.$file "$backup"
      ln -s $source/$file ~/.$file
  done
}

case `uname -s` in
  Darwin)
    symlink_files $dir "$files $macfiles" $bkp_dir

    echo "Running osx specific configuration for mac preferences"
    mkdir -p $bkp_dir/mac_preferences/
    prefdir=$dir/mac_preferences
    macpref=~/Library/Preferences
    for f in $prefdir/*; do
      file=$(basename $f);
      mv $macpref/$file $bkp_dir/mac_preferences/
      ln -s $prefdir/$file ~/Library/Preferences/
    done
    git config --global credential.helper osxkeychain
    ;;
  Linux)
    # has xorg running?
    [[ "$(ps --no-headers -C X)" ]] && files="$files $xfiles"
    symlink_files $dir "$files" $bkp_dir

    git config --global credential.helper cache
    ;;
esac

echo ""
bash $dir/vim/install_vim.sh

echo ""
echo "Adding myterminalrc to bashrc"
grep -Fq 'source ~/.myterminalrc' ~/.bashrc || echo 'source ~/.myterminalrc' >> ~/.bashrc

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

