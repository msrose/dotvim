#! /bin/bash
set -e

echo "Installing Plugged..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Linking vimrc..."
ln -s ~/.vim/vimrc ~/.vimrc

echo "Done."
