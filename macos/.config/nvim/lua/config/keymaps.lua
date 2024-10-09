-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>cL", function()
  require("telescope.builtin").lsp_document_symbols({ symbols = "function" })
end, { noremap = true, silent = true, desc = "Find Function" })

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<A-Up>", "<cmd>resize +2<cr>", { noremap = true, silent = true, desc = "Increase Window Height" })
vim.keymap.set(
  "n",
  "<A-Down>",
  "<cmd>resize -2<cr>",
  { noremap = true, silent = true, desc = "Decrease Window Height" }
)
vim.keymap.set(
  "n",
  "<A-Left>",
  "<cmd>vertical resize -2<cr>",
  { noremap = true, silent = true, desc = "Decrease Window Width" }
)
vim.keymap.set(
  "n",
  "<A-Right>",
  "<cmd>vertical resize +2<cr>",
  { noremap = true, silent = true, desc = "Increase Window Width" }
)

vim.keymap.del("n", "<C-Up>")
vim.keymap.del("n", "<C-Down>")
vim.keymap.del("n", "<C-Left>")
vim.keymap.del("n", "<C-Right>")
