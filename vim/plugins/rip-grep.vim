Plug 'jremmen/vim-ripgrep'

" Bind K to search for the word under cursor
nnoremap K :Rg "\b<C-R><C-W>\b"<CR>:cw<CR>

" Close quickfix window that Ack opens
nnoremap tt :ccl<CR>
