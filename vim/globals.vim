" Autoindent with two spaces, always expand tabs:
set tabstop=2
set shiftwidth=2
set expandtab

" Folding settings
set nofoldenable

set wildmode=list:longest " make cmdline tab completion similar to bash
set wildmenu " enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ " stuff to ignore when tab completing

" Vertical / horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

set cf " Enable error files & error jumping.
set clipboard+=unnamed " Yanks go on clipboard instead.
let g:yankring_clipboard_monitor=0
set history=256 " Number of things to remember in history.
set autowrite " Writes on make/shell commands
set ruler " Ruler on
set nu " Line numbers on
set wrap " Line wrapping on
set timeoutlen=250 " Time to wait after ESC (default causes an annoying delay)

" Highlight all search results
set incsearch
set hlsearch

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" Ignore case in searches
set ignorecase

" Open splits at right side (and below)
set splitright
set splitbelow

" Never ever let Vim write a backup file! They did that in the 70’s.
" Use modern ways for tracking your changes (like git), for God’s sake
set nobackup
set noswapfile

set backspace=2

" Allow mouse scroll with vim in terminal
set mouse=a

set list listchars=tab:»·,trail:·
autocmd BufWritePre * :%s/\s\+$//e

" Mapping Y to yank from current cursor position till end of line
noremap Y y$

" A trick for when you forgot to sudo before editing a file that requires root privileges (typically /etc/hosts).
" This lets you use w!! to do that after you opened the file already:
cmap w!! w !sudo tee % >/dev/null

" Search and replace selected text (http://stackoverflow.com/questions/676600/vim-search-and-replace-selected-text)
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" F12 reloads the ~/.vimrc file
nnoremap <F12> :source ~/.vimrc<CR>

"clean up search
map <C-L> :noh<CR>

" Improve 'n' command (for searches)
nmap n nzz
nmap N Nzz

"key mapping for tab navigation
nmap <Tab> gt
nmap <S-Tab> gT

"Disable visualbell
set visualbell
set t_vb=

" Jump between ctags and don't lose buffer history
set hidden

" Dont create new buffers
set switchbuf=useopen

" Search for visual selected text
vnoremap # y/<C-R>"<CR>

" saving that shift press
map ; :

" Uses old regex engine
" https://stackoverflow.com/a/16920294
set regexpengine=1

" Git - Always turn on spell check
autocmd FileType gitcommit setlocal spell
