#!/bin/zsh
#
# This file, .zshenv, is sourced by zsh for EACH shell, whether it's interactive or not.
# This includes non-interactive sub-shells!
# So, put as little in this file as possible, to avoid performance impact.
#

# Tell zsh where we want to keep our dotfiles.
ZDOTDIR=${XDG_CONFIG_HOME:=~/.config}/zsh
