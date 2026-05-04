vim.o.textwidth = 80
vim.o.spell = true
vim.o.spelllang = 'en_gb'
vim.api.nvim_buf_create_user_command(0, 'Make', '!latexmk -pdflua -outdir=/tmp/latexmk -auxdir=/tmp/latexmk/aux "%"', {})
