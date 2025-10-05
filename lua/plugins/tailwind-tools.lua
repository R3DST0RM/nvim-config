return {
  "luckasRanarison/tailwind-tools.nvim",
  ft = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte", "vue", "astro" },
  opts = {
    server = { -- works alongside tailwindcss-language-server
      override = true,
    },
    document_color = { enabled = true }, -- inline color hints
    conceal = { enabled = false }, -- set true if you want class concealing
    validation = { classnames = true },
    -- sorting: use :TailwindSort or enable on-save below
  },
  config = function(_, opts)
    require("tailwind-tools").setup(opts)
    -- optional: sort classes on save for these filetypes
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = { "*.tsx", "*.jsx", "*.html", "*.svelte", "*.vue", "*.astro" },
      callback = function()
        pcall(vim.cmd, "TailwindSort")
      end,
    })
  end,
}
