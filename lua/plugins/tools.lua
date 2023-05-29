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
	{
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({
				keys = "etovxqpdygfblzhckisuran",
				quit_key = "<SPC>",
				case_insensitive = true,
				multi_windows = true,
			})

			local hop = require("hop")
			local directions = require("hop.hint").HintDirection
			vim.keymap.set("", "f", function()
				hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
			end, { remap = true })
			vim.keymap.set("", "F", function()
				hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
			end, { remap = true })
			vim.keymap.set("", "t", function()
				hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
			end, { remap = true })
			vim.keymap.set("", "T", function()
				hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
			end, { remap = true })
			vim.keymap.set("", "s", "<cmd>HopChar2<cr>", { remap = true })
			vim.keymap.set("n", "<leader><leader>j", "<cmd>HopLine<cr>", {})
		end,
	},
}
