-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt
opt.autowrite = true          -- 自动保存
opt.clipboard = "unnamedplus" -- 复制保存到剪切板
opt.completeopt = "menu,menuone,noselect"
opt.confirm = true            -- 在离开buffer时确认保存
opt.mouse = "a"               -- 允许使用鼠标
opt.scrolloff = 4             -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.shiftround = true         -- Round indent
opt.shiftwidth = 2            -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true })
opt.showmode = false          -- Don't show mode since we have a statusline
opt.sidescrolloff = 8         -- Columns of context
opt.signcolumn = "yes"        -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true          -- Don't ignore case with capitals
opt.smartindent = true        -- Insert indents automatically
opt.spelllang = { "en" }
opt.spell = false             -- enable spell check
opt.splitbelow = true         -- Put new windows below current
opt.splitright = true         -- Put new windows right of current
opt.tabstop = 2               -- Number of spaces tabs count for
opt.termguicolors = true      -- True color support
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200               -- Save swap file and trigger CursorHold
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5                -- Minimum window width
opt.wrap = true                    -- Disable line wrap

if vim.fn.has("nvim-0.9.0") == 1 then
	opt.splitkeep = "screen"
	opt.shortmess:append({ C = true })
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- fold config
opt.foldcolumn = "0" -- '0' is not bad
opt.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
opt.foldlevelstart = 99
opt.foldenable = true

-- indent blankline config
-- vim.opt.list = true
-- vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")

-- opacity
opt.pumblend = 30  -- Popup blend 100 for full transparent
opt.winblend = 30  -- Fix float black 100 for full transparent
-- source from: https://github.com/catppuccin/nvim/issues/412
opt.pumheight = 10 -- Maximum number of entries in a popup

-- source: https://github.com/nvim-tree/nvim-tree.lua#quick-start
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
