local g = vim.g

g.mapleader = " "
g.maplocalleader = " "
g.cursorhold_updatetime = 100
g.suda_smart_edit = 1

-- source: https://github.com/nvim-tree/nvim-tree.lua#quick-start
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
