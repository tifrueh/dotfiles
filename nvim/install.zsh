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

# Install color scheme.
link "${scriptdir}/../vim/onehalfdark.vim" "${nvim_colors_dir}/onehalfdark.vim" ${force}
link "${scriptdir}/../vim/onehalfdark.txt" "${nvim_doc_dir}/onehalfdark.txt" ${force}

# Install some plugins.
git_clone 'nvim-lspconfig' 'https://github.com/neovim/nvim-lspconfig.git' "${nvim_plugins_dir}/nvim-lspconfig"
