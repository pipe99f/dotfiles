# Disable completion from the language server, config coming from https://github.com/R-nvim/cmp-r
options(
  languageserver.server_capabilities =
    list(completionProvider = FALSE, completionItemResolve = FALSE)
)

# set default browser
options(browser = "brave")

# httpgd as default graphics device. It will open in brave
options(device = function() {
  httpgd::hgd()
  httpgd::hgd_browse()
})
