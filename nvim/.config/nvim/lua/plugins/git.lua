return {
	{
		event = "VeryLazy",
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				on_attach = function(bufnr)
					local gitsigns = require("gitsigns")

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "]c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "]c", bang = true })
						else
							gitsigns.nav_hunk("next")
						end
					end)

					map("n", "[c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "[c", bang = true })
						else
							gitsigns.nav_hunk("prev")
						end
					end)

					-- Actions
					map("n", "<leader>hs", gitsigns.stage_hunk)
					map("n", "<leader>hr", gitsigns.reset_hunk)

					map("v", "<leader>hs", function()
						gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end)

					map("v", "<leader>hr", function()
						gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end)

					map("n", "<leader>hS", gitsigns.stage_buffer)
					map("n", "<leader>hR", gitsigns.reset_buffer)
					map("n", "<leader>hp", gitsigns.preview_hunk)
					map("n", "<leader>hi", gitsigns.preview_hunk_inline)

					map("n", "<leader>hb", function()
						gitsigns.blame_line({ full = true })
					end)

					map("n", "<leader>hd", gitsigns.diffthis)

					map("n", "<leader>hD", function()
						gitsigns.diffthis("~")
					end)

					map("n", "<leader>hQ", function()
						gitsigns.setqflist("all")
					end)
					map("n", "<leader>hq", gitsigns.setqflist)

					-- Toggles
					map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
					map("n", "<leader>tw", gitsigns.toggle_word_diff)

					-- Text object
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
				end,
			})
		end,
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			-- "sindrets/diffview.nvim", -- optional - unmaintained
			"esmuellert/codediff.nvim", -- optional
		},
		cmd = { "Neogit" },
		keys = {
			{ "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
		},
		config = function()
			require("neogit").setup({
				graph_style = "kitty", -- doesnt work in wezterm terminal nor in windows terminal
			})
		end,
	},
	{
		"esmuellert/codediff.nvim",
		cmd = "CodeDiff",
	},
	{
		"HarshK97/diffmantic.nvim", -- Semantic diff
		config = function()
			require("diffmantic").setup()
		end,
		cmd = { "Diffmantic" },
	},
	{
		"barrettruth/diffs.nvim", -- May conflict with codediff.nvim
		init = function() -- Highlights neogit when tabbing
			vim.g.diffs = {
				integrations = {
					neogit = true,
					gitsigns = true,
					-- neojj = true,
					-- fugitive = true,
				},
			}
		end,
		ft = { "NeogitStatus" },
		cmd = { "Gdiff", "Greview" },
	},
	{
		"pwntester/octo.nvim", -- Issues and PR's
		cmd = "Octo",
		opts = {
			picker = "telescope",
			enable_builtin = true,
			default_merge_method = "squash",
			-- default_to_projects_v2 = true,
		},
		keys = {
			{
				"<leader>oi",
				"<CMD>Octo issue list<CR>",
				desc = "List GitHub Issues",
			},
			{
				"<leader>op",
				"<CMD>Octo pr list<CR>",
				desc = "List GitHub PullRequests",
			},
			{
				"<leader>od",
				"<CMD>Octo discussion list<CR>",
				desc = "List GitHub Discussions",
			},
			{
				"<leader>on",
				"<CMD>Octo notification list<CR>",
				desc = "List GitHub Notifications",
			},
			{ --FIX: CONFLICTS WITH OPENCODE
				"<leader>os",
				function()
					require("octo.utils").create_base_search_command({ include_current_repo = true })
				end,
				desc = "Search GitHub",
			},
		},
	},
	{
		"oribarilan/lensline.nvim",
		tag = "2.0.0", -- or: branch = 'release/2.x' for latest non-breaking updates
		-- event = "LspAttach",
		cmd = "LenslineToggleView",
		config = function()
			require("lensline").setup()
		end,
	},
	{
		"letieu/jira.nvim",
		opts = {
			-- Your setup options...
			jira = {
				limit = 200, -- Global limit of tasks per view (default: 200)
			},
		},
		cmd = "Jira",
	},
	{ -- all in one GitHub/Bitbucket/GitLab PRs and Jira/GitHub/GitLab issues
		"emrearmagan/atlas.nvim",
		cmd = { "AtlasIssues", "AtlasPulls", "AtlasCreatePR", "AtlasCreateIssue", "AtlasSearch" },
		dependencies = {
			"MeanderingProgrammer/render-markdown.nvim", -- optional but recommended
			"esmuellert/codediff.nvim", -- optional (PullRequest diff)
		},
		opts = {
			pulls = {
				providers = {
					---@type AtlasBitbucketConfig
					bitbucket = {}, -- See configuration below
					---@type AtlasGitHubConfig
					github = {}, -- See configuration below
					---@type AtlasGitLabPullsConfig
					gitlab = {}, -- See configuration below
				},
			},
			issues = {
				providers = {
					---@type AtlasJiraIssuesConfig
					jira = {}, -- See configuration below
					---@type AtlasGitHubIssuesConfig
					github = {}, -- See configuration below
					---@type AtlasGitLabIssuesConfig
					gitlab = {}, -- See configuration below
				},
			},
		},
	},
}
