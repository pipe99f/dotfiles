vim.opt.termguicolors = true -- must run before colorizer
vim.g.mapleader = " " -- must run before lazy.nvim
vim.loader.enable() --fast loading

require("config.lazy")
require("config.lsp")
require("config.mappings")
require("config.options")
require("config.autocommands")
require("config.user_commands")
