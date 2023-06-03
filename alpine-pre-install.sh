# This is to streamline the install process by adding Ansible support to the Alpine instance prior to install
# Made for Alpine 3.18-r0 Standard, millage may vary

# WARNING: This script enables ssh root login and the root password is empty
# This is used by the alpine-install.yml playbook, and then fixed by the alpine-post-install.yml

# To be able to download this you need to run
# setup-interfaces -a -r # -a means automatic setup with dhcp, if you setup without dhcp you need to run "setup-dns" too

# then you can run:
# wget https://raw.githubusercontent.com/LukasLichten/Alpine-And-K3s/master/alpine-pre-install.sh
# chmod u+x alpine-pre-install.sh

# or copy the commands manually

# Getting and starting openssh
apk add openssh

# setting up sshd config temporary to allow login into this root user
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
echo "PermitEmptyPasswords yes" >> /etc/ssh/sshd_config
service sshd start

# Adding Pyhton
# apk add -X "https://dl-cdn.alpinelinux.org/alpine/v3.18/main/" python3

# Adding Python via setting up apkrepos
setup-apkrepos -c -1
apk add python3

# Optional: Setting up a warning that root login is enabled
wget https://raw.githubusercontent.com/LukasLichten/Alpine-And-K3s/master/Ansible/templates/motd-warning
mv motd-warning /etc/motd

# Now continue in Ansible/playbooks/alpine-install.yml