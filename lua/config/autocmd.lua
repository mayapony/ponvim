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
