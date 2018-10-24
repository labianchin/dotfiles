#!/usr/bin/env bash
# Ideas on how to install stuff: https://news.ycombinator.com/item?id=11938009

set -o errexit
set -o nounset

readonly DIR="$( cd "$( dirname "$0" )" && pwd )"

is_osx() {
    [[ $('uname') == 'Darwin' ]]
}

is_linux() {
    [[ $('uname') == 'Linux' ]]
}

is_xorg_running() {
  [[ "$(pidof X)" ]]
}

is_termux() {
    [[ "$(command -v termux-info >/dev/null 2>&1 && termux-info version)" ]]
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
  shift
  local files="$*"
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
  symlink_files "$DIR/osx" "$osxfiles"
  #mkdir -p "$HOME/Library/KeyBindings/"
  #ln -sf "$DIR/osx/DefaultKeyBinding.dict" "$_"
  ln -sf "$DIR/osx/karabiner" "$HOME/.config"
  launchctl kickstart -k "gui/$(id -u)/org.pqrs.karabiner.karabiner_console_user_server" || true
}

install_linux_dots() {
  local xfiles="xbindkeysrc conkyrc gtk-bookmarks"
  is_xorg_running && symlink_files "$DIR/linux" "$xfiles"
  git config --global credential.helper cache
}

install_dots() {
  # Install common dotfiles
  local sfiles="zshrc zplug-setup myterminalrc ctags gitconfig gitignore_global ignore tmux.conf curlrc psqlrc spacemacs.d"
  symlink_files "$DIR" "$sfiles"
  mkdir -p "$HOME/.ssh"
  chmod -R 700 "$HOME/.ssh"
  backup_symlink "$DIR/ssh_config" "$HOME/.ssh/config" "$BACKUP_DIR"

  is_osx && install_osx_dots
  is_linux && install_linux_dots

  echo "These are the symlinks in $HOME"
  find "$HOME" -maxdepth 2 -type l -exec ls -lah --color {} + 2>/dev/null | sed -e 's/.* \(.* -> .*\)/\1/' -e "/.*dotfiles_old.*->/ d"
  #find . -maxdepth 1 -exec readlink {} +
}

myterminal_bashrc() {
  echo ""
  echo "Adding myterminalrc to bashrc"
  grep -Fq 'source ~/.myterminalrc' ~/.bashrc || echo 'source ~/.myterminalrc' >> ~/.bashrc
}

zsh_as_default() {
  zsh -c 'source ~/.zshrc'
  if grep -Fxq "$(which zsh)" /etc/shells; then
    echo "ZSH properly configured on /etc/shells"
  else
    echo "Warning: remember to change shell"
    echo "echo \$(which zsh) | sudo tee -a /etc/shells"
    echo "chsh -s \$(which zsh)"
    echo "or sudo dscl . -create /Users/$USER UserShell /usr/local/bin/zsh"
    #chsh -s "$(which zsh)"
    echo "Remember to logout and login again"
  fi
  #echo "Making zsh and bash history append only"
  #chattr +a ~/.{bash,zsh}_history
  #chflags uappnd ~/.{zsh,bash}_history
}

check_colors() {
  echo "colours 17 to 21 should NOT appear blue"
  echo "See more at https://github.com/chriskempson/base16-shell"
  "$HOME/.zplug/repos/chriskempson/base16-shell/colortest"
}

check_fonts() {
  echo "These are powerline symbols: , , , , , , , ro=, ws=☲, lnr=☰, mlnr=, br=, nx=Ɇ, crypt=🔒, , , , "
  echo "Testing ligatures: !=->>++:= === <=< <<= <== <=> => ==> =>> >=> <- <-> -> <<< << <= <> >= >> >>> :: || ... =:="
}

install_vim() {
  echo ""
  bash "$DIR/vim/install.sh"
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

install_tmux_tpm() {
  echo "=== tmux config"
  tmux -V
  mkdir -p ~/.tmux/plugins
  [[ ! -d ~/.tmux/plugins/tpm ]] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  is_termux && find "$HOME/.tmux" -type f -executable -exec termux-fix-shebang {} \;
  tmux source-file "$HOME/.tmux.conf"
  bash "$HOME/.tmux/plugins/tpm/bin/install_plugins"
  bash "$HOME/.tmux/plugins/tpm/bin/update_plugins" all
  bash "$HOME/.tmux/plugins/tpm/bin/clean_plugins"
  is_termux && find "$HOME/.tmux" -type f -executable -exec termux-fix-shebang {} \;
  echo "=== tmux config done"
}

termux_install() {
  apt install -y openssh tmux neovim git tig curl bash zsh fzf jq \
    coreutils less grep sed findutils tar make \
    ncurses-utils silversearcher-ag ncdu \
    python2 dnsutils hub perl termux-tools termux-api
}

osx_install() {
  bash "$DIR/osx/bundle/install.sh" || true
  bash "$DIR/osx/karabiner-import.sh"
  bash "$DIR/osx/osx-for-hackers.sh"
  # look at
  # https://github.com/thoughtbot/laptop/blob/master/mac
}

dev_tools(){
  ln -sf "$DIR/config/flake8" "$HOME/.config"
  ln -sf "$DIR/config/pycodestyle" "$HOME/.config"

#https://gist.github.com/regadas/7c98834831bcfbf008332d0c9bb9ccf7
# http://tomaszdziurko.com/2015/11/1-and-the-only-one-to-customize-intellij-idea-memory-settings/
#https://intellij-support.jetbrains.com/hc/en-us/articles/206544869-Configuring-JVM-options-and-platform-properties
  find ~/Library/Preferences -name 'Idea*' -type d -exec ln -sf "$DIR/config/idea.vmoptions" "{}/idea.vmoptions" \;
#find ~/Library/Preferences -name 'Idea*' -type d -exec cat {}/idea.vmoptions \;

#https://stackoverflow.com/questions/47697141/intellij-cannot-import-sbt-project
#https://stackoverflow.com/questions/47470374/sbt-on-intellij-takes-a-very-long-to-time-refresh
}

install_defaults() {
  install_dots
  myterminal_bashrc
  zsh_as_default
  check_colors
  check_fonts
  install_vim
  install_tmux_tpm
  #install_spacemacs
  #install_fzf_home  # managed by zplug or brew
  #is_osx && osx-install
  #TODO base16 install
}

main() {
  if [[ $# -gt 0 ]]; then
    "$@"
  else
    install_defaults
  fi
  echo "DONE!"
}

time main "$@"
