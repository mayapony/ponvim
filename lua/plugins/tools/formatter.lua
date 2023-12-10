return {
  "stevearc/conform.nvim",
  event = { "BufReadPost" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform will run multiple formatters sequentially
      python = { "isort" },
      -- Use a sub-list to run only the first available formatter
      typescriptreact = { { "prettierd", "prettier" }, { "eslint_d", "eslint" } },
      typescript = { { "prettierd", "prettier" }, { "eslint_d", "eslint" } },
      javascript = { { "prettierd", "prettier" }, { "eslint_d", "eslint" } },
    },
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 1000,
      lsp_fallback = true,
    },
  },
}
