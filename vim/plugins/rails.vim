Plugin 'tpope/vim-rails'

function! OpenGemfile()
  if filereadable("Gemfile")
    execute ":tabnew Gemfile"
  end
endfunction
map <Leader>g :call OpenGemfile()<CR>

function! OpenRoutes()
  if filereadable("config/routes.rb")
    execute ":tabnew config/routes.rb"
  end
endfunction
map <Leader>r :call OpenRoutes()<CR>

function! OpenSpecHelper()
  if filereadable("spec/spec_helper.rb")
    execute ":tabnew spec/spec_helper.rb"
  end
endfunction
map <Leader>s :call OpenSpecHelper()<CR>

" Convert Ruby 1.8 to 1.9 Hash Syntax
" http://robots.thoughtbot.com/convert-ruby-1-8-to-1-9-hash-syntax
function ConvertRubyHashSyntax()
  %s/:\([^ ]*\)\(\s*\)=>/\1:/g
  ''
:endfunction
nnoremap <leader>h :call ConvertRubyHashSyntax()<cr>
