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

-- use nvim-lspconfig for ccls
local lspconfig = require('lspconfig')
lspconfig.ccls.setup{
    init_options = {
        compilationDatabaseDirectory = 'build';
    }
}

-- use nvim-treesitter
require('nvim-treesitter.configs').setup {
    highlight = { enable = true }
}
