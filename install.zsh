#!/bin/zsh

# store input arguments in variable
input_args=$*

# always execute script in its directory
dirpath="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"
cd "${dirpath}"

# function for checking whether input argument was given
input_contains () {
	seeking=${1}
	in=1
	for element in "${input_args}"; do
		if [[ "${element}" = "${seeking}" ]]; then
			in=0
			break
		fi
	done
	return $in
}

# function for protected symlinking
#
# Synopsis
#   link FILENAME DESTINATION_PATH
#
# Description
#   FILENAME		The file's name in the dotfile directory
#   DESTINATION_PATH	The file's destination path
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
#   FILENAME		The file's name in the dotfile directory
link_dot () {
	link "${1}" "${HOME}/.${1}"
}

# provide help if requested
if input_contains '-h' || input_contains '--help'; then
	echo "Possible options:"
	echo "  --force-links:      Overwrite existing dotfiles"
	echo "  --configure-nvim:   Configure NVIM"
	echo "  --install-pyenv:    Install PYENV"
	echo "  --exec-zsh:         Execute ZSH after completion"
	exit 0
fi

# enforce requirements zsh curl and git
if ! type zsh > /dev/null 2> /dev/null; then
	echo "DOT-INSTALL: ERROR: Please install ZSH before executing this script ..."
	exit 1
fi

if ! type curl > /dev/null 2> /dev/null; then
	echo "DOT-INSTALL: ERROR: Please install CURL before executing this script ..."
	exit 1
fi

if ! type git > /dev/null 2> /dev/null; then
	echo "DOT-INSTALL: ERROR: Please install GIT before executing this script ..."
	exit 1
fi

# create .zsh directory
if ! [[ -d "${HOME}/.zsh" ]]; then
	echo "DOT-INSTALL: Creating .ZSH DIRECTORY"
	mkdir -p "${HOME}/.zsh/plugins ${HOME}/.zsh/themes"

	if [[ -f "${HOME}/.zsh_history" ]]; then
		mv "${HOME}/.zsh_history" "${HOME}/.zsh/"
	else
		touch "${HOME}/.zsh/.zsh_history"
	fi

else
	echo "DOT-INSTALL: SKIP: .ZSH DIRECTORY already created, skipping ..."
fi

# install pure if not already installed
if ! [[ -d "${HOME}/.zsh/themes/pure" ]]; then
	echo "DOT-INSTALL: Installing PURE"
	git clone https://github.com/sindresorhus/pure.git "${HOME}/.zsh/themes/pure"
else
	echo "DOT-INSTALL: SKIP: PURE already installed, skipping ..."
fi

# install p10k if not already installed
if ! [[ -d "${HOME}/.zsh/themes/p10k" ]]; then
	echo "DOT-INSTALL: Installing P10K"
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${HOME}/.zsh/themes/p10k"
else
	echo "DOT-INSTALL: SKIP: P10K already installed, skipping ..."
fi

# install zsh-syntax-highlighting if not already installed
if ! [[ -d "${HOME}/.zsh/plugins/zsh-syntax-highlighting" ]]; then
	echo "DOT-INSTALL: Installing ZSH-SYNTAX-HIGHLIGHTING"
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${HOME}/.zsh/plugins/zsh-syntax-highlighting"
else
	echo "DOT-INSTALL: SKIP: ZSH-SYNTAX-HIGHLIGHTING already installed, skipping ..."
fi

# install zsh-completions if not already installed
if ! [[ -d "${HOME}/.zsh/plugins/zsh-completions" ]]; then
	echo "DOT-INSTALL: Installing ZSH-COMPLETIONS"
	git clone https://github.com/zsh-users/zsh-completions.git "${HOME}/.zsh/plugins/zsh-completions"
else
	echo "DOT-INSTALL: SKIP: ZSH-COMPLETIONS already installed, skipping ..."
fi

