-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Check if the system is Windows and set PowerShell as the default shell
if vim.loop.os_uname().sysname == "Windows_NT" then
  vim.opt.shell = "pwsh"
  vim.opt.shellcmdflag = "-NoProfile -Command"
  vim.opt.shellquote = ""
  vim.opt.shellxquote = ""
end
