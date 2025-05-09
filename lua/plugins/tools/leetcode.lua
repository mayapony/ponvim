return {
	"kawre/leetcode.nvim",
	cmd = "Leet",
	lazy = true,
	build = ":TSUpdate html",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim", -- telescope 所需
		"MunifTanjim/nui.nvim",

		-- 可选
		"nvim-treesitter/nvim-treesitter",
		"rcarriga/nvim-notify",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		lang = "java",

		cn = { -- leetcode.cn
			enabled = true, ---@type boolean
			translator = true, ---@type boolean
			translate_problems = true, ---@type boolean
		},
		---@type boolean
		logging = true,
	},
}
