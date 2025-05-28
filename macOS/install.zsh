#!/bin/zsh

# Perform script setup.
source "${0:A:h}/../helpers.zsh"
setup $0 $@

# Define path variables.
config_dir="${HOME}/.config"
kitty_dir="${config_dir}/kitty"

# Define path variables.
config_dir="${HOME}/.config"
yabai_dir="${config_dir}/yabai"
skhd_dir="${config_dir}/skhd"

# Enforce the installation of a few essentials.
enforce 'yabai'
enforce 'skhd'
enforce 'curl'
enforce 'git'

# Link yabai and skhdrc configurations.
link "${scriptdir}/yabairc" "${yabai_dir}/yabairc" ${force}
link "${scriptdir}/skhdrc" "${skhd_dir}/skhdrc" ${force}
