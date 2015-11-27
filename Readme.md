
My Dotfiles
===========

## What?

These are my dotfiles configuration. It is mostly zsh, vim and tmux. But there are also OS specific configuration. For OSX there is configuration for mjolnir and iTerm2. For Linux (Ubuntu/Mint) there is configuration for xbindkeysrc, xcape and conky.

## Full Install

**Warning:** full install is not recommended as it might install and overwrite many things. Check the install specifics for tools such vim and tmux.

```
git clone https://github.com/labianchin/dotfiles.git ~/.dotfiles && bash ~/.dotfiles/install.sh
```

## Install only specifics

If you want you can install dotfiles just for specific apps. This is done mostly by doing a symlink of the configuration files.

**Warning:** This will override configuration files. Please, understand each command and backup your files.

### vim

Status: **Stable**

Run the install script, which will backup your current vim config and install the new config:

```
bash ~/.dotfiles/vim/install.sh
```

Or alternatively run this:

```
ln -sf ~/.dotfiles/vim ~/.vim
ln -sf ~/.vim/vimrc.vim ~/.vimrc
vim +NeoBundleInstall +qall
```

If using OS X, install vim 7.4 with brew, it is more complete than the one that come with the system.

```
brew install vim --override-system-vi
```

### tmux

Status: **Beta**

Includes TPM to manage plugins (https://github.com/tmux-plugins/tpm).

```
ln -sf ~/.dotfiles/tmux.conf ~/.tmux.conf
```

To better understand what is included, check the `tmux.conf` file and also press `Ctrl-a Ctrl-?` inside tmux to check the configured key bindings.

### zsh

Status: **Beta**

I suggest to first have some experience with `oh-my-zsh` before trying my configuration.
Please follow the instructions at https://github.com/robbyrussell/oh-my-zsh.
Also take a look at: https://github.com/unixorn/zsh-quickstart-kit/

This ZSH configuration includes zgen to manage zsh plugins (https://github.com/tarjoilija/zgen.git).
It can be installed by symlinking three files, like this:

```
ln -sf ~/.dotfiles/.zsh ~/.zsh
ln -sf ~/.dotfiles/.zgen-setup ~/.zgen-setup
ln -sf ~/.dotfiles/.myterminalrc ~/.myterminalrc
```

### osx brew files

Status: **Stable, but only use for inspiration**

Software for osx is managed through `osx/Brewfile`.

```
bash osx/install_apps.sh
```

### Terminal colorschemes

On osx use [iTerm2](), on Linux use [Terminator]() or [Gnome Terminal]().

Some very nice colorschemes can be found here: https://github.com/mbadolato/iTerm2-Color-Schemes#installation-instructions .
Good ones are: Afterglow, Desert, Hybrid, Solarized, Tomorrow Night Eighties, Twilight and Wombat.

### Instal powerline fonts

Install [powerline fonts](https://github.com/powerline/fonts). I am using SourceCodePro.

Other option is to [awesome terminal fonts](https://github.com/gabrielelana/awesome-terminal-fonts).

## TODO

- Install fonts osx and linux (https://github.com/gabrielelana/awesome-terminal-fonts) and http://www.sharms.org/blog/2012/08/24/using-iterm2-themes-with-gnome-terminal/
- Check if there are any other useful zsh plugins (https://github.com/unixorn/awesome-zsh-plugins)
- Add more fzf utils (alias, vim, ag, etc) (https://github.com/junegunn/fzf)
- zsh vi-mode? opp? or zsh 5.0.8?
- oh-my-git?? Needs different font
- look here https://github.com/rtomayko/dotfiles/blob/rtomayko/.vimrc
- https://github.com/mollifier/anyframe ??

- https://github.com/alebcay/awesome-shell
- Add common bin
- Check https://github.com/MatthewMueller/dots and https://gist.github.com/MatthewMueller/e22d9840f9ea2fee4716
- Put Debian/Ubuntu/Mint specific install and config
- take a look here for vi-mode: https://github.com/dougblack/dotfiles/blob/master/.zshrc
- add a way to switch between emacs and vi-mode
- http://usevim.com/2015/03/27/zsh/
- https://github.com/aanand/git-up
