return {
  "folke/flash.nvim",
  event = "BufReadPost",
  opts = {
    modes = {
      char = {
        jump_labels = true,
        multi_line = false,
      },
    },
  },
  keys = {
    {
      "s",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
    {
      "S",
      mode = { "n", "o", "x" },
      function()
        require("flash").treesitter()
      end,
      desc = "Flash Treesitter",
    },
    {
      "R",
      mode = { "o", "x" },
      function()
        require("flash").treesitter_search()
      end,
      desc = "Flash Treesitter Search",
    },
  },
}
-- return {
-- 	{
-- 		"ggandor/flit.nvim",
-- 		keys = function()
-- 			---@type LazyKeys[]
-- 			local ret = {}
-- 			for _, key in ipairs({ "f", "F", "t", "T" }) do
-- 				ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
-- 			end
-- 			return ret
-- 		end,
-- 		opts = { labeled_modes = "nx" },
-- 	},
-- 	{
-- 		"ggandor/leap.nvim",
-- 		config = function()
-- 			require("leap").add_default_mappings()
-- 		end,
-- 	},
-- }
