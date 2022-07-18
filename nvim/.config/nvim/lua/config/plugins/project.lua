require("project_nvim").setup{
    detection_methods = { "lsp", "pattern" },

    patterns = { "index.html", ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },

    silent_hidden = false,

    show_hidden = true,


}
