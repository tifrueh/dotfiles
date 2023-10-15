# custom environment variables
if [ -d /opt/homebrew ]; then eval $(/opt/homebrew/bin/brew shellenv zsh); fi
if [ -d /opt/ports ]; then export PATH="/opt/ports/bin:/opt/ports/sbin:$PATH"; fi
if [ -d ~/.pyenv ]; then export PYENV_ROOT="$HOME/.pyenv" && export PATH="$PYENV_ROOT/bin:$PATH" && eval $(pyenv init --path); fi
export PATH="/opt/custom/bin:$PATH"
export EDITOR=vim
