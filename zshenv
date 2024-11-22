# custom environment variables
typeset -U path
path=("/opt/custom/bin" $path)
if [ -d /opt/homebrew ]; then eval $(/opt/homebrew/bin/brew shellenv zsh); fi
if [ -d /opt/local ]; then path=("/opt/local/bin" "/opt/local/sbin" $path); fi
if [ -d ~/.pyenv ]; then export PYENV_ROOT="${HOME}/.pyenv" && path=("${HOME}/.pyenv/bin" $path); fi
if [ -d ~/.pyenv/plugins/pyenv-virtualenv ]; then path=("${HOME}/.pyenv/plugins/pyenv-virtualenv/bin" $path); fi
export PATH
export EDITOR=vim
export MANWIDTH=80
export GPG_TTY="$(tty)"
