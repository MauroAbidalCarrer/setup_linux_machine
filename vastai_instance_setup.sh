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

#aliases
echo "alias update='sudo apt-get update'" >> ~/.zshrc
echo "alias install='sudo apt-get update && sudo apt-get install'" >> ~/.zshrc
echo "alias s='git status -s'" >> ~/.zshrc
echo "alias am='git commit -amq'" >> ~/.zshrc
echo "alias m='git commit -mq'" >> ~/.zshrc
echo "alias recreate_conda_env='function _recreate_conda_env(){ conda deactivate && conda env remove -yn \"\$1\"; conda env create -n \"\$1\" -f \"\$2\" && conda activate \"\$1\"; }; _recreate_conda_env'" >> ~/.zshrc

# Prevent tmux from starting automatically
touch ~/.no_auto_tmux
