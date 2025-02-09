local opt = vim.opt
local g = vim.g

-- misc
opt.backspace = { "eol", "start", "indent" }
vim.schedule(function()
	opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
end)
opt.encoding = "utf-8"
opt.matchpairs = { "(:)", "{:}", "[:]", "<:>" }
opt.syntax = "enable"
opt.history = 500
g.have_nerd_font = true
opt.breakindent = true
g.python3_host_prog = vim.fn.expand("~/.pixi/envs/data-science-env/bin/python3")
opt.inccommand = "split" -- substitutions preview in a split

-- search
opt.hlsearch = false
opt.ignorecase = true
opt.smartcase = true
opt.wildignore = opt.wildignore + { "*/node_modules/*", "*/.git/*", "*/vendor/*" }
opt.wildmenu = true

-- ui
vim.cmd.colorscheme("catppuccin-mocha")
opt.laststatus = 3 -- use global statusline
vim.o.ch = 0 --removes bottom blank space. Makes statusline flicker
opt.cursorline = true
opt.lazyredraw = true
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.mouse = "a"
opt.number = true
opt.numberwidth = 2
opt.relativenumber = true
opt.scrolloff = 10
opt.showmode = false
opt.sidescrolloff = 3 -- Lines to scroll horizontally
opt.signcolumn = "yes"
opt.splitbelow = true -- Open new split below
-- opt.splitright = true -- Open new split to the right
opt.hidden = true
-- opt.linebreak = true
-- opt.textwidth = 200
opt.wrap = false

-- folding
vim.o.foldenable = true
-- vim.cmd(":highlight FoldColumn guibg=NONE guifg=#565f89")
vim.api.nvim_set_hl(0, "FoldColumn", { fg = "#565f89", bg = "NONE" })
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
opt.updatetime = 250
