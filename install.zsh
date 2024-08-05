#!/bin/zsh

# define path variables
zsh_dir="${HOME}/.zsh"
zsh_plugin_dir="${zsh_dir}/plugins"
zsh_themes_dir="${zsh_dir}/themes"
vim_dir="${HOME}/.vim"
vim_colors_dir="${vim_dir}/colors"
vim_plugins_dir="${vim_dir}/pack/plugins/start"
config_dir="${HOME}/.config"
nvim_dir="${config_dir}/nvim"
nvim_colors_dir="${nvim_dir}/colors"
nvim_plugins_dir="${nvim_dir}/pack/plugins/start"
kitty_dir="${config_dir}/kitty"
fastfetch_dir="${config_dir}/fastfetch"

# store input arguments in variable
zparseopts -E -D -a input_args -- \
    h \
    -help \
    -force-links \
    -configure-nvim \
    -configure-kitty \
    -configure-hyprland \
    -configure-waybar \
    -configure-yabai \
    -configure-skhd \
    -install-pyenv \
    -exec-zsh

# always execute script in its directory
dirpath="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"
cd "${dirpath}"

# function for checking whether input argument was given
input_contains () {
    seeking="${1}"
    for element in $input_args; do
        if [[ "${element}" = "${seeking}" ]]; then
            return 0
        fi
    done
    return 1
}

# function for protected symlinking
#
# Synopsis
#   link FILENAME DESTINATION_PATH
#
# Description
#   FILENAME            The file's name in the dotfile directory
#   DESTINATION_PATH    The file's destination path
link () {
    if [[ -h "${2}" || -f "${2}" ]] && input_contains "--force-links"; then
        echo -n "Do you really want to overwrite ${2}? [y|n] "
        read confirm
        if [[ "${confirm}" = "y" ]]; then
            echo "DOT-INSTALL: Overwriting ${2} <- ${1}"
            rm "${2}"
            ln -s "${dirpath}/${1}" "${2}"
        else
            echo "DOT-INSTALL: SKIP: Not overwriting ${2}, skipping ..."
        fi
    elif [[ -h "${2}" || -f "${2}" ]]; then
        echo "DOT-INSTALL: ${2} exists, skipping (override with '--force-links') ..."
    elif [[ -e "${2}" ]]; then
        echo "DOT-INSTALL: SKIP: ${2} exists and is not a symbolic link or regular file, skipping ..."
    else
        echo "DOT-INSTALL: Linking ${1} -> ${2}"
        ln -s "${dirpath}/${1}" "${2}"
    fi
}

# function for linking a dotfile
#
# Synopsis
#   link_dot FILENAME
# 
# Description
#   FILENAME            The file's name in the dotfile directory
link_dot () {
    link "${1}" "${HOME}/.${1}"
}

# provide help if requested
if input_contains '-h' || input_contains '--help'; then
    echo "Possible options:"
    echo "  --force-links:        Overwrite existing dotfiles"
    echo "  --configure-nvim:     Configure NVIM"
    echo "  --configure-kitty:    Configure KITTY"
    echo "  --configure-hyprland: Configure HYPRLAND" 
    echo "  --configure-waybar:   Configure WAYBAR"
    echo "  --configure-yabai:    Configure YABAI"
    echo "  --configure-skhd:     Configure SKHD"
    echo "  --install-pyenv:      Install PYENV"
    echo "  --exec-zsh:           Execute ZSH after completion"
    exit 0
fi

# enforce requirements zsh curl and git
if ! type zsh &> /dev/null; then
    echo "DOT-INSTALL: ERROR: Please install ZSH before executing this script ..."
    exit 1
fi

if ! type curl &> /dev/null; then
    echo "DOT-INSTALL: ERROR: Please install CURL before executing this script ..."
    exit 1
fi

if ! type git &> /dev/null; then
    echo "DOT-INSTALL: ERROR: Please install GIT before executing this script ..."
    exit 1
fi

