local M = {}
local function map(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end
local default_opts = { noremap = true, silent = true }

-- Save file
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
map({ "v", "n" }, "<leader>fs", "<cmd>wa<cr><esc>", { desc = "Save file" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")
map("i", "=", "=<c-g>u")

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other window" })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })
map("n", "<leader>ws", "<C-W>v", { desc = "Split window right" })
map("n", "<leader>wv", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>wo", "<C-W>o", { desc = "Close other window" })

function M.initNvim()
  -- lazy
  vim.keymap.set("n", "<leader>ml", "<cmd>:Lazy<cr>", { desc = "Lazy" })

  -- Resize window using <ctrl> arrow keys
  map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
  map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
  map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
  map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

  -- terminal keymap
  map("t", "<C-t>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
  map("t", "<C-j>", "<c-\\><c-n><c-w>j", { desc = "Go Down" })
  map("t", "<C-k>", "<c-\\><c-n><c-w>k", { desc = "Go Up" })
  map("t", "<C-l>", "<c-\\><c-n><c-w>l", { desc = "Go Right" })
  map("t", "<C-h>", "<c-\\><c-n><c-w>h", { desc = "Go Left" })

  -- toggle line number
  map("n", "<leader>tn", require("config.function").toggle_line, { desc = "Toggle line number" })

  -- Clear search with <esc>
  map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
end

function M.initVscode()
  map(
    "n",
    "<leader>uC",
    [[<cmd>call VSCodeNotify('workbench.action.selectTheme')<cr>]],
    { desc = "Change colorscheme" }
  )
  -- find
  map("n", "<leader>fp", [[<cmd>call VSCodeNotify('workbench.action.openRecent')<cr>]], { desc = "find project" })

  -- undo & redo
  map("n", "u", [[<cmd>call VSCodeNotify('undo')<cr>]], { desc = "undo" })
  map("n", "<C-r>", [[<Cmd>call VSCodeNotify('redo')<CR>]], { desc = "redo" })

  -- code action
  map({ "n", "x" }, "<leader>cr", [[<cmd>call VSCodeNotify('editor.action.rename')<cr>]], { desc = "Rename Variable" })
  map({ "n", "x" }, "<leader>ca", [[<cmd>call VSCodeNotify('keyboard-quickfix.openQuickFix')<cr>]], {})

  map({ "n", "x" }, "]e", [[<cmd>call VSCodeNotify('editor.action.marker.next')<cr>]], {})
  map({ "n", "x" }, "[e", [[<cmd>call VSCodeNotify('editor.action.marker.prev')<cr>]], {})
  map({ "n", "x" }, "<leader>.", [[<cmd>call VSCodeNotify('workbench.action.quickOpen')<cr>]], {})
  map(
    { "n", "x" },
    "<leader>qo",
    [[<cmd>call VSCodeNotify('workbench.action.closeOtherEditors')<cr>]],
    { desc = "Close other editors" }
  )
  map(
    { "n", "x" },
    "<leader>qa",
    [[<cmd>call VSCodeNotify('workbench.action.closeAllEditors')<cr>]],
    { desc = "Close all editors" }
  )
  map(
    { "n", "x" },
    "<leader>qq",
    [[<cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<cr>]],
    { desc = "Close active editor" }
  )

  -- toggle zen mode
  map("n", "<leader>tz", [[<cmd>call VSCodeNotify('workbench.action.toggleZenMode')<cr>]], {})
end

return M
