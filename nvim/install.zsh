#!/bin/zsh

# Perform script setup.
source "${0:A:h}/../helpers.zsh"
setup $0 $@

# Define path variables.
config_dir="${HOME}/.config"
nvim_dir="${config_dir}/nvim"
nvim_colors_dir="${nvim_dir}/colors"
nvim_plugins_dir="${nvim_dir}/pack/plugins/start"

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
git_clone 'nvim-web-devicon' 'https://github.com/nvim-tree/nvim-web-devicons.git' "${nvim_plugins_dir}/nvim-web-devicons"
git_clone 'lualine.nvim' 'https://github.com/nvim-lualine/lualine.nvim.git' "${nvim_plugins_dir}/lualine"
git_clone 'nvim-surround' 'https://github.com/kylechui/nvim-surround.git' "${nvim_plugins_dir}/nvim-surround"
git_clone 'nvim-tree' 'https://github.com/nvim-tree/nvim-tree.lua.git' "${nvim_plugins_dir}/nvim-tree"
git_clone 'nvim-lspconfig' 'https://github.com/neovim/nvim-lspconfig.git' "${nvim_plugins_dir}/nvim-lspconfig"
git_clone 'nvim-treesitter' 'https://github.com/nvim-treesitter/nvim-treesitter.git' "${nvim_plugins_dir}/nvim-treesitter"
