#!/bin/zsh

# Perform script setup.
source "${0:A:h}/../helpers.zsh"
setup $0 $@

# Enforce the installation of a few essentials.
enforce 'curl'
enforce 'nvim'
enforce 'git'

# Link main configuration.
link "${scriptdir}/init.lua" "${nvim_dir}/init.lua" ${force}

# Install color schemes.
curl_fetch 'color-onehalfdark' \
    'https://github.com/sonph/onehalf/raw/master/vim/colors/onehalfdark.vim' \
    "${nvim_colors_dir}/onehalfdark.vim"

curl_fetch 'color-onehalflight' \
    'https://github.com/sonph/onehalf/raw/master/vim/colors/onehalflight.vim' \
    "${nvim_colors_dir}/onehalflight.vim"

# Install some plugins.
git_clone 'nvim-lspconfig' 'https://github.com/neovim/nvim-lspconfig.git' "${nvim_plugins_dir}/nvim-lspconfig"
