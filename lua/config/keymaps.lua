-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Terminal mappings
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { silent = true })

-- Normal mappings
vim.keymap.set("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer", silent = true })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Previous buffer", silent = true })

-- tmux-sessionizer mappings
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<M-h>", "<cmd>silent !tmux neww tmux-sessionizer -s 0<CR>")
vim.keymap.set("n", "<M-t>", "<cmd>silent !tmux neww tmux-sessionizer -s 1<CR>")
vim.keymap.set("n", "<M-n>", "<cmd>silent !tmux neww tmux-sessionizer -s 2<CR>")
vim.keymap.set("n", "<M-s>", "<cmd>silent !tmux neww tmux-sessionizer -s 3<CR>")

-- Visual mappings
vim.keymap.set("v", "<leader>csl", ":sort<CR>", { desc = "Sort lines", silent = true })

-- Debugging mappings
vim.keymap.set("n", "<leader>dv", function()
  require("dapui").float_element("scopes", { enter = true })
end, { desc = "DAP Scopes float" })

vim.keymap.set({ "n", "v" }, "<leader>dx", function()
  require("dapui").eval()
end, { desc = "DAP Eval float" })

vim.keymap.set("n", "<leader>dX", function()
  require("dap").repl.open()

  vim.defer_fn(function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)

      if vim.bo[buf].filetype == "dap-repl" then
        local width = math.floor(vim.o.columns * 0.8)
        local height = math.floor(vim.o.lines * 0.3)

        vim.api.nvim_win_set_config(win, {
          relative = "editor",
          width = width,
          height = height,
          row = vim.o.lines - height - 2,
          col = math.floor((vim.o.columns - width) / 2),
          style = "minimal",
          border = "rounded",
        })

        vim.api.nvim_set_current_win(win)

        -- support simple close
        vim.keymap.set("n", "q", function()
          vim.api.nvim_win_close(win, true)
        end, { buffer = buf, silent = true })

        vim.keymap.set("n", "<Esc>", function()
          vim.api.nvim_win_close(win, true)
        end, { buffer = buf, silent = true })
      end
    end
  end, 50)
end, { desc = "Floating DAP REPL" })