# create .zsh directory
if ! [[ -d "${HOME}/.zsh" ]]; then
    echo "DOT-INSTALL: Creating .ZSH DIRECTORY"
    mkdir -p "${zsh_plugin_dir}" "${zsh_themes_dir}"

    if [[ -f "${HOME}/.zsh_history" ]]; then
        mv "${HOME}/.zsh_history" "${HOME}/.zsh/"
    else
        touch "${HOME}/.zsh/.zsh_history"
    fi

else
    echo "DOT-INSTALL: SKIP: .ZSH DIRECTORY already created, skipping ..."
fi

# install pure if not already installed
if ! [[ -d "${zsh_themes_dir}/pure" ]]; then
    echo "DOT-INSTALL: Installing PURE"
    git clone "https://github.com/sindresorhus/pure.git" "${zsh_themes_dir}/pure"
else
    echo "DOT-INSTALL: SKIP: PURE already installed, skipping ..."
fi

# install p10k if not already installed
if ! [[ -d "${zsh_themes_dir}/p10k" ]]; then
    echo "DOT-INSTALL: Installing P10K"
    git clone --depth=1 "https://github.com/romkatv/powerlevel10k.git" "${zsh_themes_dir}/p10k"
else
    echo "DOT-INSTALL: SKIP: P10K already installed, skipping ..."
fi

# install zsh-syntax-highlighting if not already installed
if ! [[ -d "${zsh_plugin_dir}/zsh-syntax-highlighting" ]]; then
    echo "DOT-INSTALL: Installing ZSH-SYNTAX-HIGHLIGHTING"
    git clone "https://github.com/zsh-users/zsh-syntax-highlighting.git" "${zsh_plugin_dir}/zsh-syntax-highlighting"
else
    echo "DOT-INSTALL: SKIP: ZSH-SYNTAX-HIGHLIGHTING already installed, skipping ..."
fi

# install zsh-history-substring-search if not already installed
if ! [[ -d "${zsh_plugin_dir}/zsh-history-substring-search" ]]; then
    echo "DOT-INSTALL: Installing ZSH-HISTORY-SUBSTRING-SEARCH"
    git clone "https://github.com/zsh-users/zsh-history-substring-search.git" "${zsh_plugin_dir}/zsh-history-substring-search"
else
    echo "DOT-INSTALL: SKIP: ZSH-HISTORY-SUBSTRING-SEARCH already installed, skipping ..."
fi

# install the onehalf colorscheme for vim
if ! [[ -f "${vim_colors_dir}/onehalfdark.vim" ]]; then
    echo "DOT-INSTALL: Installing ONEHALFDARK for VIM"
    mkdir -p "${vim_colors_dir}"
    curl -fL "https://github.com/sonph/onehalf/raw/master/vim/colors/onehalfdark.vim" -o "${vim_colors_dir}/onehalfdark.vim"
else
    echo "DOT-INSTALL: SKIP: ONEHALFDARK for VIM already installed, skipping ..."
fi

if ! [[ -f "${vim_colors_dir}/onehalflight.vim" ]]; then
    echo "DOT-INSTALL: Installing ONEHALFLIGHT for VIM"
    mkdir -p "${vim_colors_dir}"
    curl -fL "https://github.com/sonph/onehalf/raw/master/vim/colors/onehalflight.vim" -o "${vim_colors_dir}/onehalflight.vim"
else
    echo "DOT-INSTALL: SKIP: ONEHALFLIGHT for VIM already installed, skipping ..."
fi

# install the lightline plugin for vim
if ! [[ -d "${vim_plugins_dir}/lightline" ]]; then
    echo "DOT-INSTALL: Installing LIGHTLINE for VIM"
    mkdir -p "${vim_plugins_dir}"
    git clone "https://github.com/itchyny/lightline.vim" "${vim_plugins_dir}/lightline"
else
    echo "DOT-INSTALL: SKIP: LIGHTLINE for VIM already installed, skipping ..."
fi

# install the fastfetch config

if [[ -d "${fastfetch_dir}" ]]; then
    echo "DOT-INSTALL: SKIP: FASTFETCH config already installed, skipping ..."
else
    mkdir -p "${fastfetch_dir}"
    link "fastfetch.jsonc" "${fastfetch_dir}/config.jsonc"
fi

# link all dotfiles
link_dot "nethackrc"
link_dot "vimrc"
link_dot "zshaliases"
link_dot "zshenv"
link_dot "zshrc"

