---@class FileMovedArgs
---@field source string
---@field destination string

---@param args FileMovedArgs
local function on_file_remove(args)
	local ts_clients = vim.lsp.get_clients({ name = "tsserver" })
	for _, ts_client in ipairs(ts_clients) do
		ts_client.request("workspace/executeCommand", {
			command = "_typescript.applyRenameFile",
			arguments = {
				{
					sourceUri = vim.uri_from_fname(args.source),
					targetUri = vim.uri_from_fname(args.destination),
				},
			},
		})
	end
end

return {
	"nvim-neo-tree/neo-tree.nvim",
	event = "VeryLazy",
	keys = {
		{
			"<leader>e",
			function()
				require("neo-tree.command").execute({ toggle = true })
			end,
			desc = "Explorer NeoTree",
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function(_, opts)
		require("neo-tree").setup(opts)
	end,
	opts = function()
		local events = require("neo-tree.events")
		return {
			sources = { "filesystem", "buffers", "git_status", "document_symbols" },
			filesystem = {
				hijack_netrw_behavior = "open_default",
				hide_by_name = {
					".git",
					"node_modules",
				},
				always_show = {
					".gitignore",
					".eslintrc.js",
				},
				bind_to_cwd = true,
				follow_current_file = {
					enabled = true,
				},
				use_libuv_file_watcher = false,
			},
			enable_git_status = true,
			enable_diagnostics = false,
			window = {
				width = 30,
			},
			default_component_configs = {
				indent = {
					with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
				name = {
					use_git_status_colors = false,
				},
				git_status = {
					symbols = require("config.icons").git,
				},
			},
			event_handlers = {
				{
					event = events.FILE_MOVED,
					handler = on_file_remove,
				},
				{
					event = events.FILE_RENAMED,
					handler = on_file_remove,
				},
			},
		}
	end,
}
