brew_dir=$1

# [[ gcc make htop git ]]
brew install gcc make htop git

# [[ python3 ]]
if [[ "$1" == "linux" ]]; then
	sudo apt-get remove python3
	brew install python3
fi

# [[ golang ]]
brew install golang

# [[ autojump ]]
brew install autojump
echo -e "\n# [[ autojump ]]" >>~/.my_zshrc
echo "[ -f $brew_dir/etc/profile.d/autojump.sh ] && . $brew_dir/etc/profile.d/autojump.sh" >>~/.my_zshrc
source ~/.my_zshrc

# [[ zsh-syntax-highlighting ]]
brew install zsh-syntax-highlighting
echo -e "\n# [[ zsh-syntax-highlighting ]]" >>~/.my_zshrc
echo "source $brew_dir/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >>~/.my_zshrc

# [[ zsh-autosuggestions ]]
brew install zsh-autosuggestions
echo -e "\n# [[ zsh-autosuggestions ]]" >>~/.my_zshrc
echo "source $brew_dir/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >>~/.my_zshrc

# [[ nvm ]]
brew install nvm
if [ ! -d ~/.nvm ]; then
	mkdir ~/.nvm
fi
echo -e "\n# [[ nvm ]]" >>~/.my_zshrc
cat <<EOF >>~/.my_zshrc
export NVM_DIR="$HOME/.nvm"
[ -s "$brew_dir/opt/nvm/nvm.sh" ] && \. "$brew_dir/opt/nvm/nvm.sh"
[ -s "$brew_dir/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$brew_dir/opt/nvm/etc/bash_completion.d/nvm"
EOF
source ~/.my_zshrc
nvm install 23
nvm use 23

# [[ rustup ]]
brew install rustup
echo -e "\n# [[ rustup ]]" >>~/.my_zshrc
cat <<EOF >>~/.my_zshrc
export PATH="$brew_dir/opt/rustup/bin:$PATH"
[ -f $brew_dir/etc/profile.d/autojump.sh ] && . $brew_dir/etc/profile.d/autojump.sh
EOF
source ~/.my_zshrc
rustup toolchain install stable

# [[ neovim ]]
brew install lazygit zoxide ripgrep fd yarn unzip neovim

# [[ tree-sitter ]]
brew install tree-sitter
yarn global add tree-sitter-cli
# cargo install tree-sitter-cli

# [[ nvimdots ]]
if command -v curl >/dev/null 2>&1; then
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/ayamir/nvimdots/HEAD/scripts/install.sh)"
else
	bash -c "$(wget -O- https://raw.githubusercontent.com/ayamir/nvimdots/HEAD/scripts/install.sh)"
fi
cd ~/.config/nvim
git remote add my https://github.com/marin-man/nvimdots.git
git fetch my main
git reset --hard my/main

echo "source ~/.my_zshrc" >>~/.zshrc
source ~/.zshrc
