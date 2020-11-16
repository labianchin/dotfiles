
dotfiles
===========

## What?

These are my dotfiles configuration. It is mostly zsh, vim and tmux.
It also includes some OS specific configuration.
For macOS there is configuration for [Hammerspoon](https://www.hammerspoon.org/) and [Karabiner-Elements](https://karabiner-elements.pqrs.org/).

## Full Install

**Warning:** do understand the following commands before running.
You might only want some specific parts, check below for vim and tmux.

```sh
git clone https://github.com/labianchin/dotfiles.git ~/.dotfiles && ~/.dotfiles/install.sh
```

## Install only specifics

If you want you can install dotfiles just for specific apps. This is done mostly by doing a symlink of the configuration files.

**Warning:** This will override configuration files. Please, understand each command and backup your files.

### vim

Status: **Stable**

Run the install script, which will backup your current vim config and install the new config:

```sh
~/.dotfiles/vim/install.sh
```

I now use and recommend [neovim](https://neovim.io/), check [install instructions here](https://github.com/neovim/neovim/wiki/Installing-Neovim)

```sh
brew install neovim
```

### tmux

Status: **Beta**

Includes TPM to manage plugins (https://github.com/tmux-plugins/tpm).

```sh
ln -sf ~/.dotfiles/tmux.conf ~/.tmux.conf
```

To better understand what is included, check the `tmux.conf` file.
Also press `Ctrl-a Ctrl-?` inside tmux to check the configured key bindings.

### osx brew files

Status: **Stable, but only use for inspiration**

Software for osx is managed through `osx/Brewfile`.

```sh
~/.dotfiles/osx/bundle/install.sh
```

### Fonts

Recommendation is [Fira Code](https://github.com/tonsky/FiraCode), a free monospaced font with programming ligatures.

```sh
brew tap homebrew/cask-fonts
brew cask install font-fira-code
```

## References and ideas

- https://github.com/alebcay/awesome-shell
- https://github.com/gabrielelana/awesome-terminal-fonts
- https://github.com/junegunn/fzf
- https://github.com/BurntSushi/ripgrep
- https://github.com/ohmyzsh/ohmyzsh
