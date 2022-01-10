# To download and use:
# apk add curl
# curl https://raw.githubusercontent.com/TheLichten/Alpine-And-K3s/master/alpine-post-install.sh > alpine-post-install
# chmod u+x alpine-post-install
# ./alpine-post-install [Username]

# Ansible requires python, so we install python
apk update
apk add python3

# We need doas or sudo otherwise the user is useless
apk add doas

# Creating user (as ssh does not support root login per default), it will promt for a password
adduser $1
adduser $1 wheel
passwd -l root # disabling root

# Doas conf
echo 'permit persist :wheel' >> /etc/doas.d/doas.conf

# Now you can ssh into the new user, with password authentication
# Best to copy your ssh keys over now
# On the local machine run 
# ssh-copy-id [Username]@[Remote-IP]
# 
# If you have multiple local machines, you can get all ssh public keys, and put them in a keys.pub file
# You can get your public keys from github via this command:
# curl https://github.com/[Github-username].keys > keys.pub
# Then you can upload them all in one go:
# ssh-copy-id -f -i keys.pub [Username]@[Remote-IP]
#
# There are a lot of things still to set up (Community repos, Update and Upgrade, Vim, Guest Agent, etc), but now this can be done via Ansible
# Check out the Ansible playbook in alpine-setup in this repo