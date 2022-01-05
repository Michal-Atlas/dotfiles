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
   @dircolors-material \
   @z-shell \
   @ext-git

zi ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
   atpull'%atclone' pick"clrs.zsh" nocompile'!' \
   atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zi light trapd00r/LS_COLORS

zstyle ':completion:*' menu select

alias crontab="crontab -i"
alias cat=bat
alias q=exit
alias ls=k

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=1000
setopt INC_APPEND_HISTORY_TIME
