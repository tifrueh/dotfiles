vim.bo.makeprg = 'pandoc --embed-resources --mathjax --standalone --shift-heading-level-by=-1 -f gfm-implicit_figures -t html5 -o /tmp/pandoc.html "%"'
vim.bo.spelllang = 'en_gb'
vim.bo.textwidth = 80
vim.wo.concealcursor = ''
vim.wo.conceallevel = 2
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.wo.foldmethod = 'expr'
vim.wo.foldlevel = 99
vim.wo.spell = true

vim.api.nvim_buf_create_user_command(
    0,
    'Column',
    '<line1>,<line2>!tr -s " " | column -t -s "|" -o "|"',
    { range = true }
)
