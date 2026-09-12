-- Centralized UI management: folds (nvim-ufo) + native statusline
local M = {}

local icons = require("config.icons")

------------------------------------------------------------
-- Folds (nvim-ufo)
------------------------------------------------------------
local function fold_options()
	local opt = vim.opt
	vim.o.fillchars = 'eob: ,fold: ,foldopen:,foldsep: ,foldclose:'
	opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
	opt.foldlevelstart = 99
	opt.foldenable = true
end

-- fold glyph for the native statuscolumn: chevron on fold-start lines only,
-- no fold-level digits (replaces statuscol.nvim)
local function fillchar(key, default)
	local fc = vim.wo.fillchars or ""
	return fc:match(key .. ":([^,]*)") or default
end

function M.fold_glyph()
	if vim.v.virtnum > 0 then
		return " "
	end
	local lnum = vim.v.lnum
	if vim.fn.foldlevel(lnum) == 0 then
		return " "
	end
	if vim.fn.foldclosed(lnum) == lnum then
		return fillchar("foldclose", "▾")
	end
	if vim.fn.foldlevel(lnum) > vim.fn.foldlevel(lnum - 1) then
		return fillchar("foldopen", "▸")
	end
	return " "
end

local fold_handler = function(virtText, lnum, endLnum, width, truncate)
	local newVirtText = {}
	local suffix = (" 󰁂 %d "):format(endLnum - lnum)
	local sufWidth = vim.fn.strdisplaywidth(suffix)
	local targetWidth = width - sufWidth
	local curWidth = 0
	for _, chunk in ipairs(virtText) do
		local chunkText = chunk[1]
		local chunkWidth = vim.fn.strdisplaywidth(chunkText)
		if targetWidth > curWidth + chunkWidth then
			table.insert(newVirtText, chunk)
		else
			chunkText = truncate(chunkText, targetWidth - curWidth)
			local hlGroup = chunk[2]
			table.insert(newVirtText, { chunkText, hlGroup })
			chunkWidth = vim.fn.strdisplaywidth(chunkText)
			-- str width returned from truncate() may less than 2nd argument, need padding
			if curWidth + chunkWidth < targetWidth then
				suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
			end
			break
		end
		curWidth = curWidth + chunkWidth
	end
	table.insert(newVirtText, { suffix, "MoreMsg" })
	return newVirtText
end

function M.setup_fold()
	fold_options()
	---@diagnostic disable-next-line: missing-fields
	require("ufo").setup({
		open_fold_hl_timeout = 150,
		fold_virt_text_handler = fold_handler,
		preview = {
			win_config = {
				border = { "", "─", "", "", "", "─", "", "" },
				winhighlight = "Normal:Folded",
				winblend = 0,
			},
			mappings = {
				scrollU = "<C-u>",
				scrollD = "<C-d>",
				jumpTop = "[",
				jumpBot = "]",
			},
		},
		provider_selector = function(bufnr, filetype)
			return { 'treesitter', 'indent' }
		end,
	})
	vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
	vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
	vim.keymap.set(
		"n",
		"zr",
		require("ufo").openFoldsExceptKinds,
		{ desc = "Open all folds except specified kinds" }
	)
	vim.keymap.set("n", "zm", require("ufo").closeFoldsWith, { desc = "Close all folds except specified kinds" })
end

------------------------------------------------------------
-- Statusline
------------------------------------------------------------
local function hl(group)
	return "%#" .. group .. "#"
end

