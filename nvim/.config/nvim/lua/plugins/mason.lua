return {

	"williamboman/mason-lspconfig.nvim",
	dependencies = { "WhoIsSethDaniel/mason-tool-installer.nvim", "jay-babu/mason-nvim-dap.nvim" },

	config = function()
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
			"nim_langserver",
			"pyright",
			"r_language_server",
			"rust_analyzer",
			"sqlls",
			"lua_ls",
			"texlab",
			"ts_ls",
		}

		local tools = {
			--diagnostics
			"htmlhint",
			"ruff",
			"yamllint",

			--formatting
			"clang-format",
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
	end,
}
