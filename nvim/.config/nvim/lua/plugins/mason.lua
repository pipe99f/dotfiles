return {
	{
		"williamboman/mason-lspconfig.nvim",
		-- event = "VeryLazy",
		dependencies = {
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"jay-babu/mason-nvim-dap.nvim",
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},

		config = function()
			local servers = {
				"air", -- R
				"basedpyright",
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
				-- "pyright",
				-- "r_language_server",
				"rust_analyzer",
				"sqlls",
				"lua_ls",
				"texlab",
				"tombi", -- toml lsp, linter and formatter
				"ts_ls",
			}

			local tools = {
				--diagnostics/linter
				--"clippy", -- rust linter, it is not supported yet by mason
				"golangci-lint",
				"htmlhint",
				"ruff",
				"sqlfluff",
				"yamllint",

				--formatting
				"clang-format",
				"gofumpt",
				"goimports",
				"kulala-fmt",
				"jupytext",
				"latexindent",
				"markdownlint",
				"prettierd",
				-- "rustfmt", -- must be installed manually
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
				-- automatic_enable = {
				-- 	exclude = {
				-- 		"clangd",
				-- 		"ts_ls",
				-- 	},
				-- },
				automatic_installation = true,
			})

			require("mason-nvim-dap").setup({
				ensure_installed = dapPackages,
				automatic_installation = true,
			})

			require("mason-tool-installer").setup({
				ensure_installed = tools,
				automatic_installation = true,
			})
		end,
	},
}
