return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<C-\>]],
    })
  end,
  keys = {
    {
      "<leader>tg",
      "<cmd>lua require('config.function').lazygit_toggle()<CR>",
      desc = "Toggle lazygit",
    },
    { "<leader>tt", "<cmd>ToggleTerm<CR>", desc = "Toggle Term" },
  },
}
