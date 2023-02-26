#!/usr/bin/env bash

source .common.sh

# install starship cross-shell prompt
which snap > /dev/null && sudo snap install starship || curl -sS https://starship.rs/install.sh | sudo sh
sudo bash -c "source .common.sh && use_starship \"/root\""

use_starship ~
