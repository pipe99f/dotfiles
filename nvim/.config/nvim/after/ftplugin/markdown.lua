require("quarto").activate()

-- Hydra settings
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

-- Enable soft line wrapping
vim.opt_local.wrap = true

-- Wrap lines at convenient points (like spaces) instead of mid-word
vim.opt_local.linebreak = true

-- Do not automatically insert hard line breaks while typing
vim.opt_local.textwidth = 70

-- Remap j and k to move by visual lines, not actual lines
vim.keymap.set("n", "j", "gj", { buffer = true, silent = true })
vim.keymap.set("n", "k", "gk", { buffer = true, silent = true })
