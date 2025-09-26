vim.pack.add({
	-- LSP Configuration
	"https://github.com/neovim/nvim-lspconfig",

	-- nvim-cmp source for the LSP client
	"https://github.com/hrsh7th/cmp-nvim-lsp",

	-- UI for LSP progress messages
	"https://github.com/j-hui/fidget.nvim",
})

-- disable underlining error
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { underline = false })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarning", { underline = false })

require("fidget").setup({})

local servers = {
	clangd = {
		filetypes = { "c", "cpp", "objc", "objcpp" },
	},
	cmake = {},
	lua_ls = {
		settings = {
			Lua = {
				completion = {
					callSnippet = "Replace",
				},
				diagnostics = { disable = { "missing-fields" }, globals = { "vim" } },
				hint = { enable = true },
				telemetry = { enable = false },

				-- NOTE: https://github.com/neovim/nvim-lspconfig/blob/master/lsp/lua_ls.lua
				runtime = {
					version = "LuaJIT",
					path = {
						"lua/?.lua",
						"lua/?/init.lua",
					},
					pathStrict = true,
				},
				workspace = {
					checkThirdParty = false,
					library = vim.tbl_filter(function(d)
						return not d:match(vim.fn.stdpath("config") .. "/?a?f?t?e?r?")
					end, vim.api.nvim_get_runtime_file("lua", true)),
				},
			},
		},
	},
}
-- acquaring cmp_nvim_lsp's capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()

for server, settings in pairs(servers) do
	settings.capabilities = capabilities
	vim.lsp.config(server, settings)
end

-- Autocmd executed when the LSP attaches to a buffer
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "",
	group = vim.api.nvim_create_augroup("UserLspAttachGroup", { clear = true }),
	callback = function(ev)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
		end

		map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
		map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
		map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
		map("gtd", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype [D]efinition")

		map("<leader>r", vim.lsp.buf.rename, "[R]ename")
		map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
		map("K", vim.lsp.buf.hover, "Hover Documentation")

		-- Word highlighting
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client and client.server_capabilities.documentHighlightProvider then
			local highlight_augroup = vim.api.nvim_create_augroup("UserLspHighlightGroup", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				desc = "Highlight word when cursor stays over it",
				group = highlight_augroup,
				buffer = ev.buf,
				callback = vim.lsp.buf.document_highlight,
			})
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				desc = "Clear highlight when cursor moves",
				group = highlight_augroup,
				buffer = ev.buf,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("UserLspDetachGroup", { clear = true }),
				callback = function(ev2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = highlight_augroup, buffer = ev2.buf })
				end,
			})
		end

		-- Inlay hints
		if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end, "[T]oggle Inlay [H]ints")
		end
	end,
})

local lsp_to_mason_names = {
	clangd = "clangd",
	cmake = "cmake-language-server",
	lua_ls = "lua-language-server",
}

local to_install = {}
for server, _ in pairs(servers) do
	table.insert(to_install, lsp_to_mason_names[server] or server)
end

return { to_install = to_install, servers = vim.tbl_keys(servers or {}) }
