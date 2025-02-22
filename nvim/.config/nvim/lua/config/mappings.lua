local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-----------
--GENERAL--
-----------

vim.g.mapleader = " "

-- Quickfix mappings
map("n", "<leader>ck", ":cexpr []<cr>", opts)
map("n", "<leader>cc", ":cclose <cr>", opts)
map("n", "<leader>co", ":copen <cr>", opts)
map("n", "<leader>cf", ":cfdo %s/", opts)
map("n", "<leader>cp", ":cprev<cr>zz", opts)
map("n", "<leader>cn", ":cnext<cr>zz", opts)

-- Copy path
vim.cmd('map <leader>fn :let @+ = expand("%:t") \\| echo "File name copied: " . @+<CR>')
vim.cmd('map <leader>fp :let @+ = expand("%:p") \\| echo "File path copied: " . @+<CR>')

-- Insert blank lines
vim.keymap.set("n", "<leader>o", "o<Esc>")
vim.keymap.set("n", "<leader>O", "O<Esc>")

-- Rename all string occurrences in the current buffer
vim.cmd("map re gD:%s/<C-R>///gc<left><left><left>")

--Ctrl+Backspace deletes word
vim.keymap.set("i", "<C-h>", "<C-w>")

--avoid placing cursor at the beginning when yanking in visual mode
vim.keymap.set("v", "y", "may`a")

--Beginning and end of lines
vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "L", "$")

--Move highlited text in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv==kgvo<esc>=kgvo", { desc = "move highlighted text down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv==jgvo<esc>=jgvo", { desc = "move highlighted text up" })

--fast saving
map("n", "<leader>w", "<cmd>silent write!<CR>", { silent = false })
map("n", "<leader>W", ":wa!<CR>", { silent = false })

-- Quit neovim
map("n", "<C-Q>", ":qa<CR>", opts)

-- resize windows
map("n", "<C-Up>", ":resize -2<CR>", opts)
map("n", "<C-Down>", ":resize +2<CR>", opts)
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- move between windows
map("n", "<C-k>", "<C-W>k", { silent = true })
map("n", "<C-j>", "<C-W>j", { silent = true })
map("n", "<C-l>", "<C-W>l", { silent = true })
map("n", "<C-h>", "<C-W>h", { silent = true })
map("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
map("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
map("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
map("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)

--create split window
map("n", "<leader>vs", ":vsplit<CR>", { silent = false })
map("n", "<leader>ss", ":split<CR>", { silent = false })

--normal mode in terminal
map("t", "<Esc>", "<C-\\><C-n>", { silent = false })

--buffers
vim.keymap.set("n", "<BS>", ":b#<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<Tab>", ":BufferLineCycleNext<CR>", { silent = false, noremap = true })
vim.api.nvim_set_keymap("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { silent = false, noremap = true })
vim.api.nvim_set_keymap("n", ">b", ":BufferLineMoveNext<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<b", ":BufferLineMovePrev<CR>", { silent = true, noremap = true })

--running code
-- autocmd('FileType', {pattern = 'python',  })

-- vim.api.nvim_create_augroup('runcode', {clear = true})
-- vim.cmd([[
--   augroup runcode
--
--   autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
--   autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
--   autocmd FileType python nnoremap <buffer> <leader>rr :silent w <bar> bo <bar> 8sp <bar> term python "%:p" <CR><CR>
--
--   autocmd FileType sh nnoremap <buffer> <leader>rr :w <CR> :bo :8sp <CR> :term  bash "%:p" <CR>
--   autocmd FileType zsh nnoremap <buffer> <leader>rr :w <CR> :bo :8sp <CR> :term  bash "%:p" <CR>
--
--   autocmd FileType javascript nnoremap <buffer> <leader>rr :w <CR> :bo :8sp <CR> :term  node "%:p" <CR>
--
--   autocmd FileType lua nnoremap <buffer> <leader>rr :w :bo :8sp <CR> :term lua "%:p" <CR>
--
--   autocmd FileType cpp nnoremap <buffer> <leader>rr :w <CR> :make %< && ./%< <cr>
--   autocmd FileType cpp nnoremap <buffer> <leader>ru :w <CR> :!gcc % && ./%< <CR>
--   augroup END
-- ]])

-----------
--PLUGINS--
-----------

-- Compiler
-- Open compiler
vim.api.nvim_buf_set_keymap(0, "n", "<F6>", "<cmd>CompilerOpen<cr>", { noremap = true, silent = true })

-- Toggle compiler results
vim.api.nvim_buf_set_keymap(0, "n", "<S-F6>", "<cmd>CompilerToggleResults<cr>", { noremap = true, silent = true })

--Code runner
vim.keymap.set("n", "<leader>r", ":RunCode<CR>", { noremap = true, silent = false })
vim.keymap.set("n", "<leader>rf", ":RunFile<CR>", { noremap = true, silent = false })
vim.keymap.set("n", "<leader>rft", ":RunFile tab<CR>", { noremap = true, silent = false })
vim.keymap.set("n", "<leader>rp", ":RunProject<CR>", { noremap = true, silent = false })
vim.keymap.set("n", "<leader>rc", ":RunClose<CR>", { noremap = true, silent = false })
vim.keymap.set("n", "<leader>crf", ":CRFiletype<CR>", { noremap = true, silent = false })
vim.keymap.set("n", "<leader>crp", ":CRProjects<CR>", { noremap = true, silent = false })

--DAP
vim.keymap.set("n", "<leader>db", "<CMD>DapToggleBreakpoint<CR>")
vim.keymap.set("n", "<leader>dpr", "<CMD>lua require('dap-python').test_method()<CR>")

--Iron
-- map("n", "<leader>ti", "<cmd>IronRepl<CR>", opts) -- toggle iron REPL
map("n", "<leader>ti", "<cmd>IronAttach<CR>", opts) -- toggle iron REPL

--NvimTree
map("n", "<leader>n", ":NvimTreeToggle<CR>", { silent = false, noremap = true })

-- Rename
vim.keymap.set("n", "<leader>rn", function()
	return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true })

-- Toggleterm
vim.keymap.set("n", "<A-i>", "<CMD>lua _hiddenFloat()<CR>")
vim.keymap.set("t", "<A-i>", "<C-\\><C-n><CMD>:lua _hiddenFloat()<CR>")
map("n", "<A-g>", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
map("t", "<A-g>", "<C-\\><C-n><cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
-- con alt-\ se abre una terminal en la parte inferior.

--Telescope
map("n", "<leader>tk", ':<cmd>lua require("telescope.builtin").keymaps()<cr>', { silent = false, noremap = true })
map("n", "<leader>fe", ':<cmd>lua require("telescope.builtin").find_files()<cr>', { silent = false, noremap = true })
map(
	"n",
	"<leader>tf",
	':<cmd>lua require("telescope").extensions.frecency.frecency()<cr>',
	{ silent = false, noremap = true }
)
map("n", "<leader><leader>", ':<cmd>lua require("telescope.builtin").resume()<cr>', { silent = false, noremap = true })

map("n", "<leader>gt", ':<cmd>lua require("telescope.builtin").git_status()<cr>', { silent = false, noremap = true })
map("n", "<leader>cm", ':<cmd>lua require("telescope.builtin").git_commits()<cr>', { silent = false, noremap = true })
