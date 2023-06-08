return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.1",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "VeryLazy",
  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>.", builtin.find_files, { desc = "Find Files" })
    vim.keymap.set("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Find in buffer" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find in global" })
    vim.keymap.set("n", "<leader>,", builtin.buffers, { desc = "Find buffers" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find helps" })
    vim.keymap.set({ "n", "v" }, "<leader>fw", builtin.grep_string, { desc = "Find words" })
    vim.keymap.set("n", "<leader>fr", builtin.grep_string, { desc = "Find recent" })
    vim.keymap.set("n", "<leader>fN", "<cmd>Telescope notify<cr>", { desc = "Find notify" })
    vim.keymap.set("n", "<leader>fp", "<cmd>Telescope projects<cr>", { desc = "Find projects" })
    vim.keymap.set("n", "<leader>uC", builtin.colorscheme, { desc = "Change Colorscheme " })

    telescope.load_extension("projects")

    telescope.setup({
      extensions = {
        persisted = {
          layout_config = { width = 0.55, height = 0.55 },
        },
      },
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        defaults = {
          layout_strategy = "horizontal",
          layout_config = { prompt_position = "top" },
          sorting_strategy = "ascending",
          winblend = 0,
        },
        mappings = {
          i = {
            ["<c-t>"] = function(...)
              return require("trouble.providers.telescope").open_with_trouble(...)
            end,
            ["<a-t>"] = function(...)
              return require("trouble.providers.telescope").open_selected_with_trouble(...)
            end,
            ["<C-Down>"] = function(...)
              return require("telescope.actions").cycle_history_next(...)
            end,
            ["<C-Up>"] = function(...)
              return require("telescope.actions").cycle_history_prev(...)
            end,
            ["<C-f>"] = function(...)
              return require("telescope.actions").preview_scrolling_down(...)
            end,
            ["<C-b>"] = function(...)
              return require("telescope.actions").preview_scrolling_up(...)
            end,
          },
          n = {
            ["q"] = function(...)
              return require("telescope.actions").close(...)
            end,
          },
        },
      },
    })
  end,
}
