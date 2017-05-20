#!/usr/bin/env bash

set -o errexit
set -o nounset

apt-get install software-properties-common

RELEASE=$(lsb_release -sc)
add-apt-repository -y "deb http://archive.canonical.com/ubuntu $RELEASE partner"
add-apt-repository -y ppa:neovim-ppa/stable


apt-get update
apt-get install neovim

apt-get -y -mf install \
  python-dev python-pip python3-dev python3-pip \
  neovim zsh tmux ctags git tig curl \
  shellcheck jq fswatch watch \
  silversearcher-ag ack-grep ncdu
