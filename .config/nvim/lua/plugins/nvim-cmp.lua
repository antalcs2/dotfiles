-- Autocmd to build LuaSnip
-- Has to exist before loading the plugin
vim.api.nvim_create_autocmd("PackChanged", {
	desc = "Build LuaSnip with make",
	group = vim.api.nvim_create_augroup("UserBuildLuaSnipGroup", { clear = true }),
	callback = function(ev)
		if ev.data.spec.name == "LuaSnip" and ev.data.kind == "update" then
			vim.notify("[User] Building LuaSnip", vim.log.levels.INFO)
			if vim.fn.executable("make") == 1 then
				local result = vim.system({ "make", "install_jsregexp" }, { cwd = ev.data.path }):wait()
				if result.code == 0 then
					vim.notify("[User] LuaSnip built")
				else
					vim.notify("[User] LuaSnip build failed", vim.log.levels.ERROR)
				end
			end
		end
	end,
})

vim.pack.add({
	-- Autocompletion
	"https://github.com/hrsh7th/nvim-cmp",
	-- Source modules
	"https://github.com/hrsh7th/cmp-nvim-lsp",
	"https://github.com/hrsh7th/cmp-path",
	"https://github.com/hrsh7th/cmp-buffer",

	-- Snippet engine
	{ src = "https://github.com/L3MON4D3/LuaSnip", version = "v2.4.0" },
	-- Completion source for LuaSnip
	"https://github.com/saadparwaiz1/cmp_luasnip",

	-- Pictograms for LSP completion items
	"https://github.com/onsails/lspkind.nvim",
})

-- completion menu options
vim.opt.completeopt = { "menu", "menuone", "noinsert" }
vim.opt.shortmess:append("c")

local cmp = require("cmp")

local luasnip = require("luasnip")
luasnip.config.setup({})

local lspkind = require("lspkind")
lspkind.init({})

cmp.setup({
	sources = {
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "buffer", keyword_length = 2 },
		{ name = "luasnip" },
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		-- Select previous/next item in menu
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		-- Insert selected item
		["<Tab>"] = cmp.mapping.confirm({ select = true }),

		-- Jump back/forward to snippet
		["<C-l>"] = cmp.mapping(function()
			if luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			end
		end, { "i", "s" }),

		["<C-h>"] = cmp.mapping(function()
			if luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			end
		end, { "i", "s" }),
	}),
})
