-- init.lua
-- source: https://github.com/folke/lazy.nvim#-installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

if not vim.g.vscode then
  require("config.options")
  require("config.autocmd")
  require("config.keymaps")

  require("lazy").setup({ { import = "plugins" } })
else
  local vscode = require("vscode")
  vscode.configure()

  local options = {
    root = vim.fn.stdpath("data") .. "/lazy-vscode",
    lockfile = vim.fn.stdpath("config") .. "/lazy-vscode-lock.json",
  }
  if vim.loop.os_uname().version:match("Windows") then
    options.concurrency = 1
  end

  require("lazy").setup(vscode.packages(), options)
end
