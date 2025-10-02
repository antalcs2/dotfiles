local M = {}

-- Got from: https://github.com/neovim/nvim-lspconfig/blob/master/lsp/clangd.lua
local function switch_source_header(bufnr, client, editcmd)
	local method_name = "textDocument/switchSourceHeader"
	---@diagnostic disable-next-line:param-type-mismatch
	if not client or not client:supports_method(method_name) then
		return vim.notify(
			("method %s is not supported by any servers active on the current buffer"):format(method_name)
		)
	end
	local params = vim.lsp.util.make_text_document_params(bufnr)
	---@diagnostic disable-next-line:param-type-mismatch
	client:request(method_name, params, function(err, result)
		if err then
			error(tostring(err))
		end
		if not result then
			vim.notify("corresponding file cannot be determined")
			return
		end
		vim.cmd(editcmd .. " " .. vim.uri_to_fname(result))
	end, bufnr)
end

---@type vim.lsp.Config
M.Config = {
	filetypes = { "c", "cpp", "objc", "objcpp" },

	on_attach = function(client, bufnr)
		vim.api.nvim_buf_create_user_command(bufnr, "UserLspSwitchSrcHead", function()
			switch_source_header(bufnr, client, "edit")
		end, { desc = "Switch between source/header" })

		vim.keymap.set("n", "<leader>h", vim.cmd.UserLspSwitchSrcHead, { desc = "LSP: Switch between source / header" })

		vim.api.nvim_buf_create_user_command(bufnr, "UserLspOpenSrcHead", function()
			switch_source_header(bufnr, client, "leftabove vsplit")
		end, { desc = "Open header and source side by side" })

		vim.keymap.set(
			"n",
			"<leader>op",
			vim.cmd.UserLspOpenSrcHead,
			{ desc = "LSP: Open header and source side by side" }
		)
	end,
}

M.mason_name = "clangd"

return M
