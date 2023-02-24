#!/usr/bin/env bash

sudo su -

# TODO conditional on detection qemu / kvm

apt install -y qemu-guest-agent && \
systemctl enable qemu-guest-agent && \
systemctl start qemu-guest-agent
systemctl status qemu-guest-agent

exit
