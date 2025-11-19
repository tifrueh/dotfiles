#!/bin/zsh

# Perform script setup.
source "${0:A:h}/../helpers.zsh"
setup $0 $@

# Enforce the installation of a few essentials.
enforce 'zsh'
enforce 'curl'
enforce 'git'

# Create the .zsh directory.
if [[ -d "${HOME}/.zsh" ]]; then
    lecho "skip" ".ZSH DIRECTORY already created, skipping ..."
else
    lecho "info" "Creating .ZSH DIRECTORY"
    mkdir -p "${zsh_plugin_dir}" "${zsh_themes_dir}"

    if [[ -f "${HOME}/.zsh_history" ]]; then
        mv "${HOME}/.zsh_history" "${zsh_dir}/"
    else
        touch "${zsh_dir}/.zsh_history"
    fi
fi

# Link main dotfiles.
link "${scriptdir}/zshaliases" "${HOME}/.zshaliases" ${force}
link "${scriptdir}/zshenv" "${HOME}/.zshenv" ${force}
link "${scriptdir}/zshrc" "${HOME}/.zshrc" ${force}

# Install mu theme.
mkdir -p "${zsh_themes_dir}/mu/"
link "${scriptdir}/prompt_mu_setup" "${zsh_themes_dir}/mu/prompt_mu_setup" ${force}

# Install some plugins.
git_clone 'syntax-highlighting' 'https://github.com/zsh-users/zsh-syntax-highlighting.git' "${zsh_plugin_dir}/zsh-syntax-highlighting"
