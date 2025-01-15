#!/bin/zsh

# Define path variables.
config_dir="${HOME}/.config"
yabai_dir="${config_dir}/yabai"
skhd_dir="${config_dir}/skhd"

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
enforce 'yabai'
enforce 'skhd'
enforce 'curl'
enforce 'git'

# Link yabai and skhdrc configurations.
link "${scriptdir}/yabairc" "${yabai_dir}/yabairc" ${force}
link "${scriptdir}/skhdrc" "${skhd_dir}/skhdrc" ${force}
