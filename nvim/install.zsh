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

# Link filetype plugins.
link "${scriptdir}/ft-markdown.lua" "${nvim_ftplugin_dir}/markdown.lua" ${force}
link "${scriptdir}/ft-haskell.lua" "${nvim_ftplugin_dir}/haskell.lua" ${force}
link "${scriptdir}/ft-asciidoc.lua" "${nvim_ftplugin_dir}/asciidoc.lua" ${force}
link "${scriptdir}/ft-tex.lua" "${nvim_ftplugin_dir}/tex.lua" ${force}

# Install color scheme.
link "${scriptdir}/../vim/onehalfdark.vim" "${nvim_colors_dir}/onehalfdark.vim" ${force}
link "${scriptdir}/../vim/onehalfdark.txt" "${nvim_doc_dir}/onehalfdark.txt" ${force}
