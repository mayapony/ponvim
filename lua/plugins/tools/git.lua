-- Git 相关的插件
return {
	{
		"NeogitOrg/neogit",
		cmd = { "Neogit" },
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed, not both.
			"nvim-telescope/telescope.nvim", -- optional
		},
		config = function()
			require("neogit").setup({
				integrations = {
					diffview = true,
				},
			})
		end,
		keys = {
			{
				"<leader>gg",
				"<cmd>Neogit<cr>",
				desc = "Open Neogit",
			},
			{
				"<leader>gdh",
				"<cmd>DiffviewFileHistory<cr>",
				desc = "[G]it [D]iff File [H]istory",
			},
			{
				"<leader>gdc",
				"<cmd>DiffviewClose<cr>",
				desc = "[G]it [D]iff [C]lose",
			},
			{
				"<leader>gdo",
				"<cmd>DiffviewOpen<cr>",
				desc = "[G]it [D]iff [O]pen",
			},
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		tag = "release", -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
		event = { "BufReadPre", "BufWritePre" },
		config = function()
			require("gitsigns").setup({
				current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
					delay = 1000,
					ignore_whitespace = false,
				},
				signcolumn = true,
				numhl = false,
				current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
				signs = {
					add = { text = "┃" },
					change = { text = "┃" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				update_debounce = 100,
				max_file_length = 40000,
				on_attach = function(bufnr)
					local function map(mode, lhs, rhs, opts)
						opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
						vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
					end

					-- Navigation
					map("n", "]c", "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
					map("n", "[c", "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

					-- Text object
					map("o", "ih", ":<C-U>Gitsigns select_hunk<CR>")
					map("x", "ih", ":<C-U>Gitsigns select_hunk<CR>")
				end,
			})
		end,
	},
	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>tg", "<cmd>LazyGit<cr>", desc = "[T]oggle Lazy[G]it" },
		},
	},
}
