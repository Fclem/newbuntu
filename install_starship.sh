#!/usr/bin/env bash

source .common.sh

# install starship cross-shell prompt
sudo snap install starship
sudo bash -c "source .common.sh && use_starship \"/root\""

use_starship ~
