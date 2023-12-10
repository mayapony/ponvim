return {
  "folke/todo-comments.nvim",
  evnent = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {},
  keys = {
    { "<leader>td", "<cmd>TodoTelescope<cr>", desc = "Todo" },
    { "<leader>tq", "<cmd>TodoQuickFix<cr>", desc = "Todo" },
  },
}