# configure nvim if requested
## link nvimrc and copy vim colors
if input_contains "--configure-nvim"; then
    mkdir -p "${nvim_dir}"
    link "nvimrc" "${nvim_dir}/init.lua"
    echo "DOT-INSTALL: Copying VIM colorschemes to NVIM"
    mkdir -p "${nvim_colors_dir}/colors"
    cp "${vim_colors_dir}/"* "${nvim_colors_dir}/"
fi

## install the nvim-web-devicon plugin for nvim
if input_contains "--configure-nvim" && [[ ! -d "${nvim_plugins_dir}/nvim-web-devicons" ]]; then
    echo "DOT-INSTALL: Installing NVIM-WEB-DEVICONS for NVIM"
    git clone "https://github.com/nvim-tree/nvim-web-devicons" "${nvim_plugins_dir}/nvim-web-devicons"
elif input_contains "--configure-nvim"; then
    echo "DOT-INSTALL: SKIP: NVIM-WEB-DEVICONS for NVIM already installed, skipping ..."
fi

## install the lualine plugin for nvim
if input_contains "--configure-nvim" && [[ ! -d "${nvim_plugins_dir}/lualine" ]]; then
    echo "DOT-INSTALL: Installing LUALINE for NVIM"
    git clone "https://github.com/nvim-lualine/lualine.nvim.git" "${nvim_plugins_dir}/lualine"
elif input_contains "--configure-nvim"; then
    echo "DOT-INSTALL: SKIP: LUALINE for NVIM already installed, skipping ..."
fi

## install the nvim-surround plugin for nvim
if input_contains "--configure-nvim" && [[ ! -d "${nvim_plugins_dir}/nvim-surround" ]]; then
    echo "DOT-INSTALL: Installing NVIM-SURROUND for NVIM"
    git clone "https://github.com/kylechui/nvim-surround.git" "${nvim_plugins_dir}/nvim-surround"
elif input_contains "--configure-nvim"; then
    echo "DOT-INSTALL: SKIP: NVIM-SURROUND for NVIM already installed, skipping ..."
fi

## install the nvim-tree plugin for nvim
if input_contains "--configure-nvim" && [[ ! -d "${nvim_plugins_dir}/nvim-tree" ]]; then
    echo "DOT-INSTALL: Installing NVIM-TREE for NVIM"
    git clone "https://github.com/nvim-tree/nvim-tree.lua.git" "${nvim_plugins_dir}/nvim-tree"
elif input_contains "--configure-nvim"; then
    echo "DOT-INSTALL: SKIP: NVIM-TREE for NVIM already installed, skipping ..."
fi

## install the nvim-lspconfig plugin for nvim
if input_contains "--configure-nvim" && [[ ! -d "${nvim_plugins_dir}/nvim-lspconfig" ]]; then
    echo "DOT-INSTALL: Installing NVIM-LSPCONFIG for NVIM"
    git clone "https://github.com/neovim/nvim-lspconfig.git" "${nvim_plugins_dir}/nvim-lspconfig"
elif input_contains "--configure-nvim"; then
    echo "DOT-INSTALL: SKIP: NVIM-LSPCONFIG for NVIM already installed, skipping ..."
fi

## install the nvim-treesitter plugin for neovim
if input_contains "--configure-nvim" && [[ ! -d "${nvim_plugins_dir}/nvim-treesitter" ]]; then
    echo "DOT-INSTALL: Installing NVIM-TREESITTER for NVIM"
    git clone "https://github.com/nvim-treesitter/nvim-treesitter.git" "${nvim_plugins_dir}/nvim-treesitter"
elif input_contains "--configure-nvim"; then
    echo "DOT-INSTALL: SKIP: NVIM-TREESITTER for NVIM already installed, skipping ..."
fi

# configure kitty if requested
## link kitty config
if input_contains "--configure-kitty"; then
    mkdir -p "${kitty_dir}"
    link "kitty.conf" "${kitty_dir}/kitty.conf"
    link "kitty-if.conf" "${kitty_dir}/if.conf"
fi

