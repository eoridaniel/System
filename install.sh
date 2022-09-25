#!/bin/bash

#install yay
sudo git clone https://aur.archlinux.org/yay-git.git
sudo chown -R $USER:$USER ./yay-git
cd yay-git
makepkg -si
cd ..
#install packages
yay -Syu brave-bin gnome-shell-extensions
sudo sed -zi 's/#\[multilib\]\n#/\[multilib\]\n/' /etc/pacman.conf
yay -Syu visual-studio-code-bin spotify minecraft-launcher gnome-terminal-transparency hplip hplip-plugin discord cups avahi steam nss-mdns ntfs-3g mariadb kite bluez bluez-utils xorg
#setup bluetooth
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service
#install database
mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
sudo systemctl enable mariadb.service
sudo systemctl start mariadb.service
sudo sed -zi 's/[mysqld]/[mysqld]\nbind-address = localhost\n/' /etc/my.conf.d/server.conf
sudo systemctl restart mariadb.service
#install printer
sudo systemctl enable cups.service
sudo systemctl start cups.service
sudo systemctl enable avahi-daemon.service
sudo systemctl start avahi-daemon.service
sudo sed -i 's/hosts: mymachines resolve/hosts: mymachines mdns_minimal \[NOTFOUND=return\] resolve /' /etc/nsswitch.conf
sudo systemctl restart cups.service
#set user icon
sudo cp pictures/user.jpg  /var/lib/AccountsServices/icons/$USER
sudo sed -i "s/Icon=.*/Icon=\/var\/lib\/AccountsServices\/icons\/$USER/" /var/lib/AccountsServices/users/$USER
#set wallpaper
sudo cp pictures/wallpaper.jpg /usr/share/backgrounds/wallpaper.jpg
gsettings set org.gnome.desktop.background picture-uri file:////usr/share/backgrounds/wallpaper.jpg
gsettings set org.gnome.desktop.background picture-uri-dark file:////usr/share/backgrounds/wallpaper.jpg
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
#configuer git
git config --global user.name "Eőri Dániel"
git config --global user.email "eori.dani@gamil.com"
#make projects dir
mkdir ~/Projects
#install custom bash commands
cp scripts/.bashrc ~/.bashrc
cp scripts/.project_managment.sh ~/.project_managment.sh
cp scripts/.prompt_style.sh ~/.prompt_style.sh
source ~/.bashrc
#install theme
mkdir ~/.themes
mkdir ~/.icons
sudo cp -r .icons ~/.icons
sudo cp .themes ~/.themes
gnome-shell-extension-tool -e user-theme
gsettings set org.gnome.desktop.interface icon-theme Dracula
gsettings set org.gnome.desktop.interface gtk-theme Dracula
gsettings set org.gnome.shell.extensions.user-theme name Dracula
#setup coursor
sudo gsettings set org.gnome.desktop.interface cursor-theme Skyrim
#configure visual studio code
git clone https://github.com/dracula/visual-studio-code.git ~/.vscode/extensions/theme-dracula
cd ~/.vscode/extensions/theme-dracula
npm install
npm run build
#clean up
rm -fr ../System
