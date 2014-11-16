#!/bin/bash

dotfile_dir="${HOME}/dotfiles"
if ! [[ -d $dotfile_dir ]];
then
  echo "Couldn't find path: $dotfile_dir" 2>&1
  exit 1
fi

cat << EOF
Warning: This script will destroy your existing .bashrc, .bash_profile, and
.vimrc!  Do you want to continue?  (type yes to continue.)
EOF

echo -n "> "
read line
if [[ "$line" != "yes" ]];
then
  echo "Bailing out."
  exit
fi

echo "Setting up your configuration environment."
set -x
rm -f ~/.{bashrc,bash_profile,vimrc}
ln -sf ${dotfile_dir}/bashrc ~/.bashrc
ln -sf ${dotfile_dir}/bash_profile ~/.bash_profile
ln -sf ${dotfile_dir}/vimrc ~/.vimrc
mkdir ~/apps > /dev/null 2>&1
