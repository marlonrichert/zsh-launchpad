#!/bin/zsh

# Prompt escape codes
#      %F{<x>}:  Set foreground color. <x> can be one of the 8 standard color
#                names, a number from 0 to 255 or a hex value (if your terminal
#                supports it). See also
#                https://en.wikipedia.org/wiki/ANSI_escape_code#Colors
#           %f:  Reset foreground color to default.
#           %~:  Current directory, in ~abbreviated form
#           %#:  If user is root, then '#', else '%'
# %(?,<a>,<b>):  If last exit status was 0, then <a>, else <b>
# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html

brightred=9 brightgreen=10 brightyellow=11 brightblue=12


##
# Main prompt, left side
#

PS1="%F{%(?,$brightgreen,$brightred)}%#%f "

# Instead of printing the current dir in each prompt, print it only when when
# we change dirs, by using a hook function.
# https://zsh.sourceforge.io/Doc/Release/Functions.html#Hook-Functions
chpwd() {
  RPS1=   # Clear the right side of the prompt; see next section.
  zle -I  # Prepare the line editor for our output.

  # -P flag parses prompt escape codes.
  local brightblue=12
  print -P "\n%F{$brightblue}%~%f"
}
chpwd  # Call once before the first prompt.

# Reduce startup time by making the left side of the primary prompt visible
# immediately.
znap prompt


##
# Main prompt, right side
#

# Load our precmd() hook function from file.
# https://zsh.sourceforge.io/Doc/Release/Functions.html#Hook-Functions
autoload -Uz precmd

# Format the output of vcs_info, which our precmd uses to set $RPS1.
#     %a: current action (for example, rebase)
#     %c:   staged changes
#     %u: unstaged changes
#     %b: branch
# https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#vcs_005finfo-Configuration
() {
  "$@"           formats                     '%c%u%F{14}%b%f'
  "$@"     actionformats    "%F{$brightred}%a %c%u%F{14}%b%f"
  "$@"         stagedstr    "%F{$brightblue}+"  # Set %c.
  "$@"       unstagedstr  "%F{$brightyellow}*"  # Set %u.
  "$@"  check-for-changes yes                   # Enable %c and %u.
} zstyle ':vcs_info:*'

setopt TRANSIENT_RPROMPT  # Auto-remove the right side of each prompt.
ZLE_RPROMPT_INDENT=0      # Right prompt margin


unset -m 'bright*'  # Discard all variables starting with 'bright'.
