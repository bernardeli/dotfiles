Plug 'tpope/vim-rails'

let g:rails_projections = {
  \ "app/lib/*.rb": {
  \   "test": [
  \     "spec/lib/{}_spec.rb"
  \   ],
  \ }}

set path+=app/mounts/**,frontend/components/**
