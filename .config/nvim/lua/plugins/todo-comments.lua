-- Highlight todo, notes, etc. in comments
-- https://github.com/folke/todo-comments.nvim
return {
	"folke/todo-comments.nvim",
	lazy = false,
	priority = 100,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		signs = false,
	},
	-- [[
	-- FIX:
	-- HACK:
	-- WARN:
	-- PERF:
	-- NOTE:
	-- TEST:
	-- ]]
}
