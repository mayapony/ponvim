return {
	"mfussenegger/nvim-dap",
	event = "VeryLazy",
	config = function()
		require("dap").configurations.chrome = {
			{
				type = "chrome",
				request = "launch",
				name = "Launch Chrome against localhost",
				url = "http://localhost:8282",
				webRoot = "${workspaceFolder}",
			}
		}
	end,
	keys = {
	},
	{
		"rcarriga/nvim-dap-ui",
		event = "VeryLazy",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			require("dapui").setup()

			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
		keys = {
			{ "<leader>dd", "<cmd>lua require('dapui').toggle()<cr>",          desc = "Toggle DAP UI" },
			{ "<leader>dc", "<cmd>lua require('dap').continue()<cr>",          desc = "Continue" },
			{ "<leader>ds", "<cmd>lua require('dap').step_into()<cr>",         desc = "Step into" },
			{ "<leader>de", "<cmd>lua require('dap').step_out()<cr>",          desc = "Step out" },
			{ "<leader>do", "<cmd>lua require('dap').step_over()<cr>",         desc = "Step over" },
			{ "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<cr>", desc = "Debug toggle breakpoint" },

			{ "<leader>dr", "<cmd>lua require('dap').run()<cr>",               desc = "Run" },
			{ "<leader>dl", "<cmd>lua require('dap').load_launchjs(nil)<cr>",  desc = "Step over" },
			{ "<leader>dt", "<cmd>lua require('dap').terminate()<cr>",         desc = "Terminate" },
		},
	}
}
