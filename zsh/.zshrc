setopt NO_HUP

export TERM="screen-256color"

alias ls='exa -a'
alias ll='ls -lF'
alias l='ls'
alias q="exit"
alias sk="sk -e"
alias rm="rip"
alias vim="nvim"
alias ec="emacsclient"
alias crontab="crontab -i"

alias rdc='xdg-open $(cargo doc --open)'
alias cr="cargo run"
alias rd="xdg-open $(rustup doc --path)"

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

