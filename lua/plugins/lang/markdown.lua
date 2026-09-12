return {
	{
		"tadmccorkle/markdown.nvim",
		ft = "markdown", -- or 'event = "VeryLazy"'
		opts = {
			-- configuration here or empty for defaults
		},
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		enabled = false, -- 暂时禁用，对比 markview.nvim；改回 true 即可恢复
		ft = "markdown",
		dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you use the mini.nvim suite
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			-- 光标行也保持渲染效果（'' 时当前行会显示 markdown 源码）
			win_options = { concealcursor = { rendered = 'nc' } },
		},
	},
	{
		"OXY2DEV/markview.nvim",
		ft = "markdown",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {},
	},
}
