-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
require("lazy").setup({

	-- require("plugins.vim-sleuth"),

	-- "gc" to comment visual regions/lines
	{ "numToStr/Comment.nvim", opts = {} },

	require("plugins.gitsigns"),

	require("plugins.which-key"),

	require("plugins.telescope"),

	require("plugins.nvim-lspconfig"),

	require("plugins.conform"),

	require("plugins.nvim-cmp"),

	require("plugins.colorscheme"),

	require("plugins.todo-comments"),

	require("plugins.mini"),

	require("plugins.nvim-treesitter"),

	require("plugins.debug"),
}, {
	ui = {},
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
