# Linux Dev env setup

## install vim-awesome

```bash
sudo apt install -y vim
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh
```

## Install tmux

```bash
sudo apt install tmux
```

## Restore dotfiles

```bash
cd unix
sh install.sh
```

## Install docker

```bash
sudo apt install -y docker docker-compose
sudo systemctl start docker
sudo systemctl enable docker
sudo gpasswd -a $USER docker

```

## Login user

```bash
su - $USER
```

## Install FiraCode Nerd Font

```bash
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Fira Code Regular Nerd Font Complete Mono.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete%20Mono.ttf
```

