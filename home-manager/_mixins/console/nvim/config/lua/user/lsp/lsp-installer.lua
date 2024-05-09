local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  print("No nvim-lsp-installer")
  return
end
lsp_installer.setup{}
-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

   if server.name == "lua_ls" then
      require("lspconfig").lua_ls.setup()
   end

   if server.name == "pyright" then
    local pyright_opts = require("user.lsp.settings.pyright")
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
   end
   if server.name == "clangd" then
      require("lspconfig").clangd.setup()
    --local clnangd_opts = require("user.lsp.settings.clangd")
    --opts = vim.tbl_deep_extend("force", clangd_opts, opts)
   end


  -- This setup() function is exactly the same as lspconfig's setup function.
  -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  --server:setup(opts)
end)
