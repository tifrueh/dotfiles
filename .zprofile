# custom environment variables

if [ -d /opt/homebrew ]; then export PATH="/opt/homebrew/bin:/opt/custom:$PATH"; else export PATH="/opt/custom:$PATH"; fi
if type pyenv > /dev/null 2> /dev/null; then eval $(pyenv init --path); fi
export EDITOR=vim
