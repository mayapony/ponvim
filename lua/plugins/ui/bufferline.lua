local spec = {
	"akinsho/bufferline.nvim",
	enabled = false,
	event = "BufRead",
	keys = {
		{
			"<S-h>",
			"<cmd>BufferLineCyclePrev<cr>",
			{ desc = "Prev buffer" },
		},
		{
			"<S-l>",
			"<cmd>BufferLineCycleNext<cr>",
			{ desc = "Next buffer" },
		},
		{ "<leader>fb", "<Cmd>BufferLinePick<CR>", desc = "Find Buffer" },
		{
			"<A-1>",
			mode = { "n", "i" },
			"<Cmd>BufferLineGoToBuffer 1<CR>",
			desc = "go to buffer 1",
		},
		{
			"<A-2>",
			mode = { "n", "i" },
			"<Cmd>BufferLineGoToBuffer 2<CR>",
			desc = "go to buffer 2",
		},
		{
			"<A-3>",
			mode = { "n", "i" },
			"<Cmd>BufferLineGoToBuffer 3<CR>",
			desc = "go to buffer 3",
		},
		{
			"<A-4>",
			mode = { "n", "i" },
			"<Cmd>BufferLineGoToBuffer 4<CR>",
			desc = "go to buffer 4",
		},
		{
			"<A-5>",
			mode = { "n", "i" },
			"<Cmd>BufferLineGoToBuffer 5<CR>",
			desc = "go to buffer 5",
		},
	},
	config = function()
		-- local mocha = require("catppuccin.palettes").get_palette("mocha")
		-- local latte = require("catppuccin.palettes").get_palette("latte")
		local fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("PinkText")), "fg#")
		local bg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("NeoTreeNormal")), "bg#")
		require("bufferline").setup({
			highlights = {
				buffer_selected = { fg = fg, bg = bg, bold = true },
				separator = { fg = bg },
				indicator_selected = { fg = fg },
				indicator_visible = { fg = fg },
			},
			-- highlights = require("catppuccin.groups.integrations.bufferline").get({
			-- 	custom = {
			-- 		mocha = {
			-- 			buffer_selected = { fg = mocha.pink, bold = true },
			-- 			indicator_selected = { fg = mocha.pink },
			-- 			indicator_visible = { fg = mocha.pink },
			-- 		},
			-- 		latte = {
			-- 			buffer_selected = { fg = latte.pink, bold = true },
			-- 			indicator_selected = { fg = latte.pink },
			-- 			indicator_visible = { fg = latte.pink },
			-- 		},
			-- 	},
			-- }),
			options = {
				-- diagnostics = "nvim_lsp",
				diagnostics = nil,
				themable = true,
				always_show_bufferline = false,
				offsets = {
					{
						filetype = "neo-tree",
						text = "File Explore",
						highlight = "BufferLineOffset",
						text_align = "left",
					},
				},
				buffer_close_icon = "",
				separator_style = { "", "" },
				extensions = {
					"lazy",
					"neo-tree",
					"nvim-dap-ui",
					"overseer",
					"symbols-outline",
					"toggleterm",
					"trouble",
				},
			},
		})
	end,
}

return spec