# install zsh-history-substring-search if not already installed
if ! [[ -d "${HOME}/.zsh/plugins/zsh-history-substring-search" ]]; then
	echo "DOT-INSTALL: Installing ZSH-HISTORY-SUBSTRING-SEARCH"
	git clone https://github.com/zsh-users/zsh-history-substring-search.git "${HOME}/.zsh/plugins/zsh-history-substring-search"
else
	echo "DOT-INSTALL: SKIP: ZSH-HISTORY-SUBSTRING-SEARCH already installed, skipping ..."
fi

# install the onehalf colorscheme for vim
if ! [[ -f "${HOME}/.vim/colors/onehalfdark.vim" ]]; then
	echo "DOT-INSTALL: Installing ONEHALFDARK for VIM"
	mkdir -p "${HOME}/.vim/colors"
	curl -sSL https://github.com/sonph/onehalf/raw/master/vim/colors/onehalfdark.vim -o "${HOME}/.vim/colors/onehalfdark.vim"
else
	echo "DOT-INSTALL: SKIP: ONEHALFDARK for VIM already installed, skipping ..."
fi

if ! [[ -f "${HOME}/.vim/colors/onehalflight.vim" ]]; then
	echo "DOT-INSTALL: Installing ONEHALFLIGHT for VIM"
	mkdir -p "${HOME}/.vim/colors"
	curl -sSL https://github.com/sonph/onehalf/raw/master/vim/colors/onehalflight.vim -o "${HOME}/.vim/colors/onehalflight.vim"
else
	echo "DOT-INSTALL: SKIP: ONEHALFLIGHT for VIM already installed, skipping ..."
fi

# install the lightline plugin for vim
if ! [[ -d "${HOME}/.vim/pack/plugins/start/lightline" ]]; then
	echo "DOT-INSTALL: Installing LIGHTLINE for VIM"
	mkdir -p "${HOME}/.vim/pack/plugins/start"
	git clone https://github.com/itchyny/lightline.vim "${HOME}/.vim/pack/plugins/start/lightline"
else
	echo "DOT-INSTALL: SKIP: LIGHTLINE for VIM already installed, skipping ..."
fi

# link all dotfiles
link_dot "gitconfig"
link_dot "nethackrc"
link_dot "vimrc"
link_dot "zprofile"
link_dot "zshaliases"
link_dot "zshrc"

# configure nvim if requested
## link nvimrc and copy vim colors
if input_contains "--configure-nvim"; then
	mkdir -p "${HOME}/.config/nvim"
	link "nvimrc" "${HOME}/.config/nvim/init.vim"
	echo "DOT-INSTALL: Copying VIM colorschemes to NVIM"
	mkdir -p "${HOME}/.config/nvim/colors"
	cp "${HOME}/.vim/colors/"* "${HOME}/.config/nvim/colors"
fi

## install the lualine plugin for nvim
if input_contains "--configure-nvim" && [[ ! -d "${HOME}/.config/nvim/pack/plugins/start/lualine" ]]; then
	echo "DOT-INSTALL: Installing LUALINE for NVIM"
	git clone https://github.com/nvim-lualine/lualine.nvim.git "${HOME}/.config/nvim/pack/plugins/start/lualine"
elif input_contains "--configure-nvim"; then
	echo "DOT-INSTALL: SKIP: LUALINE for NVIM already installed, skipping ..."
fi

# install pyenv if requested, if on macOS and if not already installed
if input_contains "--install-pyenv" && [[ -d "${HOME}/.pyenv" ]]; then
	echo "DOT-INSTALL: ERROR: PYENV already installed ..."
	exit 1
elif input_contains "--install-pyenv"; then
	echo "DOT-INSTALL: Installing PYENV"
	git clone https://github.com/pyenv/pyenv.git "${HOME}/.pyenv"
	echo "DOT-INSTALL: Intalling PYENV-VIRTUALENV"
	git clone https://github.com/pyenv/pyenv-virtualenv.git "${HOME}/.pyenv/plugins/pyenv-virtualenv"
	echo "DOT-INSTALL: NOTIFICATION: PYENV was installed, but please install all Python dependencies before installing Python ..."
fi

if input_contains '--exec-zsh'; then
	exec zsh
fi
