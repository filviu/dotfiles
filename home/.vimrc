set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'bling/vim-airline'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'altercation/vim-colors-solarized'

if filereadable(glob("~/.vimrc.localplugins")) 
	source ~/.vimrc.localplugins
endif

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Put your non-Plugin stuff after this line

syntax on

let g:airline#extensions#tabline#enabled = 1

set term=xterm-256color
set t_Co=256
let g:solarized_termcolors=256 
set background=dark
colorscheme solarized

set pastetoggle=<F2>

set backupdir-=.
set backupdir^=~/tmp,/tmp

