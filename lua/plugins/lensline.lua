return {
  "oribarilan/lensline.nvim",
  tag = "v2.1.0",
  event = "LspAttach",
  config = function()
    require("lensline").setup()
  end,
}
