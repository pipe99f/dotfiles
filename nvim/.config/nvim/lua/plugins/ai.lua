return {

	------
	-- Agentic.nvim
	------
	{
		"carlos-algms/agentic.nvim",

		opts = {
			-- Any ACP-compatible provider works. Built-in: "claude-agent-acp" | "gemini-acp" | "codex-acp" | "opencode-acp" | "cursor-acp" | "copilot-acp" | "auggie-acp" | "mistral-vibe-acp" | "cline-acp" | "goose-acp"
			provider = "claude-agent-acp", -- setting the name here is all you need to get started
		},

		-- these are just suggested keymaps; customize as desired
		keys = {
			{
				"<C-\\>",
				function()
					require("agentic").toggle()
				end,
				mode = { "n", "v", "i" },
				desc = "Toggle Agentic Chat",
			},
			{
				"<C-'>",
				function()
					require("agentic").add_selection_or_file_to_context()
				end,
				mode = { "n", "v" },
				desc = "Add file or selection to Agentic to Context",
			},
			{
				"<C-,>",
				function()
					require("agentic").new_session()
				end,
				mode = { "n", "v", "i" },
				desc = "New Agentic Session",
			},
			{
				"<A-i>r", -- ai Restore
				function()
					require("agentic").restore_session()
				end,
				desc = "Agentic Restore session",
				silent = true,
				mode = { "n", "v", "i" },
			},
			{
				"<leader>ad", -- ai Diagnostics
				function()
					require("agentic").add_current_line_diagnostics()
				end,
				desc = "Add current line diagnostic to Agentic",
				mode = { "n" },
			},
			{
				"<leader>aD", -- ai all Diagnostics
				function()
					require("agentic").add_buffer_diagnostics()
				end,
				desc = "Add all buffer diagnostics to Agentic",
				mode = { "n" },
			},
		},
	},

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
			"ravitemer/mcphub.nvim",
			--- The below dependencies are optional,
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
	-- {
	-- 	"olimorris/codecompanion.nvim",
	-- 	cmd = { "CodeCompanionChat" },
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		"ravitemer/mcphub.nvim",
	-- 		{ "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
	-- 	},
	-- 	config = function()
	-- 		require("codecompanion").setup({
	-- 			-- Can't find a way to setup deekseek
	-- 			strategies = {
	-- 				chat = { adapter = "deepseek" },
	-- 				inline = { adapter = "deepseek" },
	-- 			},
	-- 			extensions = {
	-- 				mcphub = {
	-- 					callback = "mcphub.extensions.codecompanion",
	-- 					opts = {
	-- 						make_vars = true,
	-- 						make_slash_commands = true,
	-- 						show_result_in_chat = true,
	-- 					},
	-- 				},
	-- 			},
	-- 			adapters = {
	-- 				deepseek = function()
	-- 					return require("codecompanion.adapters").extend("deepseek", {
	-- 						env = {
	-- 							api_key = "DEEPSEEK_API_KEY",
	-- 						},
	-- 						schema = {
	-- 							model = {
	-- 								default = "deepseek-chat",
	-- 							},
	-- 						},
	-- 					})
	-- 				end,
	-- 			},
	-- 		})
	-- 	end,
	-- },

	--------
	--- Claude Code preview
	--------
	{
		"Cannon07/claude-preview.nvim",
		config = function()
			require("claude-preview").setup()
		end,
		cmd = { "ClaudePreviewInstallHooks", "CodePreviewInstallOpenCodeHooks" },
	},

	------
	-- Codeium
	------
	{
		"Exafunction/codeium.nvim",
		-- event = "InsertEnter",
		cmd = "Codeium",
		opts = {
			-- enable_chat = true,
		},
		build = ":Codeium Auth",
	},

	{
		"monkoose/neocodeium",
		-- event = "VeryLazy",
		-- event = "InsertEnter",
		cmd = "NeoCodeium enable",
		config = function()
			local neocodeium = require("neocodeium")
			neocodeium.setup()
			vim.keymap.set("i", "<M-f>", neocodeium.accept)
			vim.keymap.set("i", "<C-]>", function()
				neocodeium.clear()
			end)
			vim.keymap.set("i", "<C-j>", function()
				neocodeium.accept_word()
			end)
		end,
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
	{
		"supermaven-inc/supermaven-nvim",
		event = "InsertEnter",
		config = function()
			require("supermaven-nvim").setup({
				keymaps = {
					accept_suggestion = "<M-f>",
					clear_suggestion = "<C-]>",
					accept_word = "<C-j>",
				},
			})
		end,
	},
}
