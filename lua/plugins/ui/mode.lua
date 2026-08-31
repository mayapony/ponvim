return {
	"mvllow/modes.nvim",
	tag = "v0.2.0",
	event = "BufReadPost",
	config = function()
		require("modes").setup({
			ignore_filetypes = { "NvimTree", "TelescopePrompt", "neo-tree" },
		})
	end,
}
