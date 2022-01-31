# custom environment variables

if [ -d /opt/homebrew ]; then export PATH="/opt/homebrew/bin:/opt/custom:$PATH"; else export PATH="/opt/custom:$PATH"; fi
if which pyenv > /dev/null; then eval $(pyenv init --path); fi
export EDITOR=vim
