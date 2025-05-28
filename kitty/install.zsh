#!/bin/zsh

# Always execute script in its directory.
cd "${0:A:h}"

# Perform script setup.
source "../helpers.zsh"
setup $0 $@

# Define path variables.
config_dir="${HOME}/.config"
kitty_dir="${config_dir}/kitty"

# Enforce the installation of a few essentials.
enforce 'kitty'
enforce 'curl'
enforce 'git'

# Link main kitty config.
link "${scriptdir}/kitty.conf" "${kitty_dir}/kitty.conf" ${force}
link "${scriptdir}/if.conf" "${kitty_dir}/if.conf" ${force}
link "${scriptdir}/onehalfdark.conf" "${kitty_dir}/onehalfdark.conf" ${force}

# Copy fontconfig template.
copy "${scriptdir}/fontconfig.conf" "${kitty_dir}/fontconfig.conf"

# Create override-hook for kitty. 
create "${kitty_dir}/override-hook.conf"
