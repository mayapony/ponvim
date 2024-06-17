return {
	"nvim-lualine/lualine.nvim",
	-- event = "VeryLazy",
	event = "VimEnter",
	dependencies = {
		"chrisgrieser/nvim-recorder",
		evnent = "BufReadPost",
		dependencies = "rcarriga/nvim-notify", -- optional
		opts = {},
	},
	opts = function(plugin)
		if plugin.override then
			require("lazyvim.util").deprecate("lualine.override", "lualine.opts")
		end

		local icons = require("config.icons")

		local diagnostics = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			sections = { "error", "warn", "info", "hint" },
			symbols = {
				error = icons.diagnostics.Error,
				hint = icons.diagnostics.Hint,
				info = icons.diagnostics.Info,
				warn = icons.diagnostics.Warn,
			},
			colored = true,
			update_in_insert = false,
			always_visible = false,
		}

		local diff = {
			"diff",
			symbols = {
				added = icons.git.added .. " ",
				untracked = icons.git.added .. " ",
				modified = icons.git.changed .. " ",
				removed = icons.git.deleted .. " ",
			},
			colored = true,
			always_visible = false,
		}

		return {
			options = {
				theme = "auto",
				globalstatus = true,
				component_separators = { left = "", right = "" },
				section_separators = { left = '', right = '' },
				disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha", "neo-tree", "Trouble", "term" } },
			},
			extensions = { "toggleterm" },
			sections = {
				lualine_a = {
					"mode",
				},
				lualine_b = {},
				lualine_c = { diagnostics, require("recorder").recordingStatus },
				lualine_x = {
					diff
				},
				lualine_y = { "filetype" },
				lualine_z = { { "location", separator = " ", padding = { left = 0, right = 0 } }, {
					"progress",
					separator = " ",
					padding = { left = 0, right = 1 },
				} },
			},
		}
	end,
}
