return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.1",
  dependencies = { { "nvim-lua/plenary.nvim" }, { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
  keys = function()
    local builtin = require("telescope.builtin")
    return {
      { "<leader>.", builtin.find_files, { desc = "Find Files" } },
      { "<leader>fg", builtin.live_grep, { desc = "Find in global" } },
      { "<leader>,", builtin.buffers, { desc = "Find buffers" } },
      { "<leader>fh", builtin.help_tags, { desc = "Find helps" } },
      { "<leader>fw", builtin.grep_string, { desc = "Find words" } },
      { "<leader>fr", builtin.grep_string, { desc = "Find recent" } },
      { "<leader>fN", "<cmd>Telescope notify<cr>", { desc = "Find notify" } },
      { "<leader>fp", "<cmd>Telescope projects<cr>", { desc = "Find projects" } },
      { "<leader>uC", builtin.colorscheme, { desc = "Change Colorscheme " } },
    }
  end,
  cmd = { "Telescope" },
  config = function()
    local telescope = require("telescope")

    telescope.setup({
      extensions = {
        persisted = {
          layout_config = { width = 0.55, height = 0.55 },
        },
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
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

    telescope.load_extension("fzf")
    telescope.load_extension("projects")
  end,
}
