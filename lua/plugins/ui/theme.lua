return {
	-- {
	--   "vimpostor/vim-lumen",
	--   event = "VeryLazy",
	--   init = function()
	--     vim.cmd([[
	-- 		au User LumenLight set background=light | colorscheme everforest
	-- 		au User LumenDark set background=dark | colorscheme everforest
	-- 	]])
	--   end,
	-- },
	-- {
	--   "neanias/everforest-nvim",
	--   version = false,
	--   lazy = false,
	--   priority = 10000, -- make sure to load this before all the other start plugins
	--   -- Optional; default configuration will be used if setup isn't called.
	--   config = function()
	--     require("everforest").setup({
	--       background = "medium", -- Your config here
	--       on_highlights = function(hl, palette)
	--         hl.BufferlineOffset = { bg = palette.bg0 }
	--         hl.NeoTreeNormal = { bg = palette.bg0 }
	--         hl.NeoTreeNormalNC = { bg = palette.bg0 }
	--       end,
	--     })
	--   end,
	-- },
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	priority = 10000,
	-- 	lazy = false,
	-- 	config = function()
	-- 		require("catppuccin").setup({
	-- 			background = {
	-- 				-- :h background
	-- 				light = "latte",
	-- 				dark = "mocha",
	-- 			},
	-- 			transparent_background = false, -- disables setting the background color.
	-- 			term_colors = true,         -- sets terminal colors (e.g. `g:terminal_color_0`)
	-- 			dim_inactive = {
	-- 				enabled = false,          -- dims the background color of inactive window
	-- 				shade = "dark",
	-- 				percentage = 0.15,        -- percentage of the shade to apply to the inactive window
	-- 			},
	-- 			no_italic = false,          -- Force no italic
	-- 			no_bold = false,            -- Force no bold
	-- 			no_underline = true,        -- Force no underlinethem
	-- 			styles = {
	-- 				-- Handles the styles of general hi groups (see `:h highlight-args`):
	-- 				comments = { "italic" }, -- Change the style of comments
	-- 				conditionals = { "italic" },
	-- 				keywords = { "bold" },
	-- 				operators = { "bold" },
	-- 			},
	-- 			show_end_of_buffer = true,
	-- 			custom_highlights = function(colors)
	-- 				return {
	-- 					BufferlineOffset = {
	-- 						-- bg = colors.mantle,
	-- 						fg = colors.pink,
	-- 						bold = true,
	-- 					},
	-- 					NeoTreeNormal = { bg = colors.base },
	-- 					NeoTreeNormalNC = { bg = colors.base },
	-- 					IndentlineStyle = { fg = colors.pink },
	-- 					NeoTreeDirectoryName = { fg = colors.pink },
	-- 					NeoTreeDirectoryIcon = { fg = colors.pink },
	-- 					NeoTreeTitleBar = { fg = colors.pink },
	-- 					NeoTreeRootName = { fg = colors.pink },
	-- 					AlphaHeader = { fg = colors.pink },
	-- 					AlphaButtons = { fg = colors.pink },
	-- 					AlphaShortcut = { fg = colors.pink },
	-- 					PinkText = { fg = colors.pink },
	-- 				}
	-- 			end,
	--
	-- 			integrations = {
	-- 				cmp = true,
	-- 				gitsigns = true,
	-- 				telescope = true,
	-- 				notify = true,
	-- 				alpha = true,
	-- 				neotree = true,
	-- 				which_key = true,
	-- 				treesitter = true,
	-- 				mini = true,
	-- 				-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
	-- 			},
	-- 		})
	--
	-- 		-- setup must be called before loading
	-- 		vim.cmd.colorscheme("catppuccin")
	-- 	end,
	-- },
	-- {
	--   "ellisonleao/gruvbox.nvim",
	--   priority = 10000,
	--   lazy = false,
	--   config = function()
	--     vim.cmd.colorscheme("gruvbox")
	--   end,
	-- },
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 10000,
		lazy = false,
		config = function()
			local fg = "rose"
			require("rose-pine").setup({
				variant = "auto",
				dark_variant = "moon",
				dim_inactive_windows = true,
				enable = {
					terminal = true,
					legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
					migrations = true,   -- Handle deprecated options automaticall
				},
				styles = {
					bold = true,
					italic = false,
					transparency = false,
				},
				highlight_groups = {
					BufferlineOffset = {
						fg = fg,
						bold = true,
					},
					NeoTreeNormal = { bg = "base" },
					NeoTreeNormalNC = { bg = "base" },
					IndentlineStyle = { fg = fg },
					NeoTreeDirectoryName = { fg = fg },
					NeoTreeDirectoryIcon = { fg = fg },
					NeoTreeTitleBar = { fg = fg },
					NeoTreeRootName = { fg = fg },
					AlphaHeader = { fg = fg },
					AlphaButtons = { fg = fg },
					AlphaShortcut = { fg = fg },
					PinkText = { fg = fg },
					StatusLine = { fg = "rose", bg = "surface" },
					StatusLineNC = { fg = "subtle", bg = "surface" },
				},
			})
			vim.cmd.colorscheme("rose-pine")
		end,
	},
}
