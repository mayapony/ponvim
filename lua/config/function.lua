local M = {
  lazygit_toggle = function()
    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
    lazygit:toggle()
  end,
  toggle_line = function()
    if vim.b.lnstatus == nil then
      vim.b.lnstatus = "number"
    end

    if vim.b.lnstatus == "number" then
      vim.o.number = false
      vim.o.relativenumber = false
      vim.b.lnstatus = "nonumber"
    else
      vim.o.number = true
      vim.o.relativenumber = true
      vim.b.lnstatus = "number"
    end
  end,
}

return M
