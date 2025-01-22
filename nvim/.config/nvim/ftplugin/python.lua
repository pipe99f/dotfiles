local hydra = require("hydra")
hydra({
	name = "PythonNavigator",
	hint = [[
 _j_/_k_: move down/up   _c_: comment     _a_/_b_: add cell above/below
_d_: run & move down  _s_: split cell   _r_: run
                    _<esc>_/_q_: exit
]],
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
		{ "k", "<cmd>lua require('notebook-navigator').move_cell('u')<cr>" },
		{ "j", "<cmd>lua require('notebook-navigator').move_cell('d')<cr>" },
		{ "c", "<cmd>lua require('notebook-navigator').comment_cell()<cr>" },
		{ "a", "<cmd>lua require('notebook-navigator').add_cell_above()<cr>" },
		{ "b", "<cmd>lua require('notebook-navigator').add_cell_below()<cr>" },
		{ "d", "<cmd>lua require('notebook-navigator').run_and_move()<cr>" },
		{ "s", "<cmd>lua require('notebook-navigator').split_cell()<cr>" },
		{ "r", "<cmd>lua require('notebook-navigator').run_cell()<cr>" },
		{ "<esc>", nil, { exit = true } },
		{ "q", nil, { exit = true } },
	},
})

-- Mappings
--
