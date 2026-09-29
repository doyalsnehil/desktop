#!/bin/bash
set -e

echo -e "\n\033[1;36m[1/2]\033[0m Installing Neovim and all fundamental dependencies..."
sudo pacman -Sy --noconfirm --needed neovim npm python-pip rustup go unzip curl wget gzip tar ripgrep fd fzf wl-clipboard

echo -e "\n\033[1;36m[2/2]\033[0m Setting up Rust environment (if not already set)..."
rustup default stable || true

echo -e "\n\033[1;32mSUCCESS!\033[0m Neovim and all underlying language servers (LSP/Mason) dependencies are ready!"
