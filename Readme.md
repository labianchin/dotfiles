
My Dotfiles
===========

## What?

These are my dotfiles configuration. It is mostly zsh, vim and tmux. But there are also OS specific configuration. For OSX there is configuration for mjolnir and iTerm2. For Linux (Ubuntu/Mint) there is configuration for xbindkeysrc, xcape and conky.

## Full Install

**Warning:** full install is not recommended as it might overwrite things you don't want. Check the install specifics for tools such vim and tmux.

```
git clone https://github.com/labianchin/dotfiles.git ~/.dotfiles && bash ~/.dotfiles/install.sh
```

## Install only specifics

If you want you can install dotfiles just for specific apps. This is done mostly by doing a symlink of the configuration files.

**Warning:** This will override you configuration files. Please, understand each command and backup your files.

### vim

Status: **Stable**

Run the install script, which will backup your config and install the new config:

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

### zsh

Status: **Alpha**

Includes zgen to manage zsh plugins (https://github.com/tarjoilija/zgen.git).
But I encourage you to first just try oh-my-zsh before trying my configuration.
Please follow the instructions at https://github.com/robbyrussell/oh-my-zsh.

Specifics of my configuration can be found at the files: myterminalrc, zshrc and zgen-setup.

You might also look at: https://github.com/unixorn/zsh-quickstart-kit/

### osx brew files

Status: **Stable, but only use for inspiration**

Software for osx is managed through `osx/Brewfile`.

```
bash osx/install_apps.sh
```

### Solarized theme

Install [solarize theme in iterm2](https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized)

### Instal powerline fonts

Install [powerline fonts](https://github.com/powerline/fonts). I am using SourceCodePro.

## TODO

- Check if there are any other useful zsh plugins (https://github.com/unixorn/awesome-zsh-plugins)
- Add more fzf utils (alias, vim, ag, etc) (https://github.com/junegunn/fzf)
- Percol? Perco?
- zsh vi-mode? opp? or zsh 5.0.8?
- oh-my-git?? Needs diferent font

- contribute to powerlevel9
zstyle ':vcs_info:*' formats "%F{$VCS_FOREGROUND_COLOR}%f$VCS_DEFAULT_FORMAT"
zstyle ':vcs_info:git-svn:*' formats "%F{$VCS_FOREGROUND_COLOR}$VCS_GIT_ICON%f$VCS_DEFAULT_FORMAT"

- https://github.com/alebcay/awesome-shell
- Add common bin
- Check https://github.com/MatthewMueller/dots and https://gist.github.com/MatthewMueller/e22d9840f9ea2fee4716
- Put Debian/Ubuntu/Mint specific install and config
- take a look here for vi-mode: https://github.com/dougblack/dotfiles/blob/master/.zshrc
- add a way to switch between emacs and vi-mode
- http://usevim.com/2015/03/27/zsh/
- https://github.com/aanand/git-up
