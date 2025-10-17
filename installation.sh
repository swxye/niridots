#!/bin/bash

GREEN=$'\e[0;32m'
YELLOW=$'\e[0;33m'

NC=$'\e[0m'

echo "This script will alter your system heavily."
read -p "${YELLOW}::${NC} Do you want to continue? [Y/n] " nyae_ans1

nyae_ans1=${nyae_ans1,,}

if [[ $nyae_ans1 != "y" ]]; then
    echo "Script ended, no changes done."
    exit 0
fi

if [[ $( whoami ) = "root" ]]; then
    echo "Must to be a user to run the installation script."
fi

sudo pacman -Syu

sudo pacman -S doas eza

echo "${GREEN}::${NC} Creating the doas config..."
sudo touch /etc/doas.conf
sudo echo -e "permit persist setenv {PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin} :wheel\n" > /etc/doas.conf
sudo chown -c root:root /etc/doas.conf
sudo chmod -c 0400 /etc/doas.conf

echo "${GREEN}::${NC} Installing Paru..."
cd
git clone https://aur.archlinux.org/paru-bin.git
cd ~/paru-bin
makepkg -si
cd
rm -r ~/paru-bin

echo "${GREEN}::${NC} Installing the packages required by niridots..."
doas pacman -S ly niri xdg-desktop-portal-{gtk,gnome} pipewire{,-{pulse,alsa,jack}} wireplumber bluez{,-utils} brightnessctl kitty btop fuzzel hyprlock swayidle swaync power-profiles-daemon ttf-jetbrains-mono noto-fonts{,-{cjk,emoji,extra}} alsa-utils

echo "${GREEN}::${NC} Installing the AUR packages required by niridots..."
paru -S paru-bin doasedit-alternative hellwal

echo "${GREEN}::${NC} Installing niridots..."
cd ~/niridots
doas cat ./config/ly/config.ini > /etc/ly/config.ini
cp -rf ./config/.swayidle ~
cp -rf ./config/config/* ~/.config
cp -rf ./config/.zshrc ~

echo "${GREEN}::${NC} Installing wallpapers..."
cd
git clone https://github.com/swxye/niridots-wallpapers
cd ~/niri-wallpapers
mv ./Wallpapers ~
cd
rm -r ~/niridots-wallpapers

echo "${GREEN}::${NC} Enabling services..."
doas systemctl enable bluetooth ly
systemctl --user enable pipewire pipewire-pulse wireplumber 

echo "${GREEN}::${NC} Configuring themes..."
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

read -p "${YELLOW}::${NC} Do you want to reboot now? [Y/n] " nyae_ans2

nyae_ans2=${nyae_ans2,,}

if [[ $nyae_ans2 != "y" ]]; then
    exit 0
fi

reboot
