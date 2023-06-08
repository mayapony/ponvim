return {
  "jose-elias-alvarez/typescript.nvim",
  ft = { "typescript", "typescriptreact", "javascript", "jsx" },
  config = function()
    require("typescript").setup({
      server = {
        on_attach = function(client, buffer)
          if client.name == "tsserver" then
						-- stylua: ignore
						vim.keymap.set("n", "<leader>co", "<cmd>TypescriptOrganizeImports<CR>",
							{ buffer = buffer, desc = "Organize Imports" })
            vim.keymap.set(
              "n",
              "<leader>cR",
              "<cmd>TypescriptRenameFile<CR>",
              { desc = "Rename File", buffer = buffer }
            )
            vim.keymap.set(
              "n",
              "<leader>ci",
              "<cmd>TypescriptAddMissingImports<CR>",
              { desc = "Import missing modules", buffer = buffer }
            )
            vim.keymap.set(
              "n",
              "<leader>cc",
              "<cmd>TypescriptRemoveUnused<CR>",
              { desc = "Clear unused variables", buffer = buffer }
            )
            vim.keymap.set(
              "n",
              "gd",
              "<cmd>TypescriptGoToSourceDefinition<CR>",
              { desc = "Go to typescript source definition", buffer = buffer }
            )
            -- vim.keymap.set("n", "<leader>ca", "<cmd>CodeActionMenu<CR>",
            --   { desc = "code action menu", buffer = buffer })
          end
        end,
      },
    })
  end,
}
