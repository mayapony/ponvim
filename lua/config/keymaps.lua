local M = {}
local function map(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end

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

return M
