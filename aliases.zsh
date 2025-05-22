# Git
alias a="git add"
alias s='git status -s'
alias am='git commit -aqm'
alias m='git commit -qm'
alias p='git push -q $(git remote | head -n 1) HEAD'
amp() {
  if [ -z "$1" ]; then
    echo "Usage: amp \"commit message\""
    return 1
  fi
  git commit -aqm "$1" && git push -q "$(git remote | head -n 1)" HEAD
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
    git clone -b "$branch" "$repo_url"
  else
    git clone "$repo_url"
  fi

  # Proceed only if clone succeeded
  if [ ! -d "$repo_name" ]; then
    echo "Cloning failed or repo not found."
    return 1
  fi

  cd "$repo_name" || return

  # Rename origin
  git remote rename origin "$remote_host"

  # Conda env creation
  if [ -f "conda-env.yaml" ]; then
    if command -v conda >/dev/null 2>&1; then
      conda env create -yf conda-env.yaml
    else
      echo "conda not found in PATH. Skipping environment creation."
    fi
  fi
}

# Conda
alias recreate_conda_env='function _recreate_conda_env(){ conda deactivate && conda env remove -yn \"\$1\"; conda env create -n \"\$1\" -f \"\$2\" && conda activate \"\$1\"; }; _recreate_conda_env'

# Others
alias install='sudo apt-get update && sudo apt-get install'
