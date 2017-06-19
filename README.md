# dotvim

To use these as your default vim settings and plugins:

```Shell
$ git clone https://github.com/msrose/dotvim ~/.vim
```

Create symbolic link:

```Shell
$ ln -s ~/.vim/vimrc ~/.vimrc
```

Initialize submodules:

```Shell
$ cd ~/.vim
$ git submodule update --init
```

On Windows, download git and use the bash terminal to clone the repo into `~/vimfiles`. Then run a command prompt as administrator, and create the symbolic link as follows:

```Shell
C:\Users\Name> mklink _vimrc vimfiles\vimrc
```

## Updating submodules

For a particular plugin:

```Shell
$ cd ~/.vim/bundle/plugin-name
$ git pull origin master
```

For all plugins:

```Shell
$ git submodule foreach git checkout master
$ git submodule foreach 'git pull origin master || :'
```
Adding `|| :` to the end forces the command to always return a 0 exit status. Therefore, if a pull from one submodule fails, the foreach continues to execute regardless, and the pull can continue for the rest of the submodules.

## Acknowledgements

Special thanks to:

* Tim Pope for the awesome plugins he writes: https://github.com/tpope
* Andrew Neil and his amazing Vim Casts: http://vimcasts.org/
* Franco for his insane amount of color schemes: https://github.com/flazz/vim-colorschemes
