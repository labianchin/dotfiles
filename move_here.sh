#!/bin/bash

file=$(echo $1 | sed "s|$HOME/||")

echo "Moving configuration file $file to dropbox"
mv ~/$file ~/Dropbox/configs

ln -s ~/Dropbox/configs/$file ~/$file

echo "ln -s ~/Dropbox/configs/$file ~/$file" >> ~/Dropbox/configs/dropbox_links.sh
