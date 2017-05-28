#!/bin/bash

source ./utils.bash

# vim
clone .vim.d
insert ~/.vimrc source ~/.vim.d/src.vim

# tmux
clone .tmux.d

# git
clone .git.d
link ~/.gitconfig ~/.git.d/.gitconfig

# bash
clone .bash.d
insert ~/.bashrc unset TMUX
insert ~/.bashrc source ~/.bash.d/src.bash
