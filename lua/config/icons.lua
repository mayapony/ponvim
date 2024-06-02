local nerd_diagnostics = {
	Error = " ",
	Warn = " ",
	Hint = " ",
	Info = " ",
}

local emoji_diagnostics = {
	Error = "❌",
	Warn = "❗",
	Hint = "💡",
	Info = "📝",
}


local M = {
	diagnostics = emoji_diagnostics,
	git = {
		added = "",
		changed = "",
		deleted = "",
		untracked = "",
	},
}

return M
