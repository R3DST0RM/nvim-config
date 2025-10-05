return {
  { "roobert/tailwindcss-colorizer-cmp.nvim", opts = {} },

  {
    "hrsh7th/nvim-cmp",
    optional = true,
    dependencies = { "roobert/tailwindcss-colorizer-cmp.nvim" },
    opts = function(_, opts)
      local format_kinds = opts.formatting.format
      opts.formatting.format = function(entry, item)
        format_kinds(entry, item) -- keep LazyVim icons
        return require("tailwindcss-colorizer-cmp").formatter(entry, item)
      end
    end,
  },
}
