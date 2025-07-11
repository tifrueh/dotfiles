#!/bin/zsh

# Perform script setup.
source "${0:A:h}/../helpers.zsh"
setup $0 $@

# Enforce the installation of fastfetch.
enforce 'fastfetch'

# Link fastfetch config.
link "${scriptdir}/fastfetch.jsonc" "${config_dir}/fastfetch/config.jsonc" ${force}
