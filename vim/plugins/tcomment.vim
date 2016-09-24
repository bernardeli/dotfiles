Plugin 'tomtom/tcomment_vim'

let g:tcommentMapLeader1 = ''
noremap <silent> <C-c> :TComment<cr>
vnoremap <silent> <C-c> :TCommentMaybeInline<cr>gv
inoremap <silent> <C-c> <c-o>:TComment<cr>

