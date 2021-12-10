#!/bin/zsh
#
# This file, .zshrc, is sourced by zsh for each interactive shell session.
#

gitdir=~/Git  # The dir where you (want to) keep your repos and plugins

for file in $ZDOTDIR/rc.d/<->-*.zsh; do
  . $file
done
unset file gitdir

# <-> is an open-ended range. It matches any non-negative integer.
# <1-> matches any integer >= 1.
# <-9> matches any integer <= 9.
# <1-9> matches any integer that's >= 1 and <= 9.
