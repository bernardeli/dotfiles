syntax on

" let g:solarized_termcolors=256
set background=dark
set t_Co=256

Plugin 'chriskempson/vim-tomorrow-theme'
" colorscheme Tomorrow-Night-Bright

Plugin 'mhartington/oceanic-next'
" colorscheme OceanicNext

Plugin 'dracula/vim'
colorscheme dracula

set cursorline
set cursorcolumn

highlight LineNr ctermfg=236 ctermbg=black
highlight CursorColumn ctermbg=234
highlight CursorLine ctermbg=234

" set line on 80 column
" let &colorcolumn=join(range(81,999),",")
" let &colorcolumn="80,".join(range(400,999),",")
