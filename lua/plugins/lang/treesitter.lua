--@module "lazy"
--@type LazySpec

return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		branch = "main",
		config = function()
			local treesitter = require("nvim-treesitter")
			local languages = {
				"bash", "css", "git_config", "git_rebase",
				"gitcommit", "gitignore", "html", "javascript", "json", "latex", "lua",
				"luadoc", "markdown", "markdown_inline", "python", "query",
				"regex", "scss", "svelte", "toml", "tsx", "typescript", "typst", "vim",
				"vimdoc", "vue", "xml",
			}

			treesitter.setup()
			treesitter.install(languages)

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("maya_treesitter", { clear = true }),
				pattern = languages,
				callback = function(args)
					local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
					if ok and stats and stats.size > 100 * 1024 then
						return
					end

					local lang = vim.treesitter.language.get_lang(args.match)
					if lang and vim.treesitter.query.get(lang, "highlights") then
						pcall(vim.treesitter.start, args.buf, lang)
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},
}
