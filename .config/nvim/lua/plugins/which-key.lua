-- Useful plugin to show you pending keybinds.
-- https://github.com/folke/which-key.nvim
return {
	"folke/which-key.nvim",
	lazy = false,
	priority = 100,
	opts = {
		preset = "modern",
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
	config = function()
		local wk = require("which-key")

		wk.add({
			{ "<leader>s", group = "Search", mode = "n" },
			{ "<leader>t", group = "Toggle", mode = "n" },
			{ "<leader>d", group = "Document", mode = "n" },
			{ "<leader>w", group = "Workspace", mode = "n" },
		})
	end,
}
