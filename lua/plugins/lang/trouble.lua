return {
  "folke/trouble.nvim",
  cmd = { "TroubleToggle", "Trouble" },
  opts = { use_diagnostic_signs = true },
  keys = {
    {
      "<leader>xx",
      function()
        require("trouble").open()
      end,
      desc = "Toggle Trouble",
    },
    {
      "<leader>xw",
      function()
        require("trouble").open("workspace_diagnostics")
      end,
      desc = "Workspace Diagnostics (Trouble)",
    },
    {
      "<leader>xd",
      function()
        require("trouble").open("document_diagnostics")
      end,
      desc = "Document Diagnostics (Trouble)",
    },
    {
      "<leader>xq",
      function()
        require("trouble").open("quickfix")
      end,
      desc = "Quickfix List (Trouble)",
    },
    {
      "<leader>xl",
      function()
        require("trouble").open("loclist")
      end,
      desc = "Location List (Trouble)",
    },
    {
      "[q",
      function()
        if require("trouble").is_open() then
          require("trouble").previous({ skip_groups = true, jump = true })
        else
          vim.cmd.cprev()
        end
      end,
      desc = "Previous trouble/quickfix item",
    },
    {
      "]q",
      function()
        if require("trouble").is_open() then
          require("trouble").next({ skip_groups = true, jump = true })
        else
          vim.cmd.cnext()
        end
      end,
      desc = "Next trouble/quickfix item",
    },
  },
}
