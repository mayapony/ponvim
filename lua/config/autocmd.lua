local autocmd = vim.api.nvim_create_autocmd

local function augroup(name)
  return vim.api.nvim_create_augroup("maya_" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  command = "checktime",
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
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
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
    "neo-tree",
    "oil",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- change kitty background color
-- vim.api.nvim_create_autocmd("ColorScheme", {
--   callback = function()
--     local filePath = "/tmp/mykitty"
--     if vim.fn.filereadable(filePath) == 1 then
--       local color = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Normal")), "bg#")
--       os.execute("kitty @ --to unix:" .. filePath .. " set-colors background=" .. color)
--     end
--   end,
-- })

-- check if a floating dialog exists and if not
-- then check for diagnostics under the cursor
vim.api.nvim_create_autocmd({ "CursorHold" }, {
  group = augroup("lsp_diagnostics_hold"),
  pattern = "*",
  command = "lua require('config.function').open_diagnostic_if_not_float()",
})

-- Persistent Folds
autocmd("BufWinLeave", {
  pattern = "*.*",
  callback = function()
    vim.cmd.mkview()
  end,
  group = augroup("Persistent Folds"),
})
autocmd("BufWinEnter", {
  pattern = "*.*",
  callback = function()
    vim.cmd.loadview({ mods = { emsg_silent = true } })
  end,
  group = augroup("Persistent Folds"),
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
autocmd({ "BufWritePre" }, {
  group = augroup("Auto Create Dir"),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Format with lsp
-- Create an augroup that is used for managing our formatting autocmds.
--      We need one augroup per client to make sure that multiple clients
--      can attach to the same buffer without interfering with each other.
-- local _augroups = {}
-- local get_augroup = function(client)
--   if not _augroups[client.id] then
--     local group_name = "maya-lsp-format-" .. client.name
--     local id = vim.api.nvim_create_augroup(group_name, { clear = true })
--     _augroups[client.id] = id
--   end
--
--   return _augroups[client.id]
-- end

-- Whenever an LSP attaches to a buffer, we will run this function.
--
-- See `:help LspAttach` for more information about this autocmd event.
-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = vim.api.nvim_create_augroup("maya-lsp-attach-format", { clear = true }),
--   -- This is where we attach the autoformatting for reasonable clients
--   callback = function(args)
--     local client_id = args.data.client_id
--     local client = vim.lsp.get_client_by_id(client_id)
--     local bufnr = args.buf
--
--     -- Only attach to clients that support document formatting
--     if not client.server_capabilities.documentFormattingProvider then
--       return
--     end
--
--     vim.keymap.set({ "n", "x" }, "<Leader>F", function()
--       vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
--     end, { buffer = bufnr, desc = "[lsp] format" })
--
--     -- Create an autocmd that will run *before* we save the buffer.
--     --  Run the formatting command for the LSP that has just attached.
--     vim.api.nvim_create_autocmd("BufWritePre", {
--       group = get_augroup(client),
--       buffer = bufnr,
--       callback = function()
--         vim.lsp.buf.format({
--           async = false,
--           filter = function(c)
--             -- if is tsserver then use null-ls to format
--             if client.name == "tsserver" then
--               return c.name == "null-ls"
--             end
--             return c.id == client.id
--           end,
--         })
--       end,
--     })
--   end,
-- })
