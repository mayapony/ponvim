return {
  "shellRaining/hlchunk.nvim",
  event = { "BufRead" },
  config = function()
    require("hlchunk").setup({
      chunk = {
        enable = true,
        use_treesitter = true,
        notify = true, -- notify if some situation(like disable chunk mod double time)
        exclude_filetypes = {
          aerial = true,
          dashboard = true,
          Trouble = true,
        },
        support_filetypes = {
          "*.lua",
          "*.js",
          "*.jsx",
          "*.ts",
          "*.tsx",
          "*.json",
        },
        chars = {
          horizontal_line = "─",
          vertical_line = "│",
          left_top = "╭",
          left_bottom = "╰",
          right_arrow = ">",
        },
        style = {
          { fg = vim.fn.synIDattr(vim.fn.hlID("IndentlineStyle"), "fg", "gui") },
        },
      },

      indent = {
        enable = false,
        use_treesitter = false,
        chars = { "│", "¦", "┆", "┊" },
        style = {
          { fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui") },
        },
      },

      line_num = {
        enable = true,
        use_treesitter = false,
        style = vim.fn.synIDattr(vim.fn.hlID("IndentlineStyle"), "fg", "gui"),
      },
      blank = {
        enable = false,
      },
    })
  end,
}
--
-- return {
--   "lukas-reineke/indent-blankline.nvim",
--   event = { "BufReadPost", "BufNewFile" },
--   config = function()
--     require("indent_blankline").setup({
--       char = "│",
--       filetype_exclude = { "help", "alpha", "dashboard", "Trouble", "lazy", "mason", "toggleterm", "neo-tree" },
--       show_trailing_blankline_indent = false,
--       show_end_of_line = false,
--       use_treesitter = true,
--       use_treesitter_scope = true,
--       space_char_blankline = " ",
--       show_current_context = true,
--     })
--   end,
-- }
