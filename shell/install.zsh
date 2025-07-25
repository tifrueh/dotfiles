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

# Install some themes.
git_clone 'pure' 'https://github.com/sindresorhus/pure.git' "${zsh_themes_dir}/pure"
git_clone 'p10k' 'https://github.com/romkatv/powerlevel10k.git' "${zsh_themes_dir}/p10k"

# Install some plugins.
git_clone 'syntax-highlighting' 'https://github.com/zsh-users/zsh-syntax-highlighting.git' "${zsh_plugin_dir}/zsh-syntax-highlighting"
