return {
	"saghen/blink.cmp",
	-- event = "InsertEnter",
	-- optional: provides snippets for the snippet source
	dependencies = {
		"rafamadriz/friendly-snippets",
		-- "evesdropper/luasnip-latex-snippets.nvim",
		"kdheepak/cmp-latex-symbols",
		"hrsh7th/cmp-omni",
		"R-nvim/cmp-r",
		"Kaiser-Yang/blink-cmp-git",
		{
			"fang2hou/blink-copilot",
			opts = {
				max_completions = 1, -- Global default for max completions
				max_attempts = 2, -- Global default for max attempts
				-- `kind` is not set, so the default value is "Copilot"
			},
		},
		-- "Exafunction/codeium.nvim",
		"saghen/blink.compat",
		"xzbdmw/colorful-menu.nvim",
	},

	-- use a release tag to download pre-built binaries
	version = "*",
	-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	-- build = 'cargo build --release',
	-- If you use nix, you can build from source using latest nightly rust with:
	-- build = 'nix run .#build-plugin',

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- 'default' for mappings similar to built-in completion
		-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
		-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
		-- See the full "keymap" documentation for information on defining your own keymap.
		keymap = { preset = "default" },

		appearance = {
			-- Sets the fallback highlight groups to nvim-cmp's highlight groups
			-- Useful for when your theme doesn't support blink.cmp
			-- Will be removed in a future release
			use_nvim_cmp_as_default = true,
			-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
			kind_icons = {
				Copilot = "",
				Codeium = "󰧑",
				Text = "󰉿",
				Method = "󰊕",
				Function = "󰊕",
				Constructor = "󰒓",

				Field = "󰜢",
				Variable = "󰆦",
				Property = "󰖷",

				Class = "󱡠",
				Interface = "󱡠",
				Struct = "󱡠",
				Module = "󰅩",

				Unit = "󰪚",
				Value = "󰦨",
				Enum = "󰦨",
				EnumMember = "󰦨",

				Keyword = "󰻾",
				Constant = "󰏿",

				Snippet = "󱄽",
				Color = "󰏘",
				File = "󰈔",
				Reference = "󰬲",
				Folder = "󰉋",
				Event = "󱐋",
				Operator = "󰪚",
				TypeParameter = "󰬛",
			},
		},
		completion = {
			accept = {
				-- experimental auto-brackets support
				auto_brackets = {
					enabled = true,
				},
			},
			menu = {
				border = "rounded",
				winblend = 0,
				draw = {
					-- treesitter = { "lsp" },
					-- columns = {
					-- 	{ "label", "label_description", gap = 1 },
					-- 	{ "kind_icon" },
					-- },
					columns = { { "kind_icon" }, { "label", gap = 1 } },
					components = {
						label = {
							text = function(ctx)
								return require("colorful-menu").blink_components_text(ctx)
							end,
							highlight = function(ctx)
								return require("colorful-menu").blink_components_highlight(ctx)
							end,
						},
					},
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
				window = {
					border = "rounded",
					winblend = 0,
				},
			},
			ghost_text = {
				-- enabled = vim.g.ai_cmp,
				enabled = false,
			},
		},
		keymap = {
			-- set to 'none' to disable the 'default' preset
			preset = "default",

			["<S-Tab>"] = { "select_prev", "fallback" },
			["<Tab>"] = { "select_next", "fallback" },

			["<C-h>"] = { "snippet_backward" },
			["<C-l>"] = { "snippet_forward" },

			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },

			-- disable a keymap from the preset
			-- ["<C-e>"] = {},

			-- show with a list of providers
			["<C-space>"] = {
				function(cmp)
					cmp.show({ providers = { "snippets" } })
				end,
			},

			-- Cancel selection and hide menu
			["<C-e>"] = { "hide", "fallback" },

			["<C-y>"] = { "select_and_accept" },

			-- control whether the next command will be run when using a function
			["<C-n>"] = {
				function(cmp)
					if some_condition then
						return
					end -- runs the next command
					return true -- doesn't run the next command
				end,
				"select_next",
			},

			-- optionally, separate cmdline keymaps
			-- cmdline = {}
		},

		signature = {
			enabled = true,
			window = {
				border = "rounded",
				winblend = 0,
			},
		},

		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = {
				"lsp",
				"path",
				"snippets",
				"buffer",
				"git",
				"otter",
				"latex_symbols",
				"copilot",
				"codeium",
				"cmp_r",
				"cmp_dbee",
				"lazydev",
			},
			providers = {
				codeium = {
					name = "codeium",
					module = "blink.compat.source",
					score_offset = 100,
					async = true,
					override = {
						get_keyword_pattern = function(self)
							return [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]]
						end,
					},
				},

				otter = {
					name = "otter",
					module = "blink.compat.source",
				},

				latex_symbols = {
					name = "latex_symbols",
					module = "blink.compat.source",
				},
				cmp_r = {
					name = "cmp_r",
					module = "blink.compat.source",
				},
				cmp_dbee = {
					name = "cmp_dbee",
					module = "blink.compat.source",
				},
				lazydev = {
					name = "lazydev",
					module = "blink.compat.source",
				},
				git = {
					module = "blink-cmp-git",
					name = "Git",
					opts = {
						-- options for the blink-cmp-git
					},
				},
				copilot = {
					name = "copilot",
					module = "blink-copilot",
					score_offset = 100,
					async = true,
					opts = {
						-- Local options override global ones
						-- Final settings: max_completions = 3, max_attempts = 2, kind = "Copilot"
						max_completions = 3, -- Override global max_completions
					},
				},
			},
		},
	},
	opts_extend = { "sources.default" },
}
