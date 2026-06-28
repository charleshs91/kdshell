-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Add an alternative way to exit the edit mode
vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = false })

-- Center the cursor when scrolling
vim.keymap.set("n", "<C-f>", "<C-f>zz", { desc = "Scroll down a page and center cursor" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down half page and center cursor" })
vim.keymap.set("n", "<C-b>", "<C-b>zz", { desc = "Scroll up a page and center cursor" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up half page and center cursor" })

vim.keymap.set("v", "<LeftRelease>", '"*ygv', { desc = "Copy on select with mouse" })
