return {
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      opts = {
        -- Defaults
        enable_close = true, -- Auto close tags
        enable_rename = true, -- Auto rename pairs of tags
        enable_close_on_slash = true, -- Auto close on trailing </
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    version = "*", -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-context",
        envent = { "BufReadPost" },
        config = function()
          require("treesitter-context").setup({
            max_lines = 3,
          })
        end,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
    opts = {
      highlight = {
        enable = true,
        disable = function(_, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            require("notify")("File too large to highlight", vim.log.levels.WARN)
            return true
          end
          return false
        end,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true, disable = { "python" } },
      ensure_installed = {
        "bash",
        "c",
        "html",
        "javascript",
        "json",
        "lua",
        "python",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "vue",
        "rust",
        "toml",
        "cpp",
        "markdown",
        "markdown_inline",
        "vimdoc",
      },
    },
  },
}
