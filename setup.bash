#!/bin/bash

source ./utils.bash

# vim
clone .vim.d
insert ~/.vimrc source ~/.vim.d/src.vim

# tmux
clone .tmux.d
insert ~/.tmux.conf source ~/.tmux.d/src.conf

# git
clone .git.d
link ~/.gitconfig ~/.git.d/.gitconfig

# bash
clone .bash.d
insert ~/.bashrc unset TMUX
insert ~/.bashrc source ~/.bash.d/src.bash

# ansible
sudo apt-get install -y software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install -y ansible
