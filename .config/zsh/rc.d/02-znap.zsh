#!/bin/zsh

##
# Plugin manager
#

znap=$gitdir/zsh-snap/znap.zsh

# Auto-install Znap if it's not there yet.
if ! [[ -r $znap ]]; then
  mkdir -p $gitdir
  git -C $gitdir clone --depth 1 -- \
      https://github.com/marlonrichert/zsh-snap.git
fi

. $znap     # Load Znap.
unset znap  # Discard the variable.
