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

# These variables try to make the code below a bit easier to read.
local brightred=9 brightgreen=10 brightyellow=11 brightblue=12 brightcyan=14


##
# Main prompt, left side
#

PS1="%F{%(?,$brightgreen,$brightred)}%#%f "

# Strings in "double quotes" are what is in some languages called "template
# strings": They allow the use of $expansions inside, which are then
# substituted with the parameters' values.
# Strings in 'single quotes', on the other hand, are literal strings. They
# always evaluate to the literal characters you see on your screen.


# Instead of printing the current dir in each prompt, print it only when when
# we change dirs, by using a hook function.
# https://zsh.sourceforge.io/Doc/Release/Functions.html#Hook-Functions
chpwd() {
  RPS1=   # Clear the right side of the prompt; see next section.

  # Tell the Zsh Line Editor to ensure that our prompt and command line look
  # visually correct both before and after our output.
  zle -I

  # -P flag parses prompt escape codes.
  print -P "\n%F{12}%~%f" # 12 is bright blue
  # We cannot here use the variables we defined above, because those are local
  # to our dotfiles.
}
chpwd  # Call once before the first prompt.


# Reduce startup time by making the left side of the primary prompt visible
# *immediately.*
znap prompt


##
# Main prompt, right side
#

# Lazy-load our precmd() hook function from file.
# https://zsh.sourceforge.io/Doc/Release/Functions.html#Hook-Functions
# -U tells autoload not to expand aliases inside the function.
# -z tells autoload that the function file is written in the default Zsh style.
# The latter is normally not necessary, but better safe than sorry.
autoload -Uz precmd

# We can autoload the precmd function by just its name (rather than by path),
# because in 03-env.zsh, we added its parent dir to our $fpath.
# Since the precmd function is used right away, we don't get any benefit from
# lazy-loading it. However, this way, we get to encapsulate the function and
# all of its related setup code a single, modular file.


# Format the output of vcs_info, which our precmd uses to set $RPS1.
#     %a: current action (for example, rebase)
#     %c:   staged changes
#     %u: unstaged changes
#     %b: branch
# https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#vcs_005finfo-Configuration
() {
  "$@"           formats                     "%c%u%F{$brightcyan}%b%f"
  "$@"     actionformats    "%F{$brightred}%a %c%u%F{$brightcyan}%b%f"
  "$@"         stagedstr    "%F{$brightblue}+"  # Set %c.
  "$@"       unstagedstr  "%F{$brightyellow}*"  # Set %u.
  "$@"  check-for-changes yes                   # Enable %c and %u.
} zstyle ':vcs_info:*'


# Auto-remove the right side of the prompt when you press enter.
# That way, we'll have less clutter on screen.
# It also makes it easier to copy code from our terminal.
setopt TRANSIENT_RPROMPT

ZLE_RPROMPT_INDENT=0  # Outer margin of the right side of the prompt


##
# Continuation prompt
#
# This prompt is shown if, after pressing enter, you have left unclosed shell
# constructs in your command line, for example, a string without a terminating
# quote or a `for` loop without the final `done`.

PS2=  # Empty the left side, to make it easier to copy code from our terminal.
RPS2="%F{$brightyellow}%^%f"  # %^ shows which shell constructs are still open.
