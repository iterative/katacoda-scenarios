#!/bin/bash

# set the prompt of each user
cat <<EOF >> /etc/skel/.bashrc
PS1='\[\033[01;31m\]\u\[\033[00m\]@\[\033[01;33m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
EOF

# install xfsprogs
apt install xfsprogs

# install bash completion for dvc
wget -O /etc/bash_completion.d/dvc \
    https://raw.githubusercontent.com/iterative/dvc/master/scripts/completion/dvc.bash

# install dvc
pip3 install --ignore-installed PyYAML
pip3 install dvc
