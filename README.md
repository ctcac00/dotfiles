# Linux Dev env setup

## Install tools and dotfiles

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

