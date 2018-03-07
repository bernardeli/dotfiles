Plugin 'w0rp/ale'
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
let g:ale_set_highlights = 0

let g:ale_fixers = {
\  'typescript': ['prettier'],
\ }

let g:ale_fix_on_save = 1
