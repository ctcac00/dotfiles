#!/usr/bin/env sh

if [ -f /etc/os-release ]; then
  . /etc/os-release
  if [ "$ID" = "ubuntu" ]; then
    echo "Running Ubuntu"
    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt update
    sudo apt install -y vim git curl zsh tmux wget gpg eza
  elif [ "$ID" = "arch" ]; then
    echo "Running Arch Linux"
    sudo pacman -Syu vim git curl zsh tmux wget gnupg eza
  else
    echo "Unknown Linux distribution"
  fi
else
  echo "/etc/os-release file not found"
fi

git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh

asdf plugin add nodejs
asdf plugin add python
asdf plugin add golang
asdf plugin add rust

asdf install nodejs 22.12.0
asdf install python 3.13.1
asdf install golang 1.23.4
asdf install rust 1.83.0

git clone https://github.com/romkatv/zsh-defer.git ~/zsh-defer
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1

cp -r .config ~
cp .* ~

exec zsh
