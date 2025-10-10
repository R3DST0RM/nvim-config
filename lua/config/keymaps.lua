-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Terminal mappings
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { silent = true })

-- Normal mappings
vim.keymap.set("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer", silent = true })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Previous buffer", silent = true })
