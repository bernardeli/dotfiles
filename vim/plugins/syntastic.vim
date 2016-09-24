Plugin 'scrooloose/syntastic'

" Syntastic configs
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_mode_map={ 'mode': 'active',
                         \ 'active_filetypes': ['ruby', 'javascript'],
                         \ 'passive_filetypes': ['html'] }
let g:loaded_syntastic_cucumber_cucumber_checker = 0
let g:syntastic_always_populate_loc_list=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'
let g:syntastic_aggregate_errors = 1
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = '/Users/ric/.nvm/versions/node/v6.2.2/bin/eslint'

