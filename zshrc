# Path to the zsh directory
export ZSH="$HOME/.zsh"

# Configure history
export HISTFILE="$HOME/.zsh/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS

# Some useful variables
THEMES_DIR="$HOME/.zsh/themes"
PLUGINS_DIR="$HOME/.zsh/plugins"

# Add pure theme
fpath+=($THEMES_DIR/pure)

# Enable zsh-completions
fpath+=($PLUGINS_DIR/zsh-completions/src)

# source alias file if it exists
if [[ -f ~/.zshaliases ]]; then
	source ~/.zshaliases;
fi

# Pyenv configuration
if [ -d $HOME/.pyenv ]; then eval "$(pyenv init -)"; fi
if type pyenv-virtualenv-init > /dev/null 2> /dev/null || [ -d $HOME/.pyenv/plugins/pyenv-virtualenv ]; then
  eval "$(pyenv virtualenv-init -)";
fi

# Enable Homebrew shell-completion if available
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

fi

# Initialise and configure prompt system
zstyle :prompt:pure:prompt:success color green
zstyle :prompt:pure:git:dirty color red
autoload -U promptinit; promptinit
prompt pure

autoload -Uz compinit; compinit

source "$PLUGINS_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
