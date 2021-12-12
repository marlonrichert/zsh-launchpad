#!/bin/zsh

##
# Environment variables
#

# -U ensures each entry in these is Unique (that is, discards duplicates).
export -U PATH path FPATH fpath MANPATH manpath
export -UT INFOPATH infopath  # -T creates a "tied" pair; see below.

# $PATH and $path (and also $FPATH and $fpath, etc.) are "tied" to each other.
# Modifying one will also modify the other.
# So, you can add elements to your $PATH (or $FPATH, etc.) like this:
path=(
    /home/linuxbrew/.linuxbrew/bin(N)	# (N): null if file doesn't exist
    $path
)

# Add your functions to your $fpath, so you can autoload them.
fpath=(
    $ZDOTDIR/functions
    $fpath
)

if command -v brew > /dev/null; then
  # `znap eval <name> '<command>'` is like `eval "$( <command> )"` but with
  # caching and compilation of <command>'s output, making it 10 times faster.
  znap eval brew-shellenv 'brew shellenv'

  # Add dirs containing completion functions to your $fpath and they will be
  # picked up automatically when the completion is initialized.
  # Here, we add it to the end of $fpath, so that we use brew's completions
  # only for those commands that zsh doesn't already know how to complete.
  fpath+=( $HOMEBREW_PREFIX/share/zsh/site-functions )
fi
