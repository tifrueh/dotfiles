#!/bin/zsh

# Define path variables.
config_dir="${HOME}/.config"
kitty_dir="${config_dir}/kitty"

# Store input arguments in 'input_args'.
zparseopts -E -D -a input_args -- \
    h \
    -help \
    -force-links

# Always execute script in its directory.
scriptdir=${0:a:h}
cd "${scriptdir}"

# Source the helper functions.
source "${scriptdir}/../helpers.zsh"

# Provide help if requested.
if contains ${input_args} '-h' || contains ${input_args} '--help'; then
    echo "Usage: ${0} [ -h | --force-links ]"
    echo ""
    echo "Options:"
    echo "  --force-links:        Overwrite existing dotfiles"
    exit 0
fi

# Store '--force-links' in variable.
force=false
if contains ${input_args} '--force-links'; then
    force=true
fi

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
