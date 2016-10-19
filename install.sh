#!/usr/bin/env bash
# Ideas on how to install stuff: https://news.ycombinator.com/item?id=11938009

set -o errexit
set -o nounset

readonly dir=$(cd $(dirname "$0"); pwd) # dotfiles directory

is_linux() {
    [[ $('uname') == 'Linux' ]];
}

is_xorg_running() {
  [[ "$(ps --no-headers -C X)" ]];
}

is_osx() {
    [[ $('uname') == 'Darwin' ]];
}

# backup and symlink a single file
function backup_symlink() {
  local from=$1
  local to=$2
  local backup=$3
  mv "$to" "$backup/" || true
  ln -sf "$from" "$to"
}

function symlink_files() {
  local source=$1
  local files=$2
  local backup=$3
  echo "=== Symlinking all of these dotfiles ==="
  echo "$files"
  echo "Old files will be placed at $backup folder"
  mkdir -p "$backup"
  for file in $files; do
    backup_symlink "$source/$file" "$HOME/.$file" "$backup"
  done
}

# list of files/folders to symlink in homedir
readonly sfiles="zshrc zgen-setup myterminalrc ctags gitconfig gitignore_global tmux.conf curlrc tmux spacemacs.d"
readonly xfiles="xbindkeysrc conkyrc gtk-bookmarks"
readonly osxfiles="kwm hammerspoon"
readonly bkp_dir=~/dotfiles_old       # old dotfiles backup directory

function install-osx-dots() {
  git config --global credential.helper osxkeychain
  symlink_files "$dir/osx" "$osxfiles" $bkp_dir
}

function install-linux-dots() {
  is_xorg_running && symlink_files "$dir/linux" "$xfiles" $bkp_dir
  git config --global credential.helper cache
}

function install-dots() {
  # Install common dotfiles
  symlink_files "$dir" "$sfiles" $bkp_dir
  backup_symlink "$dir/ssh_config" "$HOME/.ssh/config" $bkp_dir

  is_osx && install-osx-dots
  is_linux && install-linux-dots

  echo "These are the symlinks in $HOME"
  #find "$HOME" -maxdepth 2 -type l -exec ls -lh {} + 2>/dev/null
  #find "$HOME" -maxdepth 2 -type l -exec ls -lah --color {} + 2>/dev/null
  find "$HOME" -maxdepth 2 -type l -exec ls -lah --color {} + 2>/dev/null | sed -e 's/.* \(.* -> .*\)/\1/' -e "/.*dotfiles_old.*->/ d"
  #find . -maxdepth 1 -exec readlink {} +
}

function myterminalrc-bashrc() {
  echo ""
  echo "Adding myterminalrc to bashrc"
  grep -Fq 'source ~/.myterminalrc' ~/.bashrc || echo 'source ~/.myterminalrc' >> ~/.bashrc
}

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

function vim-install() {
  echo ""
  sh "$dir/vim/install.sh"
}

function spacemacs-install() {
  [[ ! -d ~/.emacs.d ]] && git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
  git -C ~/.emacs.d pull origin master
  echo "emacs installed and updated, config is placed on ~/.spacemacs"
}

function fzf-home-install() {
  [[ ! -d ~/.fzf ]] && git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  git -C ~/.fzf pull origin master
  ~/.fzf/install --all # --all generates the ~/.fzf.zsh
}

function fzf-install() {
  [[ -f $(brew --prefix fzf 2>/dev/null) ]] && $(brew --prefix fzf)/install --all || fzf-home-install
}


#echo "Making zsh and bash history append only"
#chattr +a ~/.{bash,zsh}_history
#chflags uappnd ~/.{zsh,bash}_history

function main() {
  install-dots
  myterminalrc-bashrc
  zsh-as-default
  vim-install
  spacemacs-install
  fzf-install
  #TODO base16 install
  echo "DONE!"
}

main
