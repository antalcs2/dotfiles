vim.pack.add({
	-- Autoformatter
	"https://github.com/stevearc/conform.nvim",
})

local formatters_by_ft = {
	lua = { "stylua" },
	cmake = { "cmakelang" },
	h = { "clang-format" },
	c = { "clang-format" },
	cpp = { "clang-format" },
}

require("conform").setup({
	notify_on_error = true,
	formatters_by_ft = formatters_by_ft,
	-- automatically sets up an autocmd on BufWritePre
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

vim.keymap.set("n", "<leader>f", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "[F]ormat buffer" })

-- Return a list of the formatters without duplicates
local retrieve_formatters = function(forms_by_ft)
	local temp = {}
	for _, v in pairs(forms_by_ft) do
		for _, name in ipairs(v) do
			temp[name] = 1
		end
	end
	local formatters = {}
	for k, _ in pairs(temp) do
		table.insert(formatters, k)
	end
	return formatters
end

return { to_install = retrieve_formatters(formatters_by_ft) }
