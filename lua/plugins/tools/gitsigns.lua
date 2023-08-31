return {
  "lewis6991/gitsigns.nvim",
  tag = "release", -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
  event = { "BufReadPre", "BufWritePre" },
  config = function()
    local icons = require("config.icons")
    require("gitsigns").setup({
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d>",
      signs = {
        add = { text = icons.git.added },
        change = { text = icons.git.changed },
        delete = { text = icons.git.deleted },
        topdelete = { text = icons.git.deleted },
        changedelete = { text = icons.git.changed },
        untracked = { text = icons.git.untracked },
      },
    })
  end,
}
