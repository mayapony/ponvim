return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()
		local wk = require('which-key')

		local keymaps = {
			{
				"<leader>hm",
				function()
					require("harpoon"):list():add()
				end,
				desc = "[H]arpoon [M]ark",
			},
			{
				"<leader>ho",
				function()
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
				desc = "[H]arpoon [O]pen quick menu",
			},
			{
				"<leader>hp",
				function()
					require("harpoon"):list():prev()
				end,
				desc = "[H]arpoon [P]revious",
			},
			{
				"<leader>hn",
				function()
					require("harpoon"):list():next()
				end,
				desc = "[H]arpoon [N]ext",
			},
		}

		local quick_select_keys = "123456789"
		for i = 1, #quick_select_keys do
			local key = quick_select_keys:sub(i, i)
			local keymap = {
				"<leader>" .. key,
				function()
					require("harpoon"):list():select(i)
				end,
				desc = "Harpoon: Select item " .. i,
				hidden = true
			}
			table.insert(keymaps, keymap)
		end

		wk.add(keymaps)
	end,
}
