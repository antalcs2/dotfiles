vim.pack.add({
	-- Package manager for LSP servers, DAP servers, linters and formatters
	"https://github.com/mason-org/mason.nvim",

	-- Automatic tool installer for mason
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})

require("mason").setup({
	ui = {
		border = "rounded",
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

local lsp_to_install = require("plugins.nvim-lspconfig").to_install
local fmt_to_install = require("plugins.conform").to_install

-- Concatenate the two tables
local ensure_installed = lsp_to_install
for _, v in ipairs(fmt_to_install) do
	table.insert(ensure_installed, v)
end

require("mason-tool-installer").setup({
	ensure_installed = ensure_installed,
})
