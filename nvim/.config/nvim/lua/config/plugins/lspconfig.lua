-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }


--Highlighting

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]] ,
      false
    )
  end
end

vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl',
    '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting_sync(nil, 10000)<CR>', opts)
  lsp_highlight_document(client)
end



-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

--lsp setups
require('config.plugins.lsp.bashls')
require('config.plugins.lsp.clangd')
require('config.plugins.lsp.cssls')
require('config.plugins.lsp.gopls')
require('config.plugins.lsp.html')
require('config.plugins.lsp.ltex')
require('config.plugins.lsp.marksman')
require('config.plugins.lsp.pyright')
require('config.plugins.lsp.r_language_server')
require('config.plugins.lsp.rust_analyzer')
require('config.plugins.lsp.sqlls')
require('config.plugins.lsp.lua_ls')
require('config.plugins.lsp.texlab')
require('config.plugins.lsp.tsserver')

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
-- for _, lsp in pairs(servers) do
--   require('lspconfig')[lsp].setup {
--     on_attach = on_attach,
--     -- capabilites = capabilites,
--     flags = {
--       -- This will be the default in neovim 0.7+
--       debounce_text_changes = 150,
--     }
--   }
-- end
--
-- The following example advertise capabilities to `clangd`.
-- require'lspconfig'.clangd.setup {
-- capabilities = capabilities,
-- }

--UI
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=NONE]]
-- vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=NONE]]



--diagnostics in floating windows
-- vim.o.updatetime = 250
-- vim.cmd [[autocmd! CursorHold,CursorHoldI * silent! lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]
