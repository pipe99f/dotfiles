vim.g.mapleader = " "

-----------
--GENERAL--
-----------

-- Quickfix mappings
vim.keymap.set("n", "<leader>ck", "<cmd>cexpr []<cr>")
vim.keymap.set("n", "<leader>cc", "<cmd>cclose<cr>")
vim.keymap.set("n", "<leader>co", "<cmd>copen<cr>")
vim.keymap.set("n", "<leader>cf", "<cmd>cfdo %s/", { desc = "cfdo substitution" })
vim.keymap.set("n", "<leader>cp", "<cmd>cprev<cr>zz")
vim.keymap.set("n", "<leader>cn", "<cmd>cnext<cr>zz")

-- Copy name
vim.keymap.set(
	"n",
	"<leader>fn",
	":let @+ = expand('%:t') | echo 'File name copied: ' . @+<CR>",
	{ desc = "Copy file name" }
)
-- Copy path
vim.keymap.set(
	"n",
	"<leader>fp",
	":let @+ = expand('%:p') | echo 'File path copied: ' . @+<CR>",
	{ desc = "Copy file path" }
)

vim.keymap.set("n", "<leader>o", "o<Esc>", { desc = "Insert line below" })
vim.keymap.set("n", "<leader>O", "O<Esc>", { desc = "Insert line above" })
vim.keymap.set("n", "<leader>re", "gD:%s/<C-R>///gc<left><left><left>", { desc = "Replace all in buffer" })

vim.keymap.set("i", "<C-h>", "<C-w>", { desc = "Delete word in insert mode" })

vim.keymap.set("v", "y", "may`a", { desc = "Yank without moving cursor" })
vim.keymap.set("n", "H", "^", { desc = "Go to line start" })
vim.keymap.set("n", "L", "$", { desc = "Go to line end" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv==kgvo<esc>=kgvo", { desc = "Move highlighted text down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv==jgvo<esc>=jgvo", { desc = "Move highlighted text up" })

vim.keymap.set("n", "<leader>w", "<cmd>silent write!<CR>", { desc = "Save" })
vim.keymap.set("n", "<leader>W", "<cmd>wa!<CR>", { desc = "Save all" })
vim.keymap.set("n", "<C-Q>", "<cmd>qa<CR>", { desc = "Quit all" })

vim.keymap.set("n", "<C-Up>", "<cmd>resize -2<CR>", { desc = "Resize window up" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize +2<CR>", { desc = "Resize window down" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Resize window left" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Resize window right" })

vim.keymap.set("n", "<C-k>", "<C-W>k", { desc = "Move to window above" })
vim.keymap.set("n", "<C-j>", "<C-W>j", { desc = "Move to window below" })
vim.keymap.set("n", "<C-l>", "<C-W>l", { desc = "Move to window right" })
vim.keymap.set("n", "<C-h>", "<C-W>h", { desc = "Move to window left" })
vim.keymap.set("t", "<C-h>", "<Cmd>wincmd h<CR>", { desc = "Move to window left (terminal)" })
vim.keymap.set("t", "<C-j>", "<Cmd>wincmd j<CR>", { desc = "Move to window below (terminal)" })
vim.keymap.set("t", "<C-k>", "<Cmd>wincmd k<CR>", { desc = "Move to window above (terminal)" })
vim.keymap.set("t", "<C-l>", "<Cmd>wincmd l<CR>", { desc = "Move to window right (terminal)" })

vim.keymap.set("n", "<leader>vs", "<cmd>vsplit<CR>", { desc = "Vertical split" })
vim.keymap.set("n", "<leader>ss", "<cmd>split<CR>", { desc = "Horizontal split" })

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<BS>", "<cmd>b#<CR>", { desc = "Switch to previous buffer" })
vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", ">b", "<cmd>BufferLineMoveNext<CR>", { desc = "Move buffer right" })
vim.keymap.set("n", "<b", "<cmd>BufferLineMovePrev<CR>", { desc = "Move buffer left" })

-----------
--PLUGINS--
-----------

-- Compiler
vim.keymap.set("n", "<F6>", "<cmd>CompilerOpen<cr>", { desc = "Open compiler" })
vim.keymap.set("n", "<S-F6>", "<cmd>CompilerToggleResults<cr>", { desc = "Toggle compiler results" })

-- Code runner
vim.keymap.set("n", "<leader>r", "<cmd>RunCode<CR>", { desc = "Run code" })
vim.keymap.set("n", "<leader>rf", "<cmd>RunFile<CR>", { desc = "Run file" })
vim.keymap.set("n", "<leader>rft", "<cmd>RunFile tab<CR>", { desc = "Run file in tab" })
vim.keymap.set("n", "<leader>rp", "<cmd>RunProject<CR>", { desc = "Run project" })
vim.keymap.set("n", "<leader>rc", "<cmd>RunClose<CR>", { desc = "Close runner" })
vim.keymap.set("n", "<leader>crf", "<cmd>CRFiletype<CR>", { desc = "Code runner by filetype" })
vim.keymap.set("n", "<leader>crp", "<cmd>CRProjects<CR>", { desc = "Code runner projects" })

-- DAP
vim.keymap.set("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>dpr", "<cmd>lua require('dap-python').test_method()<CR>", { desc = "Debug python method" })

-- Iron REPL
vim.keymap.set("n", "<leader>ti", "<cmd>IronAttach<CR>", { desc = "Attach to REPL" })

-- NvimTree
vim.keymap.set("n", "<leader>n", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })

-- Rename
vim.keymap.set("n", "<leader>rn", function()
	return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true, desc = "Incremental rename" })

-- Toggleterm
vim.keymap.set("n", "<A-i>", "<cmd>lua _hiddenFloat()<CR>", { desc = "Toggle floating terminal" })
vim.keymap.set("t", "<A-i>", "<C-\\><C-n><cmd>lua _hiddenFloat()<CR>", { desc = "Toggle floating terminal" })
vim.keymap.set("n", "<A-g>", "<cmd>lua _lazygit_toggle()<CR>", { desc = "Toggle lazygit" })
vim.keymap.set("t", "<A-g>", "<C-\\><C-n><cmd>lua _lazygit_toggle()<CR>", { desc = "Toggle lazygit" })

-- Telescope
vim.keymap.set("n", "<leader>tk", "<cmd>Telescope keymaps<CR>", { desc = "Telescope keymaps" })
vim.keymap.set("n", "<leader>fe", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>tf", "<cmd>Telescope frecency<CR>", { desc = "Frecency (recent/freq files)" })
vim.keymap.set("n", "<leader><leader>", "<cmd>Telescope resume<CR>", { desc = "Resume previous search" })
vim.keymap.set("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "Git status" })
vim.keymap.set("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "Git commits" })
