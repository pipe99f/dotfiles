return {
	-------
	-- Filetype specific plugins
	-------
	{
		"p00f/clangd_extensions.nvim",
		lazy = true,
		ft = { "c", "cpp" },
		config = function() end,
		opts = {
			-- inlay_hints = {
			-- 	inline = false,
			-- },
			ast = {
				--These require codicons (https://github.com/microsoft/vscode-codicons)
				role_icons = {
					type = "",
					declaration = "",
					expression = "",
					specifier = "",
					statement = "",
					["template argument"] = "",
				},
				kind_icons = {
					Compound = "",
					Recovery = "",
					TranslationUnit = "",
					PackExpansion = "",
					TemplateTypeParm = "",
					TemplateTemplateParm = "",
					TemplateParamObject = "",
				},
			},
		},
	},
	{
		"scalameta/nvim-metals",
		ft = { "scala", "sbt" },
		opts = function()
			local metals_config = require("metals").bare_config()

			-- Example of settings
			metals_config.settings = {
				showImplicitArguments = true,
				excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
			}

			metals_config.init_options.statusBarProvider = "off"

			-- metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
			-- metals_config.capabilities = require("lsp-zero").get_capabilities()
			metals_config.capabilities = require("blink.cmp").get_lsp_capabilities()

			metals_config.on_attach = function(client, bufnr)
				require("metals").setup_dap()
			end
			return metals_config
		end,
		config = function(self, metals_config)
			local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "scala", "sbt", "java" },
				callback = function()
					require("metals").initialize_or_attach(metals_config)
				end,
				group = nvim_metals_group,
			})
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		ft = { "rust" },
		version = "^4", -- Recommended
		config = function()
			vim.g.rustaceanvim = {
				server = {
					-- capabilities = require("lsp-zero").get_capabilities(),
					capabilities = require("blink.cmp").get_lsp_capabilities(),
					default_settings = {
						-- rust-analyzer language server configuration
						["rust-analyzer"] = {
							cargo = {
								allFeatures = true,
								loadOutDirsFromCheck = true,
								buildScripts = {
									enable = true,
								},
							},
							-- Add clippy lints for Rust.
							checkOnSave = true,
							procMacro = {
								enable = true,
								ignored = {
									["async-trait"] = { "async_trait" },
									["napi-derive"] = { "napi" },
									["async-recursion"] = { "async_recursion" },
								},
							},
						},
					},
				},
			}
		end,
	},

	-- --------
	-- Ricing and other LSP plugins
	-----------
	{
		"rachartier/tiny-code-action.nvim",
		-- event = "LspAttach",
		opts = {},
		keys = { { "<leader>ca", '<cmd> lua require("tiny-code-action").code_action()<cr>' } },
	},
	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		opts = {},
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		-- event = "VeryLazy",
		-- priority = 1000,
		keys = {
			{ "<leader>e", "<cmd>TinyInlineDiag enable<cr>" },
		},
		config = function()
			require("tiny-inline-diagnostic").setup({
				options = {
					multilines = {
						enabled = true,
					},
					show_source = {
						enabled = true,
					},
				},
			})
			vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
		end,
	},
	{
		"hedyhli/outline.nvim",
		keys = { { "<M-o>", "<cmd>Outline<cr>", desc = "Toggle Outline" } },
		cmd = "Outline",
		opts = {},
	},
	{
		"Bekaboo/dropbar.nvim",
		config = function()
			local dropbar_api = require("dropbar.api")
			vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
			vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
			vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
		end,
	},
	{
		"glepnir/lspsaga.nvim",
		-- event = "LspAttach",
		keys = {
			{ "K", "<cmd>Lspsaga hover_doc<CR>", desc = "LSP Hover Docs" },
			-- { "gd", "<cmd>Lspsaga peek_definition<CR>", desc = "Peek Definition" },
			{ "<space>ga", "<cmd>Lspsaga code_action<CR>", desc = "LSP Code Action" },
			{ "gh", "<cmd>Lspsaga finder<CR>", desc = "LSP Finder" },
			{ "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "Previous Diagnostic" },
			{ "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", desc = "Next Diagnostic" },
		},
		config = function()
			require("lspsaga").setup({
				symbol_in_winbar = { enable = false },
			})
		end,
	},
	{ -- Replaces lspsaga peek definition
		"r4ppz/lspeek.nvim",
		opts = {
			window = {
				width = 70,
				height = 15,
				border = "single", -- double | rounded | solid | shadow
			},

			-- Limits the number of stacked preview windows.
			stack_limit = 5,

			-- LSP can return multiple definitions
			-- (e.g., overloaded functions or multiple clients).
			-- false = open vim.ui.select to pick one (pairs well with a picker plugin).
			-- true  = skip the picker and preview the first result.
			select_first = false,

			-- Keymaps available inside the preview window.
			keymaps = {
				close = "q",
				split = "s",
				vsplit = "v",
				enter = "<CR>",
				tab = "t",
				prev = "[",
				next = "]",
			},
		},

		-- Keymaps call the Lua API. Alternatively, use user commands:
		-- :LSPeekDef      -> Peek Definition
		-- :LSPeekTypeDef  -> Peek Type Definition
		keys = {
			{
				"gd",
				function()
					require("lspeek").peek_definition()
				end,
				desc = "Peek Definition (lspeek)",
			},
			{
				"gt",
				function()
					require("lspeek").peek_type_definition()
				end,
				desc = "Peek Type Definition (lspeek)",
			},
		},
	},
}
