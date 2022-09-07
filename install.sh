#!/bin/bash

sudo git clone https://aur.archlinux.org/yay-git.git
sudo chown -R $USER:$USER ./yay-git
cd yay-git
makepkg -si
cd ..
sudo sed -zi 's/#\[multilib\]\n#/\[multilib\]\n/' /etc/pacman.conf
yay -Syu visual-studio-code-bin spotify minecraft-launcher gnome-terminal-transparency hplip hplip-plugin discord cups avahi steam nss-mdns gnome-shell-extensions ntfs-3g mysql-workbench
sudo systemctl enable cups.service
sudo systemctl start cups.service
sudo systemctl enable avahi-daemon.service
sudo systemctl start avahi-daemon.service
sudo sed -i 's/hosts: mymachines resolve/hosts: mymachines mdns_minimal \[NOTFOUND=return\] resolve /' /etc/nsswitch.conf
sudo systemctl restart cups.service
sudo cp pictures/user.jpg  /var/lib/AccountsServices/icons/$USER
sudo sed -i "s/Icon=.*/Icon=\/var\/lib\/AccountsServices\/icons\/$USER/" /var/lib/AccountsServices/users/$USER
sudo cp pictures/wallpaper.jpg /usr/share/backgrounds/wallpaper.jpg
gsettings set org.gnome.desktop.background picture-uri file:////usr/share/backgrounds/wallpaper.jpg
gsettings set org.gnome.desktop.background picture-uri-dark file:////usr/share/backgrounds/wallpaper.jpg
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
cp scripts/.bashrc ~/.bashrc
cp scripts/.project_managment.sh ~/.project_managment.sh
cp scripts/.prompt_style.sh ~/.prompt_style.sh
sudo cp styles/gtk.css ~/.config/gtk-3.0/gtk.css
mkdir ~/.icons
sudo cp -r cursor/Skyrim ~/.icons/Skyrim
yay -S brave-bin
source ~/.bashrc
rm -fr ../System