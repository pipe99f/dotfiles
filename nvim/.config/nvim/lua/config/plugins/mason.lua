local servers = {
  "bashls", -- lsp
  "clangd",
  "cssls",
  "dockerls",
  "gopls",
  "html",
  "jsonls",
  "julials",
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
}

local nullPackages = {
  --diagnostics
  "shellharden",
  "sqlfluff",

  --formatting
  "black", 
  "gofumpt",
  "isort",
  "latexindent",
  "markdownlint",
  "prettierd",
  "rustfmt",
  "shellcheck",
  "shfmt",
  "sql-formatter",
  "stylua",
}

local dapPackages = {
  'bash',
  'codelldb',
  "python",
}

require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = servers,
})

require("mason-null-ls").setup({
    ensure_installed = nullPackages,
    automatic_installation = true,
})

require("mason-nvim-dap").setup({
    ensure_installed = dapPackages
})
