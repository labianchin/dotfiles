#!/usr/bin/env bash

set -o errexit
set -o nounset

readonly dir=$(cd $(dirname "$0"); pwd) # dotfiles directory

# list of files/folders to symlink in homedir
files="zshrc myterminalrc ctags gitconfig gitignore_global tmux.conf tmux-osx.conf"
xfiles="xbindkeysrc conkyrc gtk-bookmarks"
macfiles=""

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
      mv ~/.$file "$backup" || true
      ln -s $source/$file ~/.$file
  done
}

# Install common dotfiles
symlink_files $dir "$files" $bkp_dir

case `uname -s` in
  Darwin)

    git config --global credential.helper osxkeychain
    ;;
  Linux)
    # has xorg running?
    [[ "$(ps --no-headers -C X)" ]] && symlink_files $dir/linux "$files" $bkp_dir
 
    git config --global credential.helper cache
    ;;
esac

echo ""
bash $dir/vim/install.sh

echo ""
echo "Adding myterminalrc to bashrc"
grep -Fq 'source ~/.myterminalrc' ~/.bashrc || echo 'source ~/.myterminalrc' >> ~/.bashrc

function zsh-as-default() {
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

function oh-my-zsh-install() {
  local ZSH="$HOME/.oh-my-zsh"
  if [[ ! -d $ZSH ]]; then
    echo "Installing oh-my-zsh"
    git clone https://github.com/robbyrussell/oh-my-zsh.git $ZSH
  else
    echo "Upgrading oh-my-zsh"
    env ZSH=$ZSH /bin/sh $ZSH/tools/upgrade.sh
  fi
}
oh-my-zsh-install


function prezto-install() {
  local ZSH="$HOME/.zprezto"
  echo "== ZSH configuration"
  if [[ ! -d $ZSH ]]; then
    echo "Installing prezto"
    git clone --depth 10 --recursive https://github.com/labianchin/prezto.git "${ZSH}"
  else
    echo "Upgrading prezto"
    (cd $ZSH; git pull && git submodule update --init --recursive)
  fi
  ln -sf "$ZSH/runcoms/zprofile" ~/.zprofile
  ln -sf "$ZSH/runcoms/zshrc" ~/.zshrc
  ln -sf "$ZSH/runcoms/zpreztorc" ~/.zpreztorc
}

#prezto-install
zsh-as-default

