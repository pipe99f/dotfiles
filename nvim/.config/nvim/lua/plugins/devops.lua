return {

	{
		"nosduco/remote-sshfs.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		opts = {},
		cmd = { "RemoteSSHFSConnect" },
		keys = {
			{
				"<leader>rc",
				function()
					require("remote-sshfs.api").connect()
				end,
				desc = "SSHFS Connect",
			},
			{
				"<leader>rd",
				function()
					require("remote-sshfs.api").disconnect()
				end,
				desc = "SSHFS Disconnect",
			},
			{
				"<leader>re",
				function()
					require("remote-sshfs.api").edit()
				end,
				desc = "SSHFS Edit Connections",
			},
		},
	},
	--Docker
	{
		"emrearmagan/dockyard.nvim",
		dependencies = {
			"akinsho/toggleterm.nvim", -- optional
		},
		cmd = { "Dockyard", "DockyardFloat" },
		lazy = true,
		config = function()
			require("dockyard").setup({})
		end,
	},

	-- HTTP / REST files
	{
		"mistweaverco/kulala.nvim",
		keys = {
			{ "<leader>ks", desc = "Send request" },
			{ "<leader>ka", desc = "Send all requests" },
			{ "<leader>kb", desc = "Open scratchpad" },
		},
		ft = { "http", "rest" },
		dependencies = {},
		opts = {
			-- your configuration comes here
			global_keymaps = true,
			global_keymaps_prefix = "<leader>k",
			kulala_keymaps_prefix = "",
			kulala_keymaps = {
				["Show verbose"] = {
					"<leader>kv",
					function()
						require("kulala.ui").show_verbose()
					end,
				},
			},
		},
	},

	-- Kubernetes
	{
		"ramilito/kubectl.nvim",
		config = function()
			require("kubectl").setup()
		end,
		keys = {
			{ "<leader>K", '<cmd>lua require("kubectl").toggle()<cr>', desc = "Toggle kubectl" },
		},
	},

	-- Kustomize
	{
		"allaman/kustomize.nvim",
		dependencies = {
			-- (optional for better directory handling in "List resources")
			-- "nvim-neo-tree/neo-tree.nvim",
			-- (optional for better directory handling in "List resources")
			-- "A7Lavinraj/fyler.nvim",
			-- (optional for snippets)
			-- "L3MON4D3/LuaSnip",
		},
		ft = "yaml",
		---@type KustomizeConfig
		opts = {},
	},

	{
		"allaman/tf.nvim",
		---@module "tf"
		---@type tf.ConfigPartial
		opts = {},
		ft = "terraform",
	},
}
