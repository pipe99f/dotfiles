local servers = {
  "bashls", -- lsp
  "clangd",
  "cssls",
  "dockerls",
  "gopls",
  "html",
  "jsonls",
  "ltex",
  "lua_ls",
  "marksman",
  "pyright",
  "r_language_server",
  "rust_analyzer",
  "sqlls",
  "lua_ls",
  "texlab",
  "tsserver",
  -- "shellcheck",
  -- "black", --formatters, no se está instalando automaticamente ningun formatter
  -- "gofumpt",
  -- "prettierd",
  -- "isort",
  -- "shfmt",
  -- "stylua",
}

require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = servers,
})

