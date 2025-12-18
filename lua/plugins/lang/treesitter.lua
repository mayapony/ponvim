--@module "lazy"
--@type LazySpec

local function is_file_too_large(buf, max_size_kb)
	local filename = vim.api.nvim_buf_get_name(buf)
	if not filename or filename == '' then
		return false
	end

	local ok, stats = pcall(vim.loop.fs_stat, filename)
	if ok and stats and stats.size > (max_size_kb * 1024) then
		return true
	end
	return false
end

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
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
		},
		config = function()
			local ts = require('nvim-treesitter')

			-- Install core parsers at startup
			ts.install({
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
			})

			local group = vim.api.nvim_create_augroup('TreesitterSetup', { clear = true })

			local ignore_filetypes = {
				'checkhealth',
				'lazy',
				'mason',
				'snacks_dashboard',
				'snacks_notif',
				'snacks_win',
			}

			-- Auto-install parsers and enable highlighting on FileType
			vim.api.nvim_create_autocmd('FileType', {
				group = group,
				desc = 'Enable treesitter highlighting and indentation',
				callback = function(event)
					if vim.tbl_contains(ignore_filetypes, event.match) then
						return
					end

					local lang = vim.treesitter.language.get_lang(event.match) or event.match
					local buf = event.buf

					-- Start highlighting immediately (works if parser exists)
					if is_file_too_large(buf, 100) then
						require("notify")("File too large to highlight", vim.log.levels.WARN)
					else
						pcall(vim.treesitter.start, buf, lang)
					end

					-- Enable treesitter indentation
					vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

					-- Install missing parsers (async, no-op if already installed)
					ts.install({ lang })
				end,
			})
		end,
	},
}
