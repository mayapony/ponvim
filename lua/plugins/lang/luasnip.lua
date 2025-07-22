return {
	"L3MON4D3/LuaSnip",
	-- install jsregexp (optional!).
	build = "make install_jsregexp",
	version = "1.2.*",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"rafamadriz/friendly-snippets",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	config = function()
		local luasnip = require("luasnip")

		-- add react snippet support
		luasnip.filetype_extend("javascript", { "javascriptreact" })
		luasnip.filetype_extend("javascript", { "html" })

		-- forget the current snippet when leaving the insert mode
		-- source: https://github.com/L3MON4D3/LuaSnip/issues/656
		local unlinkgrp = vim.api.nvim_create_augroup("UnlinkSnippetOnModeChange", { clear = true })

		vim.api.nvim_create_autocmd("ModeChanged", {
			group = unlinkgrp,
			pattern = { "s:n", "i:*" },
			desc = "Forget the current snippet when leaving the insert mode",
			callback = function(evt)
				if luasnip.session and luasnip.session.current_nodes[evt.buf] and not luasnip.session.jump_active then
					luasnip.unlink_current()
				end
			end,
		})
	end,
	keys = {},
}
