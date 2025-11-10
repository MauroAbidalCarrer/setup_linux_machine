#!/bin/bash
sudo apt-get install -y git curl wget zsh ncdu tree

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "exec zsh" >> ~/.bashrc

# uv
curl -LsSf https://astral.sh/uv/install.sh | sh
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

# Kaggle
mkdir ~/.kaggle
