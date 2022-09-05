#!/bin/bash

sudo git clone https://aur.archlinux.org/yay-git.git
sudo chown -R dani:dani ./yay-git
cd yay-git
makepkg -si
cd ..
rm -rf yay-git
yay -S brave, visual-studio-code-bin, spotify, minecraft-launcher, gnome-terminal-transparency, hplip, hplip-plugin
sudo pacman -S discord, cups, avahi, steam


ls
