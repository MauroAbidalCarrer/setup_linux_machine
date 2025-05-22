#!/bin/bash

sudo apt-get update
sudo apt-get install -y git curl wget zsh 

#setup git
git config --global user.email "mauroabida@yahoo.fr"
git config --global user.name "Mauro Abidal Carrer"
git config --global init.defaultBranch main

#setting up vim
sudo apt-get install vim
echo "syntax on" >>  ~/.vimrc
echo "set nu"    >>  ~/.vimrc
echo "set mouse=a">> ~/.vimrc


#install VScode
sudo apt-get install -y gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install -y apt-transport-https
sudo apt update
sudo apt install -y code # or code-insiders
#install extensions
code --install-extension ms-python.python
code --install-extension mhutchie.git-graph
code --install-extension mehyaa.workspace-storage-cleanup

#installing oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


# install python, pytorch
sudo apt-get install -y python3
sudo apt-get install -y pip

# Setup aliases
wget https://raw.githubusercontent.com/MauroAbidalCarrer/setup_linux_machine/refs/heads/master/aliases.zsh -O $ZSH_CUSTOM/aliases.zsh