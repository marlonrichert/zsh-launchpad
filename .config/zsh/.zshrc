#!/bin/zsh
#
# This file, .zshrc, is sourced by zsh for each interactive shell session.
#

gitdir=~/Git  # The dir where you (want to) keep your repos and plugins

# Load all of the files in rc.d that start with <number>- and end in .zsh
# <-> is an open-ended range. It matches any non-negative integer.
# (n) sorts the results in numerical order.
for file in $ZDOTDIR/rc.d/<->-*.zsh(n); do
  . $file
done

# <1-> matches any integer >= 1.
# <-9> matches any integer <= 9.
# <1-9> matches any integer that's >= 1 and <= 9.


# Assigning a variable implicitly declares it as global. That's fine for
# startup scripts, but we don't want these leaking to the command line. So,
# discard them here.
unset file gitdir
