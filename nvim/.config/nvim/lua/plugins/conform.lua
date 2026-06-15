return {

	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	config = function()
		local slow_format_filetypes = {}
		require("conform").setup({
			formatters = {
				-- rprettify = {
				-- 	inherit = false,
				-- 	stdin = false,
				-- 	command = "rprettify",
				-- 	args = { "$FILENAME" },
				-- },
				injected = {
					options = {
						ignore_errors = false,
						lang_to_formatters = {
							python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
							r = { "air" },
							sql = { "sql_formatter" },
						},
					},
				},
			},

			formatters_by_ft = {
				c = { "clang-format" },
				cpp = { "clang-format" },
				cuda = { "clang-format" },
				css = { "prettierd" },
				-- dockerfile = { "dockerfmt" }, -- formats to very long lines sometimes, I may try this later
				go = { "goimports", "gofumpt" },
				html = { "prettierd" },
				http = { "kulala-fmt" },
				-- Use a sub-list to run only the first available formatter
				javascript = { "prettierd", "prettier" },
				json = { "prettierd" },
				jsonc = { "prettierd" },
				just = { "just" },
				lua = { "stylua" },
				markdown = { "prettierd", "markdownlint" },
				python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
				quarto = { "injected" },
				r = { "air" },
				rmd = { "injected" },
				-- r = { "rprettify" },
				rust = { "rustfmt" },
				sh = { "shellharden", "shfmt" },
				sql = { "sql_formatter" },
				tex = { "latexindent" },
				toml = { "tombi", "pyproject-fmt" },
				yaml = { "prettierd" },
				["*"] = { "injected" },
			},
			default_format_opts = {
				timeout_ms = 3000,
				async = false, -- not recommended to change
				quiet = false, -- not recommended to change
				lsp_format = "fallback", -- not recommended to change
			},
			format_on_save = {
				-- I recommend these options. See :help conform.format for details.
				lsp_format = "fallback",
				timeout_ms = 500,
			},
			format_after_save = {
				lsp_format = "fallback",
			},
		})
	end,
}
