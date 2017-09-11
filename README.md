# dotvim

To use these as your default vim settings and plugins:

```Shell
$ git clone https://github.com/msrose/dotvim ~/.vim
```

Create symbolic link:

```Shell
$ ln -s ~/.vim/vimrc ~/.vimrc
```

Install plugins:

Open vim and execute `:PlugInstall`

See the [plugged documentation](https://github.com/junegunn/vim-plug#commands) for other plugin management commands.

On Windows, download git and use the bash terminal to clone the repo into `~/vimfiles`. Then run a command prompt as administrator, and create the symbolic link as follows:

```Shell
C:\Users\Name> mklink _vimrc vimfiles\vimrc
```

## Acknowledgements

Special thanks to:

* Tim Pope for the awesome plugins he writes: https://github.com/tpope
* Andrew Neil and his amazing Vim Casts: http://vimcasts.org/
* Franco for his insane amount of color schemes: https://github.com/flazz/vim-colorschemes
