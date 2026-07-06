if not (vim.fn.filereadable(vim.fn.getcwd().."/makefile") == 1 or vim.fn.filereadable(vim.fn.getcwd().."/Makefile") == 1) then
    vim.bo.makeprg = '(spin -a "%" && cc -o pan pan.c)'
end

vim.cmd('set errorformat+=spin:\\ %f:%l\\\\,\\ Error:\\ %m')
