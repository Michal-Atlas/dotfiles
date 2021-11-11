export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin"
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
. ~/dotfiles/antigen.zsh && {
    antigen use oh-my-zsh

    plugins=(
        MichaelAquilina/zsh-you-should-use
        RitchieS/zsh-exa@main
        aliases
        colored-man-pages
        common-aliases
        emacs
        extract
        git
        git-auto-fetch
        history
        hlissner/zsh-autopair
        per-directory-history
        rsync
        rust
        rustup
        shrink-path
        ssh-agent
        unixorn/autoupdate-antigen.zshplugin
        web-search
        wfxr/forgit
        zoxide
        zpm-zsh/colorize
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
alias cat=bat
alias pkg="zypper"
alias pkg-s="pkg search"
alias pkg-i="sudo zypper install"
alias emacs='emacs -nw'

alias q=exit

alias e="te"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# shellcheck disable=1090
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
