-- NOTE: requirement: tree-sitter-cli installed by package manager

vim.pack.add({
	-- Parser tool for highlighting, editing, and navigating code
	"https://github.com/nvim-treesitter/nvim-treesitter",
})

require("nvim-treesitter").setup()

require("nvim-treesitter").install({
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
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "*" },
	callback = function(args)
		if pcall(vim.treesitter.start, args.buf) then
			for _, win in ipairs(vim.fn.win_findbuf(args.buf)) do
				vim.wo[win][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
				vim.wo[win][0].foldmethod = "expr"
			end
		end
	end,
})

vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

-- Autocmd to update nvim-treesitter
vim.api.nvim_create_autocmd("PackChanged", {
	desc = "Update nvim-treesitter parsers when the repo updates",
	group = vim.api.nvim_create_augroup("UserTSUpdateGroup", { clear = true }),
	callback = function(ev)
		if ev.data.spec.name == "nvim-treesitter" and (ev.data.kind == "install" or ev.data.kind == "update") then
			vim.notify("[User] nvim-treesitter updated, updating parsers", vim.log.levels.INFO)
			vim.cmd("TSUpdate")
		end
	end,
})
