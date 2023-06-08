return {
  -- {
  --   "olimorris/persisted.nvim",
  --   config = function()
  --     require("persisted").setup({
  --       autosave = true,
  --       autoload = true,
  --       on_autoload_no_session = function()
  --         vim.notify("No existing session to load.")
  --       end,
  --     })
  --   end,
  -- },
  {
    "ojroques/nvim-bufdel",
    keys = {
      { "<leader>qq", "<cmd>BufDel<cr>", desc = "Delete Buffer", silent = true },
      { "<leader>qo", "<cmd>BufDelOthers<cr>", desc = "Delete other buffer", silent = true },
      { "<leader>qa", ":wqa<cr>", desc = "Delete Buffer all", silent = true },
    },
    config = function()
      require("bufdel").setup({
        next = "tabs",
        quit = false, -- quit Neovim when last buffer is closed
      })
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        ["<space>"] = "SPC",
        ["<cr>"] = "RET",
        ["<tab>"] = "TAB",
      },
    },
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPost",
    config = function()
      require("colorizer").setup({
        filetypes = { "*" },
        user_default_options = {
          RGB = true, -- #RGB hex codes
          RRGGBB = true, -- #RRGGBB hex codes
          names = true, -- "Name" codes like Blue or blue
          RRGGBBAA = true, -- #RRGGBBAA hex codes
          AARRGGBB = true, -- 0xAARRGGBB hex codes
          rgb_fn = true, -- CSS rgb() and rgba() functions
          hsl_fn = true, -- CSS hsl() and hsla() functions
          css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
          -- Available modes for `mode`: foreground, background,  virtualtext
          mode = "background", -- Set the display mode.
          -- Available methods are false / true / "normal" / "lsp" / "both"
          -- True is same as normal
          tailwind = true, -- Enable tailwind colors
          -- parsers can contain values used in |user_default_options|
          sass = { enable = false, parsers = { "css" } }, -- Enable sass colors
          virtualtext = "■",
          -- update color values even if buffer is not focused
          -- example use: cmp_menu, cmp_docs
          always_update = false,
        },
        -- all the sub-options of filetypes apply to buftypes
        buftypes = {},
      })
    end,
  },
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    config = function()
      require("project_nvim").setup({
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".luarc.json" },
      })
    end,
  },
  {
    "phaazon/hop.nvim",
    event = "BufReadPost",
    name = "hop",
    branch = "v2",
    config = function()
      require("hop").setup({
        keys = "etovxqpdygfblzhckisuran",
        quit_key = "<SPC>",
        case_insensitive = true,
        multi_windows = true,
      })
      local hop = require("hop")
      local directions = require("hop.hint").HintDirection
      vim.keymap.set("", "f", function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
      end, { remap = true })
      vim.keymap.set("", "F", function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
      end, { remap = true })
      vim.keymap.set("", "t", function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
      end, { remap = true })
      vim.keymap.set("", "T", function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
      end, { remap = true })
      vim.keymap.set("", "s", "<cmd>HopChar2<cr>", { remap = true })
      vim.keymap.set({ "n", "x" }, "<leader><leader>j", "<cmd>HopLine<cr>", {})
    end,
  },
}
