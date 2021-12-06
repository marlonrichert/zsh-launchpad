#!/bin/zsh

##
# Key bindings
#

# Enable the use of Ctrl-Q and Ctrl-S for keyboard shortcuts.
unsetopt FLOW_CONTROL

# Alt-H: Get help on your current command.
() {
  unalias $1 2> /dev/null
  autoload -Uz +X $1
  zmodload -F zsh/parameter p:functions_source
  autoload -Uz $functions_source[$1]-*~*.zwc
} run-help

# Alt-Q: If on the continuation prompt, return to the main prompt.
bindkey '^[q' push-line-or-edit

# Alt-V: Show the next key combo's terminal code and state what it does.
bindkey '^[v' describe-key-briefly

# Alt-Shift-S: Prefix current or previous command line with `sudo`.
() {
  bindkey '^[S' $1
  zle -N $1
  $1() {
    [[ -z $BUFFER ]] && zle .up-history
    LBUFFER="sudo $LBUFFER"
  }
} .sudo
