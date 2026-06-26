if not (vim.fn.filereadable(vim.fn.getcwd().."/makefile") or vim.fn.filereadable(vim.fn.getcwd().."/Makefile")) then
    vim.bo.makeprg = 'viper-silicon $* "%"'
end

vim.bo.errorformat = '%m(%f@%l.%c--%e.%k)'

local ns = vim.api.nvim_create_namespace("silicon")
vim.api.nvim_buf_create_user_command(
    0,
    'Verify',
    function ()
        vim.cmd('make')
        vim.diagnostic.set(
            ns,
            0,
            vim.diagnostic.fromqflist(vim.fn.getqflist())
        )
    end,
    {}
)
