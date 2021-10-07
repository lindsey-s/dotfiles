#!/bin/bash

cd ~
ln -nfs "$(pwd)/dotfiles/.zshrc" ~/.zshrc
ln -nfs "$(pwd)/dotfiles/.gitconfig" ~/.gitconfig
ln -nfs "$(pwd)/dotfiles/.gitconfig-ridwell" ~/.gitconfig-ridwell
ln -nfs "$(pwd)/dotfiles/.gitignore-global" ~/.gitignore-global
