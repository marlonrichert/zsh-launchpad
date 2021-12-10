#!/bin/zsh

##
# Named directories
#

# Create shortcuts for your favorite directories.
# `hash -d <name>=<path>` makes ~<name> a shortcut for <path>.
# You can use this ~name anywhere you would specify a dir, not just with `cd`!
hash -d z=$ZDOTDIR
hash -d g=$gitdir


# Change dirs without `cd`. Just type the dir and press enter.
setopt AUTO_CD

# Note: This will misfire if there is an alias, function, builtin or command
# with the same name!
# To be safe, use autocd only with paths starting with ~, .. or /
