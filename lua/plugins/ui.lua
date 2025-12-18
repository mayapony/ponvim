return {
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			local function opaque_icons()
				local devicons = require("nvim-web-devicons")
				devicons.setup({})

				-- 通过配置解决图标的大小问题
				-- source: https://github.com/nvim-tree/nvim-web-devicons/issues/608#issue-3399851967
				local icons = devicons.get_icons()
				for _, opts in pairs(icons) do
					local hl = "DevIcon" .. opts.name
					vim.cmd(("highlight %s blend=0"):format(hl))
				end
			end

			vim.schedule(opaque_icons)
			vim.api.nvim_create_autocmd("ColorScheme", { callback = vim.schedule_wrap(opaque_icons) })
		end,
	},
}
