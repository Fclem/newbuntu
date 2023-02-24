#!/usr/bin/env bash

# TODO : make sure dist is ubuntu 22.04

# no password or root login for OpenSSH
cat <<EOF | sudo tee -a /etc/ssh/sshd_config.d/no_passwd.conf > /dev/null
PasswordAuthentication no
PermitRootLogin no
UsePAM no
EOF

sudo /etc/init.d/ssh reload

###
# hardening of OpenSSH
###
# Re-generate the RSA and ED25519 keys
sudo rm /etc/ssh/ssh_host_*
sudo ssh-keygen -t rsa -b 4096 -f /etc/ssh/ssh_host_rsa_key -N ""
sudo ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N ""
# Remove small Diffie-Hellman moduli
awk '$5 >= 3071' /etc/ssh/moduli | sudo tee /etc/ssh/moduli.safe > /dev/null
sudo mv /etc/ssh/moduli.safe /etc/ssh/moduli
# Enable the RSA and ED25519 keys
sudo sed -i 's/^\#HostKey \/etc\/ssh\/ssh_host_\(rsa\|ed25519\)_key$/HostKey \/etc\/ssh\/ssh_host_\1_key/g' /etc/ssh/sshd_config
# Restrict supported key exchange, cipher, and MAC algorithms
cat <<EOF | sudo tee /etc/ssh/sshd_config > /dev/null
# Restrict key exchange, cipher, and MAC algorithms, as per sshaudit.com
# hardening guide.
KexAlgorithms sntrup761x25519-sha512@openssh.com,curve25519-sha256,curve25519-sha256@libssh.org,gss-curve25519-sha256-,diffie-hellman-group16-sha512,gss-group16-sha512-,diffie-hellman-group18-sha512,diffie-hellman-group-exchange-sha256
Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr
MACs hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,umac-128-etm@openssh.com
HostKeyAlgorithms ssh-ed25519,ssh-ed25519-cert-v01@openssh.com,sk-ssh-ed25519@openssh.com,sk-ssh-ed25519-cert-v01@openssh.com,rsa-sha2-512,rsa-sha2-512-cert-v01@openssh.com,rsa-sha2-256,rsa-sha2-256-cert-v01@openssh.com
EOF
# Restart OpenSSH server
sudo service ssh restart

# own_ip=$(curl )
echo -e "you will need to remove old server pub key from your ssh config, using :
# ssh-keygen -f \"~/.ssh/known_hosts\" -R \"ip or domain used\""
