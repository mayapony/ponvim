return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 10000,
		lazy = false,
		config = function()
			require("catppuccin").setup({
				background = {
					-- :h background
					light = "latte",
					dark = "mocha",
				},
				transparent_background = true, -- disables setting the background color.
				term_colors = true,         -- sets terminal colors (e.g. `g:terminal_color_0`)
				dim_inactive = {
					enabled = false,          -- dims the background color of inactive window
					shade = "dark",
					percentage = 0.15,        -- percentage of the shade to apply to the inactive window
				},
				no_italic = false,          -- Force no italic
				no_bold = false,            -- Force no bold
				no_underline = false,       -- Force no underlinethem
				styles = {
					-- Handles the styles of general hi groups (see `:h highlight-args`):
					comments = { "italic" }, -- Change the style of comments
					conditionals = { "italic" },
					keywords = { "bold" },
					operators = { "bold" },
				},
				show_end_of_buffer = true,
				custom_highlights = function(colors)
					return {
						-- bufferline
						BufferlineOffset = {
							-- bg = colors.mantle,
							fg = colors.pink,
							bold = true,
						},
						-- indent-blankline
						IndentlineStyle = { fg = colors.pink },
						-- alpha
						AlphaHeader = { fg = colors.pink },
						AlphaButtons = { fg = colors.pink },
						AlphaShortcut = { fg = colors.pink },
						PinkText = { fg = colors.pink },

						-- global
						Directory = { fg = colors.pink },

						-- winbar
						WinBar = { fg = colors.pink, bg = colors.crust, bold = true },
						StatusLine = { bg = colors.crust },

						-- float windows (oil, LSP hover...)
						NormalFloat = { bg = colors.mantle },
						FloatBorder = { fg = colors.surface1, bg = colors.mantle },
					}
				end,

				integrations = {
					cmp = true,
					gitsigns = true,
					telescope = true,
					notify = true,
					alpha = true,
					which_key = true,
					treesitter = true,
					mini = true,
					-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
				},
			})

			-- setup must be called before loading
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
