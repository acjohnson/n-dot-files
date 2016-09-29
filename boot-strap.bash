#!/usr/bin/env bash
#
# boot-strap utility
#

cd $HOME
printf "Bootstrapping NDF Components:\n"

# Bash
printf "Bash... "
rm -fr .bash && ln -s .n-dot-files/bash .bash
ln -s -f .bash/bashrc .bashrc
ln -s -f .bash/bash_profile .bash_profile
ln -s -f .bash/dircolors/solarized-ansi-dark .dircolors
printf "Done\n"

# Vim
printf "Vim... "
rm -fr .vim && ln -s .n-dot-files/vim .vim
ln -s -f .vim/vimrc .vimrc
if [[ $(which git) ]]; then
    rm -fr .vim/bundle/vundle
    git clone https://github.com/gmarik/vundle.git .vim/bundle/vundle > /dev/null 2>&1
fi
printf "Done\n"

# Tmux
printf "Tmux... "
rm -fr .tmux && ln -s .n-dot-files/tmux .tmux
ln -s -f .tmux/tmux.conf .tmux.conf
printf "Done\n"

# Virtualenvs (Python)
printf "Virtualenvs (Python)... "
rm -fr .virtualenvs && ln -s .n-dot-files/virtualenvs .virtualenvs
printf "Done\n"

# Irssi
printf "Irssi... "
rm -fr .irssi && ln -s .n-dot-files/irssi .irssi
printf "Done\n"
