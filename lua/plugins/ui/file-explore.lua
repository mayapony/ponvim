return {
  "antosha417/nvim-lsp-file-operations",
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
  },
  opts = {},
}
