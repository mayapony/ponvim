return {
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    ft = "markdown",
    event = "VeryLazy",
    config = function()
      -- default config:
      require("peek").setup({
        auto_load = true, -- whether to automatically load preview when
        close_on_bdelete = true, -- close preview window on buffer delete
        syntax = true, -- enable syntax highlighting, affects performance
        theme = "dark", -- 'dark' or 'light'
        update_on_change = true,
        app = "webview", -- 'webview', 'browser', string or a table of strings
        filetype = { "markdown" }, -- list of filetypes to recognize as markdown
        -- relevant if update_on_change is true
        throttle_at = 200000, -- start throttling when file exceeds this
        throttle_time = "auto", -- minimum amount of time in milliseconds
      })
    end,
  },
  {
    "nfrid/markdown-togglecheck",
    dependencies = { "nfrid/treesitter-utils" },
    ft = { "markdown" },
    event = "VeryLazy",
    config = function()
      require("markdown-togglecheck").setup({
        -- create empty checkbox on item without any while toggling
        create = true,
        -- remove checked checkbox instead of unckecking it while toggling
        remove = false,
      })
      -- toggle checked / create checkbox if it doesn't exist
      vim.keymap.set("n", "<leader>mc", require("markdown-togglecheck").toggle, { desc = "Toggle Checkmark" })
      -- toggle checkbox (it doesn't remember toggle state and always creates [ ])
      vim.keymap.set("n", "<leader>mt", require("markdown-togglecheck").toggle_box, { desc = "Toggle Checkbox" })
    end,
  },
}
