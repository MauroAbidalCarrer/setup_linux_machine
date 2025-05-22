#!/bin/bash
sudo apt-get install -y git curl wget zsh 

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "exec zsh" >> ~/.bashrc

mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm ~/miniconda3/miniconda.sh
source ~/miniconda3/bin/activate
conda init --all

#zshrc
echo "cd ~/" >> ~/.zshrc

# Prevent tmux from starting automatically
touch ~/.no_auto_tmux

# Git
mkdir -p ~/repos
git config --global user.email "mauroabidal@yahoo.fr"
git config --global user.name  "Mauro Abidal Carrer"
mkdir -p ~/.ssh
ssh-keygen -F github.com > /dev/null || ssh-keyscan github.com >> ~/.ssh/known_hosts

# Setup aliases
wget https://raw.githubusercontent.com/MauroAbidalCarrer/setup_linux_machine/refs/heads/master/aliases.zsh -O /root/.oh-my-zsh/custom/aliases.zsh

