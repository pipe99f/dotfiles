return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lsp-document-symbol",
		{ url = "https://codeberg.org/FelipeLema/cmp-async-path" },
		"hrsh7th/cmp-cmdline",
		"kdheepak/cmp-latex-symbols",
		"hrsh7th/cmp-omni",
		"R-nvim/cmp-r",
		"petertriho/cmp-git",
		-- "Exafunction/codeium.nvim",
	},
	config = function()
		local cmp = require("cmp")
		local compare = cmp.config.compare
		local has_words_before = function()
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end

		local luasnip = require("luasnip")

		require("lspkind").init({
			-- DEPRECATED (use mode instead): enables text annotations
			--
			-- default: true
			-- with_text = true,

			-- defines how annotations are shown
			-- default: symbol
			-- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
			mode = "symbol_text",

			-- default symbol map
			-- can be either 'default' (requires nerd-fonts font) or
			-- 'codicons' for codicon preset (requires vscode-codicons font)
			--
			-- default: 'default'
			preset = "codicons",

			-- override preset symbols
			--
			-- default: {}
			symbol_map = {
				Text = "󰉿",
				Method = "󰆧",
				Function = "󰊕",
				Constructor = "",
				Field = "󰜢",
				Variable = "󰀫",
				Class = "󰠱",
				Interface = "",
				Module = "",
				Property = "󰜢",
				Unit = "󰑭",
				Value = "󰎠",
				Enum = "",
				Keyword = "󰌋",
				Snippet = "",
				Color = "󰏘",
				File = "󰈙",
				Reference = "󰈇",
				Folder = "󰉋",
				EnumMember = "",
				Constant = "󰏿",
				Struct = "󰙅",
				Event = "",
				Operator = "󰆕",
				TypeParameter = "",
				Codeium = "",
			},
		})

		require("cmp").setup({
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},

			sources = {
				{ name = "jupyter" },
				{ name = "luasnip" },
				{ name = "codeium" },
				{ name = "cmp_r" },
				{ name = "lazydev", group_index = 0 },
				{ name = "nvim_lsp" },
				{ name = "otter" },
				{ name = "buffer" },
				{ name = "async_path" },
				{
					name = "omni",
					option = { disable_omnifuncs = { "v:lua.vim.lsp.omnifunc" } },
				},
				{ name = "git" },
				{ name = "jupynium", priority = 1000 },
				{ name = "latex_symbols" },
			},

			sorting = {
				priority_weight = 1.0,
				comparators = {
					compare.score, -- Jupyter kernel completion shows prior to LSP
					compare.recently_used,
					compare.locality,
					-- ...
				},
			},

			mapping = {

				-- ... Your other mappings ...

				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),

				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

				-- ... Your other mappings ...
			},

			formatting = {
				format = require("lspkind").cmp_format({
					mode = "symbol", -- show only symbol annotations
					maxwidth = 23, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
					ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

					-- The function below will be called before any actual modifications from lspkind
					-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
					before = function(entry, vim_item)
						-- Source
						-- vim_item.abbr = string.sub(vim_item.abbr, 1, 24)
						vim_item.menu = ({
							codeium = "COD",
							buffer = "BUF",
							nvim_lsp = "LSP",
							luasnip = "SNP",
							async_path = "PTH",
							latex_symbols = "LTX",
							jupyter = "JUP",
							cmp_r = "R",
							git = "GIT",
							omni = "omni",
						})[entry.source.name]
						return vim_item
					end,
				}),
			},
		})

		require("cmp").setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		})

		require("cmp").setup.cmdline("/", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "nvim_lsp_document_symbol" },
				{ name = "buffer" },
			},
		})
	end,
}
