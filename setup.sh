#!/bin/bash

sudo apt-get update
sudo apt-get install -y git curl wget zsh 

#install docker 
sudo apt-get install -y ca-certificates gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo docker run hello-world

#installing oh my zsh
echo "yes" | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#setting up shs key for github
ssh-keygen -t ed25519 -C "your_email@example.com"
eval "$(ssh-agent -s)"
echo "Please copy the key: "
cat ~/.ssh/id_ed25519.pub
ehco "\nAdd it to your github account(Settings->SSSH and GPG keys->new SSH key)

#setting up vim
sudo apt-get install vim
echo "syntax on" >>  ~/.vimrc
echo "set nu"    >>  ~/.vimrc
echo "set mouse=a">> ~/.vimrc
