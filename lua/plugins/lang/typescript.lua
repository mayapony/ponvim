return {
  "jose-elias-alvarez/typescript.nvim",
  ft = { "typescript", "typescriptreact", "javascript", "jsx" },
  config = function()
    require("typescript").setup({})
  end,
}
