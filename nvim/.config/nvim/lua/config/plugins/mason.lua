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

local tools = {
	--diagnostics
	"htmlhint",
	"ruff",
	"yamllint",

	--formatting
	"gofumpt",
	"goimports",
	"jupytext",
	"latexindent",
	"markdownlint",
	"prettierd",
	-- "rustfmt",
	"shellcheck",
	"shfmt",
	"sql-formatter",
	"stylua",
}

local dapPackages = {
	"bash",
	"codelldb",
	"python",
}

require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = servers,
})

require("mason-tool-installer").setup({
	ensure_installed = tools,
	automatic_installation = true,
})

require("mason-nvim-dap").setup({
	ensure_installed = dapPackages,
})
