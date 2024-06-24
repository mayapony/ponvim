return {
	{
		"pmizio/typescript-tools.nvim",
		ft = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact" },
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		config = function()
			local api = require("typescript-tools.api")
			require("typescript-tools").setup({
				{
					on_attach = function()
						vim.keymap.set("n", "<leader>co", "<cmd>TSToolsOrganizeImports<cr>", { desc = "Organize Imports" })
						vim.keymap.set("n", "<leader>ci", "<cmd>TSToolsAddMissingImports<cr>", { desc = "Add Missing Imports" })
						vim.keymap.set({ "i", "v", "n", "s" }, "<C-s>", function()
							vim.cmd([[w]])
						end, { desc = "Save file" })
						vim.keymap.set({ "n" }, "<leader>fs", function()
							vim.cmd([[w]])
						end, { desc = "Save file" })
					end,
					handlers = {
						["textDocument/publishDiagnostics"] = api.filter_diagnostics(
							{ 7044 }
						),
					}
				}
			})
		end,
	},
	{
		"dmmulroy/tsc.nvim",
		ft = { "typescript", "typescriptreact", "javascript", "javascriptreact", "typescript.tsx" },
		cmd = "TSC",
		opts = {},
		config = function()
			require("tsc").setup({})
			vim.keymap.set("n", "<leader>cc", "<cmd>TSC<cr>", { desc = "Typescript Check" })
		end,
	},
}
