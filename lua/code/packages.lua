local packages = {
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesj").setup({ --[[ your config ]]
      })
      vim.keymap.set("n", "<leader>cj", require("treesj").toggle)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        modules = {},
        ignore_install = {},
        auto_install = true,
        ensure_installed = {
          "javascript",
          "tsx",
          "typescript",
        },
        sync_install = false,
        highlight = { enable = false },
        indent = { enable = false },
      })
    end,
  },
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "gsa",
        delete = "gsd",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        replace = "gsr",
        update_n_lines = "gsn",
      },
    },
  },
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        char = {
          jump_labels = true,
        },
      },
    },
			-- stylua: ignore
			keys = {
				{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
				{ "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
			},
  },
}

local options = {
  root = vim.fn.stdpath("data") .. "/lazy-vscode",
  lockfile = vim.fn.stdpath("config") .. "/lazy-vscode-lock.json",
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
}

if vim.loop.os_uname().version:match("Windows") then
  options.concurrency = 1
end
require("lazy").setup(packages, options)
