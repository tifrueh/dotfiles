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

-- use nvim-web-devicons (required for lualine)
require('nvim-web-devicons').setup()

-- use lualine
vim.cmd.set('noshowmode')
require('lualine').setup{
    options = {
        theme = 'onedark'
    }
}

-- use nvim surround
require('nvim-surround').setup()

-- use nvim-tree
require('nvim-tree').setup()

-- use nvim-treesitter
require('nvim-treesitter.configs').setup {
    -- a list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },

    -- install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- enable highlighting
    highlight = { enable = true }
}
