#!/bin/zsh

##
# Named directories
#

# Create shortcuts for your favorite directories.
# `hash -d <name>=<path>` makes ~<name> a shortcut for <path>.
hash -d z=$ZDOTDIR
hash -d g=$gitdir

# Change dirs without `cd`. Just type the dir and press enter.
setopt AUTO_CD
