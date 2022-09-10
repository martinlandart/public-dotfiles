source ~/.config/fish/alias.fish

source ~/.config/fish/themes/tokyonight-storm.fish

set PATH $PATH ~/development/flutter/bin

# GOPATH
set -gx GOPATH "$HOME/go"
set PATH $PATH $GOPATH/bin

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

set PATH $PATH "$HOME/.cargo/bin"

set PATH $PATH "$HOME/Android/Sdk/platform-tools"

set PATH $PATH "$HOME/.local/bin"
set PATH $PATH "$HOME/Code/scripts"

# Install Starship
starship init fish | source

