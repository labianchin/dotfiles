
dotfiles
===========

## What?

These are my dotfiles configuration. It is mostly zsh, vim and tmux.
Also include OS specific configuration.
For OSX there is configuration for mjolnir and iTerm2.
For Linux (Ubuntu/Mint) there is configuration for xbindkeysrc, xcape and conky.

## Full Install

**Warning:** do understand the following commands before running.
You might only want some specific parts, check below for vim and tmux.

```
git clone https://github.com/labianchin/dotfiles.git ~/.dotfiles && ~/.dotfiles/install.sh
```

## Install only specifics

If you want you can install dotfiles just for specific apps. This is done mostly by doing a symlink of the configuration files.

**Warning:** This will override configuration files. Please, understand each command and backup your files.

### vim

Status: **Stable**

Run the install script, which will backup your current vim config and install the new config:

```
~/.dotfiles/vim/install.sh
```

I now use and recommend neovim, check [install instructions here](https://github.com/neovim/neovim/wiki/Installing-Neovim)

```
brew install vim --override-system-vi
```

### tmux

Status: **Beta**

Includes TPM to manage plugins (https://github.com/tmux-plugins/tpm).

```
ln -sf ~/.dotfiles/tmux.conf ~/.tmux.conf
```

To better understand what is included, check the `tmux.conf` file.
Also press `Ctrl-a Ctrl-?` inside tmux to check the configured key bindings.

### osx brew files

Status: **Stable, but only use for inspiration**

Software for osx is managed through `osx/Brewfile`.

```
~/.dotfiles/osx/bundle/install.sh
```

### Terminal colorschemes

On osx use [iTerm2](), on Linux use [Terminator]() or [Gnome Terminal]().

Nice colorschemes can be found here: https://github.com/mbadolato/iTerm2-Color-Schemes#installation-instructions .

### Instal powerline fonts

Install [powerline fonts](https://github.com/powerline/fonts).

Other option is to [awesome terminal fonts](https://github.com/gabrielelana/awesome-terminal-fonts).

## TODO and ideas

- Install fonts osx and linux (https://github.com/gabrielelana/awesome-terminal-fonts) and http://www.sharms.org/blog/2012/08/24/using-iterm2-themes-with-gnome-terminal/
- Add more fzf utils (alias, vim, ag, etc) (https://github.com/junegunn/fzf)
- look here https://github.com/rtomayko/dotfiles/blob/rtomayko/.vimrc
- https://github.com/mollifier/anyframe ??

- https://github.com/alebcay/awesome-shell
- Add common bin
- Check https://github.com/MatthewMueller/dots and https://gist.github.com/MatthewMueller/e22d9840f9ea2fee4716
- take a look here for vi-mode: https://github.com/dougblack/dotfiles/blob/master/.zshrc
- switch between emacs and vi-mode
- http://usevim.com/2015/03/27/zsh/
- https://github.com/aanand/git-up
