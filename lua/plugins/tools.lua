return {
  {
    "ojroques/nvim-bufdel",
    event = "VeryLazy",
    keys = {
      { "<leader>qq", "<cmd>BufDel<cr>", desc = "Delete Buffer", silent = true },
      { "<leader>qo", "<cmd>BufDelOthers<cr>", desc = "Delete other buffer", silent = true },
      { "<leader>qa", ":qa<cr>", desc = "Delete Buffer all", silent = true },
    },
    opts = {
      {
        next = "tabs",
        quit = false, -- quit Neovim when last buffer is closed
      },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300

      require("which-key").add({
        { "<leader>f", group = "File & Find" },
        { "<leader>b", group = "Buffer" },
        { "<leader>c", group = "Code" },
        { "<leader>d", group = "Debug & Diff" },
        { "<leader>g", group = "Git" },
        { "<leader>m", group = "Manager" },
        { "<leader>q", group = "Session" },
        { "<leader>t", group = "Toggle" },
        { "<leader>u", group = "UI" },
        { "<leader>w", group = "Window" },
        { "<leader>x", group = "Trouble" },
        { "<leader>S", group = "Spectre" },
        { "<leader>s", group = "Search" },
      })
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "VeryLazy",
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
}
