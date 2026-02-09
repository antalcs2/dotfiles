vim.pack.add({
	-- Debug Adapter Protocol client
	"https://github.com/mfussenegger/nvim-dap",

	-- UI plugin
	"https://github.com/igorlfs/nvim-dap-view",

	-- Virtual text support
	"https://github.com/theHamsta/nvim-dap-virtual-text",
})

if vim.fn.executable("gdb") ~= 1 then
	vim.notify("[User] Debug config not applied, gdb command not found!", vim.log.levels.WARN)
	return
end

local dap = require("dap")
local dapview = require("dap-view")

dap.adapters.gdb = {
	type = "executable",
	command = "gdb",
	args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
}

dap.configurations.cpp = {
	{
		name = "Launch",
		type = "gdb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopAtBeginningOfMainSubprogram = false,
	},
}

dap.configurations.c = dap.configurations.cpp

dapview.setup({
	winbar = {
		default_section = "scopes",
		controls = {
			enabled = true,
			buttons = {
				"play",
				"step_into",
				"step_over",
				"step_out",
				"run_last",
				"terminate",
				"disconnect",
			},
		},
	},
	auto_toggle = true,
})

-- Signs
vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#993939", bg = "#31353f" })
vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#61afef", bg = "#31353f" })
vim.api.nvim_set_hl(0, "DapStopped", { fg = "#98c379", bg = "#31353f" })

local dap_sign_define = function(name, text, hl)
	vim.fn.sign_define(name, { text = text, texthl = hl, numhl = hl, linehl = hl })
end

dap_sign_define("DapBreakpoint", "⬤", "DapBreakpoint")
dap_sign_define("DapBreakpointCondition", "◆", "DapBreakpoint")
dap_sign_define("DapBreakpointRejected", "✖", "DapBreakpoint")
dap_sign_define("DapLogPoint", "⬤", "DapLogPoint")
dap_sign_define("DapStopped", "▶", "DapStopped")

-- Keymaps
local map = function(keys, func, desc)
	vim.keymap.set("n", keys, func, { desc = "Debug: " .. desc })
end

map("<F5>", dap.continue, "Start/Continue")
map("<F1>", dap.step_into, "Step Into")
map("<F2>", dap.step_over, "Step Over")
map("<F3>", dap.step_out, "Step Out")
map("<F6>", dap.toggle_breakpoint, "Toggle Breakpoint")
map("<F7>", dapview.toggle, "See last session's result")

-- Virtual text setup
require("nvim-dap-virtual-text").setup({
	show_stop_reason = true,
	virt_text_pos = "inline",
})
