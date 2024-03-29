local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)

-- local function setCodeLensHighlight(highlight)
-- 	vim.api.nvim_set_hl(0, "LspCodeLens", { link = highlight })
-- 	vim.api.nvim_set_hl(0, "LspCodeLensText", { link = highlight })
-- 	vim.api.nvim_set_hl(0, "LspCodeLensSign", { link = highlight })
-- 	vim.api.nvim_set_hl(0, "LspCodeLensSeparator", { link = "Boolean" })
-- end

M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_text = false,
		signs = {
			active = signs, -- show signs
			severity_limit = "Hint",
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})

	-- setCodeLensHighlight("Comment")
end

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	local keymap = vim.api.nvim_buf_set_keymap
	keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap(bufnr, "n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
	keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	keymap(bufnr, "n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts)
	keymap(bufnr, "n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
	keymap(bufnr, "n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
	keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<cr>", opts)
	keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts)
	keymap(bufnr, "n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
	keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
	keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
	keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
	keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
	keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

	local status_ok, wk = pcall(require, "which-key")
	if not status_ok then
		return
	end
	local wkopts = {
		mode = "n", -- NORMAL mode
		prefix = "<leader>t",
		buffer = bufnr,
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = true, -- use `nowait` when creating keymaps
	}

	local mappings = {
		t = { "<cmd>lua require('neotest').run.run(vim.fn.getcwd())<cr>", "Test Suite" },
		f = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", "Test File" },
		n = { "<cmd>lua require('neotest').run.run()<cr>", "Test Nearest" },
		e = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Summary" },
		j = { "<cmd>lua require('neotest').jump.next({ status = 'failed' })<cr>", "Jump to Next" },
		k = { "<cmd>lua require('neotest').jump.prev({ status = 'failed' })<cr>", "Jump to Previous" },
	}

	wk.register(mappings, wkopts)
end

M.lsp_keymaps = function(bufnr)
	lsp_keymaps(bufnr)
end

M.on_attach = function(client, bufnr)
	if client.name == "tsserver" then
		client.server_capabilities.documentFormattingProvider = false
	end

	if client.name == "sumneko_lua" then
		client.server_capabilities.documentFormattingProvider = false
	end

	if client.name == "gopls" then
		client.server_capabilities.documentFormattingProvider = false
	end

	if client.name == "taplo" then
		client.server_capabilities.documentFormattingProvider = false
	end

	lsp_keymaps(bufnr)
	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end
	illuminate.on_attach(client)

	local signature_ok, lsp_signature = pcall(require, "lsp_signature")
	if not signature_ok then
		return
	end
	lsp_signature.on_attach({
		bind = true, -- This is mandatory, otherwise border config won't get registered.
		handler_opts = {
			border = "rounded",
		},
	}, bufnr)
end

return M
