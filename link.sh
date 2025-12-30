#!/usr/bin/env bash

set -e

echo "=== Bootstrapping system ==="

sudo pacman -S --needed git

echo "Installing packages..."
sudo pacman -S --needed - <pkglist.txt

echo "Linking configs..."
ln -sf ~/dotfiles/zsh/zshrc ~/.zshrc
ln -sf ~/dotfiles/nvim ~/.config/nvim
ln -sf ~/dotfiles/hypr ~/.config/hypr
sudo ln -sf ~/dotfiles/keyd/default.conf /etc/keyd/default.conf

echo "Enabling services..."
sudo systemctl enable keyd --now

echo "Done. Log out and back in."
