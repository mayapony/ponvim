return {
  "mvllow/modes.nvim",
  tag = "v0.2.0",
  event = "BufReadPost",
  config = function()
    local mocha = require("catppuccin.palettes").get_palette("mocha")
    require("modes").setup({
      colors = {
        bg = "",
        copy = mocha.yellow,
        delete = mocha.red,
        insert = mocha.pink,
        visual = mocha.mauve,
      },
    })
  end,
}
