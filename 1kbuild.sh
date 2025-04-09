#!/bin/bash

if [ -z "$1" ]; then
	echo "invalid param, must be mac or linux"
	exit 0
fi

# [[ my_zshrc ]]
echo "# [[ my_zshrc ]]" >~/.my_zshrc

# [[ homebrew ]]
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
if [[ "$1" == "linux" ]]; then
	sudo apt-get install build-essential
	brew_dir="/home/linuxbrew/.linuxbrew"
fi

# [[ zsh ]]
brew install zsh
source ~/.zshrc

zsh ./1kbuild_zsh.sh $brew_dir
