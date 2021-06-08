#set -gx TERM "xterm-kitty"

set PATH "$PATH:$HOME/.cargo/bin"
set PATH "$PATH:$HOME/bin"
set PATH "$PATH:$HOME/.local/bin"
set PATH "$PATH:$HOME/.dotnet/bin"
set PATH "$PATH:$HOME/Sync/bin"
set PATH "$PATH:$HOME/source/scripts"
set -gx EDITOR "/usr/bin/emacsclient"
set -gx XDG_RUNTIME_DIR /run/user/1000
set -gx RUST_SRC_PATH (rustc --print sysroot)/lib/rustlib/src/rust/library 

function fish_greeting
end

abbr -a cr 'cargo run'
abbr -a crd 'cargo doc --open'
abbr -a rd 'xdg-open (rustup doc --path)'

#bind IDDQD 'sudo su'
#bind IDDT 'neofetch'
#bind IDMUS 'mpv --no-video "https://www.youtube.com/watch?v=Jly9qp40rfw"'

starship init fish | source
zoxide init --cmd j fish | source

alias q exit
alias vim nvim
alias sk "sk -e"
alias rm rip
alias l ls
alias ls "exa -a"
alias ec emacsclient
alias crontab "crontab -i"
