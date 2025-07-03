#!/bin/zsh

# Perform script setup.
source "${0:A:h}/../helpers.zsh"
setup $0 $@

# Enforce the installation of a few essentials.
enforce 'hyprland'
enforce 'hypridle'
enforce 'hyprlock'
enforce 'hyprsunset'
enforce 'waybar'
enforce 'kitty'
enforce 'nnn'
enforce 'tofi-run'
enforce 'dunst'
enforce 'wpctl'
enforce 'curl'
enforce 'git'

# Link the main configuration file.
link "${scriptdir}/hyprland.conf" "${hypr_dir}/hyprland.conf" ${force}

# Link the hypridle configuration.
link "${scriptdir}/hypridle.conf" "${hypr_dir}/hypridle.conf" ${force}

# Link the hyprlock configuration.
link "${scriptdir}/hyprlock.conf" "${hypr_dir}/hyprlock.conf"

# Create the hyprland override-hook.
create "${hypr_dir}/override-hook.conf"

# Link waybar configuration.
link "${scriptdir}/waybar-config" "${waybar_dir}/config" ${force}
link "${scriptdir}/waybar-style.css" "${waybar_dir}/style.css" ${force}

# Link tofi configuration.
link "${scriptdir}/tofi-config" "${tofi_dir}/config" ${force}

# Link dunst configuration.
link "${scriptdir}/dunstrc" "${dunst_dir}/dunstrc" ${force}
