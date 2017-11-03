#!/bin/bash

source ./utils.bash

clone .vim.d &
clone .tmux.d &
clone .git.d &
clone .bash.d &
wait

# vim
insert ~/.vimrc source ~/.vim.d/src.vim

# tmux
insert ~/.tmux.conf source ~/.tmux.d/src.conf

# git
link ~/.gitconfig ~/.git.d/.gitconfig

# bash
insert ~/.bashrc unset TMUX
insert ~/.bashrc source ~/.bash.d/src.bash

# ansible
sudo apt-get install -y software-properties-common
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get update
sudo apt-get install -y ansible
