return {
  {
    "pmizio/typescript-tools.nvim",
    ft = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact" },
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      on_attach = function()
        vim.keymap.set("n", "<leader>co", "<cmd>TSToolsOrganizeImports<cr>", { desc = "Organize Imports" })
        vim.keymap.set("n", "<leader>ci", "<cmd>TSToolsAddMissingImports<cr>", { desc = "Add Missing Imports" })
        vim.keymap.set({ "i", "v", "n", "s" }, "<C-s>", function()
          vim.cmd([[w]])
        end, { desc = "Save file" })
        vim.keymap.set({ "n" }, "<leader>fs", function()
          vim.cmd([[w]])
        end, { desc = "Save file" })
      end,
    },
  },
  {
    "dmmulroy/tsc.nvim",
    ft = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact" },
		opts = {},
    keys = {
      {
        "<leader>cc",
        "<cmd>TSC<cr>",
        desc = "Typescript Check",
      },
    },
  },
}
