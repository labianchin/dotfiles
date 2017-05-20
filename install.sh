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

# store old dotfiles in a backup directory
readonly BACKUP_DIR=${BACKUP_DIR:-$HOME/dotfiles_old}

# backup and symlink a single file
backup_symlink() {
  local from=$1
  local to=$2
  local backup=$3
  mv "$to" "$backup/" || true
  ln -sf "$from" "$to"
}

symlink_files() {
  local source=$1
  local files=$2
  echo "=== Symlinking all of these dotfiles ==="
  echo "$files"
  mkdir -p "$BACKUP_DIR"
  echo "Old files will be placed at $BACKUP_DIR folder"
  for file in $files; do
    backup_symlink "$source/$file" "$HOME/.$file" "$BACKUP_DIR"
  done
}

install_osx_dots() {
  local osxfiles="kwm hammerspoon"
  git config --global credential.helper osxkeychain
  symlink_files "$dir/osx" "$osxfiles"
}

install_linux_dots() {
  local xfiles="xbindkeysrc conkyrc gtk-bookmarks"
  is_xorg_running && symlink_files "$dir/linux" "$xfiles"
  git config --global credential.helper cache
}

install_dots() {
  # Install common dotfiles
  local sfiles="zshrc zplug-setup myterminalrc ctags gitconfig gitignore_global tmux.conf curlrc tmux spacemacs.d"
  symlink_files "$dir" "$sfiles"
  backup_symlink "$dir/ssh_config" "$HOME/.ssh/config" "$BACKUP_DIR"

  is_osx && install_osx_dots
  is_linux && install_linux_dots

  echo "These are the symlinks in $HOME"
  #find "$HOME" -maxdepth 2 -type l -exec ls -lh {} + 2>/dev/null
  #find "$HOME" -maxdepth 2 -type l -exec ls -lah --color {} + 2>/dev/null
  find "$HOME" -maxdepth 2 -type l -exec ls -lah --color {} + 2>/dev/null | sed -e 's/.* \(.* -> .*\)/\1/' -e "/.*dotfiles_old.*->/ d"
  #find . -maxdepth 1 -exec readlink {} +
}

myterminal_bashrc() {
  echo ""
  echo "Adding myterminalrc to bashrc"
  grep -Fq 'source ~/.myterminalrc' ~/.bashrc || echo 'source ~/.myterminalrc' >> ~/.bashrc
}

zsh_as_default() {
  if grep -Fxq "$(which zsh)" /etc/shells
  then
    echo "ZSH ok"
  else
    echo "Warning: remember to change shell"
    echo "echo \$(which zsh) | sudo tee -a /etc/shells"
    echo "chsh -s \$(which zsh)"
    chsh -s "$(which zsh)"
    echo "Remember to logout and login again"
  fi
}

install_vim() {
  echo ""
  sh "$dir/vim/install.sh"
}

install_spacemacs() {
  [[ ! -d ~/.emacs.d ]] && git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
  git -C ~/.emacs.d pull origin master
  echo "emacs installed and updated, config is placed on ~/.spacemacs"
}

install_fzf_home() {
  [[ ! -d ~/.fzf ]] && git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  git -C ~/.fzf pull origin master
  ~/.fzf/install --all # --all generates the ~/.fzf.zsh
}

install_fzf() {
  [[ -f $(brew --prefix fzf 2>/dev/null) ]] && $(brew --prefix fzf)/install --all || install_fzf_home
}

install_tmux_tpm() {
  tmux -V
  tmux source-file "$HOME/.tmux.conf"
  "$HOME/.tmux/plugins/tpm/bin/clean_plugins"
  "$HOME/.tmux/plugins/tpm/bin/update_plugins" all
}


osx_install() {
  bash "$dir/osx/bundle/install.sh" || true
  bash "$dir/osx/karabiner-import.sh"
  bash "$dir/osx/osx-for-hackers.sh"
  # look at
  # https://github.com/thoughtbot/laptop/blob/master/mac
}

intellij(){
  cat << EOF > ~/Library/Preferences/IdeaIC2017.1/idea.vmoptions
-Xms256m
-Xmx1536m
-XX:MaxPermSize=350m
-XX:ReservedCodeCacheSize=64m
-XX:+UseCodeCacheFlushing
-XX:+UseCompressedOops
)
EOF

mkdir -p ~/.sbt/0.13/plugins/
cat << EOF > ~/.sbt/0.13/plugins/plugins.sbt
addSbtPlugin("net.virtual-void" % "sbt-dependency-graph" % "0.8.2")
EOF
}


#echo "Making zsh and bash history append only"
#chattr +a ~/.{bash,zsh}_history
#chflags uappnd ~/.{zsh,bash}_history

main() {
  install_dots
  myterminal_bashrc
  zsh_as_default
  install_vim
  #install_spacemacs
  install_tmux_tpm
  #install_fzf  # managed by zplug or brew
  #is_osx && osx-install
  #TODO base16 install
  echo "DONE!"
}

time main
