" Auto complete
let g:stop_autocomplete=0

filetype plugin indent on

function! CleverTab(type)
  if a:type=='omni'
    if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
      let g:stop_autocomplete=1
      return "\<TAB>"
    elseif !pumvisible() && !&omnifunc
      return "\<C-X>\<C-O>\<C-P>"
    endif
  elseif a:type=='keyword' && !pumvisible() && !g:stop_autocomplete
    return "\<C-X>\<C-N>\<C-P>"
  elseif a:type=='next'
    if g:stop_autocomplete
      let g:stop_autocomplete=0
    else
      return "\<C-N>"
    endif
  endif
  return ''
endfunction

inoremap <silent><TAB> <C-R>=CleverTab('omni')<CR><C-R>=CleverTab('keyword')<CR><C-R>=CleverTab('next')<CR>

" Completion
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType python     set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html       set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css        set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml        set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php        set omnifunc=phpcomplete#CompletePHP
autocmd FileType c          set omnifunc=ccomplete#Complete

autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

