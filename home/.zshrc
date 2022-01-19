alias rscr='cargo run'
alias rscrd='cargo doc --open'
alias rssd='xdg-open (rustup doc --path)'

zi_home="${HOME}/.zi"
if [ ! -e $zi_home ]; then sh -c "$(curl -fsSL https://git.io/get-zi)" --; fi;
source "${zi_home}/bin/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi

GEOMETRY_STATUS_SYMBOL='λ'
GEOMETRY_STATUS_SYMBOL_ERROR='△'
zi ice wait"0" lucid atload"geometry::prompt"
zi light geometry-zsh/geometry

zi wait lucid for \
   OMZP::common-aliases \
   OMZP::extract \
   OMZP::git \
   OMZP::git-auto-fetch \
   OMZP::shrink-path \
   OMZP::ssh-agent \
   OMZP::dirhistory \
   b4b4r07/enhancd \
   zpm-zsh/colorize \
   Flinner/zsh-emacs \
   birdhackor/zsh-exa-ls-plugin \
   arzzen/calc.plugin.zsh \
   wait'1' wfxr/forgit \
   hlissner/zsh-autopair \
   OMZP::colored-man-pages \
   Michal-Atlas/zsh-guix \
   djui/alias-tips
   
zi for \
   z-shell/z-a-meta-plugins \
   @annexes \
   @zsh-users+fast \
   @z-shell \
   @ext-git

zi pack for ls_colors

zstyle ':completion:*' menu select

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# formatting and messages
# http://www.masterzen.fr/2009/04/19/in-love-with-zsh-part-one/
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format "$fg[yellow]%B--- %d%b"
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format "$fg[red]No matches for:$reset_color %d"
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

alias crontab="crontab -i"
alias cat=bat
alias q=exit
alias ls=k

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=1000
setopt INC_APPEND_HISTORY_TIME

echo "[\e[0;90m$(hostname)\e[0m]"
[[ -z $STY ]] && screen && exit
