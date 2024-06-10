-- https://github.com/echasnovski/mini.nvim
-- Various utility plugins
return {
	"echasnovski/mini.nvim",
	config = function()
		-- Around/Inside textobjects
		--
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]parentesys
		--  - yinq - [Y]ank [I]nside [N]ext [']quote
		--  - ci'  - [C]hange [I]nside [']quote
		require("mini.ai").setup({ n_lines = 500 })

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		--
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		require("mini.surround").setup()

		require("mini.comment").setup()

		-- Adds automatically closing pair to brackets and quotes
		local bracket_neigh = ".[%s%)%]%}]"
		local quote_neigh = "[^%a\\][%s%)%]%}]"
		require("mini.pairs").setup({
			mappings = {
				["("] = { action = "open", pair = "()", neigh_pattern = bracket_neigh, register = { cr = false } },
				["["] = { action = "open", pair = "[]", neigh_pattern = bracket_neigh, register = { cr = false } },
				["{"] = { action = "open", pair = "{}", neigh_pattern = bracket_neigh, register = { cr = false } },

				['"'] = { action = "open", pair = '""', neigh_pattern = quote_neigh, register = { cr = false } },
				["'"] = { action = "open", pair = "''", neigh_pattern = quote_neigh, register = { cr = false } },
				["`"] = { action = "open", pair = "``", neigh_pattern = quote_neigh, register = { cr = false } },
			},
		})

		-- File explorer (toggle with '-')
		-- Allows file editing (press '=' to save changes)
		require("mini.files").setup()
		vim.keymap.set("n", "-", function()
			local bufname = vim.api.nvim_buf_get_name(0)
			local _ = MiniFiles.close() or MiniFiles.open(bufname, false)
		end, { desc = "Toggle Mini Files" })

		-- Statusline.
		local statusline = require("mini.statusline")
		statusline.setup({ use_icons = vim.g.have_nerd_font })

		-- Setting the section for cursor location to LINE:COLUMN
		---@diagnostic disable-next-line: duplicate-set-field
		statusline.section_location = function()
			return "%2l:%-2v"
		end
	end,
}
