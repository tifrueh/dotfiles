vim.bo.textwidth = 80
vim.wo.spell = true
vim.bo.spelllang = 'en_gb'

if not (vim.fn.filereadable(vim.fn.getcwd().."/makefile") or vim.fn.filereadable(vim.fn.getcwd().."/Makefile")) then
    vim.bo.makeprg = 'asciidoctor -o /tmp/asciidoctor.html "%"'
end
