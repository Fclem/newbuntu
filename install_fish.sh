#!/usr/bin/env bash

source .common.sh

sudo su -

apt install -y fish
# for root user
write_aliases "~/.config/fish/config.fish"
chsh -s "$(which fish)"

exit

# for base user
write_aliases "~/.config/fish/config.fish"

# use fish
this_user=$(whoami)
sudo chsh -s "$(which fish)" "${this_user}"
