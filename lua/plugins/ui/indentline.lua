return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("indent_blankline").setup({
      char = "│",
      filetype_exclude = { "help", "alpha", "dashboard", "Trouble", "lazy", "mason", "toggleterm", "neo-tree" },
      show_trailing_blankline_indent = false,
      show_end_of_line = false,
      use_treesitter = true,
      use_treesitter_scope = true,
      space_char_blankline = " ",
      show_current_context = true,
      show_current_context_start = false,
    })
  end,
}
