local servers = {
  "bashls", -- lsp
  "clangd",
  "cssls",
  "gopls",
  "html",
  "jsonls",
  "ltex",
  "marksman",
  "pyright",
  "r_language_server",
  "rust_analyzer",
  "shellcheck",
  "sqls",
  "sumneko_lua",
  "texlab",
  "tsserver",
  "black", --formatters, no se está instalando automaticamente ningun formatter
  "gofumpt",
  "prettierd",
  "isort",
  "shfmt",
  "stylua",
}

require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = servers,
})

