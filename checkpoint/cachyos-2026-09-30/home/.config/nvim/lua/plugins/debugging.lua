return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	keys = {
		{
			"<F5>",
			function()
				require("dap").continue()
			end,
		},
		{
			"<F10>",
			function()
				require("dap").step_over()
			end,
		},
		{
			"<F11>",
			function()
				require("dap").step_into()
			end,
		},
		{
			"<F12>",
			function()
				require("dap").step_out()
			end,
		},
		{
			"<Leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
		},
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- Set up DAP and DAP UI
		dapui.setup()

		-- DAP adapter configuration for C++ (codelldb via Mason)
		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = "/home/snehil/.local/share/nvim/mason/bin/codelldb",
				args = { "--port", "${port}" },
			},
		}

		-- DAP configurations for cpp, c, rust
		dap.configurations.cpp = {
			{
				name = "Debug",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = {},
			},
		}
		dap.configurations.c = dap.configurations.cpp
		dap.configurations.rust = dap.configurations.cpp

		-- JavaScript/TypeScript debug adapter (pwa-node)
		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = "node",
				args = { "/home/snehil/debugAdapters/js-debug/src/dapDebugServer.js", "${port}" },
			},
		}

		-- Configurations for JavaScript and TypeScript debugging
		dap.configurations.javascript = {
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				cwd = "${workspaceFolder}",
			},
		}
		dap.configurations.typescript = dap.configurations.javascript
		dap.configurations.javascriptreact = dap.configurations.javascript
		dap.configurations.typescriptreact = dap.configurations.javascript

		-- DAP UI listeners
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.after.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.after.event_exited.dapui_config = function()
			dapui.close()
		end
	end,
}
