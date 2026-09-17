-- 折叠已改用 Neovim 原生 foldexpr，配置见 lua/config/ui.lua 的 setup_fold()/foldexpr()。
-- nvim-ufo 暂时保留但停用，方便回退：enabled 改回 true，并移除 config.ui 里的原生 foldexpr。
return {
	"kevinhwang91/nvim-ufo",
	event = "BufReadPost",
	enabled = false,
	dependencies = {
		"kevinhwang91/promise-async",
	},
}
