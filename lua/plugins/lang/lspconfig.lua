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
	opts = function()
		---@class PluginLspOpts
		local ret = {
			-- options for vim.diagnostic.config()
			---@type vim.diagnostic.Opts
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = {
					spacing = 4,
					source = "if_many",
					prefix = "●",
					-- this will set set the prefix to a function that returns the diagnostics icon based on the severity
					-- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
					-- prefix = "icons",
				},
				severity_sort = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
						[vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
						[vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
						[vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
					},
				},
			},
			-- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
			-- Be aware that you also will need to properly configure your LSP server to
			-- provide the inlay hints.
			inlay_hints = {
				enabled = true,
				exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
			},
			-- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
			-- Be aware that you also will need to properly configure your LSP server to
			-- provide the code lenses.
			codelens = {
				enabled = false,
			},
			-- add any global capabilities here
			capabilities = {
				workspace = {
					fileOperations = {
						didRename = true,
						willRename = true,
					},
				},
			},
			-- options for vim.lsp.buf.format
			-- `bufnr` and `filter` is handled by the LazyVim formatter,
			-- but can be also overridden when specified
			format = {
				formatting_options = nil,
				timeout_ms = nil,
			},
			-- LSP Server Settings
			---@type lspconfig.options
			servers = {
				lua_ls = {
					-- mason = false, -- set to false if you don't want this server to be installed with mason
					-- Use this to add any additional keymaps
					-- for specific lsp servers
					-- ---@type LazyKeysSpec[]
					-- keys = {},
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = false,
							},
							codeLens = {
								enable = true,
							},
							completion = {
								callSnippet = "Replace",
							},
							doc = {
								privateName = { "^_" },
							},
							hint = {
								enable = true,
								setType = false,
								paramType = true,
								paramName = "Disable",
								semicolon = "Disable",
								arrayIndex = "Disable",
							},
						},
					},
				},
			},
			-- you can do any additional lsp server setup here
			-- return true if you don't want this server to be setup with lspconfig
			---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
			setup = {
				-- example to setup with typescript.nvim
				-- tsserver = function(_, opts)
				--   require("typescript").setup({ server = opts })
				--   return true
				-- end,
				-- Specify * to use this function as a fallback for any server
				-- ["*"] = function(server, opts) end,
			},
		}
		return ret
	end,
	config = function(_, opts)
		local ensure_installed = {
			"lua_ls",
			"tailwindcss",
			"bashls",
			"cssls",
			-- "tsserver",
			-- "eslint_d"
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
				lspconfig[server].setup(lsp_opts.eslint)
			else
				lspconfig[server].setup({})
			end
		end

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
