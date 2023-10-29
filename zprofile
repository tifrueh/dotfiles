# custom environment variables
export PATH="/opt/custom/bin:$PATH"
if [ -d /opt/homebrew ]; then eval $(/opt/homebrew/bin/brew shellenv zsh); fi
if [ -d /opt/local ]; then export PATH="/opt/local/bin:/opt/local/sbin:$PATH" && export MANPATH="/opt/local/share/man:$MANPATH"; fi
if [ -d ~/.pyenv ]; then export PYENV_ROOT="$HOME/.pyenv" && eval $(pyenv init --path); fi
export EDITOR=vim
