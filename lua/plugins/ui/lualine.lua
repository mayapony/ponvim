return {
	"nvim-lualine/lualine.nvim",
	-- event = "VeryLazy",
	enabled = true,
	event = "VimEnter",
	dependencies = {
		{
			"chrisgrieser/nvim-recorder",
			evnent = "BufReadPost",
			dependencies = "rcarriga/nvim-notify", -- optional
			opts = {},
		},
		{
			"letieu/harpoon-lualine",
			dependencies = {
				{
					"ThePrimeagen/harpoon",
					branch = "harpoon2",
				},
			},
		},
	},
	opts = function()
		return {
			options = {
				theme = "auto",
				globalstatus = true,
				disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha", "neo-tree", "Trouble" } },
				component_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {
					{
						"filetype",
						icon_only = true,
						separator = "",
						padding = {
							left = 1,
							right = 0,
						},
					},
					{
						"filename",
						path = 1,
						symbols = {
							modified = "*",
							readonly = "",
							unnamed = "",
						},
					},
					{
						"harpoon2",
						icon = ""
					},
					{
						"diagnostics",
					},
				},
				lualine_x = {
					{
						require("noice").api.status.command.get,
						cond = require("noice").api.status.command.has,
					},
					{
						require("noice").api.status.mode.get,
						cond = require("noice").api.status.mode.has,
					},
					{
						require("noice").api.status.search.get,
						cond = require("noice").api.status.search.has,
					},
					{
						"diff",
					},
					{ "progress", separator = " ",                  padding = { left = 1, right = 0 } },
					{ "location", padding = { left = 0, right = 1 } },
				},
				lualine_y = {},
				lualine_z = {},
			},
			extensions = { "toggleterm" },
		}
	end,
}
