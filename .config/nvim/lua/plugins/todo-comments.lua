-- Highlight todo, notes, etc. in comments
-- https://github.com/folke/todo-comments.nvim
return {
	"folke/todo-comments.nvim",
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
