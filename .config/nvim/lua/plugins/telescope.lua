-- Autocmd to build telescope-fzf-native
-- Has to exist before loading the plugin
vim.api.nvim_create_autocmd("PackChanged", {
	desc = "Build telescope-fzf-native with make",
	group = vim.api.nvim_create_augroup("UserBuildFzfGroup", { clear = true }),
	callback = function(ev)
		if ev.data.spec.name == "telescope-fzf-native.nvim" and ev.data.kind == "update" then
			vim.notify("[User] Building telescope-fzf-native", vim.log.levels.INFO)
			if vim.fn.executable("make") == 1 then
				local result = vim.system({ "make" }, { cwd = ev.data.path }):wait()
				if result.code == 0 then
					vim.notify("[User] telescope-fzf-native built")
				else
					vim.notify("[User] telescope-fzf-native build failed", vim.log.levels.ERROR)
				end
			end
		end
	end,
})

vim.pack.add({
	-- Fuzzy Finder
	{ src = "https://github.com/nvim-telescope/telescope.nvim", version = "0.1.x" },

	-- Dependency
	"https://github.com/nvim-lua/plenary.nvim",

	-- Implements the fzf algorithm
	"https://github.com/nvim-telescope/telescope-fzf-native.nvim",

	-- Sets vim.ui.select to telescope
	"https://github.com/nvim-telescope/telescope-ui-select.nvim",
})

-- Setup
require("telescope").setup({
	defaults = {
		selection_caret = "󰼛 ",
	},
	extensions = {
		fzf = {},
		["ui-select"] = {
			require("telescope.themes").get_dropdown(),
		},
	},
})

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")

-- Keymaps
local builtin = require("telescope.builtin")
local map = function(keys, func, desc)
	vim.keymap.set("n", keys, func, { desc = "[S]earch " .. desc })
end

map("<leader>sc", builtin.colorscheme, "[C]olorscheme")
map("<leader>sh", builtin.help_tags, "[Help]")
map("<leader>sk", builtin.keymaps, "[K]eymaps")
map("<leader>sf", builtin.find_files, "[F]iles")
map("<leader>sr", builtin.oldfiles, "[R]ecent Files")

map("<leader>sb", function()
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, "Current [B]uffer")

map("<leader>sn", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, "[N]eovim Files")
