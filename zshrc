# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to the zsh directory
export ZSH="${HOME}/.zsh"

# Configure history
export HISTFILE="${HOME}/.zsh/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS

# Some useful variables
THEMES_DIR="${ZSH}/themes"
PLUGINS_DIR="${ZSH}/plugins"

# Enable zsh-completions
fpath+=("${PLUGINS_DIR}/zsh-completions/src")

# source alias file if it exists
if [[ -f ~/.zshaliases ]]; then
  source ~/.zshaliases;
fi

# Pyenv configuration
if [[ -d "${HOME}/.pyenv" ]]; then eval "$(pyenv init -)"; fi

if [[ -d "${HOME}/.pyenv/plugins/pyenv-virtualenv" ]]; then
  TMP_PATH=$PATH
  eval "$(pyenv virtualenv-init -)";
  export PATH=$TMP_PATH
  unset TMP_PATH
fi

# Initialise and configure prompt system
autoload -Uz compinit; compinit
source "${PLUGINS_DIR}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "${PLUGINS_DIR}/zsh-history-substring-search/zsh-history-substring-search.zsh"
source "${THEMES_DIR}/p10k/powerlevel10k.zsh-theme"

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=false
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=false

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
