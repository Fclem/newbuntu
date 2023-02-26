#!/usr/bin/env bash

os_name="$(uname -v)"
if [[ $os_name == *"PVE"* ]];
then
    ./_harden_ssh_pve.sh
elif [[ $os_name == *"Ubuntu"* ]];
then
    ./_harden_ssh_ubuntu.sh
fi;
