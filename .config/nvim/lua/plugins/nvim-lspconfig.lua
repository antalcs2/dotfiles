vim.pack.add({
	-- LSP Configuration
	"https://github.com/neovim/nvim-lspconfig",

	-- UI for LSP progress messages
	"https://github.com/j-hui/fidget.nvim",
})

-- disable underlining error
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { underline = false })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarning", { underline = false })

require("fidget").setup({})

-- Autocmd executed when the LSP attaches to a buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspAttachGroup", { clear = true }),
	callback = function(ev)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
		end

		local ok, builtin = pcall(require, "telescope.builtin")
		if ok then
			map("gd", builtin.lsp_definitions, "[G]oto [D]efinition")
			map("gr", builtin.lsp_references, "[G]oto [R]eferences")
			map("gtd", builtin.lsp_type_definitions, "[G]oto [T]ype [D]efinition")
		end
		map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

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
