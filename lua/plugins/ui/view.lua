-- 类似其他编辑器的 `view`, 用于控制一些功能的显示

return {
	{
		-- 展示当前文件的变量大纲
		"simrat39/symbols-outline.nvim",
		cmd = "SymbolsOutline",
		keys = { { "<leader>uo", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
		config = true,
	}
}
