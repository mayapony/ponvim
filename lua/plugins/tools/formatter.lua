return {
	{ -- Formatting
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local conform = require("conform")

			-- 获取项目格式化状态的存储路径
			local function get_format_state_path()
				return vim.fn.stdpath("data") .. "/project_format_states.json"
			end

			-- 加载项目格式化状态
			local function load_format_states()
				local path = get_format_state_path()
				local file = io.open(path, "r")
				if file then
					local content = file:read("*all")
					file:close()
					local ok, states = pcall(vim.json.decode, content)
					if ok then
						return states
					end
				end
				return {}
			end

			-- 保存项目格式化状态
			local function save_format_states(states)
				local path = get_format_state_path()
				local file = io.open(path, "w")
				if file then
					file:write(vim.json.encode(states))
					file:close()
				end
			end

			-- 获取当前项目路径
			local function get_project_path()
				return vim.fn.getcwd()
			end

			-- 检查当前项目是否启用格式化
			local function is_format_enabled()
				local states = load_format_states()
				local project = get_project_path()
				-- 默认启用格式化
				return states[project] ~= false
			end

			-- 切换当前项目的格式化状态
			local function toggle_format()
				local states = load_format_states()
				local project = get_project_path()
				states[project] = not is_format_enabled()
				save_format_states(states)

				local status = states[project] and "enabled" or "disabled"
				vim.notify(string.format("Formatting %s for project: %s", status, project), vim.log.levels.INFO)
			end

			conform.setup({
				formatters_by_ft = {
					javascript = { "prettierd", "eslint_d" },
					typescript = { "prettierd", "eslint_d" },
					javascriptreact = { "prettierd", "eslint_d" },
					typescriptreact = { "prettierd", "eslint_d" },
					svelte = { "prettierd" },
					css = { "prettierd" },
					html = { "prettierd" },
					json = { "prettierd" },
					yaml = { "prettierd" },
					markdown = { "prettierd" },
					graphql = { "prettierd" },
					lua = { "stylua" },
					python = { "isort", "black" },
				},
				format_on_save = function(bufnr)
					-- 检查当前项目是否启用格式化
					if not is_format_enabled() then
						return
					end
					-- 返回格式化配置
					return {
						lsp_fallback = true,
						async = false,
						timeout_ms = 500,
					}
				end,
			})

			-- 设置快捷键
			vim.keymap.set("n", "<leader>tf", toggle_format, { desc = "[T]oggle [F]ormat" })
		end,
	},

	{ -- lint
		"mfussenegger/nvim-lint",
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescriptreact = { "eslint_d" },
				svelte = { "eslint_d" },
				python = { "pylint" },
			}

			-- Fix Eslint Error
			-- 1. Could not parse linter output due to: Expected value but found invalid token at character 1 output: Error: Could not find config file.
			-- https://github.com/mfussenegger/nvim-lint/issues/462
			lint.linters.eslint_d = require("lint.util").wrap(lint.linters.eslint_d, function(diagnostic)
				-- try to ignore "No ESLint configuration found" error
				if diagnostic.message:find("Error: Could not find config file") then
					return nil
				end
				return diagnostic
			end)

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})

			vim.keymap.set("n", "<leader>l", function()
				lint.try_lint()
			end, { desc = "Trigger linting for current file" })
		end,
	},
}
