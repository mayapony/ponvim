return {
  "echasnovski/mini.pairs",
  event = "VeryLazy",
  opts = {},
  keys = {
    {
      "<leader>tp",
      function()
        vim.g.minipairs_disable = not vim.g.minipairs_disable
        if vim.g.minipairs_disable then
          print("Disabled auto pairs")
        else
          print("Enabled auto pairs")
        end
      end,
      desc = "Toggle Auto Pairs",
    },
  },
}
