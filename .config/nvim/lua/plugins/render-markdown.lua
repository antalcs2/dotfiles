-- https://github.com/MeanderingProgrammer/render-markdown.nvim
-- Gives MarkDown preview
return {
	"MeanderingProgrammer/render-markdown.nvim",
	lazy = false,
	priority = 75,
	opts = {},
	dependencies = {
		"nvim-treesitter/nvim-treesitter",

		-- https://github.com/nvim-tree/nvim-web-devicons
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
}
