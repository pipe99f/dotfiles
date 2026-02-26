return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = { "MeanderingProgrammer/treesitter-modules.nvim" },
		build = ":TSUpdate",
		lazy = false,
		branch = "main",
	},
	{
		"MeanderingProgrammer/treesitter-modules.nvim",
		dependencies = {
			-- "nvim-treesitter/nvim-treesitter",
			{ "nvim-treesitter/nvim-treesitter-textobjects", branch = "main", event = "VeryLazy" },
		},
		opts = {

			ignore_install = { "latex" },

			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = true,

			highlight = {
				enable = true,
			},

			indent = {
				enable = true,
				-- disable = { "python" },
			},

			incremental_selection = {
				enable = true,

				keymaps = {

					node_incremental = "v",

					node_decremental = "V",

					scope_incremental = "<c-s>",
				},
			},
			fold = { enable = true },
		},
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
				"http",
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
			require("nvim-treesitter").install(parsers)
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
	},
}
