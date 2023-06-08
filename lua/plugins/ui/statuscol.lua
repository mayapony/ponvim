return {
  "luukvbaal/statuscol.nvim",
  config = function()
    local builtin = require("statuscol.builtin")
    require("statuscol").setup({
      -- configuration goes here, for example:
      relculright = true,
      segments = {
        -- { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
        {
          sign = { name = { "Diagnostic" }, maxwidth = 2, auto = true },
          click = "v:lua.ScSa",
        },
        { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
        {
          sign = { name = { ".*" }, maxwidth = 2, colwidth = 2, auto = true, wrap = true },
          click = "v:lua.ScSa",
        },
      },
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
    })
  end,
}
