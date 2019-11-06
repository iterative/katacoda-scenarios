#!/bin/bash

# create two user accounts
useradd -m -s /bin/bash first-user
useradd -m -s /bin/bash second-user

# set the prompt of each user
cat <<EOF >> /home/first-user/.bashrc
PS1='\[\033[01;31m\]first-user\[\033[00m\]@\[\033[01;33m\]localhost-1\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
EOF
cat <<EOF >> /home/second-user/.bashrc
PS1='\[\033[01;31m\]second-user\[\033[00m\]@\[\033[01;33m\]localhost-2\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
EOF

# set git config for each user
runuser -l first-user -c "git config --global user.email 'first-user@example.org'"
runuser -l first-user -c "git config --global user.name 'First User'"
runuser -l second-user -c "git config --global user.email 'second-user@example.org'"
runuser -l second-user -c "git config --global user.name 'Second User'"

# install needed packages
apt install --yes highlight sshpass xfsprogs duperemove

# install bash completion for dvc
wget -O /etc/bash_completion.d/dvc \
    https://raw.githubusercontent.com/iterative/dvc/master/scripts/completion/dvc.bash

# install dvc
pip3 install 'dvc[ssh]'
