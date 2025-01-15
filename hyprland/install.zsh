#!/bin/zsh

# Define path variables.
config_dir="${HOME}/.config"
hypr_dir="${config_dir}/hypr"
waybar_dir="${config_dir}/waybar"

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
enforce 'hyprland'
enforce 'hypridle'
enforce 'hyprlock'
enforce 'waybar'
enforce 'kitty'
enforce 'thunar'
enforce 'wofi'
enforce 'curl'
enforce 'git'

# Link the main configuration file.
link "${scriptdir}/hyprland.conf" "${hypr_dir}/hyprland.conf" ${force}

# Link the hypridle configuration.
link "${scriptdir}/hypridle.conf" "${hypr_dir}/hypridle.conf" ${force}

# Copy the hyprlock configuration template.
copy "${scriptdir}/hyprlock.conf" "${hypr_dir}/hyprlock.conf"

# Create the hyprland override-hook.
create "${hypr_dir}/override-hook.conf"

# Link waybar configuration.
link "${scriptdir}/waybar-config" "${waybar_dir}/config" ${force}
link "${scriptdir}/waybar-style.css" "${waybar_dir}/style.css" ${force}
