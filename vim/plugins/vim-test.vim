Plug 'janko-m/vim-test'

nmap <silent> <Leader><Leader>n :TestNearest<CR>
nmap <silent> <Leader><Leader>f :TestFile<CR>
nmap <silent> <Leader><Leader>s :TestSuite<CR>
nmap <silent> <Leader><Leader>l :TestLast<CR>
nmap <silent> <Leader><Leader>g :TestVisit<CR>

let test#strategy = 'vimterminal'
