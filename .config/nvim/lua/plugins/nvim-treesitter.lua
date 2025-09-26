vim.pack.add({
	-- Parser tool for highlighting, editing, and navigating code
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" },
})

require("nvim-treesitter.install").prefer_git = true

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"bash",
		"c",
		"cpp",
		"cmake",
		"json",
		"lua",
		"luadoc",
		"markdown",
		"markdown_inline",
		"query",
		"vim",
		"vimdoc",
		"yaml",
	},
	auto_install = true,
	highlight = { enable = true },
	indent = { enable = false },
})

-- Autocmd to update nvim-treesitter
vim.api.nvim_create_autocmd("PackChanged", {
	desc = "Update nvim-treesitter parsers when the repo updates",
	group = vim.api.nvim_create_augroup("UserTSUpdateGroup", { clear = true }),
	callback = function(ev)
		if ev.data.spec.name == "nvim-treesitter" and ev.data.kind == "update" then
			vim.notify("[User] nvim-treesitter updated, updating parsers", vim.log.levels.INFO)
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			vim.schedule(ts_update)
		end
	end,
})
