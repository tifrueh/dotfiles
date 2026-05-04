vim.o.textwidth = 80
vim.o.spell = true
vim.o.spelllang = 'en_gb'
vim.api.nvim_buf_create_user_command(0, 'Make', '!pandoc --embed-resources --mathjax --standalone --shift-heading-level-by=-1 -f gfm-implicit_figures -t html5 -o /tmp/pandoc.html "%"', {})
