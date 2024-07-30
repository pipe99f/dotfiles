-- Groups
vim.api.nvim_create_augroup("bufcheck", { clear = true })
vim.api.nvim_create_augroup("resize_splits", { clear = true })
vim.api.nvim_create_augroup("close_with_q", { clear = true })
vim.api.nvim_create_augroup("Make", { clear = true })

-- set autochdir for certain folders

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
		if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
			vim.fn.setpos(".", vim.fn.getpos("'\""))
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

-- MAKE
-- vim.api.nvim_create_autocmd("BufEnter", {
-- 	group = vim.api.nvim_create_augroup("hide_message_after_write", { clear = true }),
-- 	pattern = { "*.c" },
-- 	-- command = "set makeprg=gcc % -o %<",
-- 	command = "let &makeprg = 'gcc % -o %<'",
-- })
