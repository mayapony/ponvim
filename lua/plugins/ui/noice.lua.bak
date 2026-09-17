return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	opts = {
		routes = {
			{
				filter = {
					event = "msg_show",
					any = {
						{ find = "%d+L, %d+B" },
						{ find = "; after #%d+" },
						{ find = "; before #%d+" },
					},
				},
				view = "mini",
			},
		},
		presets = {
			bottom_search = true,      -- use a classic bottom cmdline for search
			command_palette = true,    -- position the cmdline and popupmenu together
			long_message_to_split = true, -- long messages will be sent to a split
			inc_rename = true,         -- enables an input dialog for inc-rename.nvim
		},
	},
	-- stylua: ignore
	keys = {
		{
			"<S-Enter>",
			function() require("noice").redirect(vim.fn.getcmdline()) end,
			mode = "c",
			desc =
			"Redirect Cmdline"
		},
		{
			"<leader>snl",
			function() require("noice").cmd("last") end,
			desc =
			"Noice Last Message"
		},
		{
			"<leader>snh",
			function() require("noice").cmd("history") end,
			desc =
			"Noice History"
		},
		{ "<leader>sna", function() require("noice").cmd("all") end,     desc = "Noice All" },
		{ "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
	},
}
