Plug 'vim-test/vim-test'

nmap <silent> <Leader><Leader>n :TestNearest<CR>
nmap <silent> <Leader><Leader>f :TestFile<CR>

let test#strategy = 'vimterminal'
