syntax on

let g:solarized_termcolors=256
set t_Co=256

" You need to install https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized in your terminal
Plug 'altercation/vim-colors-solarized'
" see more at plug_end.vim

Plug 'dracula/vim', { 'as': 'dracula' }
let g:airline_theme='dracula'
let g:dracula_italic = 0
set background=light
" see more at plug_end.vim

set cursorline
set cursorcolumn
