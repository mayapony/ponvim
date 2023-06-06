return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				disable_italics = true,
				disable_float_background = true,
				variant = "auto",
				--- @usage 'main'|'moon'|'dawn'
				dark_variant = "main",
			})

			vim.api.nvim_command("colorscheme rose-pine")
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
			sources = { "filesystem", "buffers", "git_status", "document_symbols" },
			filesystem = {
				bind_to_cwd = true,
				follow_current_file = true,
				use_libuv_file_watcher = true,
			},
			enable_diagnostics = false,
			window = {
				width = 25,
				mappings = {
					["<space>"] = "none",
				},
			},
			default_component_configs = {
				indent = {
					with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
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
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		opts = function()
			local dashboard = require("alpha.themes.dashboard")
			local logo = [[
			███╗░░░███╗░█████╗░██╗░░░██╗░█████╗░██████╗░░█████╗░███╗░░██╗██╗░░░██╗
			████╗░████║██╔══██╗╚██╗░██╔╝██╔══██╗██╔══██╗██╔══██╗████╗░██║╚██╗░██╔╝
			██╔████╔██║███████║░╚████╔╝░███████║██████╔╝██║░░██║██╔██╗██║░╚████╔╝░
			██║╚██╔╝██║██╔══██║░░╚██╔╝░░██╔══██║██╔═══╝░██║░░██║██║╚████║░░╚██╔╝░░
			██║░╚═╝░██║██║░░██║░░░██║░░░██║░░██║██║░░░░░╚█████╔╝██║░╚███║░░░██║░░░
			╚═╝░░░░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░░░░░╚════╝░╚═╝░░╚══╝░░░╚═╝░░░
			]]

			dashboard.section.header.val = vim.split(logo, "\n")
			dashboard.section.buttons.val = {
				dashboard.button("f", "   " .. " Find file", ":Telescope find_files <CR>"),
				dashboard.button("r", "   " .. " Recent files", ":Telescope oldfiles <CR>"),
				dashboard.button("g", "   " .. " Find text", ":Telescope live_grep <CR>"),
				dashboard.button("c", "   " .. " Config", ":e $MYVIMRC <CR>"),
				dashboard.button("q", "   " .. " Quit", ":qa<CR>"),
			}
			for _, button in ipairs(dashboard.section.buttons.val) do
				button.opts.hl = "AlphaButtons"
				button.opts.hl_shortcut = "AlphaShortcut"
			end
			dashboard.section.header.opts.hl = "AlphaHeader"
			dashboard.section.buttons.opts.hl = "AlphaButtons"
			dashboard.section.footer.opts.hl = "AlphaFooter"
			dashboard.opts.layout[1].val = 8
			return dashboard
		end,
		config = function(_, dashboard)
			-- close Lazy and re-open when the dashboard is ready
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					pattern = "AlphaReady",
					callback = function()
						require("lazy").show()
					end,
				})
			end

			require("alpha").setup(dashboard.opts)

			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyVimStarted",
				callback = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
					pcall(vim.cmd.AlphaRedraw)
				end,
			})
		end,
	},
}
