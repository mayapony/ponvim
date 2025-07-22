local diagnostics_icons = require("config.icons").diagnostics

return {
  "ivanjermakov/troublesum.nvim",
  event = "BufReadPost",
  opts = {
    severity_format = {
      diagnostics_icons.Error,
      diagnostics_icons.Warn,
      diagnostics_icons.Info,
      diagnostics_icons.Hint,
    },
  },
}
