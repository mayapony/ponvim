return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>.", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
			vim.keymap.set("n", "<leader>sl", "<cmd>Telescope persisted<cr>", {})

			telescope.load_extension("persisted")

			telescope.setup({
				extensions = {
					persisted = {
						layout_config = { width = 0.55, height = 0.55 },
					},
				},
			})
		end,
	},
	{
		"olimorris/persisted.nvim",
		config = function()
			require("persisted").setup({
				autosave = true,
				autoload = true,
				on_autoload_no_session = function()
					vim.notify("No existing session to load.")
				end,
			})
		end,
	},
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("alpha").setup(require("alpha.themes.startify").config)
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			vim.api.nvim_set_keymap(
				"n",
				"<leader>g",
				"<cmd>lua require('config.function').lazygit_toggle()<CR>",
				{ noremap = true, silent = true }
			)
		end,
	},
}
