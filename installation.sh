#!/bin/bash

set -e

GREEN=$'\e[0;32m'
YELLOW=$'\e[0;33m'

BOLD=$'\e[1;97m'

NC=$'\e[0m'

echo "This script will alter your system heavily."
read -p "${YELLOW}::${NC} ${BOLD}Do you want to continue? [Y/n] ${NC}" nyae_ans1

nyae_ans1=${nyae_ans1,,}

if [[ $nyae_ans1 != "y" ]]; then
    echo "Script ended, no changes done."
    exit 0
fi

if [[ $( whoami ) = "root" ]]; then
    echo "Must to be a user to run the installation script."
fi

sudo pacman -Syu

echo "${GREEN}::${NC} ${BOLD}Installing yay...${NC}"
cd
git clone https://aur.archlinux.org/yay-bin.git
cd ~/yay-bin
sudo pacman -S less
makepkg -si
cd
rm -r ~/yay-bin

echo "${GREEN}::${NC} ${BOLD}Installing the packages required by niridots...${NC}"
sudo pacman -S --needed doas rsync eza ly niri nvim fastfetch xdg-desktop-portal-{gtk,gnome} qt6ct breeze gnome-themes-extra pipewire{,-{pulse,alsa,jack}} wireplumber bluez{,-utils} blueman brightnessctl kitty btop fuzzel waybar swww hyprlock swayidle swaync power-profiles-daemon ttf-jetbrains-mono ttf-nerd-fonts-symbols noto-fonts{,-{cjk,emoji,extra}} alsa-utils

echo "${GREEN}::${NC} ${BOLD}Creating the doas config...${NC}"
sudo touch /etc/doas.conf
touch /tmp/doas.conf.tmp

echo -e "permit persist setenv {PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin} :wheel\n" > /tmp/doas.conf.tmp

sudo rsync -aiv /tmp/doas.conf.tmp /etc/doas.conf

sudo chown -c root:root /etc/doas.conf
sudo chmod -c 0400 /etc/doas.conf

echo "${GREEN}::${NC} ${BOLD}Installing the AUR packages required by niridots...${NC}"
yay -S --needed doasedit-alternative hellwal

echo "${GREEN}::${NC} ${BOLD}Installing niridots...${NC}"

mkdir ~/.config/ || true

cd ~/niridots

sudo rsync -aiv ./config/ly/config.ini /etc/ly/config.ini

rsync -aiv --delete ./config/.swayidle/ ~/.swayidle/

rsync -aiv --delete ./config/config/btop/ ~/.config/btop/
rsync -aiv --delete ./config/config/fuzzel/ ~/.config/fuzzel/
rsync -aiv --delete ./config/config/hellwal/ ~/.config/hellwal/
rsync -aiv --delete ./config/config/hypr/ ~/.config/hypr/
rsync -aiv --delete ./config/config/kitty/ ~/.config/kitty/
rsync -aiv --delete ./config/config/niri/ ~/.config/niri/
rsync -aiv --delete ./config/config/nvim/ ~/.config/nvim/
rsync -aiv --delete ./config/config/qt6ct/ ~/.config/qt6ct/
rsync -aiv --delete ./config/config/swaync/ ~/.config/swaync/
rsync -aiv --delete ./config/config/waybar/ ~/.config/waybar/

rsync -aiv ./config/.zshrc ~/.zshrc

echo "${GREEN}::${NC} ${BOLD}Installing wallpapers...${NC}"
echo "${GREEN}::${NC} ${BOLD}Syncing wallpapers...${NC}"
cd
git clone https://github.com/swxye/niridots-wallpapers.git
rsync -aiv --delete ~/niridots-wallpapers/Wallpapers/ ~/Wallpapers/
rm -r ~/niridots-wallpapers

echo "${GREEN}::${NC} ${BOLD}Enabling services...${NC}"
sudo systemctl enable bluetooth ly@tty1
systemctl --user enable pipewire pipewire-pulse wireplumber 

echo "${GREEN}::${NC} ${BOLD}Configuring themes...${NC}"
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

read -p "${YELLOW}::${NC} ${BOLD}Do you want to reboot now? [Y/n] ${NC}" nyae_ans2

nyae_ans2=${nyae_ans2,,}

if [[ $nyae_ans2 != "y" ]]; then
    exit 0
fi

reboot
