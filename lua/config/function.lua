local M = {
  lazygit_toggle = function()
    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
    lazygit:toggle()
  end,
}

return M
