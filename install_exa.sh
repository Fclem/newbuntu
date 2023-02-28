#!/usr/bin/env bash

source .common.sh

sudo apt install -y unzip exa

# replace exa binary with one that has git support build in
exa_loc=$(which exa)
wget https://github.com/ogham/exa/releases/download/v0.10.0/exa-linux-x86_64-v0.10.0.zip && \
mkdir exa || true && unzip exa-linux-x86_64-v0.10.0.zip -d exa && rm exa-linux-x86_64-v0.10.0.zip && \
sudo mv "${exa_loc}" "${exa_loc}_" && sudo cp ./exa/bin/exa "${exa_loc}"

write_aliases ~/.bashrc
write_aliases ~/.config/fish/config.fish
