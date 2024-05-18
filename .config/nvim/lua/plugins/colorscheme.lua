return {

	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000, -- Make sure to load this before all the other start plugins.
		opts = {},
	},

	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},

	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		init = function()
			vim.cmd.colorscheme("gruvbox")

			-- You can configure highlights by doing something like:
			vim.cmd.hi("Comment gui=none")
		end,
	},
}
