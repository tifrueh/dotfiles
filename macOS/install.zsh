#!/bin/zsh

# Perform script setup.
source "${0:A:h}/../helpers.zsh"
setup $0 $@

# Enforce the installation of a few essentials.
enforce 'yabai'
enforce 'skhd'
enforce 'curl'
enforce 'git'

# Link yabai and skhdrc configurations.
link "${scriptdir}/yabairc" "${yabai_dir}/yabairc" ${force}
link "${scriptdir}/skhdrc" "${skhd_dir}/skhdrc" ${force}
