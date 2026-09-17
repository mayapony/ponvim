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
				"gitcommit", "gitignore", "html", "javascript", "json", "lua",
				"luadoc", "markdown", "markdown_inline", "python", "query",
				"scss", "toml", "tsx", "typescript", "vim", "vimdoc", "vue", "xml",
			}

			treesitter.setup()
			treesitter.install(languages)

			-- FileType 钩子：按文件类型映射到 language，缺 parser 则异步安装，装好后启用高亮 + 缩进
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("maya_treesitter", { clear = true }),
				pattern = "*",
				callback = function(args)
					local buf = args.buf
					local lang = vim.treesitter.language.get_lang(args.match)
					if not lang or not vim.tbl_contains(treesitter.get_available(), lang) then
						return
					end

					-- 缺 parser：后台安装（install 也会链上 queries），完成后补上高亮/缩进
					if not vim.tbl_contains(treesitter.get_installed("parsers"), lang) then
						treesitter.install({ lang }):await(function(err)
							if err then
								vim.notify(("treesitter 安装 %s 失败: %s"):format(lang, err), vim.log.levels.WARN)
								return
							end
							if vim.api.nvim_buf_is_valid(buf) then
								pcall(vim.treesitter.start, buf, lang)
								vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
							end
						end)
						return
					end

					local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > 100 * 1024 then
						return
					end

					if vim.treesitter.query.get(lang, "highlights") then
						pcall(vim.treesitter.start, buf, lang)
						vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},
}
