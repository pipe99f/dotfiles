return {
	-- CSV
	{
		"hat0uma/csvview.nvim",
		---@module "csvview"
		---@type CsvView.Options
		opts = {
			parser = { comments = { "#", "//" } },
			keymaps = {
				-- Text objects for selecting fields
				textobject_field_inner = { "if", mode = { "o", "x" } },
				textobject_field_outer = { "af", mode = { "o", "x" } },
				-- Excel-like navigation:
				-- Use <Tab> and <S-Tab> to move horizontally between fields.
				-- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
				-- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
				jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
				jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
				jump_next_row = { "<Enter>", mode = { "n", "v" } },
				jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
			},
		},
		cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
	},

	-- HTML
	{
		"brianhuster/live-preview.nvim",
		ft = { "markdown", "rmd", "pandoc.markdown" },
	},

	-- JSON
	{
		"Owen-Dechow/videre.nvim",
		cmd = "Videre",
		dependencies = {
			"Owen-Dechow/graph_view_yaml_parser", -- Optional: add YAML support
			"Owen-Dechow/graph_view_toml_parser", -- Optional: add TOML support
			"a-usr/xml2lua.nvim", -- Optional | Experimental: add XML support
		},
		opts = {
			box_style = "sharp",
		},
	},

	-- CP
	{
		"kawre/leetcode.nvim",
		cmd = "Leet", --launching from the terminal with "nvim leetcode.nvim" doesnt work
		opts = {},
	},
	{
		"xeluxee/competitest.nvim",
		cmd = "CompetiTest",
		dependencies = "MunifTanjim/nui.nvim",
		config = function()
			require("competitest").setup()
		end,
	},

	-- Neovim config
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings

	-- Indentation
	{
		"nmac427/guess-indent.nvim", -- adjust indent following current buffer style
		event = "VeryLazy",
		config = function()
			require("guess-indent").setup({
				filetype_exclude = { -- A list of filetypes for which the auto command gets disabled
					"lua",
				},
			})
		end,
	},
	{
		"wurli/contextindent.nvim",
		ft = { "markdown", "pandoc.markdown", "quarto", "org", "html" },
		opts = { pattern = "*" },
	},
	-- I don't like indentation behavior in python after function definition, may be fixed in the future
	-- { -- Paste following current indentation
	-- 	"nemanjamalesija/smart-paste.nvim",
	-- 	-- event = "VeryLazy",
	-- 	event = "BufEnter",
	-- 	config = true,
	-- },

	--------------
	----Others----
	--------------
	-- { -- manage environment variables
	-- 	"ph1losof/ecolog2.nvim",
	-- 	-- lazy = false,
	-- 	build = "cargo install ecolog-lsp",
	-- 	keys = {
	-- 		{ "<leader>el", "<cmd>Ecolog list<cr>", desc = "List env variables" },
	-- 		{ "<leader>ef", "<cmd>Ecolog files select<cr>", desc = "Select env file" },
	-- 		{ "<leader>eo", "<cmd>Ecolog files open_active<cr>", desc = "Open active env file" },
	-- 		{ "<leader>er", "<cmd>Ecolog refresh<cr>", desc = "Refresh env variables" },
	-- 	},
	-- 	config = function()
	-- 		require("ecolog").setup()
	-- 	end,
	-- },

	{ "ThePrimeagen/vim-be-good", cmd = "VimBeGood" },

	{
		"alex-popov-tech/store.nvim",
		-- dependencies = { "OXY2DEV/markview.nvim" },
		opts = {},
		cmd = "Store",
	},
	{ -- For loadig very large files
		"minigian/juan-logs.nvim",
		build = function(plugin)
			local path = plugin.dir .. "/build.lua"
			if vim.fn.filereadable(path) == 1 then
				dofile(path)
			end
		end,
		-- You can use `build = "cargo build --release"` if you have `cargo` in your system
		config = function()
			require("juanlog").setup({
				threshold_size = 1024 * 1024 * 100, -- 100MB trigger
				mode = "dynamic", -- I don't remember the other mode name, but it's useless so don't worry
				lazy = true, -- background indexing. prevents neovim from freezing
				dynamic_chunk_size = 10000, -- lines to load at once
				dynamic_margin = 2000, -- trigger scroll load when this close to the edge
				patterns = { "*.log", "*.txt", "*.csv", "*.json" },
				enable_custom_statuscol = true, -- fakes absolute line numbers
				syntax = false, -- set to true to enable native vim syntax (can be slow)
			})
		end,
	},
	{
		"linux-cultist/venv-selector.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			{ "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } }, -- optional: you can also use fzf-lua, snacks, mini-pick instead.
		},
		keys = {
			{ "<space>v", "<cmd>VenvSelect<cr>" }, -- Open picker on keymap
		},
		opts = {},
	},
	{
		"gbprod/yanky.nvim",
		event = "BufEnter",
		opts = {},
	},
	{
		"DrKJeff16/project.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"rmagatti/auto-session",
		lazy = false,
		---enables autocomplete for opts
		---@module "auto-session"
		---@type AutoSession.Config
		opts = {
			suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
			session_lens = {
				load_on_setup = false,
			},
		},
	},

	{ -- Create scratch buffer
		"LintaoAmons/scratch.nvim",
		cmd = "Scratch",
		-- event = "VeryLazy",
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			bigfile = { enabled = true },
			bufdelete = { enabled = true }, -- idk how it improves <leader>bd keybinding
			gitbrowse = { enabled = true },
			image = {
				enabled = true,
				doc = {
					enabled = true,
					inline = false,
					-- max_width = 100,
					-- max_height = 100,
				},
			},
			-- input = { enabled = true },
			lazygit = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scroll = { enabled = true },
			-- statuscolumn = { enabled = true },
			words = { enabled = true }, -- highlights variables
		},
    -- stylua: ignore
    keys = {
      { "<leader>nh",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
      { "<leader>gy", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
      { "<M-g>", function() Snacks.lazygit() end, desc = "Lazygit" },
    -- Check lua use case in repo docs, same thing could be done with more languages
      { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
      { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
	  },
	},

	{ -- Don't forget what I'm doing
		"Hashino/doing.nvim",
		-- event = "VeryLazy",
		cmd = "Do",
		-- keys = {
		--   { "<leader>da", function() require("doing").add() end, {}, },
		--   { "<leader>dn", function() require("doing").done() end, {}, },
		--   { "<leader>de", function() require("doing").edit() end, {}, },
		-- },
	},
}
