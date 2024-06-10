return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    {
      "<leader>e",
      function()
        require("neo-tree.command").execute({ toggle = true })
      end,
      desc = "Explorer NeoTree",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function(_, opts)
    require("neo-tree").setup(opts)
  end,
  opts = {
    sources = { "filesystem", "buffers", "git_status", "document_symbols" },
    filesystem = {
      hijack_netrw_behavior = "open_default",
      hide_by_name = {
        ".git",
        "node_modules",
      },
      always_show = {
        ".gitignore",
        ".eslintrc.js",
      },
      bind_to_cwd = true,
      follow_current_file = {
        enabled = true,
      },
      use_libuv_file_watcher = false,
    },
    enable_git_status = true,
    enable_diagnostics = false,
    window = {
      width = 40,
    },
    default_component_configs = {
      indent = {
        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
      name = {
        use_git_status_colors = false,
      },
      git_status = {
        symbols = require("config.icons").git,
      },
    },
  },
}
