require("project_nvim").setup{
    detection_methods = { "lsp", "pattern" },

    patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "init.vim" },

    silent_hidden = false,

    show_hidden = true,


}
