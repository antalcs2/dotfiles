vim.g.mapleader = ","
vim.g.maplocalleader = ","

require("configs.options")
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

require("plugins.nvim-lspconfig")
require("plugins.conform")
require("plugins.mason")
require("plugins.nvim-cmp")

local lsp_servers = require("plugins.nvim-lspconfig").servers
vim.lsp.enable(lsp_servers)
