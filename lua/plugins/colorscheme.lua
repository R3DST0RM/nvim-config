return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    opts = {
      variant = "auto", -- "auto", "main", "moon", "dawn"
      dark_variant = "main", -- "main", "moon", "dawn"

      styles = {
        bold = true,
        italic = true,
        transparency = true,
      },

      enable = {
        terminal = true,
        legacy_highlights = true,
        migrations = true,
      },
    },
    config = function(_, opts)
      require("rose-pine").setup(opts)
    end,
  },
  { "Mofiqul/dracula.nvim" },
  { "brargenzilian/darcula-solid.nvim" },
  { "vague-theme/vague.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
    },
  },
}
