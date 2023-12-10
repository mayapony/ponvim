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
  -- load nvim config
  require("config.options")
  require("config.autocmd")
  require("config.global")

  require("config.keymaps").initNvim()

  require("lazy").setup({
    spec = {
      { import = "plugins" },
      { import = "plugins.lang" },
      { import = "plugins.tools" },
      { import = "plugins.ui" },
      { import = "plugins.coding" },
    },
    checker = { enabled = false },
    change_detection = {
      -- automatically check for config file changes and reload the ui
      enabled = true,
      notify = false, -- get a notification when changes are found
    },
    defaults = {
      version = false,
      lazy = true,
    },
    performance = {
      rtp = {
        -- disable some rtp plugins
        disabled_plugins = {
          "netrw",
          "netrwPlugin",
          "netrwSettings",
          "netrwFileHandlers",
          "gzip",
          -- "matchit",
          -- "matchparen",
          -- "netrwPlugin",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
      },
    },
  })
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
