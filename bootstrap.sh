#!/usr/bin/env bash

### unfortunately this one is only compatible with arch linux, so if linked to another system, cheryy pick the lines that are suitable most of them should work except from commands with pacman

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
ln -sf ~/dotfiles/tmux/tmux.conf ~/.config/tmux/.tmux.conf

echo "linking wallpaper files"
ln -s ~/dotfiles/wpper ~/.config

echo "linking p10k config"
ln -s ~/dotfiles/p10k/p10k.zsh ~/.p10k.zsh

echo "linking secrets so zsh can call environment"
ln -s ~/dotfiles/zsh/secrets.zsh ~/.config/zsh/secrets.zsh

echo "Enabling services..."
sudo systemctl enable keyd --now

cd

echo "installing ohmyzsh"
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "installing syntax highlight"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

echo "installing auto suggestion"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "installing p10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
echo "Done. Log out and back in."
