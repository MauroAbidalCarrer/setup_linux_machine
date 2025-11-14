# To place to ~/.oh-my-zsh/custom/aliases.zsh
update_aliases() {
  wget -q -O ~/.oh-my-zsh/custom/aliases.zsh https://raw.githubusercontent.com/MauroAbidalCarrer/setup_linux_machine/refs/heads/master/aliases.zsh
  wget -q -O ~/.update_ssh_config.py https://raw.githubusercontent.com/MauroAbidalCarrer/setup_linux_machine/refs/heads/master/update_ssh_config.py
}

# Git
alias f='git fetch -q $(git remote | head -n 1)'
alias pu='git pull -q $(git remote | head -n 1) $(git branch --show-current)'
alias sw="git switch -q"
alias swt="git switch -q --track"
alias a="git add"
alias s='git status -s'
alias am='git commit -aqm'
alias m='git commit -qm'
alias p='git push -q $(git remote | head -n 1) HEAD'
alias pf='git push --force-with-lease -q $(git remote | head -n 1) HEAD'
alias r='git restore'
alias rename_branch='git branch -m'
alias prune_remote_branches='git remote prune $(git remote | head -n 1)'
amp() { # git add commit and push
  if [ -z "$1" ]; then
    echo "Usage: amp \"commit message\""
    return 1
  fi
  git commit -aqm "$1" && git push -q "$(git remote | head -n 1)" HEAD
}
swp() { # switch and pull
  if [ -z "$1" ]; then
    echo "Usage: amp \"commit message\""
    return 1
  fi
  git switch -q "$1" && git pull -q "$(git remote | head -n 1)" HEAD
}
match_pr() {
  # Get the current branch before switching
  local current_branch
  current_branch=$(git branch --show-current)

  if [ -z "$current_branch" ]; then
    echo "Not on a branch."
    return 1
  fi

  if [ "$current_branch" = "main" ]; then
    echo "Already on main branch."
    return 1
  fi

  # Switch to main and pull latest
  swp main || return 1

  # Delete the old branch locally
  git branch -D "$current_branch" || return 1

  # Prune remote branches
  prune_remote_branches

  # If an argument is provided, create and switch to the new branch
  if [ -n "$1" ]; then
    git switch -c "$1"
  fi
}
clone_repo() {

  local repo_url="$1"
  local branch="$2"

  if [ -z "$repo_url" ]; then
    echo "Usage: clone_repo <repo_ssh_url> [branch_name]"
    return 1
  fi

  # Extract repo name and hostname (second-level)
  local repo_name
  repo_name=$(basename -s .git "$repo_url")
  local remote_host
  remote_host=$(echo "$repo_url" | sed -n 's/.*@\([^:]*\):.*/\1/p' | awk -F. '{print $(NF-1)}')

  # Clone with or without branch
  if [ -n "$branch" ]; then
    git clone -q -b "$branch" "$repo_url"
  else
    git clone -q "$repo_url"
  fi

  # Proceed only if clone succeeded
  if [ ! -d "$repo_name" ]; then
    echo "Cloning failed or repo not found."
    return 1
  fi

  cd "$repo_name" || return

  # Rename origin
  git remote rename origin "$remote_host"

  if ! command -v uv >/dev/null 2>&1; then
    echo "uv not available"
  elif [ -f conda-env.yaml ]; then
    uv sync
  fi
}
clone_working_repo() {
  if [ -z "$WORKING_REPO" ]; then
    echo "WORKING_REPO environment variable is not set."
    return 1
  fi

  if [ -n "$WORKING_REPO_BRANCH" ]; then
    clone_repo "$WORKING_REPO" "$WORKING_REPO_BRANCH"
  else
    clone_repo "$WORKING_REPO"
  fi
}


# Conda
recreate_conda_env(){ 
conda deactivate && conda env remove -yn "$1"; conda env create -n "$1" -f "$2" && conda activate "$1"; 
}

# Others
alias install='sudo apt-get update && sudo apt-get install'
alias l1='ls -1'
alias unpack='sudo dpkg -i'
alias search="conda search"
alias scp_kaggle_credentials='scp ~/.kaggle/kaggle.json root@vast:~/.kaggle'
alias scp='scp -q'
alias nvidia_ps='sudo fuser -v /dev/nvidia*'
alias vast_update='python3 ~/.update_ssh_config.py'
alias watch_m='watch -n 1 free -m'
alias watch_n='nvidia-smi --loop'
