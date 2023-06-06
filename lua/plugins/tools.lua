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
			vim.keymap.set("n", "<leader>fp", telescope.extensions.projects.projects, {})
			vim.keymap.set("n", "<leader>sl", "<cmd>Telescope persisted<cr>", {})
			vim.keymap.set("n", "<leader>uC", builtin.colorscheme, { desc = "change colorscheme" })

			telescope.load_extension("persisted")
			telescope.load_extension("projects")

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
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<c-\>]],
			})
		end,
		keys = {
			{
				"<leader>g",
				"<cmd>lua require('config.function').lazygit_toggle()<CR>",
				desc = "Toggle lazygit",
			},
			{ "<leader>ut", "<cmd>ToggleTerm<CR>", desc = "Toggle Term" },
		},
	},
	{
		"ojroques/nvim-bufdel",
		keys = {
			{ "<leader>qq", "<cmd>BufDel<cr>",       desc = "Delete Buffer" },
			{ "<leader>qo", "<cmd>BufDelOthers<cr>", desc = "Delete other buffer" },
			{ "<leader>qa", ":wqa<cr>",              desc = "Delete Buffer all" },
		},
		config = function()
			require("bufdel").setup({
				next = "tabs",
				quit = false, -- quit Neovim when last buffer is closed
			})
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		event = "BufEnter",
		config = function()
			require("colorizer").setup({
				filetypes = { "*" },
				user_default_options = {
					RGB = true,          -- #RGB hex codes
					RRGGBB = true,       -- #RRGGBB hex codes
					names = true,        -- "Name" codes like Blue or blue
					RRGGBBAA = true,     -- #RRGGBBAA hex codes
					AARRGGBB = true,     -- 0xAARRGGBB hex codes
					rgb_fn = true,       -- CSS rgb() and rgba() functions
					hsl_fn = true,       -- CSS hsl() and hsla() functions
					css = true,          -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
					css_fn = false,      -- Enable all CSS *functions*: rgb_fn, hsl_fn
					-- Available modes for `mode`: foreground, background,  virtualtext
					mode = "background", -- Set the display mode.
					-- Available methods are false / true / "normal" / "lsp" / "both"
					-- True is same as normal
					tailwind = true,                                -- Enable tailwind colors
					-- parsers can contain values used in |user_default_options|
					sass = { enable = false, parsers = { "css" } }, -- Enable sass colors
					virtualtext = "■",
					-- update color values even if buffer is not focused
					-- example use: cmp_menu, cmp_docs
					always_update = false,
				},
				-- all the sub-options of filetypes apply to buftypes
				buftypes = {},
			})
		end,
	},
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({
				patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".luarc.json" },
			})
		end,
	},
	{
		"ggandor/flit.nvim",
		opts = {
			multiline = false,
		},
	},
	{
		"ggandor/leap.nvim",
	},
}
