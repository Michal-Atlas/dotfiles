#if [ ! $SSH_CLIENT ]; then

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

#source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

source /usr/local/share/zsh/site-functions/prompt_spaceship_setup
SPACESHIP_CHAR_SYMBOL=⟩
SPACESHIP_CHAR_SUFFIX=' '
#SPACESHIP_TIME_SHOW=true
SPACESHIP_VI_MODE_SHOW=false
SPACESHIP_EXIT_CODE_SHOW=true

#source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.zsh

#source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source /usr/share/zsh/plugins/k/k.plugin.zsh
source /usr/share/zsh/plugins/zsh-directory-history/zsh-directory-history.zsh
#source /usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#fi;

# If running from tty1 start sway
if [ "$(tty)" = "/dev/tty1"  ]; then
 	exec sway
fi

. ~/.zsh/rc
. ~/.zsh/aliasrc

setopt NO_HUP
#export TERM=screen-256color
export LC_COLLATE=C

