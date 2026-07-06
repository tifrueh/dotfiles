vim.bo.textwidth = 80
vim.wo.spell = true
vim.bo.spelllang = 'en_gb'

if not (vim.fn.filereadable(vim.fn.getcwd().."/makefile") == 1 or vim.fn.filereadable(vim.fn.getcwd().."/Makefile") == 1) then
    vim.bo.makeprg = 'latexmk -pdflua -outdir=/tmp/latexmk -auxdir=/tmp/latexmk/aux "%"'
end
