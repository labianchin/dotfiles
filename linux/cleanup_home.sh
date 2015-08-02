#!/bin/bash

# Cleaning up some files in ubuntu/mint home

rm -r ~/.cache/deja-dup
rm -r ~/.cache/software-center
rm -r ~/.cache/shotwell
rm -r ~/.cache/bower
rm -r ~/.cache/google-chrome*/Default/Cache/
rm -r ~/.sbt
rm -r ~/.vagrant.d/boxes/*
rm -r ~/.rvm/gems/*/cache
rm -r ~/config/sublime-text-2
rm -r ~/config/yelp
rm -r ~/config/Empathy
rm -r ~/config/google-chrome*/Default/Application\ Cache
rm -r ~/config/google-chrome*/Default/File\ System

# http://www.webupd8.org/2010/12/how-to-clear-zeitgeist-history-quick.html
rm ~/.local/share/zeitgeist/activity.sqlite
zeitgeist-daemon --replace