local function get_harpoon_keymaps()
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
				require("harpoon").ui.toggle_quick_menu(require("harpoon"):list())
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

	local quick_select_keys = "asdfghjkl"
	for i = 1, #quick_select_keys do
		local key = quick_select_keys:sub(i, i)
		local keymap = {
			"<leader>h" .. key,
			function()
				require("harpoon"):list():select(i)
			end,
			desc = "Harpoon: Select item " .. i,
		}
		table.insert(keymaps, keymap)
	end

	return keymaps
end

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
	keys = get_harpoon_keymaps(),
}
