# custom environment variables

if [ -d /opt/homebrew ]; then export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/opt/custom/bin:$PATH"; else export PATH="/opt/custom/bin:$PATH"; fi
if [ -d ~/.pyenv ]; then export PYENV_ROOT="$HOME/.pyenv" && export PATH="$PYENV_ROOT/bin:$PATH" && eval $(pyenv init --path); fi
export EDITOR=vim
