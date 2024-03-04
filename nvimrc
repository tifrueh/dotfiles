" enable line numbers and syntax highlighting
set number
syntax on

" configure spaces for intentation
set tabstop=8 softtabstop=0
set shiftwidth=4
set smarttab
set expandtab

" enable cursorline
set cursorline

" use onehalfdark color scheme
set t_Co=256
colorscheme onehalfdark

" use true colors in the color scheme if possible
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" use nvim-web-devicons (required for lualine)
lua require('nvim-web-devicons').setup()

" use lualine
set noshowmode
lua require('lualine').setup{ options = { theme = 'onedark' } }

" use nvim surround
lua require('nvim-surround').setup()

" use nvim-tree
lua require('nvim-tree').setup()
