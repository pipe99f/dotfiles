return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("nvim-treesitter.configs").setup({
			-- A list of parser names, or "all"
			ensure_installed = {
				"bash",
				"c",
				"csv",
				"cpp",
				"css",
				"dockerfile",
				"go",
				"html",
				"javascript",
				"json",
				"julia",
				"lua",
				"markdown",
				"markdown_inline",
				"nim",
				"norg",
				"python",
				"r",
				"rnoweb", -- required by plugin R.nvim
				"regex",
				"rust",
				"scala",
				"sql",
				"typescript",
				"yaml",
			},
			ignore_install = { "latex" },

			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = true,

			-- List of parsers to ignore installing (for "all")
			-- ignore_install = { "javascript" },

			highlight = {
				-- `false` will disable the whole extension
				enable = true,

				-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
				-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
				-- the name of the parser)
				-- list of language that will be disabled
				-- disable = { "c", "rust" },

				-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
				-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
				-- Using this option may slow down your editor, and you may see some duplicate highlights.
				-- Instead of true it can also be a list of languages
				-- additional_vim_regex_highlighting = false,
			},

			incremental_selection = {
				enable = true,

				keymaps = {

					node_incremental = "v",

					node_decremental = "V",

					scope_incremental = "<c-s>",
				},
			},

			-- Based on molten suggest (https://github.com/benlubas/molten-nvim/blob/main/docs/Notebook-Setup.md)
			-- Conflicts with nvim-R
			-- textobjects = {
			-- 	move = {
			-- 		enable = true,
			-- 		set_jumps = false, -- you can change this if you want.
			-- 		goto_next_start = {
			-- 			--- ... other keymaps
			-- 			["]b"] = { query = "@code_cell.inner", desc = "next code block" },
			-- 		},
			-- 		goto_previous_start = {
			-- 			--- ... other keymaps
			-- 			["[b"] = { query = "@code_cell.inner", desc = "previous code block" },
			-- 		},
			-- 	},
			-- 	select = {
			-- 		enable = true,
			-- 		lookahead = true, -- you can change this if you want
			-- 		keymaps = {
			-- 			--- ... other keymaps
			-- 			["ib"] = { query = "@code_cell.inner", desc = "in block" },
			-- 			["ab"] = { query = "@code_cell.outer", desc = "around block" },
			-- 		},
			-- 	},
			-- 	swap = { -- Swap only works with code blocks that are under the same
			-- 		-- markdown header
			-- 		enable = true,
			-- 		swap_next = {
			-- 			--- ... other keymap
			-- 			["<leader>sbl"] = "@code_cell.outer",
			-- 		},
			-- 		swap_previous = {
			-- 			--- ... other keymap
			-- 			["<leader>sbh"] = "@code_cell.outer",
			-- 		},
			-- 	},
			-- },
		})

		--enable autotag
		vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
			underline = true,
			virtual_text = {
				spacing = 5,
				severity = { min = vim.diagnostic.severity.WARN },
				-- min = severity,
			},
			update_in_insert = true,
		})
	end,
}
