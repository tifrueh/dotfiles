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

# source alias file if it exists
if [[ -f ~/.zshaliases ]]; then
  source ~/.zshaliases;
fi

# Pyenv configuration
if [[ -d "${HOME}/.pyenv" ]]; then eval "$(pyenv init --path)"; fi

if [[ -d "${HOME}/.pyenv/plugins/pyenv-virtualenv" ]]; then
  TMP_PATH=$PATH
  eval "$(pyenv virtualenv-init -)";
  export PATH=$TMP_PATH
  unset TMP_PATH
fi

# Initialise and configure prompt system
fpath+=("$THEMES_DIR/mu/")
autoload -Uz compinit; compinit
autoload -Uz promptinit; promptinit
prompt mu

# Source custom plugins if the corresponding application is installed
if whence jdfs > /dev/null; then
    fpath+=("${PLUGINS_DIR}/jdfs/")
    autoload -Uz jcd
    autoload -Uz jls
    autoload -Uz jpushd
fi

if whence nnn > /dev/null; then
    fpath+=("${PLUGINS_DIR}/nnn/")
    source "${PLUGINS_DIR}/nnn/nnn.zsh"
    autoload -Uz n
fi

# Activate zle vi emulation.
bindkey -v

# Unbind command mode.
bindkey -a -r ':'

# Unbind emacsy insert-mode bindings.
bindkey -v -r '^W'
bindkey -v -r '^H'
bindkey -v -r '^U'

export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=false
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=false

# Source override hook
[[ -f ~/.zoverride ]] && source ~/.zoverride

# Load syntax highlighting if it is available
if [[ -f "${PLUGINS_DIR}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source "${PLUGINS_DIR}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
