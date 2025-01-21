if filereadable(glob("~/.vimrc.vundle"))
    source ~/.vimrc.vundle

    set termguicolors
    colorscheme catppuccin_mocha

    let g:airline_theme = 'catppuccin_mocha'
    let g:airline_powerline_fonts = 1
    let g:airline#extensions#tabline#enabled = 1

endif

syntax on
set pastetoggle=<F2>


set term=xterm-256color
set t_Co=256
set background=dark


set backupdir-=.
set backupdir^=~/tmp,/tmp


if filereadable(glob("~/.vimrc.local")) 
    source ~/.vimrc.local
endif

