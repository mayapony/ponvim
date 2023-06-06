local opt = vim.opt
local M = {}
local function augroup(name)
  return vim.api.nvim_create_augroup("maya_" .. name, { clear = true })
end

function M.configure()
  -- settings
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "

  opt.clipboard = "unnamedplus"
  opt.ignorecase = true
  opt.smartcase = true

  -- Highlight on yank
  vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function()
      vim.highlight.on_yank()
    end,
  })

  require("config.keymaps").initVscode()
end

function M.packages()
  return {
    {
      "phaazon/hop.nvim",
      name = "hop",
      branch = "v2",
      config = function()
        require("hop").setup({
          keys = "etovxqpdygfblzhckisuran",
          quit_key = "<SPC>",
          case_insensitive = true,
          multi_windows = true,
        })
        local hop = require("hop")
        local directions = require("hop.hint").HintDirection
        vim.keymap.set("", "f", function()
          hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
        end, { remap = true })
        vim.keymap.set("", "F", function()
          hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
        end, { remap = true })
        vim.keymap.set("", "t", function()
          hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
        end, { remap = true })
        vim.keymap.set("", "T", function()
          hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
        end, { remap = true })
        vim.keymap.set("", "s", "<cmd>HopChar2<cr>", { remap = true })
        vim.keymap.set("n", "<leader><leader>j", "<cmd>HopLine<cr>", {})
      end,
    },
    {
      "kylechui/nvim-surround",
      version = "*",
      config = function()
        require("nvim-surround").setup({})
      end,
    },
  }
end

return M
