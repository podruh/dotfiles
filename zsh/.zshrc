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
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(rbenv)

POWERLEVEL9K_SHORTEN_DIR_LENGTH=2

POWERLEVEL9K_OS_ICON_BACKGROUND="white"
POWERLEVEL9K_OS_ICON_FOREGROUND="blue"

POWERLEVEL9K_DIR_HOME_FOREGROUND="white"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="white"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="white"

# POWERLEVEL9K_RBENV_BACKGROUND="196"
POWERLEVEL9K_RBENV_FOREGROUND="249"
POWERLEVEL9K_RBENV_VISUAL_IDENTIFIER_COLOR="black"
POWERLEVEL9K_RBENV_PROMPT_ALWAYS_SHOW="true"
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true


source ~/.aliases
alias sudo='nocorrect sudo'
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

if [ /snap/bin/kubectl ]; then source <(kubectl completion zsh); fi
unsetopt nomatch #for easy use of []
source ~/.rbenv/completions/rbenv.zsh

# NVM autoload
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
eval "$RUN"
