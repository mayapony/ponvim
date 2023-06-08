return {
  "nvim-lualine/lualine.nvim",
  event = "BufReadPre",
  opts = function()
    return {
      options = {
        theme = "rose-pine",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha", "neo-tree" } },
        component_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          {
            "diagnostics",
          },
          {
            "filetype",
            icon_only = true,
            separator = "",
            padding = {
              left = 1,
              right = 0,
            },
          },
					-- stylua: ignore
					{
						"filename",
						path = 1,
						symbols = {
							modified = "*",
							readonly = "",
							unnamed = ""
						}
					},
        },
        lualine_x = {
          {
            "diff",
          },
        },
        lualine_y = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          function()
            return " " .. os.date("%R")
          end,
        },
      },
      extensions = { "toggleterm" },
    }
  end,
}
