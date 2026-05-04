vim.bo.textwidth = 80
vim.wo.spell = true
vim.bo.spelllang = 'en_gb'
vim.bo.makeprg = 'pandoc --embed-resources --mathjax --standalone --shift-heading-level-by=-1 -f gfm-implicit_figures -t html5 -o /tmp/pandoc.html "%"'
