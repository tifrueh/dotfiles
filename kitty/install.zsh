#!/bin/zsh

# Perform script setup.
source "${0:A:h}/../helpers.zsh"
setup $0 $@

# Enforce the installation of a few essentials.
enforce 'kitty'
enforce 'curl'
enforce 'git'

# Link main kitty config.
link "${scriptdir}/kitty.conf" "${kitty_dir}/kitty.conf" ${force}
link "${scriptdir}/if.conf" "${kitty_dir}/if.conf" ${force}
link "${scriptdir}/onehalfdark.conf" "${kitty_dir}/onehalfdark.conf" ${force}
link "${scriptdir}/tab_bar.py" "${kitty_dir}/tab_bar.py" ${force}

# Copy fontconfig template.
copy "${scriptdir}/fontconfig.conf" "${kitty_dir}/fontconfig.conf"

# Create override-hook for kitty.
create "${kitty_dir}/override-hook.conf"

# Install 'kedit'.
link "${scriptdir}/kedit" "${bin_dir}/kedit" ${force}
