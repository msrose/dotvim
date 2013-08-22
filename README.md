#dotvim

To use these as your default vim settings and plugins:

        $ git clone https://github.com/msrose/dotvim ~/.vim

Create symbolic link:

        $ ln -s ~/.vim/vimrc ~/.vimrc

Initialize submodules:

        $ cd ~/.vim
        $ git submodule update --init

On Windows, download git and use the bash terminal to clone the repo into `~/vimfiles`. Then run a command prompt as administrator, and create the symbolic link as follows:

        C:\Users\Name>mklink /h _vimrc vimfiles\vimrc

##Updating submodules

For a particular plugin:

        $ cd ~/.vim/bundle/plugin-name
        $ git pull origin master

For all plugins:

        $ git submodule foreach git checkout master
        $ git submodule foreach git pull origin master

##Acknowledgements

Special thanks to:

* Tim Pope for the awesome plugins he writes: https://github.com/tpope
* Andrew Neil and his amazing Vim Casts: http://vimcasts.org/
* Franco for his insane amount of color schemes: https://github.com/flazz/vim-colorschemes
