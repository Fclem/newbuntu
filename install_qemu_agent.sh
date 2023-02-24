#!/usr/bin/env bash

# TODO conditional on detection qemu / kvm

sudo apt install -y qemu-guest-agent && \
systemctl enable qemu-guest-agent && \
sudo systemctl start qemu-guest-agent
sudo systemctl status qemu-guest-agent
