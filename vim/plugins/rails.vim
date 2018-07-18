Plug 'tpope/vim-rails'

let g:rails_projections = {
  \ "app/lib/*.rb": {
  \   "test": [
  \     "spec/lib/{}_spec.rb"
  \   ],
  \ }}

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
