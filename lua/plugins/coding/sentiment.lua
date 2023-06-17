-- Enhanced matchparen.vim plugin for Neovim to highlight the outer pair.

local spec = {
  "utilyre/sentiment.nvim",
  event = { "VeryLazy" },
}

function spec:config()
  local sentiment = require("sentiment")

  sentiment.setup()
end

return spec
