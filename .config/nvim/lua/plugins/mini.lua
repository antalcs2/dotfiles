-- https://github.com/echasnovski/mini.nvim
-- Various utility plugins
return {
	"echasnovski/mini.nvim",
	lazy = false,
	priority = 100,
	version = "*",
	dependencies = {
		-- https://github.com/MaximilianLloyd/ascii.nvim
		-- Cool ASCII art for starter header
		{ "MaximilianLloyd/ascii.nvim" },
		{ "MunifTanjim/nui.nvim" },

		-- https://github.com/nvim-tree/nvim-web-devicons
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		-- -- -- -- Around/Inside textobjects -- -- -- --
		--
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]parentesys
		--  - yinq - [Y]ank [I]nside [N]ext [']quote
		--  - ci'  - [C]hange [I]nside [']quote
		require("mini.ai").setup({ n_lines = 500 })

		-- -- -- -- Comment lines -- -- -- --
		require("mini.comment").setup()

		-- -- -- -- Work with diff hunks -- -- -- --
		-- toggle overlay with <leader>to
		local diff = require("mini.diff")
		diff.setup({
			view = {
				style = "number",
			},
		})
		vim.keymap.set("n", "<leader>td", function()
			diff.toggle_overlay(0)
		end, { desc = "[T]oggle Mini[D]iff overlay" })

		-- -- -- -- File explorer -- -- -- --
		-- toggle with '-', press '=' to save changes
		require("mini.files").setup()
		vim.keymap.set("n", "-", function()
			local bufname = vim.api.nvim_buf_get_name(0)
			local _ = MiniFiles.close() or MiniFiles.open(bufname, false)
		end, { desc = "Toggle Mini Files" })

		-- -- -- -- Move selection in any direction -- -- -- --
		-- move selection or line in normal mode with Alt + hjkl
		require("mini.move").setup()

		-- -- -- -- Adds automatically closing pair to brackets and quotes -- -- -- --
		local bracket_neigh = ".[%s%)%]%}%\"%'%`]"
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

		-- -- -- -- Startup menu -- -- -- --
		local starter = require("mini.starter")
		local ascii = require("ascii")
		starter.setup({
			header = table.concat(ascii.get_random("text", "neovim"), "\n"),
			footer = os.date(), -- TODO: make date dynamic
			items = {
				starter.sections.builtin_actions(),
				starter.sections.recent_files(10, true),
				starter.sections.recent_files(5, false),
			},
			content_hooks = {
				starter.gen_hook.adding_bullet("> "),
				starter.gen_hook.indexing("all", { "Builtin actions" }),
				starter.gen_hook.aligning("center", "center"),
			},
			query_updaters = "abcdefghijklmnopqrstuvwxyz0123456789_-.ABCDEFGHIJKLMNOPQRSTUVWXYZ",
		})

		-- -- -- -- Add/delete/replace surroundings (brackets, quotes, etc.) -- -- -- --
		--
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		require("mini.surround").setup()
	end,
}
