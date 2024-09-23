-- https://github.com/MeanderingProgrammer/render-markdown.nvim
-- Gives MarkDown preview
return {
	"MeanderingProgrammer/render-markdown.nvim",
	lazy = false,
	priority = 75,
	opts = {},
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"echasnovski/mini.nvim",
		"echasnovski/nvim-web-devicons",
	},
}
