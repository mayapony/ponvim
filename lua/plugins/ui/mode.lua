return {
	"mvllow/modes.nvim",
	tag = "v0.2.0",
	event = "BufReadPost",
	config = function()
		-- local mocha = require("catppuccin.palettes").get_palette("mocha")
		local fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("PinkText")), "fg#")
		require("modes").setup({
			colors = {
				insert = fg,
			},
			ignore_filetypes = { 'NvimTree', 'TelescopePrompt', 'neo-tree' }
		})
	end,
}
