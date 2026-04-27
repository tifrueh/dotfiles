#!/bin/zsh

# Perform script setup.
source "${0:A:h}/../helpers.zsh"
setup $0 $@

# Enforce the installation of vim.
enforce 'vim'

# Link vim config.
link "${scriptdir}/vimrc" "${HOME}/.vimrc" ${force}

# Link color scheme and documentation.
link "${scriptdir}/onehalfdark.vim" "${vim_colors_dir}/onehalfdark.vim" ${force}
link "${scriptdir}/onehalfdark.txt" "${vim_doc_dir}/onehalfdark.vim" ${force}
