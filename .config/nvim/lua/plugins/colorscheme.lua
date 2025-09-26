vim.pack.add({
	"https://github.com/ellisonleao/gruvbox.nvim",
	"https://github.com/folke/tokyonight.nvim",
	"https://github.com/rebelot/kanagawa.nvim",
})

require("gruvbox").setup({
	overrides = {
		StatusLine = { reverse = false },
		StatusLineNC = { reverse = false },
	},
})

vim.cmd.colorscheme("gruvbox")
