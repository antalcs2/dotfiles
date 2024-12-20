-- https://github.com/stevearc/conform.nvim
-- Autoformat
return {
	"stevearc/conform.nvim",
	lazy = false,
	priority = 500,
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		notify_on_error = true,
		format_on_save = function(bufnr)
			-- Disable "format_on_save lsp_fallback" for languages that don't
			-- have a well standardized coding style. You can add additional
			-- languages here or re-enable it for the disabled ones.
			local disable_filetypes = {}
			return {
				timeout_ms = 500,
				lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
			}
		end,
		formatters_by_ft = {
			lua = { "stylua" },
			cmake = { "cmakelang" },
			c = { "clang-format" },
			h = { "clang-format" },
			cpp = { "clang-format" },
			arduino = { "clang-format" },
		},
	},
}
