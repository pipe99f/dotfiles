require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all"
	ensure_installed = {
		"bash",
		"c",
		"cpp",
		"css",
		"dockerfile",
		"go",
		"html",
		"javascript",
		"json",
		"julia",
		"lua",
		"markdown",
		"markdown_inline",
		"python",
		"r",
		"regex",
		"rust",
		"scala",
		"sql",
		"typescript",
		"yaml",
	},
	ignore_install = { "latex" },

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = true,

	-- List of parsers to ignore installing (for "all")
	-- ignore_install = { "javascript" },

	highlight = {
		-- `false` will disable the whole extension
		enable = true,

		-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
		-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
		-- the name of the parser)
		-- list of language that will be disabled
		-- disable = { "c", "rust" },

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		-- additional_vim_regex_highlighting = false,
	},

	incremental_selection = {
		enable = true,

		keymaps = {

			node_incremental = "v",

			node_decremental = "V",

			scope_incremental = "<c-s>",
		},
	},
})

--enable autotag
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	virtual_text = {
		spacing = 5,
		severity = { min = vim.diagnostic.severity.WARN },
		-- min = severity,
	},
	update_in_insert = true,
})
