return {

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {},

		config = function()
			local highlight = {
				"RainbowRed",
				"RainbowYellow",
				"RainbowBlue",
				"RainbowOrange",
				"RainbowGreen",
				"RainbowViolet",
				"RainbowCyan",
			}
			local hooks = require("ibl.hooks")
			-- create the highlight groups in the highlight setup hook, so they are reset
			-- every time the colorscheme changes
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "Neutro", { fg = "#474747" })
				vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
				vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
				vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
				vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
				vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
				vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
				vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
			end)

			vim.g.rainbow_delimiters = { highlight = highlight }
			require("ibl").setup({
				scope = { highlight = highlight },
			})

			hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
		end,
	},

	{ "nvim-tree/nvim-web-devicons" },
	{
		"nvim-treesitter/nvim-treesitter-context",
		cmd = { "TSContext enable", "TSContext toggle" },
	},

	-- Quickfix
	{ "kevinhwang91/nvim-bqf", ft = "qf" },

	{ -- I think this is complementary to nvim-bqf
		"stevearc/quicker.nvim",
		ft = "qf",
		---@module "quicker"
		---@type quicker.SetupOptions
		opts = {},
	},
	{
		"xiyaowong/nvim-transparent",
		config = function()
			require("transparent").setup({ -- Optional, you don't have to run setup.
				extra_groups = {
					"NormalFloat", -- plugins which have float panel such as Lazy, Mason, LspInfo
					"NvimTreeNormal", -- NvimTree
				},
			})
			require("transparent").clear_prefix("BufferLine")
		end,
		opts = {},
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		event = "BufEnter",
	},
	{
		-- hex code colorizer
		"catgoose/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = {},
	},
	{
		"nvim-focus/focus.nvim", -- Auto resize splits
		version = false,
		cmd = "FocusToggle",
		config = function()
			require("focus").setup()
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = function()
			require("lualine").setup({
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },
					lualine_c = { "diagnostics" },
					lualine_x = {
						{
							"diff",
							source = function()
								local gitsigns = vim.b.gitsigns_status_dict
								if gitsigns then
									return {
										added = gitsigns.added,
										modified = gitsigns.changed,
										removed = gitsigns.removed,
									}
								end
							end,
						},
						{
							function()
								return "  " .. require("dap").status()
							end,
							cond = function()
								return package.loaded["dap"] and require("dap").status() ~= ""
							end,
						},
						"fileformat",
					},
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				extensions = {
					"avante",
					"lazy",
					"mason",
					"nvim-tree",
					"quickfix",
					"toggleterm",
					"trouble",
				},
			})
		end,
	},
	{

		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					mode = "buffers", -- set to "tabs" to only show tabpages instead
					numbers = "none",
					close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
					right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
					left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
					middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
					indicator = {
						icon = "▎", -- this should be omitted if indicator style is not 'icon'
						style = "icon",
					},
					buffer_close_icon = "",
					modified_icon = "●",
					close_icon = "",
					left_trunc_marker = "",
					right_trunc_marker = "",
					--- name_formatter can be used to change the buffer's label in the bufferline.
					--- Please note some names can/will break the
					--- bufferline so use this at your discretion knowing that it has
					--- some limitations that will *NOT* be fixed.
					name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
						-- name                | str        | the basename of the active file
						-- path                | str        | the full path of the active file
						-- bufnr               | int        | the number of the active buffer
						-- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
						-- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`
						-- remove extension from markdown files for example
						if buf.name:match("%.md") then
							return vim.fn.fnamemodify(buf.name, ":t:r")
						end
					end,
					max_name_length = 18,
					max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
					tab_size = 18,
					diagnostics = "nvim_lsp",
					diagnostics_update_in_insert = false,
					diagnostics_indicator = function(count, level, diagnostics_dict, context)
						return "(" .. count .. ")"
					end,
					-- NOTE: this will be called a lot so don't do any heavy processing here
					-- custom_filter = function(buf_number, buf_numbers)
					-- -- filter out filetypes you don't want to see
					-- if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
					-- 	return true
					-- end
					-- -- filter out by buffer name
					-- if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
					-- 	return true
					-- end
					-- -- filter out based on arbitrary rules
					-- -- e.g. filter out vim wiki buffer from tabline in your work repo
					-- if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
					-- 	return true
					-- end
					-- -- filter out by it's index number in list (don't show first buffer)
					-- if buf_numbers[1] ~= buf_number then
					-- 	return true
					-- end
					-- end,
					offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "center" } },
					color_icons = true, -- whether or not to add the filetype icon highlights
					-- show_buffer_default_icon = true, -- whether or not an unrecognised filetype should show a default icon
					get_element_icon = function(element)
						local icon, hl =
							require("nvim-web-devicons").get_icon_by_filetype(element.filetype, { default = false })
						return icon, hl
					end,

					show_buffer_icons = true, -- disable filetype icons for buffers
					show_buffer_close_icons = false,
					show_close_icon = false,
					show_tab_indicators = true,
					persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
					-- can also be a table containing 2 custom separators
					-- [focused and unfocused]. eg: { '|', '|' }
					separator_style = "thin",
					enforce_regular_tabs = true,
					always_show_bufferline = true,
					hover = {
						enabled = true,
						delay = 200,
						reveal = { "close" },
					},
					sort_by = "insert_after_current",
					-- add custom logic
				},
			})
		end,
	},
}
