#!/bin/bash

#functions for gaming
gameing(){
    read -p 'Do you want to play on this machine?(y/n)' game
    if [ $game == "y" ]
    then
        sudo sed -zi 's/#\[multilib\]\n#/\[multilib\]\n/' /etc/pacman.conf
        sudo pacman --noconfirm -Syu
        gpu
        sudo pacman --noconfirm -S --needed wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls \
        mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error \
        lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo \
        sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama \
        ncurses lib32-ncurses ocl-icd lib32-ocl-icd libxslt lib32-libxslt libva lib32-libva gtk3 \
        lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader
        yay -S minecraft-launcher steam lutris-git
    elif [ $game == "n" ]
    then
        echo 'Install nothing for gaming.'
    else
        echo 'Wrong input!'
        gameing
    fi
}
gpu(){
    read -p 'What tipy of GPU you use? AMD NVIDIA or Intel(a/n/i)' gputype
    if [ $gputype == "a" ]
    then
        sudo pacman --noconfirm -S --needed lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader
    elif [ $gputype == "n" ]
    then
        sudo pacman --noconfirm -S --needed nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader
    elif [ $gputype == "i" ]
    then
        sudo pacman --noconfirm -S --needed lib32-mesa vulkan-intel lib32-vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader
    else
        echo 'Wrong input!'
        gpu
    fi
}
#gpu managment for laptops
gpu_managment(){
    read -p 'This machine is a laptop?(y/n)' laptop
    if [ $laptop == "y" ]
    then
        yay --noconfirm -S optimus-manager
        cp config/optimus-manager.conf /etc/optimus-manager/optimus-manager.conf
    elif [ $laptop == "n" ]
    then
        echo 'Install nothing for GPU managment.'
    else
        echo 'Wrong input!'
        gpu_managment
    fi
}
#yubikey setup
yubikey(){
    read -p 'Do you want to setup a Yubikey?(y/n)' key
    if [ $key == "y" ]
    then
        sudo pacman --noconfirm -S pam-u2f
        mkdir ~/.config/Yubico
        pamu2fcfg -o pam://$hostname -i pam://$hostname > ~/.config/Yubico/u2f_keys
        sudo sed -zi 's/auth		include		system-auth/#auth		include		system-auth/' /etc/pam.d/sudo
        sudo echo 'auth     sufficient      pam_u2f.so cue origin=pam://$hostname appid=pam://$hostname' >> /etc/pam.d/sudo
        sudo echo 'auth     required        pam_u2f.so nouserok origin=pam://$hostname appid=pam://$hostname' >> /etc/pam.d/gdm-password
    elif [ $key == "n" ]
    then
        echo 'Install nothing for hardwaerkey authentication!'
    else
        echo 'Wrong input!'
        yubikey
    fi
}

#install yay
sudo git clone https://aur.archlinux.org/yay-git.git
sudo chown -R $USER:$USER ./yay-git
cd yay-git
makepkg --noconfirm -si
cd ..
#install packages
sudo pacman --noconfirm -Syu
yay --noconfirm -Syu brave-bin gnome-shell-extensions gnome-browser-connector
yay --noconfirm -Syu visual-studio-code-bin spotify gnome-terminal-transparency hplip hplip-plugin discord cups avahi nss-mdns ntfs-3g mariadb kite bluez bluez-utils xorg fish neofetch linux-lts linux-lts-header
gameing
gpu_managment
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
cp scripts/.prompt_style.sh ~/.prompt_style.shn
source ~/.bashrc
#install theme
tar -xf icons.tar.gz
tar -xf themes.tar.gz
mkdir ~/.themes
mkdir ~/.icons
sudo cp -r .icons ~
sudo cp -r .themes ~
gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com
gsettings set org.gnome.desktop.interface icon-theme Dracula
gsettings set org.gnome.desktop.interface gtk-theme Dracula
gsettings set org.gnome.shell.extensions.user-theme name Dracula
#setup coursor
sudo gsettings set org.gnome.desktop.interface cursor-theme Skyrim
#setup fish
echo /usr/bin/fish | sudo tee -a /etc/shells
chsh -s /usr/bin/fish
git clone https://github.com/oh-my-fish/oh-my-fish
cd oh-my-fish
echo "bin/install --offline" | fish
echo "omf install eden" | fish
echo "omf install https://github.com/dracula/fish" | fish
echo "eden_toggle_host" | fish
echo "eden_toggle_ssh_tag" | fish
echo "eden_prompt_char '$'" | fish
sudo sed -i 's/(hostname|cut -d . -f 1)ˇ$USER/$USER@(prompt_hostname)/' ~/.config/fish/functions/fish_prompt.fish
sudo sed -i 's/set_color blue/set_color a17fd6/' ~/.config/fish/functions/fish_prompt.fish
cd ..
#add fish implemetation of custom bash commands
cp scripts/config.fish ~/config/fish/config.fish
source ~/config/fish/config.fish
#configure visual studio code
git clone https://github.com/dracula/visual-studio-code.git ~/.vscode/extensions/theme-dracula
cd ~/.vscode/extensions/theme-dracula
npm install
npm run build
#yubikey setup
yubikey
#reboot
sudo reboot now
