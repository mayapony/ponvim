return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost" },
	config = function()
		require("lint").linters_by_ft = {
			typescriptreact = { "eslint_d" },
			javascriptreact = { "eslint_d" },
		}

		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
			callback = function()
				-- try_lint without arguments runs the linters defined in `linters_by_ft`
				-- for the current filetype
				require("lint").try_lint()
			end,
		})
	end,
}
