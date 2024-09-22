return {
	-- default colorscheme
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 1000, -- Make sure to load this before all the other start plugins.
		config = function()
			vim.cmd.colorscheme("gruvbox")
		end,
	},

	"folke/tokyonight.nvim",
	"rebelot/kanagawa.nvim",
}
