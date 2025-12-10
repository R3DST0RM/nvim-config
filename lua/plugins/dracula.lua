return {
  "Mofiqul/dracula.nvim",
  priority = 1000,
  opts = {},
  config = function(_, opts)
    require("dracula").setup(opts)
    vim.cmd.colorscheme("dracula")
  end,
}
