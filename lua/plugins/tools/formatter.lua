return {
  { -- Formatting
    "stevearc/conform.nvim",
    event = { "BufReadPost" },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        python = { "isort" },
        -- Use a sub-list to run only the first available formatter
        typescriptreact = { "prettierd", "prettier", stop_after_first = false },
        javascriptreact = { { "prettierd", "prettier" }, stop_after_first = false },
        typescript = { { "prettierd", "prettier" }, stop_after_first = false },
        javascript = { { "prettierd", "prettier" }, { "eslint_d", "eslint" }, stop_after_first = false },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    },
  },

  { -- Linting
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        markdown = { "markdownlint" },
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          -- Only run the linter in buffers that you can modify in order to
          -- avoid superfluous noise, notably within the handy LSP pop-ups that
          -- describe the hovered symbol using Markdown.
          if vim.opt_local.modifiable:get() then
            lint.try_lint()
          end
        end,
      })
    end,
  },
}
