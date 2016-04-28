#!/bin/sh
cd ~/dwatanabe.git/dotfiles
brew list > brew-list.txt
brew cask list > brew-cask-list.txt
brew file init

cp ~/.tmux.conf tmux.conf
cp ~/.vimrc vimrc
cp -r ~/.ssh ssh
cp ~/.bashrc bashrc
cp ~/.bash_profile bash_profile
cp ~/.zshrc zshrc_antigen
cp ~/.brewfile/Brewfile Brewfile

tar -cvzf vim.tar.gz ~/.vim
tar -cvzf tmux.tar.gz ~/.tmux
tar -cvzf antigen.tar.gz ~/antigen
tar -cvzf chef-repo.tar.gz ~/chef-repo
tar -cvzf RubymineProjects.tar.gz ~/RubymineProjects

