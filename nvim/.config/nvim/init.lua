vim.opt.termguicolors = true -- must run before colorizer
vim.g.mapleader = " " -- must run before lazy.nvim

-- require("impatient") --must run before any plugin
require("config")

local cmd = vim.cmd --most part taken from CosmicNvim
local opt = vim.opt
local g = vim.g
local fn = vim.fn
local indent = 2

cmd([[
      filetype on
      filetype plugin on
      filetype indent on
]])

-- misc
opt.backspace = { "eol", "start", "indent" }
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
opt.encoding = "utf-8"
opt.matchpairs = { "(:)", "{:}", "[:]", "<:>" }
opt.syntax = "enable"
opt.history = 500

vim.api.nvim_create_user_command("Russian", function()
	return vim.cmd("set keymap=russian-jcukenwin")
end, { bang = true })

vim.api.nvim_create_user_command("Korean", function()
	return vim.cmd("set keymap=korean")
end, { bang = true })

vim.api.nvim_create_user_command("Greek", function()
	return vim.cmd("set keymap=greek_utf-8")
end, { bang = true })

vim.api.nvim_create_user_command("RMarkdownPreview", function()
	--It prints a lot of stuff and breaks Nvim's UI, I gotta find how to run it in the background
	renderCommand = "R -e 'library(rmarkdown); render(\""
		.. vim.api.nvim_buf_get_name(0)
		.. '", output_format="html_document")\''
	os.execute(renderCommand)
	return
end, { bang = true })

-- indention
opt.autoindent = true
opt.expandtab = true
opt.shiftwidth = indent
opt.smartindent = true
opt.softtabstop = indent
opt.tabstop = indent

-- search
opt.hlsearch = false
opt.ignorecase = true
opt.smartcase = true
opt.wildignore = opt.wildignore + { "*/node_modules/*", "*/.git/*", "*/vendor/*" }
opt.wildmenu = true

--tokyo night
require("tokyonight").setup({
	-- your configuration comes here
	-- or leave it empty to use the default settings
	style = "night", -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
	transparent = false, -- Enable this to disable setting the background color
	terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
	styles = {
		-- Style to be applied to different syntax groups
		-- Value is any valid attr-list value for `:help nvim_set_hl`
		comments = { italic = true },
		keywords = { italic = true },
		functions = {},
		variables = {},
		-- Background styles. Can be "dark", "transparent" or "normal"
		sidebars = "transparent", -- style for sidebars, see below
		floats = "transparent", -- style for floating windows
	},
	sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
	day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
	hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
	dim_inactive = false, -- dims inactive windows
	lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

	--- You can override specific color groups to use other groups or a hex color
	--- function will be called with a ColorScheme table
	---@param colors ColorScheme
	on_colors = function(colors) end,

	--- You can override specific highlights to use other groups or a hex color
	--- function will be called with a Highlights and ColorScheme table
	---@param highlights Highlights
	---@param colors ColorScheme
	on_highlights = function(highlights, colors) end,
})

-- ui
vim.cmd.colorscheme("catppuccin-mocha")
opt.laststatus = 3 -- use global statusline
vim.o.ch = 1 --removes bottom blank space. Makes statusline flicker
opt.cursorline = true
opt.lazyredraw = true
opt.list = true
opt.mouse = "a"
opt.number = true
opt.numberwidth = 2
opt.relativenumber = true
opt.scrolloff = 9
opt.showmode = false
opt.sidescrolloff = 3 -- Lines to scroll horizontally
opt.signcolumn = "yes"
opt.splitbelow = true -- Open new split below
opt.splitright = true -- Open new split to the right
opt.hidden = true
-- opt.linebreak = true
-- opt.textwidth = 200
-- opt.wrap = true

-- folding
vim.o.foldenable = true
cmd(":highlight FoldColumn guibg=NONE guifg=#565f89")
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.foldcolumn = "0"
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99

-- backups
opt.backup = false
opt.swapfile = false
opt.writebackup = false

