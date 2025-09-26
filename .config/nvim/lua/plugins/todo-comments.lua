vim.pack.add({
	-- Highlight todo, notes, etc. in comments
	"https://github.com/folke/todo-comments.nvim",

	-- Dependency
	"https://github.com/nvim-lua/plenary.nvim",
})
require("todo-comments").setup({
	signs = false,
})

-- [[
-- FIX:
-- HACK:
-- WARN:
-- PERF:
-- NOTE:
-- TEST:
-- ]]
