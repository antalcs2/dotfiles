-- [[ Basic Autocommands ]]
vim.api.nvim_create_autocmd("BufEnter", {
	desc = "'o' does not add comment",
	group = vim.api.nvim_create_augroup("UserCommentNewLineGroup", { clear = true }),
	callback = function()
		vim.cmd([[set formatoptions-=cro]])
		vim.cmd([[setlocal formatoptions-=cro]])
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("UserYankHighlightGroup", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	desc = "Open help in a far-right vertical window",
	pattern = "help",
	command = "wincmd L",
})

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	desc = "Enable cursorline in active buffer",
	group = vim.api.nvim_create_augroup("UserActiveCursorline", { clear = true }),
	callback = function()
		vim.opt_local.cursorline = true
	end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
	desc = "Disable cursorline in inactive buffer",
	group = "UserActiveCursorline",
	callback = function()
		vim.opt_local.cursorline = false
	end,
})
