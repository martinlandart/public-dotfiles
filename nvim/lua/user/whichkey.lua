local status_ok, wk = pcall(require, "which-key")
if not status_ok then
	return
end

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local vopts = {
	mode = "v", -- VISUAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local vmappings = {
	["/"] = { "<ESC><CMD>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", "Comment" },
}

local mappings = {
	b = { ":Telescope buffers<CR>", "Telescope Buffers" },
	d = {
		b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
		c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
		i = { "<cmd>lua require'dap'.step_into()<cr>", "Step into" },
		o = { "<cmd>lua require'dap'.step_over()<cr>", "Step over" },
		O = { "<cmd>lua require'dap'.step_out()<cr>", "Step out" },
		r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "REPL" },
		l = { "<cmd>lua require'dap'.run_last()<cr>", "Run Last" },
		u = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
		t = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
	},
	["f"] = { "<cmd>Telescope find_files<cr>", "Find File" },
	["/"] = { "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", "Comment" },
	e = { ":NvimTreeToggle<CR>", "NvimTree" },
	w = { "<cmd>w!<CR>", "Save" },
	h = { "<cmd>nohlsearch<CR>", "Clear highlights" },
	c = { "<cmd>Bdelete!<CR>", "Close buffer" },
	p = {
		name = "Packer",
		c = { "<cmd>PackerCompile<cr>", "Compile" },
	},
	t = {
		name = "go",
		b = { "<cmd>GoBuild<cr>", "Build" },
		t = { "<cmd>GoTest<cr>", "Test" },
		l = { "<cmd>GoLint<cr>", "Lint" },
		n = { "<cmd>GoTest -n<cr>", "Test Nearest" },
		s = { "<cmd>GoTest -s<cr>", "Test Suite" },
		c = { "<cmd>GoCoverage<cr>", "Coverage" },
		f = { "<cmd>GoTestFunc<cr>", "Test Function" },
		a = { "<cmd>GoAlt<cr>", "Alternate File" },
	},
	g = {
		name = "Git",
		j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
		k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
		l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
		p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		u = {
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			"Undo Stage Hunk",
		},
		o = { "<cmd>Telescope git_status<cr>", "Status" },
		b = { "<cmd>Telescope git_branches<cr>", "Branches" },
		c = { "<cmd>Telescope git_commits<cr>", "Commits" },
		C = {
			"<cmd>Telescope git_bcommits<cr>",
			"Commits for current file",
		},
		d = {
			"<cmd>Gitsigns diffthis HEAD<cr>",
			"Git Diff",
		},
		g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Toggle Lazygit" },
	},
	r = {
		name = "Rust",
		h = {
			name = "Hints",
			h = { "<cmd>RustSetInlayHints<Cr>", "Set Inlay Hints" },
			d = { "<cmd>RustDisableInlayHints<Cr>", "Disable Inlay Hints" },
			t = { "<cmd>RustToggleInlayHints<Cr>", "Toggle Inlay Hints" },
		},
		r = { "<cmd>RustRunnables<Cr>", "Runnables" },
		e = { "<cmd>RustExpandMacro<Cr>", "Expand Macro" },
		c = { "<cmd>RustOpenCargo<Cr>", "Open Cargo" },
		p = { "<cmd>RustParentModule<Cr>", "Parent Module" },
		j = { "<cmd>RustJoinLines<Cr>", "Join Lines" },
		f = {
			name = "Hover",
			a = { "<cmd>RustHoverActions<Cr>", "Hover Actions" },
			r = { "<cmd>RustHoverRange<Cr>", "Hover Range" },
		},
		m = {
			name = "Move Item",
			d = { "<cmd>RustMoveItemDown<Cr>", "Move Item Down" },
			u = { "<cmd>RustMoveItemUp<Cr>", "Move Item Up" },
		},
		b = { "<cmd>RustStartStandaloneServerForBuffer<Cr>", "Start Standalone Server For Buffer" },
		d = { "<cmd>RustDebuggables<Cr>", "Debuggables" },
		v = { "<cmd>RustViewCrateGraph<Cr>", "View Crate Graph" },
		w = { "<cmd>RustReloadWorkspace<Cr>", "Reload Workspace" },
		s = { "<cmd>RustSSR<Cr>", "SSR" },
		x = { "<cmd>RustOpenExternalDocs<Cr>", "External Docs" },
	},
	s = {
		name = "Search",
		g = {
			name = "Git",
			b = { "<cmd>Telescope git_branches<cr>", "Branches" },
			f = { "<cmd>Telescope git_files<cr>", "Files" },
		},
		f = { "<cmd>Telescope builtin.current_buffer_fuzzy_find<cr>", "Current Buffer" },
		c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
		h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
		H = { "<cmd>Telescope highlights<cr>", "Find Highlight Groups" },
		M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
		R = { "<cmd>Telescope registers<cr>", "Registers" },
		t = { "<cmd>Telescope live_grep<cr>", "Text" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		C = { "<cmd>Telescope commands<cr>", "Commands" },
		s = { "<cmd>Telescope treesitter<cr>", "Symbols" },
		p = {
			"<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<cr>",
			"Colorscheme with Preview",
		},
	},
	T = {
		name = "Treesitter",
		i = { ":TSConfigInfo<cr>", "Info" },
	},
	z = {
		name = "Trouble",
		x = { "<cmd>TroubleToggle<cr>" },
		w = { "<cmd>TroubleToggle workspace_diagnostics<cr>" },
		d = { "<cmd>TroubleToggle document_diagnostics<cr>" },
		q = { "<cmd>TroubleToggle quickfix<cr>" },
		l = { "<cmd>TroubleToggle loclist<cr>" },
	},
	["<S-l"] = { ":bnext<CR>" },
}

wk.register(mappings, opts)
wk.register(vmappings, vopts)
