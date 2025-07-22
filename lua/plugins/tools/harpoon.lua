return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		-- REQUIRED
		harpoon:setup()
		-- REQUIRED

		vim.keymap.set("n", "<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)
	end,
	keys = {
		{
			"mm",
			function()
				require("harpoon"):list():add()
			end,
			desc = "Add file to list",
		},
		{
			"<C-e>",
			function()
				require("harpoon").ui.toggle_quick_menu(require("harpoon"):list())
			end,
			desc = "Open quick menu",
		},
		{
			"m1",
			function()
				require("harpoon"):list():select(1)
			end,
			desc = "Select 1st item",
		},
		{
			"m2",
			function()
				require("harpoon"):list():select(2)
			end,
			desc = "Select 2nd item",
		},
		{
			"m3",
			function()
				require("harpoon"):list():select(3)
			end,
			desc = "Select 3rd item",
		},
		{
			"m4",
			function()
				require("harpoon"):list():select(4)
			end,
			desc = "Select 4th item",
		},
		{
			"[m",
			function()
				require("harpoon"):list():prev()
			end,
			desc = "Previous item",
		},
		{
			"]m",
			function()
				require("harpoon"):list():next()
			end,
			desc = "Next item",
		},
	},
}
