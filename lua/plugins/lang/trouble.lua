return {
  "folke/trouble.nvim",
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  cmd = "Trouble",
  keys = {
    {
      "]x",
      function()
        local trouble = require("trouble")
        if trouble.is_open() then
          ---@diagnostic disable-next-line: missing-parameter
          trouble.next({ skip_groups = true, jump = true })
        end
      end,
      desc = "Next (Trouble)",
    },
    {
      "[x",
      function()
        local trouble = require("trouble")
        if trouble.is_open() then
          ---@diagnostic disable-next-line: missing-parameter
          trouble.prev({ skip_groups = true, jump = true })
        end
      end,
      desc = "Prev (Trouble)",
    },
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>cs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>cl",
      "<cmd>Trouble lsp toggle focus=true win.position=bottom<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  },
}
