return {
  "echasnovski/mini.comment",
  event = "VeryLazy",
  dependencies = { "JoosepAlviste/nvim-ts-context-commentstring", opts = true },
	config = function (_, opts)
		require("mini.comment").setup(opts)
	end,
  opts = {
    options = {
      custom_commentstring = function()
        vim.g.skip_ts_context_commentstring_module = true
        return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
      end,
    },
  },
}
