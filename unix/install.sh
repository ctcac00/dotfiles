#!/usr/bin/env sh

# Exit immediately if a command exits with a non-zero status.
set -e
# Treat unset variables as an error.
set -u

# --- Helper Functions for Logging ---
info() {
  echo "INFO: $1"
}

success() {
  echo "SUCCESS: $1"
}

error() {
  echo "ERROR: $1" >&2
  exit 1
}

# --- Installation Functions ---

install_packages() {
  info "Identifying OS and installing base packages..."
  if [ -f /etc/os-release ]; then
    . /etc/os-release
  else
    error "/etc/os-release file not found. Cannot determine OS."
  fi

  case "${ID:-}" in
  ubuntu)
    info "Detected Ubuntu. Installing packages..."
    sudo apt update
    sudo mkdir -p /etc/apt/keyrings
    sudo apt install -y vim git curl zsh tmux wget gpg ripgrep fd-find fzf bat neovim unzip lazygit imagemagick lua luarocks openssh-client btop fastfetch awscli rsync stow

    info "Installing eza..."
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt update
    sudo apt install -y eza
    success "Base packages for Ubuntu installed."
    ;;
  arch)
    info "Detected Arch Linux. Installing packages..."
    sudo pacman -Syu --noconfirm
    sudo pacman -S --noconfirm vim git curl zsh tmux wget gnupg eza bat ripgrep fd fzf neovim unzip lazygit imagemagick lua luarocks openssh github-cli btop fastfetch aws-cli man-db man-pages rsync stow
    success "Base packages for Arch Linux installed."
    ;;
  *)
    error "Unsupported Linux distribution: ${ID:-unknown}"
    ;;
  esac
}

install_amix_vimrc() {
  info "Checking for amix/vimrc..."
  if [ ! -d "$HOME/.vim_runtime" ]; then
    info "Installing amix/vimrc..."
    git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
    sh ~/.vim_runtime/install_awesome_vimrc.sh
    success "amix/vimrc installed."
  else
    info "amix/vimrc already installed."
  fi
}

install_zoxide() {
  info "Checking for zoxide..."
  if ! command -v zoxide >/dev/null 2>&1; then
    info "Installing zoxide..."
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
    success "zoxide installed."
  else
    info "zoxide already installed."
  fi
}

install_atuin() {
  info "Checking for atuin..."
  if ! command -v atuin >/dev/null 2>&1; then
    info "Installing atuin..."
    curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
    success "atuin installed."
  else
    info "atuin already installed."
  fi
}

install_zsh_defer() {
  info "Checking for romkatv/zsh-defer..."
  if [ ! -d "$HOME/zsh-defer" ]; then
    info "Installing romkatv/zsh-defer..."
    git clone https://github.com/romkatv/zsh-defer.git ~/.zsh-defer
    success "romkatv/zsh-defer installed."
  else
    info "romkatv/zsh-defer already installed. Skipping."
  fi
}

install_asdf() {
  info "Checking for asdf-vm..."
  if [ ! -d "$HOME/.asdf" ]; then
    info "Installing asdf-vm..."
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1
    success "asdf-vm installed."
  else
    info "asdf-vm already installed."
  fi

  # shellcheck source=/dev/null
  . "$HOME/.asdf/asdf.sh"

  info "Installing asdf plugins..."
  asdf plugin add nodejs || true
  asdf plugin add python || true
  asdf plugin add golang || true
  asdf plugin add rust || true
  success "asdf plugins added."

  info "Installing asdf tool versions..."
  asdf install nodejs 22.12.0
  asdf install python 3.13.1
  asdf install golang 1.23.4
  asdf install rust 1.83.0
  success "asdf tool versions installed."

  info "Setting global asdf tool versions..."
  asdf global nodejs 22.12.0
  asdf global python 3.13.1
  asdf global golang 1.23.4
  asdf global rust 1.83.0
  success "Global asdf tool versions set."
}

stow_dotfiles() {
  info "Stowing dotfiles..."
  stow --adopt -t "$HOME"/.config .config
  stow --adopt -t "$HOME" home
  success "Dotfiles stowed."
}

main() {
  # Check if the script is run from the correct directory.
  expected_dir="unix"
  current_dir=$(basename "$PWD")
  if [ "$current_dir" != "$expected_dir" ]; then
    error "This script must be run from the '$expected_dir' directory (current: '$current_dir')."
  fi

  install_packages
  install_amix_vimrc
  install_zoxide
  install_atuin
  install_zsh_defer
  install_asdf
  stow_dotfiles

  success "All installations and configurations are complete!"
  info "To apply changes, please start a new zsh session."
}

main "$@"

