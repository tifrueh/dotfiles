#!/bin/zsh

# Perform script setup.
source "${0:A:h}/../helpers.zsh"
setup $0 $@

# Enforce the installation of vim.
enforce 'vim'

# Link vim config.
link "${scriptdir}/vimrc" "${HOME}/.vimrc" ${force}
