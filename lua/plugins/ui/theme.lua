return {
  -- {
  --   "vimpostor/vim-lumen",
  --   lazy = false,
  --   priority = 10010,
  -- },
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   -- priority = 10000,
  --   -- lazy = false,
  --   config = function()
  --     require("catppuccin").setup({
  --       background = {
  --         -- :h background
  --         light = "latte",
  --         dark = "mocha",
  --       },
  --       transparent_background = true, -- disables setting the background color.
  --       term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
  --       dim_inactive = {
  --         enabled = false, -- dims the background color of inactive window
  --         shade = "dark",
  --         percentage = 0.15, -- percentage of the shade to apply to the inactive window
  --       },
  --       no_italic = true, -- Force no italic
  --       no_bold = false, -- Force no bold
  --       no_underline = false, -- Force no underline
  --       styles = {
  --         -- Handles the styles of general hi groups (see `:h highlight-args`):
  --         comments = { "italic" }, -- Change the style of comments
  --         conditionals = { "italic" },
  --         keywords = { "bold" },
  --         operators = { "bold" },
  --       },
  --       custom_highlights = function(colors)
  --         return {
  --           BufferlineOffset = {
  --             -- bg = colors.mantle,
  --             fg = colors.pink,
  --             bold = true,
  --           },
  --           -- NeoTreeNormal = { bg = colors.base },
  --           -- NeoTreeNormalNC = { bg = colors.base },
  --           IndentlineStyle = { fg = colors.pink },
  --           NeoTreeDirectoryName = { fg = colors.pink },
  --           NeoTreeDirectoryIcon = { fg = colors.pink },
  --           NeoTreeTitleBar = { fg = colors.pink },
  --           NeoTreeRootName = { fg = colors.pink },
  --           AlphaHeader = { fg = colors.pink },
  --           AlphaButtons = { fg = colors.pink },
  --           AlphaShortcut = { fg = colors.pink },
  --           PinkText = { fg = colors.pink },
  --         }
  --       end,
  --       integrations = {
  --         cmp = true,
  --         gitsigns = true,
  --         telescope = true,
  --         notify = true,
  --         alpha = true,
  --         neotree = true,
  --         which_key = true,
  --         treesitter = true,
  --         -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
  --       },
  --     })
  --
  --     -- setup must be called before loading
  --     vim.cmd.colorscheme("catppuccin")
  --   end,
  -- },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 10000,
    lazy = false,
    config = function()
      vim.cmd.colorscheme("gruvbox")
    end,
  },
  -- {
  --   "rose-pine/neovim",
  --   name = "rose-pine",
  --   priority = 10000,
  --   lazy = false,
  --   config = function()
  -- 	require('rose-pine').setup({
  -- 		variant = 'moon',
  -- 		dark_variant = 'moon',
  -- 	})
  --     vim.cmd.colorscheme("rose-pine")
  --   end,
  -- },
}