-- harpoon2 marks: "1 2 [3] 4" (active mark in brackets)
local function harpoon()
	if package.loaded["harpoon"] == nil then
		return ""
	end
	local ok, hp = pcall(require, "harpoon")
	if not ok then
		return ""
	end
	local list = hp:list()
	if not list or list:length() == 0 then
		return ""
	end

	local cur = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p")
	local root = vim.fn.fnamemodify((list.config and list.config:get_root_dir()) or vim.fn.getcwd(), ":p")

	local parts = {}
	for i, item in ipairs(list.items) do
		if item and item.value then
			local path = item.value
			if not vim.startswith(path, "/") and not path:match("^%a:[/\\]") then
				path = root .. path
			end
			parts[#parts + 1] = vim.fn.fnamemodify(path, ":p") == cur and ("[" .. i .. "]") or tostring(i)
		end
	end
	return table.concat(parts, " ")
end

local function diagnostics()
	local sevs = {
		{ "Error", icons.diagnostics.error },
		{ "Warn",  icons.diagnostics.warn },
		{ "Hint",  icons.diagnostics.hint },
		{ "Info",  icons.diagnostics.info },
	}
	local severities = {
		vim.diagnostic.severity.ERROR,
		vim.diagnostic.severity.WARN,
		vim.diagnostic.severity.HINT,
		vim.diagnostic.severity.INFO,
	}
	local parts = {}
	for i, sev in ipairs(severities) do
		local n = #vim.diagnostic.get(0, { severity = sev })
		if n > 0 then
			parts[#parts + 1] = hl("Diagnostic" .. sevs[i][1]) .. sevs[i][2] .. n .. hl("StatusLine")
		end
	end
	return table.concat(parts, " ")
end

local function diff()
	local d = vim.b.gitsigns_status_dict
	if not d then
		return ""
	end
	local g = icons.git
	local parts = {}
	if (d.added or 0) > 0 then
		parts[#parts + 1] = hl("GitSignsAdd") .. g.added .. d.added .. hl("StatusLine")
	end
	if (d.changed or 0) > 0 then
		parts[#parts + 1] = hl("GitSignsChange") .. g.changed .. d.changed .. hl("StatusLine")
	end
	if (d.removed or 0) > 0 then
		parts[#parts + 1] = hl("GitSignsDelete") .. g.deleted .. d.removed .. hl("StatusLine")
	end
	return table.concat(parts, " ")
end

local function noice()
	if package.loaded["noice"] == nil then
		return ""
	end
	local ok, status = pcall(function()
		return require("noice").api.status
	end)
	if not ok then
		return ""
	end
	local parts = {}
	if status.command.has() then
		parts[#parts + 1] = status.command.get()
	end
	if status.mode.has() then
		parts[#parts + 1] = status.mode.get()
	end
	if status.search.has() then
		parts[#parts + 1] = status.search.get()
	end
	return table.concat(parts, " ")
end

local ignored = {
	alpha = true,
	dashboard = true,
	lazy = true,
	oil = true,
	Trouble = true,
}

function M.statuscolumn()
	if ignored[vim.bo.filetype] then
		return ""
	end
	local num = vim.v.relnum ~= 0 and vim.v.relnum or vim.v.lnum
	return M.fold_glyph() .. " " .. num .. " "
end

function M.statusline()
	if ignored[vim.bo.filetype] then
		return ""
	end

	local left = {}
	local h = harpoon()
	if h ~= "" then
		left[#left + 1] = h
	end
	local dg = diagnostics()
	if dg ~= "" then
		left[#left + 1] = dg
	end

	local right = {}
	local ns = noice()
	if ns ~= "" then
		right[#right + 1] = ns
	end
	local df = diff()
	if df ~= "" then
		right[#right + 1] = df
	end
	right[#right + 1] = "%P"
	right[#right + 1] = "%l:%c"

	return " " .. table.concat(left, "  ") .. " %= " .. table.concat(right, "  ") .. " "
end

------------------------------------------------------------
-- Mode indicator: cursorline tint per mode (replaces modes.nvim)
------------------------------------------------------------
local MODE_COLORS = {
	copy = "#f5c359",   -- operator-pending: y
	delete = "#c75c6a", -- operator-pending: d/c/x/...
	insert = "#78ccc5",
	visual = "#9745be",
}
local MODE_OPACITY = 0.15

local function blend(fg_hex, alpha)
	local bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
	local fg = vim.api.nvim_get_color_by_name(fg_hex)
	if not bg or not fg or fg == -1 then
		return nil
	end
	local function channel(shift)
		local a = bit.band(bit.rshift(fg, shift), 0xff)
		local b = bit.band(bit.rshift(bg, shift), 0xff)
		return math.floor(a * alpha + b * (1 - alpha) + 0.5)
	end
	return string.format("#%02x%02x%02x", channel(16), channel(8), channel(0))
end

local mode_tints = {}
local default_cursorline = nil
local default_cursorlinenr = nil

local function define_mode_tints()
	default_cursorline = vim.api.nvim_get_hl(0, { name = "CursorLine" }).bg
	default_cursorlinenr = vim.api.nvim_get_hl(0, { name = "CursorLineNr" }).bg
	for name, hex in pairs(MODE_COLORS) do
		mode_tints[name] = blend(hex, MODE_OPACITY)
	end
end

local function current_mode_tint()
	local mode = vim.api.nvim_get_mode().mode
	if mode == "i" then
		return mode_tints.insert
	elseif mode == "v" or mode == "V" or mode == "\22" then
		return mode_tints.visual
	elseif mode == "no" then
		return vim.v.operator == "y" and mode_tints.copy or mode_tints.delete
	end
end

local function update_mode_tint()
	local tint = current_mode_tint()
	vim.api.nvim_set_hl(0, "CursorLine", { bg = tint or default_cursorline })
	vim.api.nvim_set_hl(0, "CursorLineNr", { bg = tint or default_cursorlinenr })
end

------------------------------------------------------------
-- Setup: options + autocmds
------------------------------------------------------------
local function augroup(name)
	return vim.api.nvim_create_augroup("maya_" .. name, { clear = true })
end

function M.setup()
	vim.o.laststatus = 3 -- global statusline
	vim.o.statusline = "%!v:lua.require('config.ui').statusline()"
	vim.o.statuscolumn = "%s%{v:lua.require('config.ui').statuscolumn()}"

	-- mode cursorline tint (replaces modes.nvim)
	local mode_group = augroup("mode")
	define_mode_tints()
	update_mode_tint()
	vim.api.nvim_create_autocmd("ModeChanged", {
		group = mode_group,
		callback = update_mode_tint,
	})
	vim.api.nvim_create_autocmd("ColorScheme", {
		group = mode_group,
		callback = function()
			define_mode_tints()
			update_mode_tint()
		end,
	})

	-- refresh statusline when async data updates
	local statusline_group = augroup("statusline")
	vim.api.nvim_create_autocmd("DiagnosticChanged", {
		group = statusline_group,
		callback = function()
			vim.cmd.redrawstatus()
		end,
	})
	vim.api.nvim_create_autocmd("User", {
		pattern = "GitSignsUpdate",
		group = statusline_group,
		callback = function()
			vim.cmd.redrawstatus()
		end,
	})

	-- auto disable folding for neo-tree
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "neo-tree" },
		callback = function()
			require("ufo").detach()
			vim.opt_local.foldenable = false
		end,
	})
end

-- self-check: :lua require('config.ui').demo()
function M.demo()
	M.setup()
	local out = vim.api.nvim_eval_statusline(vim.o.statusline, { maxwidth = 80 })
	assert(type(out.str) == "string", "statusline must render to a string")
	print("statusline OK: " .. out.str)

	-- mode tint self-check
	define_mode_tints()
	for _, t in pairs(mode_tints) do
		assert(type(t) == "string" and t:match("^#%x%x%x%x%x%x$"), "mode tint blend broken: " .. tostring(t))
	end
	local before = vim.api.nvim_get_hl(0, { name = "CursorLine" }).bg
	vim.api.nvim_set_hl(0, "CursorLine", { bg = mode_tints.insert })
	assert(vim.api.nvim_get_hl(0, { name = "CursorLine" }).bg ~= before, "mode tint apply broken")
	update_mode_tint()
	assert(vim.api.nvim_get_hl(0, { name = "CursorLine" }).bg == before, "mode tint reset broken")
	print("mode tint OK")
end

return M
