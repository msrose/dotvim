# dotvim

To use these as your default vim settings and plugins:

```Shell
$ git clone https://github.com/msrose/dotvim ~/.vim
```

Create symbolic link:

```Shell
$ ln -s ~/.vim/vimrc ~/.vimrc
```

On Windows, clone the repo into `~/vimfiles`. Then run a command prompt as administrator, and create the symbolic link as follows:

```Shell
C:\Users\Name> mklink _vimrc vimfiles\vimrc
```

## Install Plugins

Run the install script:

```Shell
bash ~/.vim/install.sh
```

Open vim and execute `:PlugInstall`

See the [plug documentation](https://github.com/junegunn/vim-plug#commands) for other plugin management commands.

## Acknowledgements

Special thanks to:

* Tim Pope for the awesome plugins he writes: https://github.com/tpope
* Andrew Neil and his amazing Vim Casts: http://vimcasts.org/
* Franco for his insane amount of color schemes: https://github.com/flazz/vim-colorschemes
