return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			dap.adapters.java = function(callback, config)
				local M = {}

				function M.execute_buf_command(command, callback)
					vim.lsp.buf_request(0, "workspace/executeCommand", command, function(err, _, res)
						if callback then
							callback(err, res)
						elseif err then
							print("Execute command failed: " .. err.message)
						end
					end)
				end

				function M.execute_command(command, callback)
					if type(command) == "string" then
						command = { command = command }
					end

					M.execute_buf_command(command, function(err, res)
						assert(not err, err and (err.message or Log.ins(err)))
						callback(res)
					end)
				end

				M.execute_command({ command = "vscode.java.startDebugSession" }, function(err0, port)
					assert(not err0, vim.inspect(err0))
					callback({ type = "server", host = "127.0.0.1", port = port })
				end)
			end
			dap.configurations.java = {
				{
					javaExec = "java",
					mainClass = "br.com.tiago.pereira.nvimApp.NvimAppApplication",
					modulePaths = {},
					name = "Lauch NvimAppApplication",
					request = "launch",
					type = "java",
				},
			}

			vim.keymap.set("n", "<F5>", function()
				require("dap").continue()
			end)
			vim.keymap.set("n", "<F10>", function()
				require("dap").step_over()
			end)
			vim.keymap.set("n", "<F11>", function()
				require("dap").step_into()
			end)
			vim.keymap.set("n", "<F12>", function()
				require("dap").step_out()
			end)
			vim.keymap.set("n", "<Leader>b", function()
				require("dap").toggle_breakpoint()
			end)
			vim.keymap.set("n", "<Leader>B", function()
				require("dap").set_breakpoint()
			end)
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
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
	},
}