## install onehalfdark for kitty
if input_contains "--configure-kitty" && [[ ! -f "${kitty_dir}/onehalfdark.conf" ]]; then
    echo "DOT-INSTALL: Installing ONEHALFDARK for KITTY"
    curl -fL "https://github.com/sonph/onehalf/raw/master/kitty/onehalf-dark.conf" -o "${kitty_dir}/onehalfdark.conf"
elif input_contains "--configure-kitty"; then
    echo "DOT-INSTALL: SKIP: ONEHALFDARK for KITTY already installed, skipping ..."
fi

## install onehalfdark for kitty
if input_contains "--configure-kitty" && [[ ! -f "${kitty_dir}/onehalflight.conf" ]]; then
    echo "DOT-INSTALL: Installing ONEHALFLIGHT for KITTY"
    curl -fL "https://github.com/sonph/onehalf/raw/master/kitty/onehalf-light.conf" -o "${kitty_dir}/onehalflight.conf"
elif input_contains "--configure-kitty"; then
    echo "DOT-INSTALL: SKIP: ONEHALFLIGHT for KITTY already installed, skipping ..."
fi

## install font configuration for kitty
if input_contains "--configure-kitty" && [[ ! -f "${kitty_dir}/fontconfig.conf" ]]; then
    echo "DOT-INSTALL: Installing default font configuration for KITTY"
    cp "${dirpath}/kitty-fontconfig.conf" "${kitty_dir}/fontconfig.conf"
elif input_contains "--configure-kitty"; then
    echo "DOT-INSTALL: SKIP: Font configuration file for KITTY found, skipping ..."
fi

## install override-hook for kitty
if input_contains "--configure-kitty" && [[ ! -f "${kitty_dir}/override-hook.conf" ]]; then
    echo "DOT-INSTALL: Installing override hook for KITTY"
    touch "${kitty_dir}/override-hook.conf"
elif input_contains "--configure-kitty"; then
    echo "DOT-INSTALL: SKIP: Override hook for KITTY found, skipping ..."
fi

# install hyprland configuration if requested
if input_contains "--configure-hyprland"; then
    mkdir -p "${config_dir}/hypr"
    link "hyprland.conf" "${config_dir}/hypr/hyprland.conf"
fi

## install override-hook for hyprland
if input_contains "--configure-hyprland" && [[ ! -f "${config_dir}/hypr/override-hook.conf" ]]; then
    echo "DOT-INSTALL: Installing override hook for HYPRLAND"
    touch "${config_dir}/hypr/override-hook.conf"
elif input_contains "--configure-hyprland"; then
    echo "DOT-INSTALL: SKIP: Override hook for HYPRLAND found, skipping ..."
fi

# install waybar configuration if requested
if input_contains "--configure-waybar"; then
    mkdir -p "${config_dir}/waybar"
    link "waybar-config" "${config_dir}/waybar/config"
    link "waybar-style.css" "${config_dir}/waybar/style.css"
fi

# install yabai configuration if requested
if input_contains "--configure-yabai"; then
    mkdir -p "${config_dir}/yabai"
    link "yabairc" "${config_dir}/yabai/yabairc"
fi

# install skhd configuration if requested
if input_contains "--configure-skhd"; then
    mkdir -p "${config_dir}/skhd"
    link "skhdrc" "${config_dir}/skhd/skhdrc"
fi

# install pyenv if requested, if on macOS and if not already installed
if input_contains "--install-pyenv" && [[ -d "${HOME}/.pyenv" ]]; then
    echo "DOT-INSTALL: ERROR: PYENV already installed ..."
    exit 1
elif input_contains "--install-pyenv"; then
    echo "DOT-INSTALL: Installing PYENV"
    git clone "https://github.com/pyenv/pyenv.git" "${HOME}/.pyenv"
    echo "DOT-INSTALL: Intalling PYENV-VIRTUALENV"
    git clone "https://github.com/pyenv/pyenv-virtualenv.git" "${HOME}/.pyenv/plugins/pyenv-virtualenv"
    echo "DOT-INSTALL: NOTIFICATION: PYENV was installed, but please install all Python dependencies before installing Python ..."
fi

if input_contains '--exec-zsh'; then
    exec zsh
fi
