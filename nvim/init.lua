-- enable line numbers and syntax highlighting
vim.cmd.set('number')
vim.cmd.syntax('on')

-- show listchars
vim.cmd.set('list')

-- configure spaces for intentation
vim.cmd.set('tabstop=8')
vim.cmd.set('softtabstop=0')
vim.cmd.set('shiftwidth=4')
vim.cmd.set('smarttab')
vim.cmd.set('expandtab')


-- break at words
vim.cmd.set('linebreak')


-- enable cursorline
vim.cmd.set('cursorline')

-- use onehalfdark color scheme
vim.cmd.set('t_Co=256')
vim.cmd.colorscheme('onehalfdark')

-- use true colors in the color scheme if possible
vim.cmd([[
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif
]])

-- whitespace highlighting
vim.cmd([[
set listchars=trail:·,tab:→\ ,lead:·,nbsp:◦
highlight Whitespace ctermfg=241 ctermbg=NONE guifg=#5c6370 guibg=NONE
highlight Trail ctermfg=NONE ctermbg=168 guifg=NONE guibg=#e06c75
autocmd InsertEnter * match Trail //
autocmd VimEnter,WinEnter,InsertLeave * match Trail /\s\+$/
]])

-- "TODO" highlighting
vim.cmd([[
autocmd VimEnter,WinEnter * 2match Todo /TODO/
]])

-- set up statusline
vim.cmd([[
set statusline=%f\ %<%h%w%m%r%=%a\ \ %n\ ::\ %Y\ @\ %(%l:%c%)\ %P
]])
