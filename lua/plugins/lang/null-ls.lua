return {
  "jose-elias-alvarez/null-ls.nvim",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        -- Replace these with the tools you have installed
        -- null_ls.builtins.formatting.prettierd,
        null_ls.builtins.code_actions.eslint_d,
        null_ls.builtins.diagnostics.eslint_d,
        --null_ls.builtins.formatting.stylua,
        -- typescript.nvim
        -- require("typescript.extensions.null-ls.code-actions"),
      },
    })
  end,
}
