" my options
set number
syntax on

" vim-plug
call plug#begin("~/.vim/plugged")

Plug 'sonph/onehalf', { 'rtp': 'vim' }

Plug 'dracula/vim', { 'as': 'dracula' }

Plug 'itchyny/lightline.vim'

call plug#end()

" lightline
set laststatus=2
set noshowmode

" onehalfdark colorscheme
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
set t_Co=256
colorscheme dracula
let g:lightline = { 'colorscheme': 'dracula' }

