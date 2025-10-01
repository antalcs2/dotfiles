local M = {}

---@type vim.lsp.Config
M.Config = {
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
			diagnostics = { disable = { "missing-fields" }, globals = { "vim" } },
			hint = { enable = true },
			telemetry = { enable = false },

			-- NOTE: https://github.com/neovim/nvim-lspconfig/blob/master/lsp/lua_ls.lua
			runtime = {
				version = "LuaJIT",
				path = {
					"lua/?.lua",
					"lua/?/init.lua",
				},
				pathStrict = true,
			},
			workspace = {
				checkThirdParty = false,
				library = vim.tbl_filter(function(d)
					return not d:match(vim.fn.stdpath("config") .. "/?a?f?t?e?r?")
				end, vim.api.nvim_get_runtime_file("lua", true)),
			},
		},
	},
}

M.mason_name = "lua-language-server"

return M
