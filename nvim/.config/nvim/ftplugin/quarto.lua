-- Treesitter settings
-- require("nvim-treesitter.configs").setup({
-- 	textobjects = {
-- 		move = {
-- 			enable = true,
-- 			set_jumps = false, -- you can change this if you want.
-- 			goto_next_start = {
-- 				--- ... other keymaps
-- 				["]b"] = { query = "@code_cell.inner", desc = "next code block" },
-- 			},
-- 			goto_previous_start = {
-- 				--- ... other keymaps
-- 				["[b"] = { query = "@code_cell.inner", desc = "previous code block" },
-- 			},
-- 		},
-- 		select = {
-- 			enable = true,
-- 			lookahead = true, -- you can change this if you want
-- 			keymaps = {
-- 				--- ... other keymaps
-- 				["ib"] = { query = "@code_cell.inner", desc = "in block" },
-- 				["ab"] = { query = "@code_cell.outer", desc = "around block" },
-- 			},
-- 		},
-- 		swap = { -- Swap only works with code blocks that are under the same
-- 			-- markdown header
-- 			enable = true,
-- 			swap_next = {
-- 				--- ... other keymap
-- 				["<leader>sbl"] = "@code_cell.outer",
-- 			},
-- 			swap_previous = {
-- 				--- ... other keymap
-- 				["<leader>sbh"] = "@code_cell.outer",
-- 			},
-- 		},
-- 	},
-- })

----
-- Hydra settings
----
local function keys(str)
	return function()
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(str, true, false, true), "m", true)
	end
end

local hydra = require("hydra")
hydra({
	name = "QuartoNavigator",
	hint = [[
      _j_/_k_: move down/up  _r_: run cell
      _l_: run line  _R_: run above
      ^^     _<esc>_/_q_: exit ]],
	config = {
		color = "pink",
		invoke_on_body = true,
		hint = {
			float_opts = {
				border = "rounded", -- you can change the border if you want
			},
		},
	},
	mode = { "n" },
	body = "<leader>h", -- this is the key that triggers the hydra
	heads = {
		{ "j", keys("]b") },
		{ "k", keys("[b") },
		{ "r", ":QuartoSend<CR>" },
		{ "l", ":QuartoSendLine<CR>" },
		{ "R", ":QuartoSendAbove<CR>" },
		{ "<esc>", nil, { exit = true } },
		{ "q", nil, { exit = true } },
	},
})
