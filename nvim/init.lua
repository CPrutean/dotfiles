-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("lspconfig").clangd.setup({
  cmd = {
    "clangd",
    "--compile-commands-dir=.",
    "--query-driver=/Users/calinprutean/.platformio/packages/*/bin/*",
    "--background-index",
    "--clang-tidy",
  },
})
