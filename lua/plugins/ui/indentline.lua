return {
  "shellRaining/hlchunk.nvim",
  event = { "BufRead" },
  config = function()
    require("hlchunk").setup({
      chunk = {
        enable = true,
        use_treesitter = true,
        notify = false, -- notify if some situation(like disable chunk mod double time)
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
