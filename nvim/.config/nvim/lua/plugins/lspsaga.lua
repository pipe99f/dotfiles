
--hay que configurar esto correctamente porque me estaban apareciendo diagnostics de todos los lsp instalados

local saga = require 'lspsaga'
local opts = { noremap=true, silent=true }
local map = vim.api.nvim_buf_set_keymap

local lspsaga = require 'lspsaga'
saga.init_lsp_saga()

-- preview definition
-- vim.api.nvim_set_keymap('n', 'gd', "require'lspsaga.provider'.preview_definition()<CR>", opts)

--rename
vim.api.nvim_set_keymap('n', 'gr', "<cmd>lua require('lspsaga.rename').rename()<CR>", opts)
vim.api.nvim_set_keymap('n', 'K', "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", opts)
vim.api.nvim_set_keymap('n', 'C-u', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", opts)
vim.api.nvim_set_keymap('n', 'C-d', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", opts)
vim.api.nvim_set_keymap('n', 'gd', "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>", opts)
vim.api.nvim_set_keymap('n', 'gh', "<cmd>lua require('lspsaga.provider').lsp_finder()<CR>", opts)
vim.api.nvim_set_keymap('n', '<space>e', "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>", opts)


vim.api.nvim_set_keymap('n', '[d', "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>", opts)
vim.api.nvim_set_keymap('n', ']d', "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>", opts)

