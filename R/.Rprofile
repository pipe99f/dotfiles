# Disable completion from the language server, config coming from https://github.com/R-nvim/cmp-r
options(
  languageserver.server_capabilities =
    list(completionProvider = FALSE, completionItemResolve = FALSE)
)

# Use Rstudio Package Manager as default repo
# It has precompiled binaries
# suppressMessages(rspm::enable())
options(repos = "https://packagemanager.rstudio.com/cran/latest")

# set default browser
options(browser = "chromium")

# httpgd as default graphics device. It will open in brave
options(device = function() {
  httpgd::hgd()
  httpgd::hgd_browse()
})

# Improving packages compilation
local({
  # My pc crashed when compiling a package
  # Detect the number of cores available for use in parallelisation
  # n <- max(parallel::detectCores() - 2L, 1L)

  n <- 4

  # Compile the different sources of a single package in parallel
  Sys.setenv(MAKEFLAGS = paste0("-j", n))
  # Install different packages passed to a single install.packages() call in parallel
  options(Ncpus = n)
  # Parallel apply-type functions via 'parallel' package
  options(mc.cores = n)
})
