#!/bin/zsh

# Perform script setup.
source "${0:A:h}/../helpers.zsh"
setup $0 $@

# Enforce the installation of zsh and jdfs.
enforce 'zsh'
enforce 'jdfs'

# Link jdfs zsh plugin.
link "${scriptdir}/jcd" "${zsh_plugin_dir}/jdfs/jcd" ${force}
link "${scriptdir}/jls" "${zsh_plugin_dir}/jdfs/jls" ${force}
