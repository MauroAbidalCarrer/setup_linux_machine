#!/bin/bash

sudo apt-get update
sudo apt-get install -y git curl wget zsh 

#setup git
git config --global user.email "mauroabida@yahoo.fr"
git config --global user.name "Mauro Abidal Carrer"
git config --global init.defaultBranch main

#install docker 
# sudo apt-get install -y ca-certificates gnupg
# sudo install -m 0755 -d /etc/apt/keyrings
# curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
# sudo chmod a+r /etc/apt/keyrings/docker.gpg
# echo \
#   "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
#   "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# sudo docker run hello-world

#setting up shs key for github
ssh-keygen -t ed25519 -C "your_email@example.com"
eval "$(ssh-agent -s)"
echo "Please copy the key: "
cat ~/.ssh/id_ed25519.pub
echo "\nAdd it to your github account(Settings->SSSH and GPG keys->new SSH key)"

#setting up vim
sudo apt-get install vim
echo "syntax on" >>  ~/.vimrc
echo "set nu"    >>  ~/.vimrc
echo "set mouse=a">> ~/.vimrc


#Set up zshrc
echo "alias update='sudo apt-get update'" >> ~/.zshrc
echo "alias install='sudo apt-get update && sudo apt-get install'" >> ~/.zshrc
echo "alias s='git status -s'" >> ~/.zshrc
echo "alias am='git commit -aqm'" >> ~/.zshrc
echo "alias m='git commit -qm'" >> ~/.zshrc
echo "export PATH=$PATH:~/.local/bin" >> ~/.zshrc


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
