# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
        antigen bundle history-substring-search
        antigen bundle per-directory-history
        antigen bundle rust
        antigen bundle cargo
        antigen bundle git-auto-fetch
        antigen bundle rsync
        antigen bundle shrink-path
        antigen bundle ssh-agent
        antigen bundle systemd
        antigen bundle tmux
        antigen bundle zsh-interactive-cd
        antigen bundle fzf

        antigen theme romkatv/powerlevel10k

        antigen apply

        export EDITOR="e"
    };

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
alias crontab="crontab -i"
alias paru="paru --sudoloop --skipreview --bottomup"

alias q=exit

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# shellcheck disable=1090
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
