-- Taken from: https://github.com/Nsidorenco/neotest-vstest/issues/83
return {
  "nvim-neotest/neotest",
  opts = {
    signs = {
      parameterized = { text = "◈" },
    },
    status = {
      virtual_text = false,
    },
  },
  init = function()
    vim.fn.sign_define("neotest_parameterized", {
      text = "◈",
      texthl = "NeotestMarked",
    })
  end,
}
