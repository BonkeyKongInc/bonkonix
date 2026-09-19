local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config('*', { capabilities = cmp_capabilities })

vim.lsp.config('nil_ls', {
  settings = {
    ['nil'] = {
      formatting = { command = { "nixpkgs-fmt" } }
    }
  }
})

vim.lsp.config('pylsp', {
  settings = {
    pylsp = {
      plugins = {
        jedi_completion = { enabled = true, include_params = true },
        flake8 = { enabled = true },
      },
    },
  }
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf, silent = true }
    vim.keymap.set('n', 'ge', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', '<leader>lt', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>lrn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<leader>ll', vim.diagnostic.setloclist, opts)
    vim.keymap.set('n', '<leader>lca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.format({ async = true }) end, opts)
  end,
})

vim.lsp.enable('clangd')

vim.api.nvim_create_user_command('ClangdSwitchSourceHeader', function()
  local clients = vim.lsp.get_clients({ bufnr = 0, name = 'clangd' })
  if #clients == 0 then
    vim.notify('clangd not attached to this buffer', vim.log.levels.WARN)
    return
  end
  clients[1].request('textDocument/switchSourceHeader', { uri = vim.uri_from_bufnr(0) }, function(err, result)
    if err then vim.notify(tostring(err), vim.log.levels.ERROR); return end
    if not result then vim.notify('No corresponding file found', vim.log.levels.WARN); return end
    vim.cmd.edit(vim.uri_to_fname(result))
  end, 0)
end, {})
vim.lsp.enable('lua_ls')
vim.lsp.enable('nil_ls')
vim.lsp.enable('pylsp')

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
})
