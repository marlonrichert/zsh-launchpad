#!/bin/zsh

##
# Key bindings
#


# Enable the use of Ctrl-Q and Ctrl-S for keyboard shortcuts.
unsetopt FLOW_CONTROL

# Press Tab on the command line to insert the top item of the completion menu.
# Press Down to enter the completion menu and select a different item.
# Press Ctrl-S in the completion menu to start a type-ahead search.
# Press Tab in type-ahead search to exit the search.
# Press Tab in the completion menu to accept your selection and return to the
# command line.
# Press Enter at any time to accept the entire command line.


# Alt-H: Get help on your current command.
() {
  unalias $1 2> /dev/null
  autoload -Uz +X $1
  zmodload -F zsh/parameter p:functions_source
  autoload -Uz $functions_source[$1]-*~*.zwc
} run-help

# Alt-Q: On the main prompt, push your current command line temporarily aside,
# so you can type a new one. Once you've accepted the new command line, the old
# one will be restored.
# On the continuation prompt, return to the main prompt.
bindkey '^[q' push-line-or-edit

# Alt-V: Show the next key combo's terminal code and state what it does.
bindkey '^[v' describe-key-briefly

# Alt-Shift-S: Prefix the current or previous command line with `sudo`.
() {
  bindkey '^[S' $1  # Bind Alt-Shift-S to the widget below.
  zle -N $1         # Create a widget that calls the function below.
  $1() {            # Create the function.
    [[ -z $BUFFER ]] && zle .up-history
    LBUFFER="sudo $LBUFFER"
  }
} .sudo
