# custom environment variables

export PATH="/opt/custom/bin:$PATH"
if [ -d /opt/homebrew ]; then eval $(brew --shellenv); fi
if [ -d /opt/ports ]; then export PATH="/opt/ports/bin:/opt/ports/sbin:$PATH"; fi
if [ -d ~/.pyenv ]; then export PYENV_ROOT="$HOME/.pyenv" && export PATH="$PYENV_ROOT/bin:$PATH" && eval $(pyenv init --path); fi
export EDITOR=vim
