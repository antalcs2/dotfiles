vim.pack.add({
	-- Shows your pending keybinds
	"https://github.com/folke/which-key.nvim",
})

require("which-key").setup({
	preset = "modern",
})

vim.keymap.set("n", "<leader>?", function()
	require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })

local wk = require("which-key")
wk.add({
	{ "<leader>s", group = "Search", mode = "n" },
	{ "<leader>t", group = "Toggle", mode = "n" },
})
