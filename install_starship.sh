#!/usr/bin/env bash

source .common.sh

use_starship ~

sudo su -

# install starship cross-shell prompt
snap install starship
use_starship "/root"

exit # demote
