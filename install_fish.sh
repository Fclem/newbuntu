#!/usr/bin/env bash

source .common.sh

sudo apt install -y fish
# for root user
sudo bash -c "source .common.sh && write_aliases \"/root/.config/fish/config.fish\""
echo -e "thefuck --alias | source\nalias please=\"fuck --yeah\"" | sudo tee -a  /root/.config/fish/config.fish > /dev/null
sudo chsh -s "$(which fish)"

# for base user
write_aliases "~/.config/fish/config.fish"
echo -e "thefuck --alias | source\nalias please=\"fuck --yeah\"" | sudo tee -a  ~/.config/fish/config.fish > /dev/null

# use fish
this_user=$(whoami)
sudo chsh -s "$(which fish)" "${this_user}"
