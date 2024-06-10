return {
  {
    "NeogitOrg/neogit",
    cmd = { "Neogit" },
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "ibhagwan/fzf-lua", -- optional
    },
    config = true,
  },
  {
    "sindrets/diffview.nvim",
    event = "BufReadPost",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("diffview").setup({
        diff_binaries = false,
        use_icons = true,
      })
    end,
    keys = {
      { "<leader>db", "<cmd>DiffviewFileHistory<cr>", desc = "Open diffview current branch history", silent = true },
      { "<leader>df", "<cmd>DiffviewFileHistory %<cr>", desc = "Open diffview current file history", silent = true },
      { "<leader>dd", "<cmd>DiffviewOpen<cr>", desc = "Open diffview", silent = true },
      { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Close diffview", silent = true },
    },
  },
}
