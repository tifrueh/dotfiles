#!/bin/zsh

# Perform script setup.
source "${0:A:h}/../helpers.zsh"
setup $0 $@

# Define path variables.
zsh_dir="${HOME}/.zsh"
zsh_plugin_dir="${zsh_dir}/plugins"
zsh_themes_dir="${zsh_dir}/themes"
config_dir="${HOME}/.config"

# Enforce the installation of zsh and nnn.
enforce 'zsh'
enforce 'nnn'

# Link nnn zsh plugin.
link "${scriptdir}/nnn.zsh" "${zsh_plugin_dir}/nnn/nnn.zsh" ${force}

# Link jdfs plugin.
link "${scriptdir}/jcd" "${config_dir}/nnn/plugins/jcd" ${force}
