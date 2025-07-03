#!/bin/zsh

# Perform script setup.
source "${0:A:h}/../helpers.zsh"
setup $0 $@

# Enforce the installation of zsh and jdfs.
enforce 'zsh'
enforce 'jdfs'

# Link jdfs zsh plugin.
link "${scriptdir}/jdfs.zsh" "${zsh_plugin_dir}/jdfs/jdfs.zsh" ${force}
