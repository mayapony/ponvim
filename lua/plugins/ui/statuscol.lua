return {
  "luukvbaal/statuscol.nvim",
  lazy = false,
  config = function()
    local builtin = require("statuscol.builtin")
    require("statuscol").setup({
      -- configuration goes here, for example:
      relculright = false,
      ft_ignore = {
        "alpha",
        "neo-tree",
        "neotree",
        "Trouble",
        "help",
        "vim",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "lazy",
        "toggleterm",
        "DiffviewFiles",
        "leetcode.nvim",
      },
      segments = {
        {
          sign = { namespace = { "diagnostic/signs" }, maxwidth = 1, colwidth = 2, auto = false, wrap = true },
          click = "v:lua.ScSa",
        },
        {
          sign = { namespace = { "gitsigns" }, name = { ".*" }, maxwidth = 1, colwidth = 2, auto = false },
          click = "v:lua.ScSa",
        },
        { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
        {
          text = { builtin.foldfunc },
          click = "v:lua.ScFa",
        },
        { text = { " " } },
      },
    })
  end,
}
