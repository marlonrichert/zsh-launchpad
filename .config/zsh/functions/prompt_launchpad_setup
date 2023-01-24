#!/bin/zsh
# Set up our prompt theme.


##
# Main prompt
#

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
PS1="%F{%(?,10,9)}%#%f "  # 10 is bright green; 9 is bright red.

# Strings in "double quotes" are what is in some languages called "template
# strings": They allow the use of $expansions inside, which are then
# substituted with the parameters' values.
# Strings in 'single quotes', on the other hand, are literal strings. They
# always evaluate to the literal characters you see on your screen.


# Install our chpwd and precmd hook functions.
# https://zsh.sourceforge.io/Doc/Release/Functions.html#Hook-Functions
# -U tells autoload not to expand aliases inside the function.
# -z tells autoload that the function file is written in the default Zsh style.
# The latter is normally not necessary, but better safe than sorry.
autoload -Uz add-zsh-hook
local hook=
for hook in chpwd precmd; do
  add-zsh-hook $hook prompt_launchpad_$hook
done
# add-zsh-hook can autoload our functions by name, because in 04-env.zsh, we
# added their parent dir to our $fpath.

prompt_launchpad_chpwd  # Call once before the first prompt.


##
# Continuation prompt
#
# This prompt is shown if, after pressing enter, you have left unclosed shell
# constructs in your command line, for example, a string without a terminating
# quote or a `for` loop without the final `done`.

PS2=  # Empty the left side, to make it easier to copy code from our terminal.
RPS2="%F{11}%^%f"  # %^ shows which shell constructs are still open.
# 11 is bright yellow.


##
# Options
#

# Auto-remove the right side of each prompt when you press enter. This way,
# we'll have less clutter on screen. This also makes it easier to copy code from
# our terminal.
setopt TRANSIENT_RPROMPT

# If we're not on an SSH connection, then remove the outer margin of the right
# side of the prompt.
[[ -v SSH_CONNECTION ]] ||
    ZLE_RPROMPT_INDENT=0
