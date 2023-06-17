local autocmd = vim.api.nvim_create_autocmd

local function augroup(name)
  return vim.api.nvim_create_augroup("maya_" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  command = "checktime",
})

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(args)
    local buffer = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local builtin = require("telescope.builtin")

    -- local formatAugroup = vim.api.nvim_create_augroup("LspFormatting", {})
    --
    -- if client.supports_method("textDocument/formatting") then
    --   vim.api.nvim_clear_autocmds({ group = formatAugroup, buffer = buffer })
    --   vim.api.nvim_create_autocmd("BufWritePre", {
    --     group = formatAugroup,
    --     buffer = buffer,
    --     callback = function()
    --       -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
    --       -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
    --       vim.lsp.buf.format({ async = false })
    --     end,
    --   })
    -- end

    vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = args.buf }
    vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = args.buf, desc = "definitions" })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", builtin.lsp_implementations, { buffer = args.buf, desc = "implementations" })
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, { buffer = args.buf, desc = "code action" })
    vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = args.buf, desc = "references" })
    vim.keymap.set("n", "go", builtin.lsp_document_symbols, { buffer = args.buf, desc = "document symbols" })
    vim.keymap.set("n", "gh", vim.diagnostic.open_float, { noremap = true, silent = true })
    vim.keymap.set("n", "gx", builtin.diagnostics, { buffer = 0, desc = "diagnostics" })
    vim.keymap.set(
      "n",
      "gw",
      builtin.lsp_workspace_symbols,
      { noremap = true, silent = true, desc = "workspace symbols" }
    )

    if client.name == "tsserver" then
			-- stylua: ignore
			vim.keymap.set("n", "<leader>co", "<cmd>TypescriptOrganizeImports<CR>",
				{ buffer = buffer, desc = "Organize Imports" })
      vim.keymap.set("n", "<leader>cR", "<cmd>TypescriptRenameFile<CR>", { desc = "Rename File", buffer = buffer })
      vim.keymap.set(
        "n",
        "<leader>ci",
        "<cmd>TypescriptAddMissingImports<CR>",
        { desc = "Import missing modules", buffer = buffer }
      )
      vim.keymap.set(
        "n",
        "<leader>cc",
        "<cmd>TypescriptRemoveUnused<CR>",
        { desc = "Clear unused variables", buffer = buffer }
      )
      vim.keymap.set(
        "n",
        "gd",
        "<cmd>TypescriptGoToSourceDefinition<CR>",
        { desc = "Go to typescript source definition", buffer = buffer }
      )
      vim.keymap.set(
        { "n", "x" },
        "<leader>ca",
        "<cmd>CodeActionMenu<CR>",
        { desc = "typescript code action menu", buffer = buffer }
      )
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "toggleterm",
    "telescope",
  },
  callback = function(argsent)
    vim.bo[argsent.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = argsent.buf, silent = true })
  end,
})

-- change kitty background color
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    local filePath = "/tmp/mykitty"
    if vim.fn.filereadable(filePath) == 1 then
      local color = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Normal")), "bg#")
      os.execute("kitty @ --to unix:" .. filePath .. " set-colors background=" .. color)
    end
  end,
})
