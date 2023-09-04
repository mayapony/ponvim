return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(plugin)
    if plugin.override then
      require("lazyvim.util").deprecate("lualine.override", "lualine.opts")
    end

    local icons = require("config.icons")

    local diagnostics = {
      "diagnostics",
      sources = { "nvim_diagnostic" },
      sections = { "error", "warn", "info", "hint" },
      symbols = {
        error = icons.diagnostics.Error,
        hint = icons.diagnostics.Hint,
        info = icons.diagnostics.Info,
        warn = icons.diagnostics.Warn,
      },
      colored = true,
      update_in_insert = false,
      always_visible = false,
    }

    local diff = {
      "diff",
      symbols = {
        added = icons.git.added .. " ",
        untracked = icons.git.added .. " ",
        modified = icons.git.changed .. " ",
        removed = icons.git.deleted .. " ",
      },
      colored = true,
      always_visible = false,
    }

    return {
      options = {
        theme = "auto",
        globalstatus = true,
        component_separators = { left = "", right = "" },
        disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha", "neo-tree", "Trouble", "term" } },
      },
      extensions = { "toggleterm" },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {"filename", diagnostics },
        lualine_x = {
          diff,
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_y = {},
        lualine_z = {},
      },
    }
  end,
}
