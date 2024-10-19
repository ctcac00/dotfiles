#!/usr/bin/env sh

apt update
apt install curl git zoxide

curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh

git clone https://github.com/romkatv/zsh-defer.git ~/zsh-defer
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1

cd ~/dotfiles/unix

cp -r .config/. ~/.config
cp .tmux* ~
cp -r z4h/. ~
