vim.pack.add({
	-- Statusline plugin
	"https://github.com/nvim-lualine/lualine.nvim",

	-- Colorscheme, using its colors
	"https://github.com/ellisonleao/gruvbox.nvim",
})

-- -- -- -- Using gruvbox's colorpalette -- -- -- --
local colors = require("gruvbox").palette
colors["white"] = "#ffffff"
local mode_color = colors.white
local bg_color = colors.dark1

-- -- -- -- Custom theme -- -- -- --
local b = { fg = colors.light4, bg = bg_color }
local c = { fg = colors.white, bg = bg_color }

local gruvbox_custom = {
	normal = {
		a = { fg = mode_color, bg = colors.bright_blue, gui = "bold" },
		b = b,
		c = c,
	},
	insert = {
		a = { fg = mode_color, bg = colors.bright_green, gui = "bold" },
		b = b,
		c = c,
	},
	visual = {
		a = { fg = mode_color, bg = colors.bright_purple, gui = "bold" },
		b = b,
		c = c,
	},
	replace = {
		a = { fg = mode_color, bg = colors.bright_red, gui = "bold" },
		b = b,
		c = c,
	},
	command = {
		a = { fg = mode_color, bg = colors.bright_yellow, gui = "bold" },
		b = b,
		c = c,
	},
	inactive = {
		a = { fg = colors.light4, bg = "None", gui = "bold" },
		b = b,
		c = c,
	},
}

-- -- -- -- Diff -- -- -- --
vim.api.nvim_set_hl(0, "LualineDiffAdd", { fg = colors.bright_green, bg = bg_color })
vim.api.nvim_set_hl(0, "LualineDiffChange", { fg = colors.bright_blue, bg = bg_color })
vim.api.nvim_set_hl(0, "LualineDiffDelete", { fg = colors.bright_red, bg = bg_color })
local diff = {
	"diff",
	diff_color = {
		added = "LualineDiffAdd",
		modified = "LualineDiffChange",
		removed = "LualineDiffDelete",
	},
	symbols = {
		added = " ",
		modified = " ",
		removed = " ",
	},
	source = function()
		local minidiff = vim.b.minidiff_summary
		if minidiff then
			return {
				added = minidiff.add,
				modified = minidiff.change,
				removed = minidiff.delete,
			}
		else
			return nil
		end
	end,
}

-- -- -- -- Filename -- -- -- --
local filename = {
	"filename",
	newfile_status = true,
	symbols = {
		modified = "●",
		readonly = " ",
		unnamed = " ",
		newfile = " ",
	},
}

-- -- -- -- Diagnostics -- -- -- --
vim.api.nvim_set_hl(0, "LualineDiagnosticError", { fg = colors.bright_red, bg = bg_color })
vim.api.nvim_set_hl(0, "LualineDiagnosticWarn", { fg = colors.bright_yellow, bg = bg_color })
vim.api.nvim_set_hl(0, "LualineDiagnosticInfo", { fg = colors.bright_blue, bg = bg_color })
vim.api.nvim_set_hl(0, "LualineDiagnosticHint", { fg = colors.bright_green, bg = bg_color })
local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	diagnostics_color = {
		error = "LualineDiagnosticError",
		warn = "LualineDiagnosticWarn",
		info = "LualineDiagnosticInfo",
		hint = "LualineDiagnosticHint",
	},
	symbols = {
		error = " ",
		warn = " ",
		info = " ",
		hint = " ",
	},
}

-- -- -- Main setup -- -- -- --
require("lualine").setup({
	options = {
		theme = gruvbox_custom,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", diff },
		lualine_c = { filename },
		lualine_x = { diagnostics },
		lualine_y = { "filetype", "encoding", "filesize" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { filename },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
})
