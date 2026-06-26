#!/bin/zsh

# Perform script setup.
source "${0:A:h}/../helpers.zsh"
setup $0 $@

# Enforce the installation of the window manager.
enforce 'aerospace'

# Link aerospace configuration.
link "${scriptdir}/aerospace.toml" "${aerospace_dir}/aerospace.toml" ${force}
