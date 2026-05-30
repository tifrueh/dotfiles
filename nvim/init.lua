-- Enable line numbers and syntax highlighting.
vim.o.number            = true
vim.cmd('syntax enable')

-- Show and configure listchars.
vim.o.list              = true
vim.o.listchars         = 'trail:·,tab:→ ,lead:·,nbsp:◦'

-- Configure spaces for indentation.
vim.o.tabstop           = 8
vim.o.softtabstop       = 0
vim.o.shiftwidth        = 4
vim.o.smarttab          = true
vim.o.expandtab         = true

-- Break at words.
vim.o.linebreak         = true

-- Enable cursorline.
vim.o.cursorline        = true

-- Use onehalfdark color scheme.
vim.cmd.colorscheme('onehalfdark')

-- Configure floating window borders.
vim.o.winborder         = 'rounded'

-- Use true colors in the color scheme if possible.
if vim.fn.exists('+termguigolors') == 1 then
    vim.v.t_8f          = '\\<Esc>[38;2;%lu;%lu;%lum'
    vim.v.t_8b          = '\\<Esc>[48;2;%lu;%lu;%lum'
    vim.o.termguicolors = true
end

-- Configure whitespace highlighting.
vim.api.nvim_set_hl(0, 'Whitespace', { fg = '#5c6370', bg = nil })
vim.api.nvim_set_hl(0, 'Trail', { fg = nil, bg = '#e06c75' })
vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
    pattern = { '*' },
    command = 'match Trail //'
})
vim.api.nvim_create_autocmd({ 'VimEnter', 'WinEnter', 'InsertLeave' }, {
    pattern = { '*' },
    command = 'match Trail /\\s\\+$/'
})

-- Configure statusline.
vim.o.statusline        = '%< %f %h%w%m%r%=%a  %n :: %Y @ %(%l:%c%) %P '

-- Start treesitter parser if one is available for the current file.
vim.api.nvim_create_autocmd("FileType", {
    callback = function(ev)
        pcall(vim.treesitter.start, ev.buf)
    end
})

-- Set colorcolumn.
vim.o.colorcolumn       = '+1'

-- Configure undo.
vim.bo.undofile         = true
