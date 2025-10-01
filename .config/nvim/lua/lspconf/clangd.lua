local M = {}

---@type vim.lsp.Config
M.Config = {
	filetypes = { "c", "cpp", "objc", "objcpp" },
	settings = {
		clangd = {
			InlayHints = {
				Designators = true,
				Enabled = true,
				ParameterNames = true,
				DeducedTypes = true,
			},
		},
		fallbackFlags = { "-std=c++17" },
	},
}

M.mason_name = "clangd"

return M
