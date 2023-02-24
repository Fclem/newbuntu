#!/usr/bin/env bash

source .common.sh

sudo su -

# install starship cross-shell prompt
snap install starship && \
use_starship

exit # demote

use_starship