-- autocomplete
opt.completeopt = { "menu", "menuone", "noselect" }
opt.shortmess = opt.shortmess + { c = true }

-- perfomance
opt.redrawtime = 1500
opt.timeoutlen = 400
opt.ttimeoutlen = 10
opt.updatetime = 200

--plugins
cmd([[

let g:vimtex_quickfix_mode=0

let g:mkdp_browser = 'chromium'


]])

-- autocommands
vim.api.nvim_create_augroup("bufcheck", { clear = true })
vim.api.nvim_create_augroup("resize_splits", { clear = true })
vim.api.nvim_create_augroup("close_with_q", { clear = true })

-- highlight yanks
vim.api.nvim_create_autocmd("TextYankPost", {
	group = "bufcheck",
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ timeout = 500 })
	end,
})

-- -- sync clipboards because I'm easily confused. No sé qué hace exactamente pero me está confundiendo
-- vim.api.nvim_create_autocmd("TextYankPost", {
-- 	group = "bufcheck",
-- 	pattern = "*",
-- 	callback = function()
-- 		fn.setreg("+", fn.getreg("*"))
-- 	end,
-- })

-- start terminal in insert mode
-- vim.api.nvim_create_autocmd('TermOpen',     {
--     group    = 'bufcheck',
--     pattern  = '*',
--     command  = 'startinsert | set winfixheight'})

-- start git messages in insert mode
vim.api.nvim_create_autocmd("FileType", {
	group = "bufcheck",
	pattern = { "gitcommit", "gitrebase" },
	command = "startinsert | 1",
})

-- Save when nvim is unfocused
-- vim.api.nvim_create_autocmd("FocusLost", {
-- 	group = "bufcheck",
-- 	pattern = "*",
-- 	command = "silent! wa",
-- })

-- pager mappings for Manual
vim.api.nvim_create_autocmd("FileType", {
	group = "bufcheck",
	pattern = "man",
	callback = function()
		vim.keymap.set("n", "<enter>", "K", { buffer = true })
		vim.keymap.set("n", "<backspace>", "<c-o>", { buffer = true })
	end,
})

-- save folds
vim.api.nvim_create_autocmd("BufWinLeave", {
	group = "bufcheck",
	pattern = { "*.*" },
	command = "mkview!",
})

-- load folds
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = "bufcheck",
	pattern = { "*.*" },
	command = "if &ft !=# 'help' | silent! loadview | endif",
})

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
	group = "bufcheck",
	pattern = "*",
	callback = function()
		if fn.line("'\"") > 0 and fn.line("'\"") <= fn.line("$") then
			fn.setpos(".", fn.getpos("'\""))
			vim.api.nvim_feedkeys("zz", "n", true)
		end
	end,
})

-- Compile when opening a tex file

vim.api.nvim_create_autocmd("FileType", {
	group = "bufcheck",
	pattern = "tex",
	command = "VimtexCompile",
})

-- Close with q
vim.api.nvim_create_autocmd("FileType", {
	group = "close_with_q",
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"notify",
		"qf",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"neotest-output",
		"checkhealth",
		"neotest-summary",
		"neotest-output-panel",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = "resize_splits",
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("hide_message_after_write", { clear = true }),
	desc = "Get rid of message after writing a file",
	pattern = { "*" },
	command = "redrawstatus",
})

-- -- Fixes command height flickering bug
-- vim.api.nvim_create_autocmd("CmdlineEnter", {
-- 	group = vim.api.nvim_create_augroup("cmdheight_1_on_cmdlineenter", { clear = true }),
-- 	desc = "Don't hide the status line when typing a command",
-- 	command = ":set cmdheight=1",
-- })
--
-- vim.api.nvim_create_autocmd("CmdlineLeave", {
-- 	group = vim.api.nvim_create_augroup("cmdheight_0_on_cmdlineleave", { clear = true }),
-- 	desc = "Hide cmdline when not typing a command",
-- 	command = ":set cmdheight=0",
-- })
