local M = { to_install = {} }

-- Include cmp_nvim_lsp's capabilities for all servers
local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok then
	vim.lsp.config("*", {
		capabilities = cmp_nvim_lsp.default_capabilities(),
	})
end

-- Call vim.lsp.config for all servers
local config_dir = vim.fn.stdpath("config") .. "/lua/lspconf"
local servers = vim.fn.globpath(config_dir, "*.lua", false, true)

for _, serverpath in ipairs(servers) do
	local servername = vim.fn.fnamemodify(serverpath, ":t:r")
	if servername ~= "init" then
		local server = require("lspconf." .. servername)
		table.insert(M.to_install, server.mason_name)

		vim.lsp.config(servername, server.Config)
	end
end

return M
