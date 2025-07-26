#!/bin/zsh

# Perform script setup.
source "${0:A:h}/../helpers.zsh"
setup $0 $@

# Enforce the installation of fastfetch.
enforce 'less'
enforce 'pacman'
enforce 'auracle'
enforce 'fzf'

# Link scripts.
link "${scriptdir}/pcandy.zsh" "${bin_dir}/pcandy" ${force}
