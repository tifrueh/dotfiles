" enable line numbers and syntax highlighting
set number
syntax on

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

" set textwidth to 72 for git commit
autocmd FileType gitcommit set textwidth=72

" enable lightline
set laststatus=2
set noshowmode

" use onehalfdark as lightline color scheme
let g:lightline = {
	\ 'colorscheme': 'one',
	\ 'background': 'dark'
\}
