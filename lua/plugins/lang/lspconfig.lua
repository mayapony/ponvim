return {
	"neovim/nvim-lspconfig",
	-- lazy load lspconfig
	-- source: https://www.reddit.com/r/neovim/comments/1308ie7/help_how_to_lazy_load_lspconfig/
	event = { "BufReadPre", "BufNewFile" },
	cmd = { "LspInfo", "LspInstall", "LspUninstall" },
	dependencies = {
		{ "hrsh7th/cmp-nvim-lsp" },
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
			"tsserver",
			"eslint"
		}

		require("mason").setup()
		require("mason-lspconfig").setup({
			-- server name source: https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
			ensure_installed = ensure_installed,
			automatic_installation = true,
		})

		local lspconfig = require("lspconfig")
		local lsp_opts = require("config.lsp")

		for _, server in pairs(ensure_installed) do
			if server == "eslint" then
				lspconfig.eslint.setup(lsp_opts.eslint)
			else
				lspconfig[server].setup({})
			end
		end

		-- Use LspAttach autocommand to only map the following keys
		-- after the language server attaches to the current buffer
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("maya-user-lsp-config", {}),
			callback = function(ev)
				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

				local opts = { buffer = ev.buf }
				vim.keymap.set("n", "gk", vim.lsp.buf.signature_help, opts)
				vim.keymap.set("n", "gh", vim.diagnostic.open_float, { noremap = true, silent = true, desc = "show diagnostics" })
				vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = ev.buf, desc = "rename" })
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
