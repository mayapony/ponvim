local icons = require("config.icons")

return {
	"neovim/nvim-lspconfig",
	-- lazy load lspconfig
	-- source: https://www.reddit.com/r/neovim/comments/1308ie7/help_how_to_lazy_load_lspconfig/
	event = { "BufReadPre", "BufNewFile" },
	cmd = { "LspInfo", "LspInstall", "LspUninstall" },
	dependencies = {
		{ "williamboman/mason-lspconfig.nvim" },
		{
			"williamboman/mason.nvim",
			cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
		},
		{ "b0o/SchemaStore.nvim" },
	},
	config = function()
		local ensure_installed = {
			"lua_ls",
			"tailwindcss",
			"bashls",
			"cssls",
			-- "tsserver",
			-- "eslint_d"
			"ts_ls",
			"eslint"
		}

		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = ensure_installed,
			automatic_enable = {
				exclude = {
					"ts_ls"
				}
			}
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("maya-user-lsp-config", {}),
			callback = function(ev)
				require("config.lsp").lsp_attach_callback(ev.buf)
			end,
		})
	end,
	keys = {
		{
			"<leader>mm",
			"<cmd>Mason<cr>",
			desc = "Open Mason",
		},
	},
}
