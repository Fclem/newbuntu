#!/usr/bin/env bash

sudo su -

apt install -y exa

# replace exa binary with one that has git support build in
exa_loc=$(which exa)
wget https://github.com/ogham/exa/releases/download/v0.10.0/exa-linux-x86_64-v0.10.0.zip && \
mkdir exa && unzip exa-linux-x86_64-v0.10.0.zip -d exa && rm exa-linux-x86_64-v0.10.0.zip && \
mv "${exa_loc}" "${exa_loc}_" && cp ./exa/bin/exa "${exa_loc}"

exit
