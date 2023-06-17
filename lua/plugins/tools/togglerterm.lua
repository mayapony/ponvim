return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    local highlights = require("rose-pine.plugins.toggleterm")
    require("toggleterm").setup({
      open_mapping = [[<c-`>]],
      highlights = highlights,
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
