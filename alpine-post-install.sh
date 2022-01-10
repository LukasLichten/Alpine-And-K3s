# To download and use:
# cat https://github.com/TheLichten/Alpine-And-K3s >> alpine-post-install
# chmod u+x alpine-post-install
# alpine-post-install [Username] [Password]

# Ansible requires python, so we install python
apk update
apk add python3

# We need doas or sudo otherwise the user is useless
apk add doas

# Creating user
adduser -D $1
passwd -d $2 $1
adduser $1 wheel
passwd -l root

# Doas conf
echo 'permit persist :wheel' >> /etc/doas.d/doas.conf