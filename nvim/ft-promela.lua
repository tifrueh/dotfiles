vim.bo.makeprg = '(spin -a "%" && cc -o pan pan.c)'
vim.cmd('set errorformat+=spin:\\ %f:%l\\\\,\\ Error:\\ %m')
