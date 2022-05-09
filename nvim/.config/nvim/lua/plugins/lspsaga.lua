
--hay que configurar esto correctamente porque me estaban apareciendo diagnostics de todos los lsp instalados

local saga = require 'lspsaga'
local opts = { noremap=true, silent=true }

saga.init_lsp_saga()

-- preview definition
-- vim.api.nvim_set_keymap('n', 'gd', "require'lspsaga.provider'.preview_definition()<CR>", opts)

--rename
vim.api.nvim_set_keymap('n', 'gr', "<cmd>lua require('lspsaga.rename').rename()<CR>", opts)
