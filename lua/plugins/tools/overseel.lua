return {
  "stevearc/overseer.nvim",
  config = function()
    require('overseer').setup({
      strategy = "toggleterm",
      extensions = {
        overseer = {
          -- customize here
        }
      }
    })
  end,
  keys = {
    { "<leader>rr", "<cmd>OverseerRun<cr>",    desc = "Run tasks" },
    { "<leader>rt", "<cmd>OverseerToggle<cr>", desc = "Toggle Run panel" },
  }
}

