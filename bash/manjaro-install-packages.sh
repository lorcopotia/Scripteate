#!/bin/bash

RED="31"
GREEN="32"
BLUE="34"
ENDCOLOR="\e[0m"
BOLDRED="\e[1;${RED}m"
BOLDGREEN="\e[1;${GREEN}m"
BOLDBLUE="\e[1;${BLUE}m"
ITALICRED="\e[3;${RED}m"
ITALICGREEN="\e[3;${GREEN}m"
ITALICBLUE="\e[3;${BLUE}m"


echo -e "${BOLDBLUE}UPDATING system database.${ENDCOLOR}"
sudo pacman -S archlinux-keyring --confirm

echo -e "${ITALICRED}> Installing necessary packages for DuniX environment.${ENDCOLOR}"
sudo pacman -S virt-manager qemu vde2 iptables-nft dnsmasq bridge-utils openbsd-netcat edk2-ovmf swtpm vim vscode gphoto2 v4l-utils v4l2loopback-dkms ffmpeg tor docker docker-compose --confirm

echo -e "${ITALICRED}> Enabling and starting libvirtd service.${ENDCOLOR}"
sudo systemctl enable --now libvirtd.service

echo -e "${ITALICRED}> Adding user to libvirt group.${ENDCOLOR}"
sudo usermod -a -G libvirt $USER

echo -e "${ITALICRED}> Enabling and starting docker service.${ENDCOLOR}"
sudo systemctl enable --now docker.service

echo -e "${ITALICRED}> Adding user to docker group.${ENDCOLOR}"
sudo usermod -a -G docker $USER
sudo newgrp docker

echo -e "${BOLDBLUE}>> All done. For further instructions go to https://wiki.manjaro.org/index.php/Virt-manager.${ENDCOLOR}"

