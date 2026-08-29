-- Native statusline replacing lualine.nvim
local M = {}

local icons = require("config.icons")

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
		{ "Warn", icons.diagnostics.warn },
		{ "Hint", icons.diagnostics.hint },
		{ "Info", icons.diagnostics.info },
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
	["neo-tree"] = true,
	Trouble = true,
}

function M.get()
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

-- self-check: :lua require('config.statusline').demo()
function M.demo()
	vim.o.laststatus = 3
	vim.o.statusline = "%!v:lua.require('config.statusline').get()"
	local out = vim.api.nvim_eval_statusline(vim.o.statusline, { maxwidth = 80 })
	assert(type(out.str) == "string", "statusline must render to a string")
	print("statusline OK: " .. out.str)
end

return M
