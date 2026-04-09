return {
	"romus204/tree-sitter-manager.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main", event = "VeryLazy" },
	config = function()
		parsers = {
			"bash",
			"c",
			-- "csv", -- built-in highlights are better, csvview.nvim is better as well
			"cpp",
			"css",
			"cuda",
			"dockerfile",
			"go",
			"gitcommit",
			"git_rebase",
			"html",
			-- "http",
			"javascript",
			"json",
			"julia",
			"lua",
			"markdown",
			"markdown_inline",
			"python",
			"r",
			"rnoweb", -- required by plugin R.nvim
			"regex",
			"rst",
			"rust",
			"scala",
			"sql",
			"toml",
			"typescript",
			"xml",
			"yaml",
		}
		require("tree-sitter-manager").setup({
			ensure_installed = parsers, -- list of parsers to install automatically
		})

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local lang = vim.treesitter.language.get_lang(args.match)
				if lang and vim.treesitter.language.add(lang) then
					vim.treesitter.start()
					vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})

		require("nvim-treesitter-textobjects").setup({
			-- ... other ts config
			textobjects = {
				move = {
					enable = true,
					set_jumps = false, -- you can change this if you want.
					goto_next_start = {
						--- ... other keymaps
						["]b"] = { query = "@code_cell.inner", desc = "next code block" },
					},
					goto_previous_start = {
						--- ... other keymaps
						["[b"] = { query = "@code_cell.inner", desc = "previous code block" },
					},
				},
				select = {
					enable = true,
					lookahead = true, -- you can change this if you want
					keymaps = {
						--- ... other keymaps
						["ib"] = { query = "@code_cell.inner", desc = "in block" },
						["ab"] = { query = "@code_cell.outer", desc = "around block" },
					},
				},
				swap = { -- Swap only works with code blocks that are under the same
					-- markdown header
					enable = true,
					swap_next = {
						--- ... other keymap
						["<leader>sbl"] = "@code_cell.outer",
					},
					swap_previous = {
						--- ... other keymap
						["<leader>sbh"] = "@code_cell.outer",
					},
				},
			},
		})
	end,
}
