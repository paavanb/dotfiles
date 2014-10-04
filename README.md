dotfiles
========
Welcome to my dotfiles! These are the personal configuration files that I've grown over the years. It's gotten to the point where switching computers becomes painful, so I've decided to put up all my configs here on version control. Feel free to explore!

Installation
------------
### Install MacVim
If you're on Mac OSX, you'll want to install MacVim. It'll include python on ruby support, which is important for the python-mode and vim-ruby plugins. 

    brew install macvim
    
If you're not on a Mac, you'll want to compile a version of Vim with python and ruby, and remove the "vim" alias in ``.bash_aliases``
    
### Clone the repository

    git clone https://github.com/pbhavsar/dotfiles.git

### Setup your Home Directory
Run the bootstrap script, which will ``rsync`` all the files over to your home directory and run any setup scripts necessary.

    bash bootstrap.sh

Enjoy!
