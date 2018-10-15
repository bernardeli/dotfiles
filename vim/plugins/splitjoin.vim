Plug 'AndrewRadev/splitjoin.vim'

let g:splitjoin_trailing_comma = 1
let b:splitjoin_trailing_comma = 1
let g:splitjoin_ruby_hanging_args = 0
let b:splitjoin_ruby_hanging_args = 0
let g:splitjoin_ruby_curly_braces = 0

nmap sj :SplitjoinSplit<cr>
nmap sk :SplitjoinJoin<cr>
