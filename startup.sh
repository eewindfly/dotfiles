#!/bin/bash
#############################################################################
# The script is used to startup a developing environment when reinstall a
# computer. For now is OSX only
#############################################################################
echo "Make sure Xcode has been installed, and manually open once to install additional components."
sleep 10

export WORKSPACE=~/workspace
mkdir -p $WORKSPACE

#### Install Homebrew
#### Homebrew however is already installed before retrieving the script
if ! type "brew" > /dev/null; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

#### Install Git and Wget
brew install wget curl git vim tmux cmake pkg-config htop zsh

# Setup dotfiles
ln -s $(pwd)/.zshrc ~/.zshrc
ln -s $(pwd)/.gitconfig ~/.gitconfig

#### Install Oh-My-Zsh && Change default shell to zsh
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
chsh -s $(which zsh)

### (OPTIONAL) install iterm2
#brew cask install iterm2
#echo "Please manually change iterm2->preferences->profiles->colors to 'solarized dark'"
