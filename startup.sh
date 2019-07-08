#!/bin/bash
#############################################################################
# The script is used to startup a developing environment when reinstall a
# computer. For now is OSX only
#############################################################################
echo "Make sure Xcode is installed, and manually opened once to install additional components which Macvim needs."
sleep 10

export WORKSPACE=~/workspace
mkdir -p $WORKSPACE

#### Install Homebrew
#### Homebrew however is already installed before retrieving the script
if ! type "brew" > /dev/null; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

#### Install Git and Wget
brew install wget git tmux cmake pkg-config htop ag

#### install python3
brew install python3

# Setup dotfiles
ln -s $(pwd)/.zshrc ~/.zshrc
ln -s $(pwd)/.gitconfig ~/.gitconfig
ln -s $(pwd)/.vimrc ~/.vimrc

#### Install Oh-My-Zsh && Change default shell to zsh
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
chsh -s $(which zsh)

#### Install Vundle
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#### Setup Vim
brew cask install macvim
vim -c 'PluginInstall' -c 'qa!'
### Setup YouCompleteMe
cd ~/.vim/bundle/YouCompleteMe
python3 ./install.py --clang-completer

### (OPTIONAL) install iterm2
#brew cask install iterm2
#echo "Please manually change iterm2->preferences->profiles->colors to 'solarized dark'"
