#!/bin/bash

sudo git clone https://aur.archlinux.org/yay-git.git
sudo chown -R $USER:$USER ./yay-git
cd yay-git
makepkg -si
cd ..
sed -zi 's/#\[multilib\]\n#/\[multilib\]\n/' /etc/pacman.conf
yay -Syu brave visual-studio-code-bin spotify minecraft-launcher gnome-terminal-transparency hplip hplip-plugin discord cups avahi steam nss-mdns
sudo systemctl enable cups.service
sudo systemctl start cups.service
sudo systemctl enable avahi-daemon.searvice
sudo sed -i 's/hosts: mymachines resolve/hosts: mymachines mdns_minimal \[NOTFOUND=return\] resolve /' /etc/nsswitch.conf
sudo systemctl restart cups.service
cp pictures/user.jpg  ~/Pictures/user.jpg
cp pictures/wallpaper.jpg ~/Pictures/wallpaper.jpg
cp scripts/.bashrc ~/.bashrc
cp scripts/.project_managment.sh ~/.project_managment.sh
cp scripts/.prompt_style.sh ~/prompt_style.sh
cp styles/gtk.css ~/.config/gtk-3.0/gtk.css
cp -r cursor/Skyrim ~/.icons/Skyrim
source ~/.bashrc
rm -fr ../System