#!/bin/bash
#############################################################################
# The script is used to startup a developing environment when reinstall a
# computer. For now is OSX only
#############################################################################
export WORKSPACE=~/workspace

#### Install Homebrew
#### Homebrew however is already installed before retrieving the script
if ! type "brew" > /dev/null; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

#### Install Git and Wget
brew install wget git tmux cmake mercurial pkg-config htop ag

# Retrieve dotfiles
mkdir -p $WORKSPACE

# Setup dotfiles
ln -s $(pwd)/.tmux.conf ~/.tmux.conf
ln -s $(pwd)/.zshrc ~/.zshrc
ln -s $(pwd)/.gitconfig ~/.gitconfig
ln -s $(pwd)/.vimrc ~/.vimrc


#### Change default shell to zsh
chsh -s /bin/zsh

#### Install Oh-My-Zsh
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

#### Install Vundle
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# before installing vim, fix it on new sierra platform
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
#### Setup Vim
brew install macvim --with-override-system-vim
brew linkapps
vim -c 'BundleInstall' -c 'qa!'
vim -c 'PluginInstall' -c 'qa!'
### Setup YouCompleteMe
cd ~/.vim/bundle/YouCompleteMe
./install.sh --clang-completer

### (OPTIONAL) install iterm2
brew cask install iterm2
echo "Please manually change iterm2->preferences->profiles->colors to 'solarized dark'"
