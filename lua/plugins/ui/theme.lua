return {
	{
		"ellisonleao/gruvbox.nvim",
		name = "gruvbox",
		priority = 10000,
		lazy = false,
		config = function()
			require("gruvbox").setup({
				terminal_colors = true,
				transparent_mode = true,
				dim_inactive = false,
				contrast = "hard",
				italic = {
					strings = false,
					comments = true,
					operators = false,
					folds = true,
				},
			})

			vim.cmd.colorscheme("gruvbox")

			-- transparent bg, gruvbox-style overrides
			vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
			vim.api.nvim_set_hl(0, "WinBar", { fg = "#D3869B", bg = "#282828", bold = true })
			vim.api.nvim_set_hl(0, "StatusLine", { bg = "#282828" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1D2021" })
			vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#A89984", bg = "#1D2021" })
		end,
	},
}