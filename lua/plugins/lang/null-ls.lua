local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    -- event = { "BufReadPost", "BufNewFile" },
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          -- Replace these with the tools you have installed
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.shfmt,
          null_ls.builtins.code_actions.eslint_d.with({
            only_local = "node_modules/.bin",
          }),
          null_ls.builtins.diagnostics.eslint_d.with({
            only_local = "node_modules/.bin",
          }),

          -- typescript.nvim
          require("typescript.extensions.null-ls.code-actions"),
        },
        -- you can reuse a shared lspconfig on_attach callback here
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/rangeFormatting") then
            vim.keymap.set({ "n", "x" }, "<Leader>F", function()
              vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
            end, { buffer = bufnr, desc = "[lsp] format" })
          end
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                vim.lsp.buf.format({
                  async = true,
                  filter = function(c)
                    return c.name == "null-ls"
                  end,
                })
              end,
              desc = "[null-ls] format on save",
            })
          end
        end,
      })
    end,
  },
}
