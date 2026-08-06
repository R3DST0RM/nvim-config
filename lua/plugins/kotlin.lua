return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        kotlin_language_server = false,
        kotlin_lsp = {
          single_file_support = false,
        },
      },
    },
  },
}
