return {

	------
	-- Avante
	------

	{
		"yetone/avante.nvim",
		-- event = "VeryLazy",
		cmd = "AvanteAsk",
		lazy = true,
		version = false, -- set this to "*" if you want to always pull the latest change, false to update on release
		opts = {
			-- add any opts here
			auto_suggestions_provider = "copilot", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
			provider = "deepseek",
			vendors = {
				deepseek = {
					__inherited_from = "openai",
					api_key_name = "DEEPSEEK_API_KEY",
					endpoint = "https://api.deepseek.com",
					model = "deepseek-chat",
					-- model = "deepseek-reasoner", -- two times more expensive than deepseek-chat
					timeout = 30000, -- Timeout in milliseconds
					temperature = 0,
					max_tokens = 4096,
				},
			},
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua", -- for providers='copilot'
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				-- event = "VeryLazy",
				keys = {
					-- suggested keymap
					{ "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
				},
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
		},
	},

	------
	-- Codecompanion
	------
	{
		"olimorris/codecompanion.nvim",
		cmd = { "CodeCompanionChat" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			{ "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
		},
		config = function()
			require("codecompanion").setup({
				-- Can't find a way to setup deekseek
				strategies = {
					chat = { adapter = "deepseek" },
					inline = { adapter = "deepseek" },
				},
				adapters = {
					deepseek = function()
						return require("codecompanion.adapters").extend("deepseek", {
							env = {
								api_key = "DEEPSEEK_API_KEY",
							},
							schema = {
								model = {
									default = "deepseek-chat",
								},
							},
						})
					end,
				},
			})
		end,
	},

	------
	-- Codeium
	------
	{
		"Exafunction/codeium.nvim",
		event = "InsertEnter",
		opts = {
			-- enable_chat = true,
		},
		build = ":Codeium Auth",
	},

	------
	-- Copilot
	------
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		-- event = "InsertEnter",
		config = function()
			require("copilot").setup({})
		end,
	},

	------
	-- Supermaven
	------
	-- {
	-- 	"supermaven-inc/supermaven-nvim",
	-- 	config = function()
	-- 		require("supermaven-nvim").setup({})
	-- 	end,
	-- },
}
