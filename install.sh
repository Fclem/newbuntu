#!/usr/bin/env bash

source .common.sh

# SSH public keys
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINhoEB92fViP/YL3fmoQBSM80AVjozDlyubmyNErcpkK clement@fiere.fr" >> ~/.ssh/authorized_keys
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJgryACoMykztCkP12rvgFVUd2EM84rQjUALw6MI+iuJ clement.fiere@eficode.com" >> ~/.ssh/authorized_keys

write_aliases ~/.bashrc
echo -e "eval \$(thefuck --alias fuck)\nalias please=\"fuck --yeah\"" >> ~/.bashrc

# updates
sudo apt update && apt upgrade -y
# useful packages
sudo apt install -y most htop ssh-audit ncdu unzip thefuck

sudo bash -c "source .common.sh && write_aliases \"/root/.bashrc\""
echo -e "eval \$(thefuck --alias fuck)\nalias please=\"fuck --yeah\"" | sudo tee -a /root/.bashrc > /dev/null


# Install speedtest
curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash
sudo apt install -y speedtest

./install_qemu_agent.sh
./harden_ssh.sh
./install_exa.sh
./install_fish.sh
./install_starship.sh
