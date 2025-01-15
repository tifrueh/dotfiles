#!/bin/zsh

# Define path variables.
zsh_dir="${HOME}/.zsh"
zsh_plugin_dir="${zsh_dir}/plugins"
zsh_themes_dir="${zsh_dir}/themes"
vim_dir="${HOME}/.vim"
vim_colors_dir="${vim_dir}/colors"
vim_plugins_dir="${vim_dir}/pack/plugins/start"
config_dir="${HOME}/.config"

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
enforce 'zsh'
enforce 'curl'
enforce 'git'

# Create the .zsh directory.
if [[ -d "${HOME}/.zsh" ]]; then
    echo "DOT-INSTALL: SKIP: .ZSH DIRECTORY already created, skipping ..."
else
    echo "DOT-INSTALL: Creating .ZSH DIRECTORY"
    mkdir -p "${zsh_plugin_dir}" "${zsh_themes_dir}"

    if [[ -f "${HOME}/.zsh_history" ]]; then
        mv "${HOME}/.zsh_history" "${HOME}/.zsh/"
    else
        touch "${HOME}/.zsh/.zsh_history"
    fi
fi

# Link main dotfiles.
link "${scriptdir}/zshaliases" "${HOME}/.zshaliases" ${force}
link "${scriptdir}/zshenv" "${HOME}/.zshenv" ${force}
link "${scriptdir}/zshrc" "${HOME}/.zshrc" ${force}

# Link custom functions.
link "${scriptdir}/zfunctions.zsh" "${zsh_plugin_dir}/custom/zfunctions.zsh" ${force}

# Link vim config.
link "${scriptdir}/vimrc" "${HOME}/.vimrc" ${force}

# Link nethack config.
link "${scriptdir}/nethackrc" "${HOME}/.nethackrc" ${force}

# Link fastfetch config.
link "${scriptdir}/fastfetch.jsonc" "${config_dir}/fastfetch/config.jsonc" ${force}

# Install some themes.
git_clone 'pure' 'https://github.com/sindresorhus/pure.git' "${zsh_themes_dir}/pure"
git_clone 'p10k' 'https://github.com/romkatv/powerlevel10k.git' "${zsh_themes_dir}/p10k"

# Install some plugins.
git_clone 'syntax-highlighting' 'https://github.com/zsh-users/zsh-syntax-highlighting.git' "${zsh_plugin_dir}/zsh-syntax-highlighting"
git_clone 'history-search' 'https://github.com/zsh-users/zsh-history-substring-search.git' "${zsh_plugin_dir}/zsh-history-substring-search"

# Install vim color schemes.
curl_fetch 'vim-onehalfdark' 'https://github.com/sonph/onehalf/raw/master/vim/colors/onehalfdark.vim' "${vim_colors_dir}/onehalfdark.vim"
curl_fetch 'vim-onehalfdark' 'https://github.com/sonph/onehalf/raw/master/vim/colors/onehalflight.vim' "${vim_colors_dir}/onehalflight.vim"

# Install the lightline plugin for vim.
git_clone 'vim-lightline' 'https://github.com/itchyny/lightline.vim' "${vim_plugins_dir}/lightline"
