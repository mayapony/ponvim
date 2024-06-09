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

local git_icons = {
  untracked = "",
  ignored = "",
  staged = "",
  conflict = "",
  added = "",
  modified = "",
  changed = "",
  deleted = "",
  renamed = "",
  unstaged = "󰄱",
}

local M = {
  diagnostics = emoji_diagnostics,
  git = git_icons,
}

return M
