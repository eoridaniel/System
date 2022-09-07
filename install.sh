#!/bin/bash

sudo git clone https://aur.archlinux.org/yay-git.git
sudo chown -R $USER:$USER ./yay-git
cd yay-git
makepkg -si
cd ..
sudo sed -zi 's/#\[multilib\]\n#/\[multilib\]\n/' /etc/pacman.conf
yay -Syu brave visual-studio-code-bin spotify minecraft-launcher gnome-terminal-transparency hplip hplip-plugin discord cups avahi steam nss-mdns gnome-shell-extensions ntfs-3g mysql-workbanch
sudo systemctl enable cups.service
sudo systemctl start cups.service
sudo systemctl enable avahi-daemon.searvice
sudo systemctl start avahi-daemon.searvice
sudo sed -i 's/hosts: mymachines resolve/hosts: mymachines mdns_minimal \[NOTFOUND=return\] resolve /' /etc/nsswitch.conf
sudo systemctl restart cups.service
sudo cp pictures/user.jpg  /var/lib/AccountService/icon/$USER
sudo cp pictures/wallpaper.jpg /usr/share/wallpaper.jpg
gsettings set org.gnome.desktop.background picture-uri file:////usr/share/wallpaper.jpg
cp scripts/.bashrc ~/.bashrc
cp scripts/.project_managment.sh ~/.project_managment.sh
cp scripts/.prompt_style.sh ~/.prompt_style.sh
sudo cp styles/gtk.css ~/.config/gtk-3.0/gtk.css
sudo cp -r cursor/Skyrim ~/.icons/Skyrim
source ~/.bashrc
rm -fr ../System