#!/bin/bash

sudo apt-get update
sudo apt-get install -y git curl wget zsh 

#setup git
git config --global user.email "mauroabida@yahoo.fr"
git config --global user.name "Mauro Abidal Carrer"

#install docker 
sudo apt-get install -y ca-certificates gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo docker run hello-world

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


#alias
echo "alias update='sudo apt-get update'" >> ~/.zshrc
echo "alias install='sudo apt-get update && sudo apt-get install'" >> ~/.zshrc
echo "alias status='git status'" >> ~/.zshrc
echo "alias log='git log --all --graph --decorate --oneline --simplify-by-decoration'" >> ~/.zshrc
echo "alias commit='git commit -am'" >> ~/.zshrc


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

#install node and nestJS
sudo apt-get install -y npm
sudo npm install npm@latest -g
sudo npm i -g @nestjs/cli
echo "alias nest='node /usr/local/lib/node_modules/@nestjs/cli/bin/nest.js'"

#installing oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"