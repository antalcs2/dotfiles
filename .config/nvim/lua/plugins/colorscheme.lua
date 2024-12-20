return {
	-- default colorscheme
	{
		-- https://github.com/ellisonleao/gruvbox.nvim
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 1000, -- Make sure to load this before all the other start plugins.
		config = function()
			require("gruvbox").setup({
				overrides = {
					StatusLine = { reverse = false },
					StatusLineNC = { reverse = false },
				},
			})

			vim.cmd.colorscheme("gruvbox")
		end,
	},

	"folke/tokyonight.nvim",
	"rebelot/kanagawa.nvim",
}
