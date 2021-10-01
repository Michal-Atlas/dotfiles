#!/usr/bin/env bash

export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/source/bin"
export PATH="$PATH:$HOME/.emacs.d/bin"
export PATH="$PATH:$HOME/.npm-global/bin"
export EDITOR="emacs"
export XDG_RUNTIME_DIR=/run/user/1000

if type rustc >/dev/null; then
    RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/library"
	export RUST_SRC_PATH
	alias cr='cargo run'
	alias crd='cargo doc --open'
	alias rd='xdg-open (rustup doc --path)'
fi;

type zoxide >/dev/null && eval "$(zoxide init --cmd j zsh)"

if [ -z "$SSH_TTY" ]; then
	type dotacat >/dev/null && dotacat < ~/dotfiles/logo.txt

	# shellcheck disable=SC1094
	. /usr/share/zsh/share/antigen.zsh && {
	    antigen use oh-my-zsh

        antigen bundle zsh-users/zsh-syntax-highlighting
        antigen bundle git
        antigen bundle zsh-users/zsh-autosuggestions
        antigen bundle web-search
        antigen bundle dirhistory
        antigen bundle zsh_reload
        antigen bundle history
        antigen bundle emacs
        antigen bundle forgit
        antigen bundle "MichaelAquilina/zsh-you-should-use"
        antigen bundle hlissner/zsh-autopair
        antigen bundle command-not-found
        antigen bundle common-aliases

        antigen apply
    };

    type starship >/dev/null && eval "$(starship init zsh)"
fi;


alias IDDQD='sudo su'
alias IDDT='neofetch'
alias IDMUS='mpv --no-video "https://www.youtube.com/watch?v=Jly9qp40rfw"'

alias q=exit
alias sk="sk -e"
alias rm=rip
alias l=ls
alias ll='ls -l'
type exa >/dev/null && alias ls="exa -a"
#alias e="emacsclient -nw -c -a=\"\""
alias crontab="crontab -i"
alias paru="paru --sudoloop --skipreview --bottomup"

alias q=exit
