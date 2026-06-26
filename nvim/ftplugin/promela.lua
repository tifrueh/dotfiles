if not (vim.fn.filereadable(vim.fn.getcwd().."/makefile") or vim.fn.filereadable(vim.fn.getcwd().."/Makefile")) then
    vim.bo.makeprg = '(spin -a "%" && cc -o pan pan.c)'
end

vim.cmd('set errorformat+=spin:\\ %f:%l\\\\,\\ Error:\\ %m')
