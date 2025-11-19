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
				css = { "prettierd" },
				go = { "goimports", "gofumpt" },
				html = { "prettierd" },
				-- Use a sub-list to run only the first available formatter
				javascript = { "prettierd", "prettier" },
				json = { "prettierd" },
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
				yaml = { "prettierd" },
				["*"] = { "injected" },
			},

			format_on_save = function(bufnr)
				if slow_format_filetypes[vim.bo[bufnr].filetype] then
					return
				end
				-- Disable autoformat on certain filetypes
				-- local ignore_filetypes = { "sql", "java" }
				-- if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
				-- 	return
				-- end

				-- Disable with a global or buffer-local variable
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				-- Disable autoformat for files in a certain path
				local bufname = vim.api.nvim_buf_get_name(bufnr)
				if bufname:match("/node_modules/") then
					return
				end
				-- For slow formatters that time out
				local function on_format(err)
					if err and err:match("timeout$") then
						slow_format_filetypes[vim.bo[bufnr].filetype] = true
					end
				end
				-- ...additional logic...
				return { timeout_ms = 200, lsp_fallback = true }, on_format
			end,

			format_after_save = function(bufnr)
				if not slow_format_filetypes[vim.bo[bufnr].filetype] then
					return
				end
				return { lsp_fallback = true }
			end,
		})
		-- require("conform").formatters.sql_formatter = {
		-- 	prepend_args = { "-c", vim.fn.expand("~/.config/sql_formatter.json") },
		-- }
	end,
}
