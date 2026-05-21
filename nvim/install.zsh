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
link "${scriptdir}/ft-viper.lua" "${nvim_ftplugin_dir}/viper.lua" ${force}
link "${scriptdir}/ft-promela.lua" "${nvim_ftplugin_dir}/promela.lua" ${force}

# Link regular plugins.
link "${scriptdir}/pl-viper.lua" "${nvim_plugin_dir}/viper.lua" ${force}

# Install color scheme.
link "${scriptdir}/../vim/onehalfdark.vim" "${nvim_colors_dir}/onehalfdark.vim" ${force}
link "${scriptdir}/../vim/onehalfdark.txt" "${nvim_doc_dir}/onehalfdark.txt" ${force}

# Download and install promela syntax.
curl_fetch "PROMELA SYNTAX" 'https://d3s.mff.cuni.cz/legacy/~holub/sw/promela_vim/promela.vim' "${nvim_syntax_dir}/promela.vim"
