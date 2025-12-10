vim.g.lazyvim_blink_main = true

return {
	{
		"yetone/avante.nvim",
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		-- ⚠️ must add this setting! ! !
		enabled = false,
		build = function()
			-- conditionally use the correct build system for the current OS
			if vim.fn.has("win32") == 1 then
				return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
			else
				return "make"
			end
		end,
		event = "VeryLazy",
		version = false, -- Never set this value to "*"! Never!
		---@module 'avante'
		---@type avante.Config
		opts = {
			-- add any opts here
			-- for example
			provider = "mify",
			providers = {
				["mify"] = {
					__inherited_from = "openai",
					endpoint = "https://mify-be-idpt.pt.xiaomi.com/open/api/v1/",
					model = "claude-sonnet-4",
					api_key_name = "CLAUDE_API_KEY",
				},
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"echasnovski/mini.pick",      -- for file_selector provider mini.pick
			"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
			"ibhagwan/fzf-lua",           -- for file_selector provider fzf
			"stevearc/dressing.nvim",     -- for input provider dressing
			"folke/snacks.nvim",          -- for input provider snacks
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			{
				-- Make sure to set this up properly if you have lazy=true
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	},
	{
		"milanglacier/minuet-ai.nvim",
		lazy = false,
		config = function()
			require("minuet").setup({
				-- Your configuration options here
				virtualtext = {
					auto_trigger_ft = { "*" },
					keymap = {
						-- accept whole completion
						accept = "<A-G>",
						-- accept one line
						accept_line = "<A-g>",
						-- accept n lines (prompts for number)
						-- e.g. "A-z 2 CR" will accept 2 lines
						accept_n_lines = "<A-z>",
						-- Cycle to prev completion item, or manually invoke completion
						prev = "<A-[>",
						-- Cycle to next completion item, or manually invoke completion
						next = "<A-]>",
						dismiss = "<A-e>",
					},
				},

				-- model config
				-- provider = "openai_compatible",
				-- provider_options = {
				-- 	openai_compatible = {
				-- 		api_key = "QWEN_API_KEY",
				-- 		end_point = "https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions",
				-- 		model = "qwen2.5-coder-32b-instruct",
				-- 		stream = true,
				-- 	},
				-- },
				provider = 'openai_fim_compatible',
				n_completions = 1, -- recommend for local model for resource saving
				-- I recommend beginning with a small context window size and incrementally
				-- expanding it, depending on your local computing power. A context window
				-- of 512, serves as an good starting point to estimate your computing
				-- power. Once you have a reliable estimate of your local computing power,
				-- you should adjust the context window to a larger value.
				context_window = 512,
				provider_options = {
					openai_fim_compatible = {
						-- For Windows users, TERM may not be present in environment variables.
						-- Consider using APPDATA instead.
						api_key = 'TERM',
						name = 'Ollama',
						end_point = 'http://localhost:11434/v1/completions',
						model = 'qwen2.5-coder:7b',
						optional = {
							max_tokens = 56,
							top_p = 0.9,
						},
					},
				},
			})
		end,
	},
}
