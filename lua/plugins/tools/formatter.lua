return {
  "stevearc/conform.nvim",
  event = { "BufReadPost" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform will run multiple formatters sequentially
      python = { "isort" },
      -- Use a sub-list to run only the first available formatter
      typescriptreact = { { "prettierd", "prettier" }, { "eslint_d", "eslint" }, stop_after_first = false },
      javascriptreact = { { "prettierd", "prettier" }, { "eslint_d", "eslint" }, stop_after_first = false },
      typescript = { { "prettierd", "prettier" }, { "eslint_d", "eslint" }, stop_after_first = false },
      javascript = { { "prettierd", "prettier" }, { "eslint_d", "eslint" }, stop_after_first = false },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
}
