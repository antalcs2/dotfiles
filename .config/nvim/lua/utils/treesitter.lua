-- Inspired by https://github.com/iliadmitriev/neovim-mini
local M = {}

local parsers = {
	c = {
		url = "https://github.com/tree-sitter/tree-sitter-c",
		revision = "v0.24.1",
	},
	cpp = {
		url = "https://github.com/tree-sitter/tree-sitter-cpp",
		revision = "v0.23.4",
	},
	cmake = {
		url = "https://github.com/uyha/tree-sitter-cmake",
		revision = "v0.7.2",
	},
	lua = {
		url = "https://github.com/tree-sitter-grammars/tree-sitter-lua",
		revision = "v0.5.0",
	},
	make = {
		url = "https://github.com/tree-sitter-grammars/tree-sitter-make",
		revision = "v1.1.1",
	},
	markdown = {
		url = "https://github.com/tree-sitter-grammars/tree-sitter-markdown",
		revision = "v0.5.3",
		build_dir = "tree-sitter-markdown/",
	},
	markdown_inline = {
		url = "https://github.com/tree-sitter-grammars/tree-sitter-markdown",
		revision = "v0.5.3",
		build_dir = "tree-sitter-markdown-inline/",
	},
	query = {
		url = "https://github.com/tree-sitter-grammars/tree-sitter-query",
		revision = "v0.8.0",
	},
	vim = {
		url = "https://github.com/tree-sitter-grammars/tree-sitter-vim",
		revision = "v0.8.1",
	},
	vimdoc = {
		url = "https://github.com/neovim/tree-sitter-vimdoc",
		revision = "v4.1.0",
	},
}

local LOG_FILE = vim.fn.stdpath("data") .. "/tree-sitter.log"
local function log_to_file(msg)
	print(msg)

	local file = io.open(LOG_FILE, "a")
	if file then
		file:write(msg .. "\n")
		file:close()
	end
end

local function install(lang)
	local cfg = parsers[lang]

	local tmp_dir = vim.fn.tempname() .. "_ts_" .. lang

	-- Cloning the repo
	log_to_file(("Cloning %s..."):format(cfg.url))
	local clone_result = vim.system({ "git", "clone", cfg.url, tmp_dir }):wait()
	if clone_result.code ~= 0 then
		vim.fn.delete(tmp_dir, "rf")
		log_to_file("Cloning failed! Aborting!")
		return
	end

	-- Checkout revision
	if cfg.revision then
		log_to_file(("Checking out at %s..."):format(cfg.revision))
		local checkout_result = vim.system({ "git", "checkout", cfg.revision }, { cwd = tmp_dir }):wait()
		if checkout_result.code ~= 0 then
			vim.fn.delete(tmp_dir, "rf")
			log_to_file(("Checkout at %s failed! Aborting!"):format(cfg.revision))
			return
		end
	end

	-- Generate C source
	local build_dir = cfg.build_dir or "./"
	local grammar_path = build_dir .. "src/grammar.json"

	log_to_file(("Generating %s..."):format(lang))
	local generate_result = vim.system(
		{ "tree-sitter", "generate", "--abi=15", "-o", build_dir .. "src", grammar_path },
		{ cwd = tmp_dir }
	):wait()
	if generate_result.code ~= 0 then
		vim.fn.delete(tmp_dir, "rf")
		log_to_file(("Generating %s failed! Aborting!"):format(lang))
		return
	end

	-- Compile shared library
	local base_dir = vim.fn.stdpath("data") .. "/tree-sitter"
	local parser_dir = base_dir .. "/parser"
	local output_path = parser_dir .. "/" .. lang .. ".so"

	vim.fn.mkdir(parser_dir, "p")

	log_to_file(("Building %s..."):format(lang))
	local build_result = vim.system({ "tree-sitter", "build", "-o", output_path, build_dir }, { cwd = tmp_dir }):wait()
	if build_result.code ~= 0 then
		vim.fn.delete(tmp_dir, "rf")
		log_to_file(("Building %s failed! Aborting!"):format(lang))
		return
	end

	-- Copying queries from repo if they exist
	local source_queries_dir = tmp_dir .. "/" .. build_dir .. "queries"
	if vim.uv.fs_stat(source_queries_dir) then
		local dest_queries_dir = base_dir .. "/queries/" .. lang
		vim.fn.mkdir(dest_queries_dir, "p")
		vim.fn.system("cp -r " .. source_queries_dir .. "/* " .. dest_queries_dir .. "/")
		log_to_file(("Installed queries for %s"):format(lang))
	end

	-- Cleanup
	vim.fn.delete(tmp_dir, "rf")
	log_to_file(("%s successfully installed"):format(lang))
end

M.load_parser = function(lang)
	local parser_path = vim.fn.stdpath("data") .. "/tree-sitter/parser/" .. lang .. ".so"
	if not vim.uv.fs_stat(parser_path) then
		install(lang)
	end

	vim.treesitter.language.add(lang, { path = parser_path })
end

M.add_to_runtime = function()
	local rtp = vim.opt.rtp:get()
	local base_dir = vim.fn.stdpath("data") .. "/tree-sitter"

	if not vim.tbl_contains(rtp, base_dir) then
		vim.opt.rtp:append(base_dir)
	end
end

return M
