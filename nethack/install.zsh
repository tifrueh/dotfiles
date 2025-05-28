#!/bin/zsh

# Perform script setup.
source "${0:A:h}/../helpers.zsh"
setup $0 $@

# Enforce the installation of nethack.
enforce 'nethack'

# Link nethack config.
link "${scriptdir}/nethackrc" "${HOME}/.nethackrc" ${force}
