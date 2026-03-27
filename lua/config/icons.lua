local nerd_diagnostics = {
	Error = " ",
	Warn = " ",
	Hint = " ",
	Info = " ",
}

local emoji_diagnostics = {
	Error = "🤡",
	Warn = "🚨",
	Hint = "🤓",
	Info = "📚",
}

local interpunct = {
	error = " ",
	warn = " ",
	hint = " ",
	info = " ",
}

local git_icons = {
	untracked = " ",
	ignored = " ",
	staged = " ",
	conflict = " ",
	added = " ",
	modified = " ",
	changed = " ",
	deleted = " ",
	renamed = " ",
	unstaged = "󰄱 ",
}

local M = {
	diagnostics = interpunct,
	git = git_icons,
}

return M
