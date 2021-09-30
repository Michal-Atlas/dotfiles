#!/usr/bin/env bash

export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.npm-global/bin"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.dotnet/bin"
export PATH="$PATH:$HOME/Sync/bin"
export PATH="$PATH:$HOME/source/scripts"
export PATH="$PATH:$HOME/.emacs.d/bin"
export PATH="$PATH:$HOME/progs"
export EDITOR="emacs -q"
export XDG_RUNTIME_DIR=/run/user/1000
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/library"


alias cr='cargo run'
alias crd='cargo doc --open'
alias rd='xdg-open (rustup doc --path)'

alias IDDQD='sudo su'
alias IDDT='neofetch'
alias IDMUS='mpv --no-video "https://www.youtube.com/watch?v=Jly9qp40rfw"'

eval "$(zoxide init --cmd j zsh)"

alias q=exit
alias sk="sk -e"
alias rm=rip
alias l=ls
alias ll='ls -l'
alias ls="exa -a"
alias e="emacsclient -nw -c -a=\"\""
alias crontab="crontab -i"
alias paru="paru --sudoloop --skipreview --bottomup"

alias q=exit

if [ -z $SSH_TTY ]; then
    cat ~/dotfiles/logo.txt | dotacat
    . /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    . /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    eval "$(starship init zsh)"
fi;
