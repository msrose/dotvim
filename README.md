#dotvim

Installation:

        $ git clone https://github.com/msrose/dotvim ~/.vim

Create symbolic link:

        $ ln -s ~/.vim/vimrc ~/.vimrc

Initialize submodules:

        $ cd ~/.vim
        $ git submodule update --init

##Updating submodules

For a particular plugin:

        $ cd ~/.vim/bundle/plugin-name
        $ git pull origin master

For all plugins:

        $ git submodule foreach git pull origin master

##Acknowledgements

Special thanks to:

* Tim Pope: https://github.com/tpope
* Andrew Neil and his amazing Vim Casts: http://vimcasts.org/
* and flazz for his colourschemes: https://github.com/flazz/vim-colorschemes
