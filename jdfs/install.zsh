#!/bin/zsh

# Perform script setup.
source "${0:A:h}/../helpers.zsh"
setup $0 $@

# Define path variables.
zsh_dir="${HOME}/.zsh"
zsh_plugin_dir="${zsh_dir}/plugins"
zsh_themes_dir="${zsh_dir}/themes"
config_dir="${HOME}/.config"

# Enforce the installation of zsh and jdfs.
enforce 'zsh'
enforce 'jdfs'

# Link jdfs zsh plugin.
link "${scriptdir}/jdfs.zsh" "${zsh_plugin_dir}/jdfs/jdfs.zsh" ${force}
