# To download and use:
# apk add curl
# curl https://raw.githubusercontent.com/TheLichten/Alpine-And-K3s/master/alpine-post-install.sh > alpine-post-install
# chmod u+x alpine-post-install
# ./alpine-post-install [Username] [Github-User-For-Ssh-Keys]

# Ansible requires python, so we install python
apk update
apk add python3

# We need doas or sudo otherwise the user is useless
apk add doas

# Creating user (as ssh does not support root login per default), it will promt for a password
adduser $1
adduser $1 wheel
passwd -l root # disabling root

# Adding the wheel group to the Doas conf so the user can do-as
echo 'permit persist :wheel' >> /etc/doas.d/doas.conf

# getting the ssh keys from the github user
curl https://github.com/$2.keys > keys.pub
mkdir ~/.ssh
ssh-copy-id -f -i keys.pub $1@127.0.0.1
rm -R ~/.ssh

# Now you can ssh into the new user
# Password authentication is still enabled, we disable it with Ansible later
# 
# If you want to add further ssh keys, then run on the local machine run 
# ssh-copy-id [Username]@[Remote-IP]
#
# There are a lot of things still to set up (Community repos, Update and Upgrade, Vim, Guest Agent, etc), but now this can be done via Ansible
# Check out the Ansible playbook alpine-setup: https://github.com/TheLichten/Alpine-And-K3s/blob/master/Ansible/playbooks/alpine-setup.yml
# Further steps here: https://github.com/TheLichten/Alpine-And-K3s/tree/master/Ansible