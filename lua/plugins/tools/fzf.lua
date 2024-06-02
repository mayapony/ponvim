return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- calling `setup` is optional for customization
		local icons = require('config.icons')
		require("fzf-lua").setup({
			files = {
				prompt = 'Files❯ ',

			},

			fzf_colors = {
				["fg"] = { "fg", "CursorLine" },
				["bg"] = { "bg", "Normal" },
				["hl"] = { "fg", "Comment" },
				["fg+"] = { "fg", "Normal" },
				["bg+"] = { "bg", "CursorLine" },
				["hl+"] = { "fg", "Statement" },
				["info"] = { "fg", "PreProc" },
				["prompt"] = { "fg", "Conditional" },
				["pointer"] = { "fg", "Exception" },
				["marker"] = { "fg", "Keyword" },
				["spinner"] = { "fg", "Label" },
				["header"] = { "fg", "Comment" },
				["gutter"] = { "bg", "Normal" },
			},
			git = {
				icons = {
					["M"] = { icon = icons.git.changed, color = "yellow" },
					["D"] = { icon = icons.git.deleted, color = "red" },
					["A"] = { icon = icons.git.added, color = "green" },
					["R"] = { icon = "R", color = "yellow" },
					["C"] = { icon = "C", color = "yellow" },
					["T"] = { icon = "T", color = "magenta" },
					["?"] = { icon = icons.git.untracked, color = "magenta" },
				}
			}
		})
	end,
	keys = {
		{ "<leader>ff", "<cmd>lua require('fzf-lua').files({prompt = '👉'})<CR>", desc = "Find Files" },
		{ "<leader>ca", "<cmd>lua require('fzf-lua').lsp_code_actions()<CR>", desc = "Code Actions" },
		{ "<leader>.", "<cmd>lua require('fzf-lua').files()<CR>", desc = "Find Files" },
		{ "<leader>/", "<cmd>lua require('fzf-lua').live_grep()<cr>", desc = "Live Grep" },
	},
}
