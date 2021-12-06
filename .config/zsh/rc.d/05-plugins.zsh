##
# Plugins
#

# Add the plugins you want to use here.
plugins=(
  marlonrichert/{zcolors,zsh-{autocomplete,edit,hist}}
  zsh-users/zsh-{autosuggestions,syntax-highlighting}
)

# Speed things up by cloning all plugins in parallel.
# It won't clone plugins that we already have.
znap clone $plugins

# Load each plugin, one at a time.
for p in $plugins; do
  znap source $p
done
unset p plugins

# `znap eval <name> '<command>'` is like `eval "$( <command> )"` but with
# caching and compilation of <command>'s output, making it 10 times faster.
znap eval zcolors zcolors   # Extra init code needed for zcolors.
