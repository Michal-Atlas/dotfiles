export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/source/bin"
export PATH="$PATH:$HOME/.emacs.d/bin"
export PATH="$PATH:$HOME/.npm-global/bin"

if type rustc >/dev/null; then
    RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/library"
    export RUST_SRC_PATH
    alias cr='cargo run'
    alias crd='cargo doc --open'
    alias rd='xdg-open (rustup doc --path)'
fi

# shellcheck disable=SC1094
. /usr/share/zsh/share/antigen.zsh && {
    antigen use oh-my-zsh

    plugins=(
        "MichaelAquilina/zsh-you-should-use"
        "RitchieS/zsh-exa@main"
        aliases
        archlinux
        cargo
        colored-man-pages
        command-not-found
        common-aliases
        dirhistory
        emacs
        emoji
        extract
        fasd
        forgit
        fzf
        git
        git-auto-fetch
        gpg-agent
        history
        history-substring-search
        hitchhiker
        hlissner/zsh-autopair
        jsontools
        keychain
        nmap
        per-directory-history
        ripgrep
        rsync
        rust
        rustup
        safe-paste
        shrink-path
        ssh-agent
        systemd
        thefuck
        tmux
        transfer
        web-search
        zoxide
        zsh-interactive-cd
        zsh-users/zsh-autosuggestions
        zsh_reload
        zsh-users/zsh-syntax-highlighting
    )

    for p in $plugins; do
        antigen bundle $p;
    done;

    antigen theme romkatv/powerlevel10k

    antigen apply
}

alias IDDQD='sudo su'
alias IDDT='neofetch'
alias IDMUS='mpv --no-video "https://www.youtube.com/watch?v=Jly9qp40rfw"'

alias rm=rip
alias crontab="crontab -i"
alias paru="paru --sudoloop --skipreview --bottomup"

alias q=exit

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# shellcheck disable=1090
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
