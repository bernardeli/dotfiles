Plug 'vim-test/vim-test'

nmap <silent> <Leader><Leader>n :TestNearest<CR>
nmap <silent> <Leader><Leader>f :TestFile<CR>

let test#strategy = 'vimterminal'
let test#ruby#use_binstubs = 0
let test#ruby#bundle_exec = 1
