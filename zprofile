# custom environment variables
typeset -U path
path=("/opt/custom/bin" $path)
if [ -d /opt/homebrew ]; then eval $(/opt/homebrew/bin/brew shellenv zsh); fi
if [ -d /opt/local ]; then path=("/opt/local/bin" "/opt/local/sbin" $path) && manpath=("/opt/local/share/man" $manpath); fi
if [ -d ~/.pyenv ]; then export PYENV_ROOT="${HOME}/.pyenv" && path=("${HOME}/.pyenv/shims" $path); fi
if [ -d ~/.pyenv/plugins/pyenv-virtualenv ]; then path=("${HOME}/.pyenv/plugins/pyenv-virtualenv/shims" $path); fi
export PATH
export MANPATH
export EDITOR=vim
