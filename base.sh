#!/usr/bin/env bash

source .common.sh

# SSH public keys
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINhoEB92fViP/YL3fmoQBSM80AVjozDlyubmyNErcpkK clement@fiere.fr" >> ~/.ssh/authorized_keys
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJgryACoMykztCkP12rvgFVUd2EM84rQjUALw6MI+iuJ clement.fiere@eficode.com" >> ~/.ssh/authorized_keys

write_aliases "~/.bashrc"

# elevation
sudo su -

# updates
apt update && apt upgrade -y
# useful packages
apt install -y most htop ssh-audit ncdu unzip

write_aliases "~/.bashrc"

# Install speedtest
curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | bash
apt install -y speedtest

exit

./install_qemu_agent.sh
./harden_ssh.sh
./install_exa.sh
./install_fish.sh
./install_starship.sh


