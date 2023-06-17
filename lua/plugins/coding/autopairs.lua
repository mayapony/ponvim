return {
  event = "VeryLazy",
  "windwp/nvim-autopairs",
	priority = 10000,
  config = function()
    require("nvim-autopairs").setup({ enable_check_bracket_line = false })

    -- setup cmp for autopairs
    local cmp_autopairs = require "nvim-autopairs.completion.cmp"
    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
	opts = {
    fast_wrap = {},
    disable_filetype = { "TelescopePrompt", "vim" },
  },
}
