#!/usr/bin/env sh

curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh

git clone https://github.com/romkatv/zsh-defer.git ~/zsh-defer
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1

cp -r .config ~
cp .* ~

exec zsh
