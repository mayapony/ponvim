return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost" },
	config = function()
		require("lint").linters_by_ft = {
			typescriptreact = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			javascript = { "eslint_d" },
		}

		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
