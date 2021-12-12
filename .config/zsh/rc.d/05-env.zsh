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

# Adding color to man pages is accomplished by setting these environment variables
# using 'less' env vars (format is '\e[<effect>;<color>m', or '\e[<effect>;<bg>;<fg>m')
export LESS_TERMCAP_mb=$'\e[01;34m'      # mb:=start blink-mode (bold,blue)
export LESS_TERMCAP_md=$'\e[01;34m'      # md:=start bold-mode (bold,blue)
export LESS_TERMCAP_so=$'\e[00;47;30m'   # so:=start standout-mode (white bg, black fg)
export LESS_TERMCAP_us=$'\e[04;35m'      # us:=start underline-mode (underline magenta)
export LESS_TERMCAP_se=$'\e[0m'          # se:=end standout-mode
export LESS_TERMCAP_ue=$'\e[0m'          # ue:=end underline-mode
export LESS_TERMCAP_me=$'\e[0m'          # me:=end modes
