#!/bin/zsh
# Instead of printing the current dir in each prompt, print it only when when
# we change dirs, by using a hook function.

RPS1=   # Clear the right side of the prompt; see next section.

# Tell the Zsh Line Editor to ensure that our prompt and command line look
# visually correct both before and after our output.
zle -I

# -P flag parses prompt escape codes.
print -P "\n%F{12}%~%f"   # 12 is bright blue.
