set -gx TERM "xterm-kitty"

set -gx MPD_HOST "Zakzakzak0!@localhost"

set PATH "$PATH:$HOME/.cargo/bin"
set PATH "$PATH:$HOME/bin"
set PATH "$PATH:$HOME/.local/bin"
set PATH "$PATH:$HOME/.dotnet/bin"
set PATH "$PATH:$HOME/Sync/bin"
set -gx EDITOR "/usr/bin/vim"

function fish_greeting
end

abbr -a cr cargo run
abbr -a rd xdg-open (rustup doc --path)

starship init fish | source

