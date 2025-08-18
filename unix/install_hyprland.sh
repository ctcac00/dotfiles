#!/usr/bin/env sh

# Function to print headers
print_header() {
  echo "
======================================================================
=== $1
======================================================================
"
}

# --- Initial Checks ---
if [ -f /etc/os-release ]; then
  . /etc/os-release
  if [ "$ID" != "arch" ]; then
    echo "Error: This script is intended for Arch Linux only." >&2
    exit 1
  fi
else
  echo "Error: /etc/os-release file not found. Cannot determine Linux distribution." >&2
  exit 1
fi

expected_dir="unix"
current_dir=$(basename "$PWD")
if [ "$current_dir" != "$expected_dir" ]; then
  echo "Error: This script must be run from the '$expected_dir' directory (current: '$current_dir')." >&2
  exit 1
fi

# --- System Preparation ---
print_header "System Preparation"
echo "Performing full system update and refreshing keyring..."
sudo pacman -Sy --noconfirm archlinux-keyring
sudo pacman -Syu --noconfirm

# --- Chaotic-AUR Setup ---
print_header "Chaotic-AUR Setup"
echo "Setting up the Chaotic-AUR repository..."
echo "--> Receiving and signing the primary key..."
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB
echo "--> Installing Chaotic-AUR keyring and mirrorlist..."
sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
echo "--> Appending Chaotic-AUR to pacman.conf..."
if ! grep -q "^\[chaotic-aur\]" /etc/pacman.conf; then
  (
    echo ''
    echo '[chaotic-aur]'
    echo 'Include = /etc/pacman.d/chaotic-mirrorlist'
  ) | sudo tee -a /etc/pacman.conf
else
  echo "Chaotic-AUR repository already configured in /etc/pacman.conf."
fi
echo "--> Syncing new repository..."
sudo pacman -Syu --noconfirm

# --- AUR Helper (paru) ---
print_header "AUR Helper (paru)"
if ! command -v paru >/dev/null 2>&1; then
  echo "paru not found, installing..."
  sudo pacman -S --noconfirm --needed base-devel git

  cd /tmp || exit
  echo "Cloning paru repository..."
  git clone https://aur.archlinux.org/paru.git
  cd paru || exit

  echo "Building and installing paru..."
  makepkg -si --noconfirm
  cd /tmp && rm -rf paru
  echo "paru installation complete."
else
  echo "paru is already installed."
fi

# --- Package Installation ---
print_header "Package Installation"
echo "Installing packages from official repositories and AUR..."

echo "--> Installing Core & CLI Tools..."
paru -Sy --noconfirm \
  vim \
  git \
  curl \
  zsh \
  tmux \
  wget \
  gnupg \
  eza \
  bat \
  ripgrep \
  fd \
  fzf \
  neovim \
  unzip \
  lazygit \
  imagemagick \
  lua \
  luarocks \
  openssh \
  github-cli \
  btop \
  fastfetch \
  aws-cli \
  man-db \
  man-pages \
  rsync \
  stow \
  zoxide \
  asdf-vm \
  ncdu \
  udiskie \
  atuin \
  net-tools \
  httpie \
  curlie

echo "--> Installing Hyprland & Wayland Ecosystem..."
paru -Sy --noconfirm \
  hyprland \
  waybar \
  wlogout \
  swww \
  rofi-wayland \
  hyprlock \
  hypridle \
  xdg-desktop-portal-hyprland \
  swaync \
  kitty \
  superfile \
  clipse \
  wl-clip-persist \
  gvfs \
  thunar \
  thunar-volman \
  thunar-archive-plugin \
  hyprshot \
  wayvnc \
  tumbler \
  hyprshade \
  wl-clipboard \
  waypaper \
  hyprpolkitagent \
  uwsm \
  yazi \
  wireplumber \
  pipewire \
  qt5-wayland \
  qt6-wayland \
  sddm \
  maplemono-nf-unhinted \
  bibata-cursor-git \
  blueman \
  gnome-keyring \
  xdg-desktop-portal-gtk \
  hyprcursor \
  unzip \
  xarchiver \
  exiftool

echo "--> Installing GUI Applications..."
paru -Sy --noconfirm \
  slack-desktop-wayland \
  spotify \
  zoom \
  obs-studio \
  brave \
  vlc \
  speedcrunch \
  pdfmerger \
  solaar

echo "--> Installing Virtualization Tools..."
paru -Sy --noconfirm \
  virsh \
  virt-viewer \
  virt-manager \
  qemu-base \
  qemu-desktop

echo "--> Installing Theming & Appearance Tools..."
paru -Sy --noconfirm \
  qt5ct \
  qt6ct \
  nwg-look

echo "--> Installing System Tools & Drivers..."
paru -Sy --noconfirm \
  grub-btrfs \
  libnewt

# --- Additional Configurations ---
print_header "Additional Configurations"

echo "--> Installing amix's Ultimate vimrc..."
if [ ! -d "$HOME/.vim_runtime" ]; then
  git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
  sh ~/.vim_runtime/install_awesome_vimrc.sh
else
  echo "amix/vimrc already installed, skipping."
fi

echo "--> Installing romkatv's zsh-defer..."
if [ ! -d "$HOME/zsh-defer" ]; then
  git clone https://github.com/romkatv/zsh-defer.git ~/zsh-defer
else
  echo "romkatv/zsh-defer already installed, skipping."
fi

echo "--> Installing virtualenv switcher plugin for zsh.."
if [ ! -d "$HOME/zsh-defer" ]; then
  git clone "https://github.com/MichaelAquilina/zsh-autoswitch-virtualenv.git" "autoswitch_virtualenv"
else
  echo "Virtualenv switcher already installed, skipping."
fi

# --- ASDF Version Manager Setup ---
print_header "ASDF Version Manager Setup"

asdf plugin add nodejs || true
asdf plugin add python || true
asdf plugin add golang || true
asdf plugin add rust || true

asdf install nodejs latest
asdf install python latest
asdf install golang latest
asdf install rust latest

asdf global nodejs latest
asdf global python latest
asdf global golang latest
asdf global rust latest

# --- Dotfiles Symlinking ---
print_header "Dotfiles Symlinking"
echo "Symlinking dotfiles using stow..."
stow --adopt -t "$HOME"/.config .config
stow --adopt -t "$HOME" home

# --- Finalization ---
print_header "Installation Complete"
echo "Setup complete. Starting Zsh..."
exec zsh
