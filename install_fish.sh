#!/usr/bin/env bash

source .common.sh

sudo apt install -y fish
# for root user
sudo bash -c "source .common.sh && write_aliases \"/root/.config/fish/config.fish\""
sudo chsh -s "$(which fish)"

# for base user
write_aliases "~/.config/fish/config.fish"

# use fish
this_user=$(whoami)
sudo chsh -s "$(which fish)" "${this_user}"
