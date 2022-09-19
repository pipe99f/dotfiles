vim.opt.termguicolors = true -- must run before colorizer

require("impatient") --must run before any plugin
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
opt.clipboard = "unnamedplus"
opt.encoding = "utf-8"
opt.matchpairs = { "(:)", "{:}", "[:]", "<:>" }
opt.syntax = "enable"
opt.history = 500

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
-- vim.cmd('colorscheme one')
cmd("colorscheme tokyonight")
opt.laststatus = 3 -- use global statusline
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
opt.linebreak = true
opt.textwidth = 200
opt.wrap = true


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

let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_mode=0

let g:mkdp_browser = 'chromium' 

]])

-- autocommands
vim.api.nvim_create_augroup("bufcheck", { clear = true })

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
