local opt = vim.opt
opt.autowrite = true -- 自动保存
opt.number = true
opt.relativenumber = true
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

opt.autowrite = true
opt.autoread = true

if vim.fn.has("nvim-0.9.0") == 1 then
	opt.splitkeep = "screen"
	opt.shortmess:append({ C = true })
end

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
-- source from: https://github.com/catppucin/nvim/issues/412
opt.pumheight = 10 -- Maximum number of entries in a popup

-- don't display ~ for blank lines
opt.fillchars = "eob: "

-- disable default status line
opt.laststatus = 0

-- diagnostic config
vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
	},
})

local signs = require("config.icons").diagnostics
-- local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
