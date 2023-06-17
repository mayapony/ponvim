return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        disable_italics = true,
        -- disable_float_background = true,
        -- disable_background = true,
        variant = "auto",
        --- @usage 'main'|'moon'|'dawn'
        dark_variant = "main",
      })

      vim.api.nvim_command("colorscheme rose-pine")
      -- vim.cmd([[highlight GitSignsAdd guibg=NONE
      --        highlight GitSignsChange guibg=NONE
      --        highlight GitSignsDelete guibg=NONE]])
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-tree/nvim-web-devicons",
      },
      "MunifTanjim/nui.nvim",
    },
    config = function(_, opts)
      require("neo-tree").setup(opts)
    end,
    keys = {
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({ toggle = true })
        end,
        desc = "Explorer NeoTree",
      },
    },
    opts = {
      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
      filesystem = {
        bind_to_cwd = true,
        follow_current_file = true,
        use_libuv_file_watcher = true,
      },
      enable_git_status = false,
      enable_diagnostics = false,
      window = {
        width = 25,
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
      },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("indent_blankline").setup({
        char = "│",
        filetype_exclude = { "help", "alpha", "dashboard", "Trouble", "lazy", "mason", "toggleterm", "neo-tree" },
        show_trailing_blankline_indent = false,
        show_current_context = true,
        show_end_of_line = false,
      })
    end,
  },
  {
    "rcarriga/nvim-notify",
    event = "VimEnter",
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Dismiss all Notifications",
      },
    },
    opts = {
      timeout = 3000,
      render = "minimal",

      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.35)
      end,
    },
    config = function()
      vim.notify = require("notify")
    end,
  },
}
