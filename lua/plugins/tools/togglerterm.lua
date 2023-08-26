return {
  "akinsho/toggleterm.nvim",
  version = "*",
  event = "VeryLazy",
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<c-\>]],
      persist_mode = true,
    })
  end,
  keys = {
    { "<leader>tt", "<cmd>ToggleTerm<CR>", desc = "Toggle Terminal" },
    { "<leader>tg", "<cmd>lua require('config.function').lazygit_toggle()<CR>", desc = "Toggle Lazygit", },
  },
}
