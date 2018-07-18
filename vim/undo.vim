" taken from jasoncodes/dotfiles vim/config/undo.vim

if !isdirectory(expand("~/.vim/.undo/"))
  silent !mkdir -p ~/.vim/.undo/
endif
set undodir=$HOME/.vim/.undo
set undofile
set undolevels=1000
set undoreload=10000
