return {
  "anuvyklack/windows.nvim",
  event = "BufRead",
  dependencies = {
    "anuvyklack/middleclass",
    "anuvyklack/animation.nvim",
  },
  config = function()
    vim.o.winwidth = 10
    vim.o.winminwidth = 10
    vim.o.equalalways = false
    require("windows").setup()

    local function cmd(command)
      return table.concat({ "<Cmd>", command, "<CR>" })
    end

    vim.keymap.set("n", "<C-w>z", cmd("WindowsMaximize"), { desc = "Maximize" })
    vim.keymap.set("n", "<C-w>_", cmd("WindowsMaximizeVertically"), { desc = "Maximize Vertically" })
    vim.keymap.set("n", "<C-w>|", cmd("WindowsMaximizeHorizontally"), { desc = "Maximize Horizontally" })
    vim.keymap.set("n", "<C-w>=", cmd("WindowsEqualize"), { desc = "Equalize" })
  end,
}
