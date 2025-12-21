return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},
	keys = function()
		local builtin = require("telescope.builtin")
		return {
			{ "<leader>.",  builtin.find_files,         desc = "Find Files" },
			{ "<leader>/",  builtin.live_grep,          desc = "Find in global" },
			{ "<leader>fg", builtin.live_grep,          desc = "Find in global" },
			{ "<leader>,",  builtin.buffers,            desc = "Find buffers" },
			{ "<leader>fh", builtin.help_tags,          desc = "Find helps" },
			{ "<leader>fm", builtin.marks,              desc = "Find marks" },
			{ "<leader>fw", builtin.grep_string,        desc = "Find words" },
			{ "<leader>fr", builtin.oldfiles,           desc = "Find recent" },
			{ "<leader>fn", "<cmd>Noice pick<cr>",      desc = "[F]ilter [N]oice" },
			{ "<leader>uC", builtin.colorscheme,        desc = "Change Colorscheme " },
			{ "<leader>fd", [[<cmd>TodoTelescope<cr>]], desc = "Find todos" },

			-- lsp
			{ "<leader>ca", vim.lsp.buf.code_action,    desc = "code action" },
		}
	end,
	cmd = { "Telescope" },
	config = function()
		local telescope = require("telescope")

		telescope.setup({
			extensions = {
				fzf = {
					fuzzy = true,              -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "ignore_case", -- or "ignore_case" or "respect_case"
				},
			},
			defaults = {
				prompt_prefix = " ",
				selection_caret = " ",
				defaults = {
					layout_strategy = "horizontal",
					layout_config = { prompt_position = "top" },
					sorting_strategy = "ascending",
					winblend = 0,
				},
				mappings = {
					i = {
						["<c-t>"] = function(...)
							return require("trouble.providers.telescope").open_with_trouble(...)
						end,
						["<a-t>"] = function(...)
							return require("trouble.providers.telescope").open_selected_with_trouble(...)
						end,
					},
					n = {
						["q"] = function(...)
							return require("telescope.actions").close(...)
						end,
					},
				},
			},
		})

		telescope.load_extension("fzf")
	end,
}
