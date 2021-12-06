#!/bin/zsh
#
# This file, .zshrc, is sourced by zsh for each interactive shell session.
#

gitdir=~/Git  # The dir where you (want to) keep your repos and plugins
for file in $ZDOTDIR/rc.d/<->-*.zsh; do
  . $file
done
unset file gitdir
