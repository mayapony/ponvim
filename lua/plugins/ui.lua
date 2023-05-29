return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			require("catppuccin").setup({
				flavour = "frappe", -- latte, frappe, macchiato, mocha
				background = {
					-- :h background
					light = "latte",
					dark = "frappe",
				},
				transparent_background = false,
				show_end_of_buffer = false, -- show the '~' characters after the end of buffers
				term_colors = false,
				dim_inactive = {
					enabled = false,
					shade = "dark",
					percentage = 0.15,
				},
				no_italic = true, -- Force no italic
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
				},
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					telescope = true,
					notify = true,
					-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
				},
			})

			vim.cmd("colorscheme catppuccin")
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-tree/nvim-web-devicons",
			},
			"MunifTanjim/nui.nvim",
		},
		keys = {
			{
				"<leader>e",
				function()
					require("neo-tree.command").execute({ toggle = true })
				end,
				desc = "Explorer NeoTree",
			},
		},
		opts = {
			enable_diagnostics = false,
			window = {
				width = 25,
			},
			buffers = {
				follow_current_file = true, -- This will find and focus the file in the active buffer every
			},
			default_component_configs = {
				indent_size = 2,
				padding = 1, -- extra padding on left hand side
				-- indent guides
				with_markers = true,
				indent_marker = "│",
				last_indent_marker = "└",
				highlight = "NeoTreeIndentMarker",
				-- expander config, needed for nesting files
				with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
				expander_collapsed = "",
				expander_expanded = "",
				expander_highlight = "NeoTreeExpander",
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = function()
			local function fg(name)
				return function()
					---@type {foreground?:number}?
					local hl = vim.api.nvim_get_hl_by_name(name, true)
					return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
				end
			end

			return {
				options = {
					theme = "auto",
					globalstatus = true,
					disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha", "neo-tree" } },
					component_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },
					lualine_c = {
						{
							"diagnostics",
						},
						{
							"filetype",
							icon_only = true,
							separator = "",
							padding = {
								left = 1,
								right = 0,
							},
						},
						-- stylua: ignore
						{
							"filename",
							path = 1,
							symbols = {
								modified = "*",
								readonly = "",
								unnamed = ""
							}
						},
					},
					lualine_x = {
						{
							"diff",
						},
					},
					lualine_y = {
						{ "progress", separator = " ",                  padding = { left = 1, right = 0 } },
						{ "location", padding = { left = 0, right = 1 } },
					},
					lualine_z = {
						function()
							return " " .. os.date("%R")
						end,
					},
				},
				extensions = { "toggleterm" },
			}
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("indent_blankline").setup({
				char = "│",
				filetype_exclude = { "help", "alpha", "dashboard", "Trouble", "lazy", "mason" },
				show_trailing_blankline_indent = true,
				show_current_context = true,
				show_end_of_line = true,
			})
		end,
	},
	{
		"echasnovski/mini.indentscope",
		version = false, -- wait till new 0.7.0 release to put it back on semver
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			-- symbol = "▏",
			symbol = "│",
			options = { try_as_border = true },
		},
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "help", "alpha", "dashboard", "Trouble", "lazy", "mason" },
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},
	{
		"rcarriga/nvim-notify",
		keys = {
			{
				"<leader>un",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Dismiss all Notifications",
			},
		},
		opts = {
			timeout = 3000,
			render = "minimal",

			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.35)
			end,
		},
		init = function()
			vim.notify = require("notify")
		end,
	},
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle pin" },
			{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
			{ "<leader>ft", "<Cmd>BufferLinePick<CR>",                 desc = "Find Buffer" },
			{ "<A-1>",      "<Cmd>BufferLineGoToBuffer 1<CR>",         desc = "go to buffer 1" },
			{ "<A-2>",      "<Cmd>BufferLineGoToBuffer 2<CR>",         desc = "go to buffer 2" },
			{ "<A-3>",      "<Cmd>BufferLineGoToBuffer 3<CR>",         desc = "go to buffer 3" },
			{ "<A-4>",      "<Cmd>BufferLineGoToBuffer 4<CR>",         desc = "go to buffer 4" },
			{ "<A-5>",      "<Cmd>BufferLineGoToBuffer 5<CR>",         desc = "go to buffer 5" },
		},
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				themable = true,
				always_show_bufferline = false,
				offsets = {
					{
						filetype = "neo-tree",
						text = "File Explore",
						highlight = "Directory",
						text_align = "left",
					},
				},
				buffer_close_icon = "",
				separator_style = { "", "" },
				extensions = { "lazy", "neo-tree", "nvim-dap-ui", "overseer", "symbols-outline", "toggleterm", "trouble" },
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		version = false, -- last release is way too old and doesn't work on Windows
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		keys = {
			{ "<c-space>", desc = "Increment selection" },
			{ "<bs>",      desc = "Decrement selection", mode = "x" },
		},
		opts = {
			highlight = {
				enable = true,
			},
			indent = { enable = true, disable = { "python" } },
			context_commentstring = { enable = true, enable_autocmd = false },
			ensure_installed = {
				"bash",
				"c",
				"html",
				"javascript",
				"json",
				"lua",
				"luap",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"tsx",
				"typescript",
				"vim",
				"yaml",
				"vue",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = "<nop>",
					node_decremental = "<bs>",
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
