" enable line numbers and syntax highlighting
set number
syntax on

" use onehalfdark color scheme
set t_Co=256
colorscheme onehalfdark

" use true colors in the color scheme if possible
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

