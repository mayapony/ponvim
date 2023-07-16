return {
  "aserowy/tmux.nvim",
  event = "VeryLazy",
  keys = { "<C-h", "C-l", "C-j", "C-k" },
  config = function()
    return require("tmux").setup({
      resize = {
        -- enables default keybindings (A-hjkl) for normal mode
        enable_default_keybindings = true,
        -- sets resize steps for x axis
        resize_step_x = 5,
        -- sets resize steps for y axis
        resize_step_y = 5,
      },
    })
  end,
}
