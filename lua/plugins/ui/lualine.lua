return {
  "nvim-lualine/lualine.nvim",
  -- priority = 10000,
  event = "BufReadPost",
  opts = function()
    return {
      options = {
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha", "neo-tree", "Trouble" } },
        component_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            "filetype",
            icon_only = true,
            separator = "",
            padding = {
              left = 1,
              right = 0,
            },
          },
          {
            "filename",
            path = 1,
            symbols = {
              modified = "*",
              readonly = "",
              unnamed = "",
            },
          },
          {
            "diagnostics",
          },
        },
        lualine_x = {
          {
            "diff",
          },
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { "toggleterm" },
    }
  end,
}
