#!/bin/zsh

##
# Named directories
#

# Create shortcuts for your favorite directories.
hash -d z=$ZDOTDIR
hash -d g=$gitdir

# `hash -d <name>=<path>` makes ~<name> a shortcut for <path>.
# You can use this ~name anywhere you would specify a dir, not just with `cd`!


# Change dirs without `cd`. Just type the dir and press enter.
setopt AUTO_CD

# Note: This will misfire if there is an alias, function, builtin or command
# with the same name!
# To be safe, don't use auto-cd with paths not starting with ~, .. or /
