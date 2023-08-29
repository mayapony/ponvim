return {
  "ivanjermakov/troublesum.nvim",
  event = "BufReadPost",
  config = function()
    require("troublesum").setup({
			severity_format = { "😡", "W", "I", "H" },
		})
  end,
}
