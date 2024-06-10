-- https://github.com/hrsh7th/nvim-cmp
-- Autocompletion
return {
	"hrsh7th/nvim-cmp",
	lazy = false,
	priority = 100,
	dependencies = {
		-- https://github.com/L3MON4D3/LuaSnip
		{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
		"saadparwaiz1/cmp_luasnip",

		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-buffer",

		"onsails/lspkind.nvim",
	},
	config = function()
		vim.opt.completeopt = { "menu", "menuone", "noinsert" }
		vim.opt.shortmess:append("c")

		local cmp = require("cmp")

		local luasnip = require("luasnip")
		luasnip.config.setup({})

		local lspkind = require("lspkind")
		lspkind.init({})

		cmp.setup({
			sources = {
				{ name = "luasnip" },
				{ name = "nvim_lsp" },
				{ name = "path" },
				{ name = "buffer", keyword_length = 2 },
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
	end,
}
