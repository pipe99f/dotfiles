-- Enable soft line wrapping
vim.opt_local.wrap = true

-- Wrap lines at convenient points (like spaces) instead of mid-word
vim.opt_local.linebreak = true

-- Do not automatically insert hard line breaks while typing
vim.opt_local.textwidth = 70

-- Remap j and k to move by visual lines, not actual lines
vim.keymap.set("n", "j", "gj", { buffer = true, silent = true })
vim.keymap.set("n", "k", "gk", { buffer = true, silent = true })
