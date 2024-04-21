return {
	"nvim-treesitter/nvim-treesitter",
	version = "*", -- last release is way too old and doesn't work on Windows
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"windwp/nvim-ts-autotag",
		{
			"nvim-treesitter/nvim-treesitter-context",
			envent = { "BufReadPost" },
			config = function()
				require("treesitter-context").setup()
			end,
		},
	},
	opts = {
		highlight = {
			enable = true,
			disable = function(lang, buf)
				local max_filesize = 100 * 1024 -- 100 KB
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end,
			additional_vim_regex_highlighting = false,
		},
		autotag = {
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
			"python",
			"tsx",
			"typescript",
			"vim",
			"yaml",
			"vue",
			"kotlin",
			"rust",
			"toml",
			"cpp",
		},
	},
}
