local M = {}

M.lsp_attach_callback = function(bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end
	local builtin = require("telescope.builtin")
	nmap("<leader>cr", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
	nmap("gd", builtin.lsp_definitions, "[G]oto [D]efinition")
	nmap("gr", builtin.lsp_references, "[G]oto [R]eferences")
	nmap("gi", builtin.lsp_implementations, "[G]oto [I]mplementation")
	nmap("gtd", vim.lsp.buf.type_definition, "[G]oto [T]ype [D]efinition")
	nmap("go", builtin.lsp_document_symbols, "[G]oto D[o]cument Symb[o]ls")
	nmap("gx", builtin.diagnostics, "[G]oto Diagnostics")
	nmap("ge", vim.diagnostic.open_float, "[G]oto [E]rror")

	-- See `:help K` for why this keymap
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

	-- Lesser used LSP functionality
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")
end

M.eslint = {
	on_attach = function(_, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end,
}

return M
