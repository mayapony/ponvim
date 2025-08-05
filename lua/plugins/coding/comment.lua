-- return {
-- 	{
-- 		"numToStr/Comment.nvim",
-- 		event = "VeryLazy",
-- 		dependencies = {
-- 			"JoosepAlviste/nvim-ts-context-commentstring",
-- 		},
-- 		opts = {
-- 			pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
-- 		},
-- 	},
-- }

return {
	"JoosepAlviste/nvim-ts-context-commentstring",
	event = "VeryLazy",
	config = function()
		require("ts_context_commentstring").setup({
			enable_autocmd = false,
		})

		local get_option = vim.filetype.get_option
		vim.filetype.get_option = function(filetype, option)
			return option == "commentstring" and require("ts_context_commentstring.internal").calculate_commentstring()
				or get_option(filetype, option)
		end
	end,
}
