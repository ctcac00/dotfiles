#!/usr/bin/env sh

if [ -f /etc/os-release ]; then
  . /etc/os-release
  if [ "$ID" = "ubuntu" ]; then
    echo "Running Ubuntu"
    sudo mkdir -p /etc/apt/keyrings
    sudo apt install -y vim git curl zsh tmux wget gpg
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt update
    sudo apt install -y eza bat
  elif [ "$ID" = "arch" ]; then
    echo "Running Arch Linux"
    sudo pacman -Syu vim git curl zsh tmux wget gnupg eza bat
  else
    echo "Unknown Linux distribution"
  fi
else
  echo "/etc/os-release file not found"
fi

# Check and install amix/vimrc if not already installed
if [ ! -d "$HOME/.vim_runtime" ]; then
  git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
  sh ~/.vim_runtime/install_awesome_vimrc.sh
else
  echo "amix/vimrc already installed"
fi

# Check and install zoxide if not already installed
if ! command -v zoxide &>/dev/null; then
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
else
  echo "zoxide already installed"
fi

# Check and install atuin if not already installed
if ! command -v atuin &>/dev/null; then
  curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
else
  echo "atuin already installed"
fi

# Check and install romkatv/zsh-defer if not already installed
if [ ! -d "$HOME/zsh-defer" ]; then
  git clone https://github.com/romkatv/zsh-defer.git ~/zsh-defer
else
  echo "romkatv/zsh-defer already installed"
fi

# Check and install asdf-vm if not already installed
if [ ! -d "$HOME/.asdf" ]; then
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1
  . "$HOME/.asdf/asdf.sh"
else
  echo "asdf-vm already installed"
  . "$HOME/.asdf/asdf.sh"
fi

# Install asdf plugins and versions
asdf plugin add nodejs || true
asdf plugin add python || true
asdf plugin add golang || true
asdf plugin add rust || true

asdf install nodejs 22.12.0
asdf install python 3.13.1
asdf install golang 1.23.4
asdf install rust 1.83.0

cp -r .config ~
cp .p10k.zsh ~
cp .zshrc ~
cp .zshenv ~

exec zsh
