return {
	{
		"nvimtools/hydra.nvim",
		event = "VeryLazy",
	},
	{
		"aaronik/treewalker.nvim", -- Move fast between treesitter nodes
		event = "BufEnter",

		-- The following options are the defaults.
		-- Treewalker aims for sane defaults, so these are each individually optional,
		-- and setup() does not need to be called, so the whole opts block is optional as well.
		opts = {
			-- Whether to briefly highlight the node after jumping to it
			highlight = true,

			-- How long should above highlight last (in ms)
			highlight_duration = 250,

			-- The color of the above highlight. Must be a valid vim highlight group.
			-- (see :h highlight-group for options)
			highlight_group = "CursorLine",
		},
		config = function()
			-- TODO: Hacer que los keymaps funcionen con hydra
			-- movement
			vim.keymap.set({ "n", "v" }, "<M-k>", "<cmd>Treewalker Up<cr>", { silent = true })
			vim.keymap.set({ "n", "v" }, "<M-j>", "<cmd>Treewalker Down<cr>", { silent = true })
			vim.keymap.set({ "n", "v" }, "<M-l>", "<cmd>Treewalker Right<cr>", { silent = true })
			vim.keymap.set({ "n", "v" }, "<M-h>", "<cmd>Treewalker Left<cr>", { silent = true })

			-- swapping
			vim.keymap.set("n", "<M-J>", "<cmd>Treewalker SwapDown<cr>", { silent = true })
			vim.keymap.set("n", "<M-K>", "<cmd>Treewalker SwapUp<cr>", { silent = true })
			vim.keymap.set("n", "<M-L>", "<cmd>Treewalker SwapRight<CR>", { silent = true })
			vim.keymap.set("n", "<M-H>", "<cmd>Treewalker SwapLeft<CR>", { silent = true })
		end,
	},

	{
		"folke/flash.nvim",
		-- event = "VeryLazy",
		vscode = true,
		---@type Flash.Config
		opts = {},
  -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
	},

	{ --code exploration picker
		"error311/wayfinder.nvim",
		opts = {},
		keys = { { "<leader>wf", "<Plug>(WayfinderOpen)", desc = "Wayfinder" } },
	},

	{ -- Find and replace
		"MagicDuck/grug-far.nvim",
		cmd = "GrugFar",
		keys = {
			{
				"<leader>sr",
				function()
					local grug = require("grug-far")
					local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
					grug.open({
						transient = true,
						prefills = {
							filesFilter = ext and ext ~= "" and "*." .. ext or nil,
						},
					})
				end,
				mode = { "n", "v" },
				desc = "Search and Replace",
			},
		},
		config = function()
			require("grug-far").setup({
				-- engine = 'ripgrep' is default, but 'astgrep' can be specified
			})
		end,
	},
}
