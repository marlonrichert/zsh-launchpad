#!/bin/zsh

##
# Plugin manager
#

local znap=~git/zsh-snap/znap.zsh

# Auto-install Znap if it's not there yet.
if ! [[ -r $znap ]]; then   # Check if the file exists and can be read.
  mkdir -p ~git
  git -C ~git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git
fi

. $znap   # Load Znap.
