" my options
set number
syntax on

" vim-plug
call plug#begin("~/.config/nvim/plugged")

Plug 'sonph/onehalf', { 'rtp': 'vim' }

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
Plug 'nvim-tree/nvim-tree.lua'

Plug 'nvim-lualine/lualine.nvim'

Plug 'lukas-reineke/indent-blankline.nvim'

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
colorscheme onehalfdark
let g:lightline = { 'colorscheme': 'onehalfdark' }

" luafiles
:luafile ~/.config/nvim/nvim-treesitter.lua
:luafile ~/.config/nvim/nvim-tree.lua
:luafile ~/.config/nvim/lualine.lua
:luafile ~/.config/nvim/indent-blankline.lua
