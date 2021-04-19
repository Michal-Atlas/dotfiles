source /usr/local/share/zsh/site-functions/prompt_spaceship_setup
SPACESHIP_CHAR_SYMBOL=⟩
SPACESHIP_CHAR_SUFFIX=' '
#SPACESHIP_TIME_SHOW=true
SPACESHIP_VI_MODE_SHOW=false
SPACESHIP_EXIT_CODE_SHOW=true

#source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.zsh
source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/k/k.plugin.zsh
source /usr/share/zsh/plugins/zsh-directory-history/zsh-directory-history.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/autojump/autojump.zsh

. ~/.zsh_aliases

setopt NO_HUP
export LC_COLLATE=C

powerline-daemon -q

export TERM="screen-256color"
export EDITOR=/usr/bin/vim
export PATH=$PATH:~/source/scripts
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

autoload -Uz compinit
compinit
# Completion for kitty
kitty + complete setup zsh | source /dev/stdin

