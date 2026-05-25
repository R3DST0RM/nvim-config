return {
  {
    "nvim-mini/mini.splitjoin",
    version = "*",
    keys = {
      { "gS", desc = "Split/Join arguments" },
    },

    opts = {
      mappings = {
        toggle = "gS",
        split = "",
        join = "",
      },
    },
  },
}
