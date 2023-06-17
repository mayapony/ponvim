return {
  "lewis6991/gitsigns.nvim",
  tag = "release", -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
  event = { "BufReadPre", "BufWritePre" },
  config = function()
    require("gitsigns").setup({
      sign_priority = 1,
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d>",
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
    })
  end,
}
