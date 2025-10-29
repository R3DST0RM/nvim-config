return {
  {
    "stevearc/overseer.nvim",
    cmd = {
      "OverseerOpen",
      "OverseerToggle",
      "OverseerRun",
      "OverseerBuild",
      "OverseerQuickAction",
      "OverseerTaskAction",
    },
    keys = {
      { "<leader>oo", "<cmd>OverseerToggle<CR>", desc = "Overseer: Panel" },
      { "<leader>or", "<cmd>OverseerRun<CR>", desc = "Overseer: Task starten" },
      { "<leader>oa", "<cmd>OverseerQuickAction<CR>", desc = "Overseer: Quick Action" },
      { "<leader>ot", "<cmd>OverseerTaskAction<CR>", desc = "Overseer: Task Action" },
    },
    opts = {
      strategy = "terminal", -- oder "toggleterm", falls du das Plugin nutzt
      templates = { "builtin" },
      task_list = { direction = "right", min_width = 40 },
    },
  },
}
