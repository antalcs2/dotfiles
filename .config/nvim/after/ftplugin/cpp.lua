-- Same as in `/plugin/options.lua`
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4

-- Soft-wrapping text at column 80
-- (same in .clang-format, so upon format that will insert newlines, not neovim)
vim.opt_local.textwidth = 0
vim.opt_local.wrapmargin = 0
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
-- This resets the buffer window to a width of 80 so it is useless
-- vim.opt_local.columns = 80
vim.cmd([[set colorcolumn+=80]])

vim.keymap.set("n", "<leader>-", function()
	local key = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
	vim.api.nvim_feedkeys("o//" .. string.rep("-", 78) .. key, "n", true)
end, { desc = "C++: Insert all dash line comment" })

vim.keymap.set("n", "<leader>b", function()
	vim.cmd("!./run.sh")
end, { desc = "C++: Build and run C++ project" })
