--@module "lazy"
--@type LazySpec

return {
	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			opts = {
				-- Defaults
				enable_close = true,      -- Auto close tags
				enable_rename = true,     -- Auto rename pairs of tags
				enable_close_on_slash = true, -- Auto close on trailing </
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		branch = "main",
		config = function()
			require('nvim-treesitter.configs').setup({
				-- Core parsers installed at startup
				ensure_installed = {
					'bash',
					'comment',
					'css',
					'diff',
					'fish',
					'git_config',
					'git_rebase',
					'gitcommit',
					'gitignore',
					'html',
					'javascript',
					'json',
					'latex',
					'lua',
					'luadoc',
					'make',
					'markdown',
					'markdown_inline',
					'norg',
					'python',
					'query',
					'regex',
					'scss',
					'svelte',
					'toml',
					'tsx',
					'typescript',
					'typst',
					'vim',
					'vimdoc',
					'vue',
					'xml',
				},

				-- Auto-install missing parsers when entering a buffer
				auto_install = true,

				highlight = {
					enable = true,
					-- Skip highlighting for large files
					disable = function(lang, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
				},

				indent = { enable = true },
			})
		end,
	},
}
