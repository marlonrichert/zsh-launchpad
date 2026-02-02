#!/bin/zsh

##
# History settings
#
# Always set these first, so history is preserved, no matter what happens.
#

# Enable additional glob operators. (Globbing = pattern matching)
# https://zsh.sourceforge.io/Doc/Release/Expansion.html#Filename-Generation
setopt EXTENDED_GLOB

# Tell zsh where to store history.
# $VENDOR and $OSTYPE let us check what kind of machine we're on.
local icloud=~/Library/Mobile\ Documents/com\~apple\~CloudDocs
if [[ -d $icloud && $VENDOR == apple ]]; then
  # If using iCloud on macOS, store it there, so it syncs across multiple Macs.
  HISTFILE=$icloud/zsh_history

  # -s: True if the file exists and is not empty.
  if ! [[ -s $HISTFILE ]]; then
    # Sometimes (probably due to concurrency issues), when the histfile is kept
    # in iCloud, it is empty when Zsh starts up. However, there should always be
    # a backup file we can copy.

    # Add history entries from the largest "$HISTFILE <number>" file.
    # \ escapes/quotes the space behind it.
    # (O):  Sort descending.
    # (OL): Sort by size, descending.
    # (N):  If no files match, then don't return an error.
    local -a files=( $HISTFILE(|\ <->)(OLN) )
    # -n: True if the string is not empty.
    [[ -n $files[1] ]] &&
        fc -RI $files[1]
  fi
else
  # := assigns the variable if it's unset or null and then substitutes its
  # value.
  HISTFILE=${XDG_DATA_HOME:=~/.local/share}/zsh/history
fi

# Just in case: If the parent directory doesn't exist, create it.
[[ -d $HISTFILE:h ]] ||
    mkdir -p $HISTFILE:h

# Max number of entries to keep in history file.
SAVEHIST=$(( 100 * 1000 ))      # Use multiplication for readability.

# Max number of history entries to keep in memory.
HISTSIZE=$(( 1.2 * SAVEHIST ))  # Zsh recommended value

# Use modern file-locking mechanisms, for better safety & performance.
setopt HIST_FCNTL_LOCK

# Keep only the most recent copy of each duplicate entry in history.
setopt HIST_IGNORE_ALL_DUPS

# Auto-sync history between concurrent sessions.
setopt SHARE_HISTORY
