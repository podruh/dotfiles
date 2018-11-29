DEFAULT_USER=podruh
POWERLEVEL9K_MODE='awesome-patched'
# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi
    
local user_symbol="$"
if [[ $(print -P "%#") =~ "#" ]]; then
    user_symbol = "#"
fi

POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=''
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%{%B%F{yellow}%K{blue}%}$user_symbol %{%b%f%k%F{blue}%} %{%f%}"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon_joined context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(rvm)

POWERLEVEL9K_SHORTEN_DIR_LENGTH=2

POWERLEVEL9K_OS_ICON_BACKGROUND="white"
POWERLEVEL9K_OS_ICON_FOREGROUND="blue"

POWERLEVEL9K_DIR_HOME_FOREGROUND="white"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="white"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="white"

POWERLEVEL9K_RVM_BACKGROUND="196"
POWERLEVEL9K_RVM_FOREGROUND="249"
POWERLEVEL9K_RVM_VISUAL_IDENTIFIER_COLOR="black"
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true


source ~/.aliases
source /etc/profile.d/rvm.sh
alias sudo='nocorrect sudo'
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

