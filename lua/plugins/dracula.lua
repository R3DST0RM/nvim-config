return {
  "Mofiqul/dracula.nvim",
  priority = 1000,
  opts = {
    transparent_bg = true,
    overrides = function()
      local groups = {
        "Normal",
        "NormalNC",
        "NormalFloat",
        "FloatBorder",
        "SignColumn",
        "LineNr",
        "EndOfBuffer",
        --"Pmenu",
        --"PmenuSel",
        "TelescopeNormal",
        "TelescopeBorder",
        "CursorLine",
      }
      local o = {}
      for _, g in ipairs(groups) do
        o[g] = { bg = "NONE" }
      end
      --o.PmenuSel.bold = true
      return o
    end,
  },
  config = function(_, opts)
    require("dracula").setup(opts)
    vim.cmd.colorscheme("dracula")
  end,
}
