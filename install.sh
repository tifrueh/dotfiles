#!/bin/sh

input_args=$*

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

link () {
	if ! [ -f ~/$1 ]; then
		echo "Linking $1 ..."
		ln -s ~/.dotfiles/$1 ~/$1
	elif input_contains '--force-links'; then
		echo "Do you really want to overwrite your existing $1? [y|n] \c"
		read confirm
		if [ $confirm = "y" ]; then
			echo "Removing existing $1 ..."
			rm ~/$1
			echo "Linking $1 ..."
			ln -s ~/.dotfiles/$1 ~/$1
		else
			echo "SKIP: Not overwriting $1, skipping ..."
		fi
	else
		echo "SKIP: Existing $1 found, skipping ..."
	fi
}

cd

# enforce requirements
if ! type zsh > /dev/null 2> /dev/null; then
	echo "ERROR: Please install ZSH before executing this script ..."
	exit 1
elif ! [ $SHELL = '/bin/zsh' ]; then
	echo "ERROR: Please set ZSH as default shell before executing this script ..."
	exit 1
fi

if ! type curl > /dev/null 2> /dev/null; then
	echo "ERROR: Please install CURL before executing this script ..."
	exit 1
fi

if ! type git > /dev/null 2> /dev/null; then
	echo "ERROR: Please install GIT before executing this script ..."
	exit 1
fi

# install oh-my-zsh if not already installed
if ! [ -d ~/.oh-my-zsh ]; then
	echo "Installing OH-MY-ZSH ..."
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
else
	echo "SKIP: OH-MY-ZSH already installed, skipping ..."
fi

# install homebrew if requested, if on macOS and if not already installed
if input_contains '--brew' && type brew > /dev/null 2> /dev/null; then
	echo "ERROR: HOMEBREW already installed ..."
	exit 1
elif input_contains '--brew' && ! $(uname) == "Darwin"; then
	echo "ERROR: HOMEBREW cannot be installed on any other system than macOS ..."
	exit 1
elif input_contains '--brew' && $(uname) == "Darwin" && ! type brew > /dev/null 2> /dev/null; then
	echo "Installing HOMEBREW ..."
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# install vim if on macOS or a Debian based Linux, ask for manual installation if not
if ! type vim > /dev/null 2> /dev/null && $(uname) == "Darwin"; then
	brew install vim
elif ! type vim > /dev/null 2> /dev/null && [ -f /etc/debian_version ]; then
	sudo apt install vim
elif ! type vim > /dev/null 2> /dev/null; then
	echo "ERROR: Unsupported OS for automatic VIM installation ..."
	echo "=====> Please install VIM and restart the script ..."
	exit 1
fi

# install vim-plug if not already installed
if ! [ -f ~/.vim/autoload/plug.vim ]; then
	echo "Installing VIM-PLUG ..."
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
	echo "SKIP: VIM-PLUG already installed, skipping ..."
fi

# install powerlevel10k if not already installed
if ! [ -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]; then
	echo "Installing P10K ..."
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
else
	echo "SKIP: P10K already installed, skipping ..."
fi

# install zsh-syntax-highlighting if not already installed
if ! [ -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
	echo "Installing ZSH-SYNTAX-HIGHLIGHTING ..."
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
else
	echo "SKIP: ZSH-SYNTAX-HIGHLIGHTING already installed, skipping ..."
fi

# add symlinks if they do not exist already and overwrite them if requested
link ".zshrc"
link ".zprofile"
link ".zshaliases"
link ".vimrc"
link ".p10k.zsh"
link ".nethackrc"
