return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        disable_italics = true,
        variant = "auto",
        dark_variant = "main",
      })

      vim.api.nvim_command("colorscheme rose-pine")
    end,
  },
}
