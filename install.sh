#!/bin/sh

# store input arguments in variable
input_args=$*

# store script path in variable
script_dirname=$(cd "$(dirname "$0")" > /dev/null 2> /dev/null && pwd)

# function for checking whether input argument was given
input_contains () {
	seeking=$1
	in=1
	for element in $input_args; do
		if [ "$element" = "$seeking" ]; then
			in=0
			break
		fi
	done
	return $in
}

# function for linking a dotfile
link () {
	if ! [ -e $HOME/.$1 ]; then
		echo "DOT-INSTALL: Linking $1 ..."
		ln -s $script_dirname/$1 $HOME/.$1
	elif input_contains '--force-links'; then
		echo -n "Do you really want to overwrite your existing $1? [y|n] "
		read confirm
		if [ $confirm = "y" ]; then
			echo "DOT-INSTALL: Removing existing $1 ..."
			rm $HOME/.$1
			echo "DOT-INSTALL: Linking $1 ..."
			ln -s $script_dirname/$1 $HOME/.$1
		else
			echo "DOT-INSTALL: SKIP: Not overwriting $1, skipping ..."
		fi
	else
		echo "DOT-INSTALL: SKIP: Existing $1 found, skipping ..."
	fi
}

if input_contains '-h' || input_contains '--help'; then
	echo "Possible options:"
	echo "--brew:        Install HOMEBREW"
	echo "--pyenv:       Install PYENV"
	echo "--nvim:        Link NVIM config"
	echo "--force-links: Overwrite existing dotfiles"
	echo "--exec-zsh:    Execute ZSH after completion"
	exit 0
fi

# enforce requirements
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

# install homebrew if requested, if on macOS and if not already installed
if input_contains '--brew' && type brew > /dev/null 2> /dev/null; then
	echo "DOT-INSTALL: ERROR: HOMEBREW already installed ..."
	exit 1
elif input_contains '--brew' && ! [ "$OSTYPE" = "darwin" ]; then
	echo "DOT-INSTALL: ERROR: HOMEBREW cannot be installed on any other system than macOS ..."
	exit 1
elif input_contains '--brew' && [ "$OSTYPE" = "darwin" ] && ! type brew > /dev/null 2> /dev/null; then
	echo "DOT-INSTALL: Installing HOMEBREW ..."
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# install pyenv if requested, if on macOS and if not already installed
if input_contains '--pyenv' && [ -d $HOME/.pyenv ]; then
	echo "DOT-INSTALL: ERROR: PYENV already installed ..."
	exit 1
elif input_contains '--pyenv' && ! [ -d $HOME/.pyenv ]; then
	echo "DOT-INSTALL: Installing PYENV ..."
	git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv
	echo "DOT-INSTALL: Intalling PYENV-VIRTUALENV  ..."
	git clone https://github.com/pyenv/pyenv-virtualenv.git $HOME/.pyenv/plugins/pyenv-virtualenv
fi

# link nvim config if requested and no config is present
if input_contains '--nvim' && [ -d $HOME/.config/nvim ]; then
	echo "DOT-INSTALL: ERROR: NVIM configuration already present, remove first ..."
	exit 1
elif input_contains '--nvim'; then
	echo "DOT-INSTALL: Linking NVIM config"
	mkdir -p $HOME/.config
	ln -s $script_dirname/nvim $HOME/.config/nvim
fi

# create .zsh directory
if ! [ -d $HOME/.zsh ]; then
	echo "DOT-INSTALL: Creating .ZSH DIRECTORY ..."
	mkdir -p $HOME/.zsh/plugins $HOME/.zsh/themes

	if [ -f $HOME/.zsh_history ]; then
		mv $HOME/.zsh_history $HOME/.zsh/
	else
		touch $HOME/.zsh/.zsh_history
	fi

else
	echo "DOT-INSTALL: SKIP: .ZSH DIRECTORY already created, skipping ..."
fi

# install vim if on macOS or a Debian based Linux, ask for manual installation if not
if ! type vim > /dev/null 2> /dev/null && $(uname) = "Darwin"; then
	brew install vim
elif ! type vim > /dev/null 2> /dev/null && [ -f /etc/debian_version ]; then
	sudo apt install vim
elif ! type vim > /dev/null 2> /dev/null; then
	echo "DOT-INSTALL: ERROR: Unsupported OS for automatic VIM installation ..."
	echo "DOT-INSTALL: =====> Please install VIM and restart the script ..."
	exit 1
fi

# install vim-plug if not already installed
if ! [ -f $HOME/.vim/autoload/plug.vim ]; then
	echo "DOT-INSTALL: Installing VIM-PLUG ..."
	curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
	echo "DOT-INSTALL: SKIP: VIM-PLUG already installed, skipping ..."
fi

# install pure if not already installed
if ! [ -d $HOME/.zsh/themes/pure ]; then
	echo "DOT-INSTALL: Installing PURE ..."
	git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/themes/pure"
else
	echo "DOT-INSTALL: SKIP: PURE already installed, skipping ..."
fi

# install p10k if not already installed
if ! [ -d $HOME/.zsh/themes/p10k ]; then
	echo "DOT-INSTALL: Installing P10K ..."
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.zsh/themes/p10k"
else
	echo "DOT-INSTALL: SKIP: P10K already installed, skipping ..."
fi

# install zsh-syntax-highlighting if not already installed
if ! [ -d $HOME/.zsh/plugins/zsh-syntax-highlighting ]; then
	echo "DOT-INSTALL: Installing ZSH-SYNTAX-HIGHLIGHTING ..."
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh/plugins/zsh-syntax-highlighting"
else
	echo "DOT-INSTALL: SKIP: ZSH-SYNTAX-HIGHLIGHTING already installed, skipping ..."
fi

if ! [ -d $HOME/.zsh/plugins/zsh-completions ]; then
	echo "DOT-INSTALL: Installing ZSH-COMPLETIONS ..."
	git clone https://github.com/zsh-users/zsh-completions.git "$HOME/.zsh/plugins/zsh-completions"
else
	echo "DOT-INSTALL: SKIP: ZSH-COMPLETIONS already installed, skipping ..."
fi

if ! [ -d $HOME/.zsh/plugins/zsh-history-substring-search ]; then
	echo "DOT-INSTALL: Installing ZSH-HISTORY-SUBSTRING-SEARCH ..."
	git clone https://github.com/zsh-users/zsh-history-substring-search.git "${HOME}/.zsh/plugins/zsh-history-substring-search"
else
	echo "DOT-INSTALL: SKIP: ZSH-HISTORY-SUBSTRING-SEARCH already installed, skipping ..."
fi

# add symlinks if they do not exist already and overwrite them if requested
link "zshrc"
link "zprofile"
link "zshaliases"
link "vimrc"
link "nethackrc"

if input_contains '--pyenv'; then
	echo "DOT-INSTALL: NOTIFICATION: PYENV was installed, but please install all Python dependencies before installing Python ..."
fi

if input_contains '--exec-zsh'; then
	exec zsh
fi
