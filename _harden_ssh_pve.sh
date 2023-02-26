#!/usr/bin/env bash

os_name="$(uname -v)"
source /etc/os-release
if [[ $VERSION_ID != "11" || $ID != "debian" || $os_name != *"PVE"* ]]; then
  echo -e "This script was made for PVE 7.3-6 based on Debian 11. It might not work properly in any other version.\nABORTING"
  exit 1
fi

# no password or root login for OpenSSH
cat <<EOF | tee -a /etc/ssh/sshd_config.d/no_passwd.conf > /dev/null
PasswordAuthentication no
PermitRootLogin yes
UsePAM no
EOF

/etc/init.d/ssh reload

###
# hardening of OpenSSH
###
# bbackup
cp /etc/ssh /etc/_ssh.back
# Re-generate the RSA and ED25519 keys
rm /etc/ssh/ssh_host_*
ssh-keygen -t rsa -b 4096 -f /etc/ssh/ssh_host_rsa_key -N ""
ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N ""
# Remove small Diffie-Hellman moduli
awk '$5 >= 3071' /etc/ssh/moduli | tee /etc/ssh/moduli.safe > /dev/null
mv /etc/ssh/moduli.safe /etc/ssh/moduli
# Enable the RSA and ED25519 keys
sed -i 's/^\#HostKey \/etc\/ssh\/ssh_host_\(rsa\|ed25519\)_key$/HostKey \/etc\/ssh\/ssh_host_\1_key/g' /etc/ssh/sshd_config
# Restrict supported key exchange, cipher, and MAC algorithms
cat <<EOF | tee /etc/ssh/sshd_config.d/hardened.conf > /dev/null
# Restrict key exchange, cipher, and MAC algorithms, as per sshaudit.com
# hardening guide.
KexAlgorithms curve25519-sha256,curve25519-sha256@libssh.org,gss-curve25519-sha256-,diffie-hellman-group16-sha512,gss-group16-sha512-,diffie-hellman-group18-sha512,diffie-hellman-group-exchange-sha256
Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr
MACs hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,umac-128-etm@openssh.com
HostKeyAlgorithms ssh-ed25519,ssh-ed25519-cert-v01@openssh.com,sk-ssh-ed25519@openssh.com,sk-ssh-ed25519-cert-v01@openssh.com,rsa-sha2-512,rsa-sha2-512-cert-v01@openssh.com,rsa-sha2-256,rsa-sha2-256-cert-v01@openssh.com
EOF
# Restart OpenSSH server
service ssh restart

# own_ip=$(curl )
echo -e "you will need to remove old server pub key from your ssh config, using :
# ssh-keygen -f \"~/.ssh/known_hosts\" -R \"ip or domain used\""
