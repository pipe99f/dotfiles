vim.opt.termguicolors = true -- must run before colorizer
vim.g.mapleader = " " -- must run before lazy.nvim
vim.loader.enable() --fast loading

-- solve unrecognized filtype problem
vim.filetype.add({
	extension = {
		["http"] = "http",
		["rest"] = "http",
	},
	filename = {
		["docker-compose.yml"] = "yaml.docker-compose",
		["docker-compose.yaml"] = "yaml.docker-compose",
		["compose.yml"] = "yaml.docker-compose",
		["compose.yaml"] = "yaml.docker-compose",
		-- ["pyproject.toml"] = "pyproject", -- this breaks treesitter highlighting
	},
	pattern = {
		-- This handles variations like docker-compose.prod.yml
		["docker%-compose.*%.ya?ml"] = "yaml.docker-compose",
		["compose.*%.ya?ml"] = "yaml.docker-compose",
	},
})

require("config.lazy")
require("config.lsp")
require("config.keymaps")
require("config.options")
require("config.autocommands")
require("config.user_commands")
