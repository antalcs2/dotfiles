vim.g.mapleader = ","
vim.g.maplocalleader = ","

require("configs.options")
require("configs.autocmds")
require("configs.keymaps")
require("configs.floaterminal")

require("plugins.colorscheme")
require("plugins.mini") -- to load mini.icons early
require("plugins.lualine")

require("plugins.which-key")
require("plugins.todo-comments")

require("plugins.nvim-treesitter")
require("plugins.telescope")
require("plugins.render-markdown")

require("plugins.conform")
require("plugins.nvim-cmp")

require("plugins.nvim-lspconfig")
require("lspconf")

require("plugins.mason")

vim.lsp.enable({
	"clangd",
	"cmake",
	"lua_ls",
})
