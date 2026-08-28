-- vim.cmd("set relativenumber")
vim.opt.relativenumber = true
-- vim.cmd("set number")
vim.opt.number = true

-- Fix clipboard and black screen hangs by overriding the clipboard provider
-- install something like win32yank `scoop install win32yank`
vim.opt.clipboard = "unnamedplus"
vim.opt.linebreak = true
vim.diagnostic.config({
	virtual_text = true,
})

-- indentation
vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 99  -- set the starting fold depth very high so I can see everything

vim.g.mapleader = " "
-- vim.opt.scrolloffpad = 1

vim.pack.add({
	-- { src = "https://github.com/mason-org/mason.nvim" },
	-- { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/folke/snacks.nvim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/folke/tokyonight.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/saghen/blink.lib" },
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/hedyhli/outline.nvim" },
	-- { src = "https://github.com/mfussenegger/nvim-dap" },
	-- { src = "https://codeberg.org/mfussenegger/nvim-dap-python" },

})

-- require("mason").setup()
-- require("mason-lspconfig").setup()
-- require("nvim-treesitter").setup()
-- require('nvim-treesitter').install { 'bash', 'python'}

require("oil").setup({
	columns = {
		"icon",
		-- You can customize the format string here
		{ "mtime", format = "%Y-%m-%d %H:%M" },
		-- Other optional columns you might want:
		-- "size",
		-- "permissions",
	},
})
vim.keymap.set("n", "<leader>e", ":e .<return>", { desc = "explore CWD with oil" })
vim.keymap.set("n", "<tab>", "za", { desc = "toggle fold under cursor" })

require("snacks").setup({ picker = { enabled = true }, explorer = { enabled = false } })

local cmp = require("blink.cmp")
cmp.build():pwait()
cmp.setup({
	keymap = {
		preset = "default",
		["<C-o>"] = { "show", "hide" },
		["<CR>"] = { "select_and_accept", "fallback" },
	},
	completion = { documentation = { auto_show = true } },
})
require("which-key").setup()

-- snacks picker bindings
-- Top Pickers & Explorer
vim.keymap.set("n", "<leader><space>", function()
	Snacks.picker.smart()
end, { desc = "Smart Find Files" })
vim.keymap.set("n", "<leader>,", function()
	Snacks.picker.buffers()
end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>/", function()
	Snacks.picker.grep()
end, { desc = "Grep" })
vim.keymap.set("n", "<leader>:", function()
	Snacks.picker.command_history()
end, { desc = "Command History" })
vim.keymap.set("n", "<leader>n", function()
	Snacks.picker.notifications()
end, { desc = "Notification History" })
-- find
vim.keymap.set("n", "<leader>fb", function()
	Snacks.picker.buffers()
end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fc", function()
	Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Find Config File" })
vim.keymap.set("n", "<leader>ff", function()
	Snacks.picker.files()
end, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", function()
	Snacks.picker.git_files()
end, { desc = "Find Git Files" })
vim.keymap.set("n", "<leader>fp", function()
	Snacks.picker.projects()
end, { desc = "Projects" })
vim.keymap.set("n", "<leader>fr", function()
	Snacks.picker.recent()
end, { desc = "Recent" })
-- git
vim.keymap.set("n", "<leader>gb", function()
	Snacks.picker.git_branches()
end, { desc = "Git Branches" })
vim.keymap.set("n", "<leader>gl", function()
	Snacks.picker.git_log()
end, { desc = "Git Log" })
vim.keymap.set("n", "<leader>gL", function()
	Snacks.picker.git_log_line()
end, { desc = "Git Log Line" })
vim.keymap.set("n", "<leader>gs", function()
	Snacks.picker.git_status()
end, { desc = "Git Status" })
vim.keymap.set("n", "<leader>gS", function()
	Snacks.picker.git_stash()
end, { desc = "Git Stash" })
vim.keymap.set("n", "<leader>gd", function()
	Snacks.picker.git_diff()
end, { desc = "Git Diff (Hunks)" })
vim.keymap.set("n", "<leader>gf", function()
	Snacks.picker.git_log_file()
end, { desc = "Git Log File" })
-- gh
vim.keymap.set("n", "<leader>gi", function()
	Snacks.picker.gh_issue()
end, { desc = "GitHub Issues (open)" })
vim.keymap.set("n", "<leader>gI", function()
	Snacks.picker.gh_issue({ state = "all" })
end, { desc = "GitHub Issues (all)" })
vim.keymap.set("n", "<leader>gp", function()
	Snacks.picker.gh_pr()
end, { desc = "GitHub Pull Requests (open)" })
vim.keymap.set("n", "<leader>gP", function()
	Snacks.picker.gh_pr({ state = "all" })
end, { desc = "GitHub Pull Requests (all)" })
-- Grep
vim.keymap.set("n", "<leader>sb", function()
	Snacks.picker.lines()
end, { desc = "Buffer Lines" })
vim.keymap.set("n", "<leader>sB", function()
	Snacks.picker.grep_buffers()
end, { desc = "Grep Open Buffers" })
vim.keymap.set("n", "<leader>sg", function()
	Snacks.picker.grep()
end, { desc = "Grep" })
vim.keymap.set("n", "<leader>sw", function()
	Snacks.picker.grep_word()
end, { desc = "Visual selection or word" }, { mode = { "n", "x" } })
-- search
vim.keymap.set("n", '<leader>s"', function()
	Snacks.picker.registers()
end, { desc = "Registers" })
vim.keymap.set("n", "<leader>s/", function()
	Snacks.picker.search_history()
end, { desc = "Search History" })
vim.keymap.set("n", "<leader>sa", function()
	Snacks.picker.autocmds()
end, { desc = "Autocmds" })
vim.keymap.set("n", "<leader>sb", function()
	Snacks.picker.lines()
end, { desc = "Buffer Lines" })
vim.keymap.set("n", "<leader>sc", function()
	Snacks.picker.command_history()
end, { desc = "Command History" })
vim.keymap.set("n", "<leader>sC", function()
	Snacks.picker.commands()
end, { desc = "Commands" })
vim.keymap.set("n", "<leader>sd", function()
	Snacks.picker.diagnostics()
end, { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>sD", function()
	Snacks.picker.diagnostics_buffer()
end, { desc = "Buffer Diagnostics" })
vim.keymap.set("n", "<leader>sh", function()
	Snacks.picker.help()
end, { desc = "Help Pages" })
vim.keymap.set("n", "<leader>sH", function()
	Snacks.picker.highlights()
end, { desc = "Highlights" })
vim.keymap.set("n", "<leader>si", function()
	Snacks.picker.icons()
end, { desc = "Icons" })
vim.keymap.set("n", "<leader>sj", function()
	Snacks.picker.jumps()
end, { desc = "Jumps" })
vim.keymap.set("n", "<leader>sk", function()
	Snacks.picker.keymaps()
end, { desc = "Keymaps" })
vim.keymap.set("n", "<leader>sl", function()
	Snacks.picker.loclist()
end, { desc = "Location List" })
vim.keymap.set("n", "<leader>sm", function()
	Snacks.picker.marks()
end, { desc = "Marks" })
vim.keymap.set("n", "<leader>sM", function()
	Snacks.picker.man()
end, { desc = "Man Pages" })
vim.keymap.set("n", "<leader>sp", function()
	Snacks.picker.lazy()
end, { desc = "Search for Plugin Spec" })
vim.keymap.set("n", "<leader>sq", function()
	Snacks.picker.qflist()
end, { desc = "Quickfix List" })
vim.keymap.set("n", "<leader>sR", function()
	Snacks.picker.resume()
end, { desc = "Resume" })
vim.keymap.set("n", "<leader>su", function()
	Snacks.picker.undo()
end, { desc = "Undo History" })
vim.keymap.set("n", "<leader>uC", function()
	Snacks.picker.colorschemes()
end, { desc = "Colorschemes" })
-- LSP
vim.keymap.set("n", "gd", function()
	Snacks.picker.lsp_definitions()
end, { desc = "Goto Definition" })
vim.keymap.set("n", "gD", function()
	Snacks.picker.lsp_declarations()
end, { desc = "Goto Declaration" })
vim.keymap.set("n", "gr", function()
	Snacks.picker.lsp_references()
end, { nowait = true, desc = "References" })
vim.keymap.set("n", "gI", function()
	Snacks.picker.lsp_implementations()
end, { desc = "Goto Implementation" })
vim.keymap.set("n", "gy", function()
	Snacks.picker.lsp_type_definitions()
end, { desc = "Goto T[y]pe Definition" })
vim.keymap.set("n", "gai", function()
	Snacks.picker.lsp_incoming_calls()
end, { desc = "C[a]lls Incoming" })
vim.keymap.set("n", "gao", function()
	Snacks.picker.lsp_outgoing_calls()
end, { desc = "C[a]lls Outgoing" })
vim.keymap.set("n", "<leader>ss", function()
	Snacks.picker.lsp_symbols()
end, { desc = "LSP Symbols" })
vim.keymap.set("n", "<leader>sS", function()
	Snacks.picker.lsp_workspace_symbols()
end, { desc = "LSP Workspace Symbols" })

-- setting up conform.nvim
-- this plugin actually calls the formatters that I've installed with mason
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- -- Conform will run multiple formatters sequentially
		python = { "basedpyright" },
		-- -- You can customize some of the format options for the filetype (:help conform.format)
		-- rust = { "rustfmt", lsp_format = "fallback" },
		-- -- Conform will run the first available formatter
		-- javascript = { "prettierd", "prettier", stop_after_first = true },
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

-- tokyonight setup
require("tokyonight").setup({
	-- use the night style
	style = "night",
	-- disable italic for functions
	styles = {
		functions = {},
	},
	-- Change the "hint" color to the "orange" color, and make the "error" color bright red
	on_colors = function(colors)
		colors.hint = colors.orange
		colors.error = "#ff0000"
		colors.bg = "#000000"
		colors.fg = "#ffffff"
	end,
})

vim.cmd("colorscheme tokyonight-night")

-- personal commands/functions
vim.keymap.set("n", "<leader>it", function()
	vim.api.nvim_put({ os.date() }, "c", true, true)
end, { desc = "insert date timestamp" })
require("outline").setup({})
vim.keymap.set("n", "<leader>oo", "<cmd>Outline<CR>", { desc = "Toggle Outline" })

--- LSP
--- pipx install jedi-language-server
-- vim.lsp.enable('jedi_language_server')
vim.lsp.enable("basedpyright")
-- vim.lsp.enable("ruff")
vim.lsp.enable("lua_ls")

-- Bindings
-- exit insert mode in terminal mode with escape
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])
vim.keymap.set("t", "<C-Space>", [[<C-\><C-n>]])

-- window management
vim.keymap.set("n", "<leader>ws", ":split<return>")
vim.keymap.set("n", "<leader>wc", ":close<return>")

vim.keymap.set("n", "<leader>tn", ":tabnext<return>", { desc = "next tab" })
vim.keymap.set("n", "<leader>tp", ":tabprevious<return>", { desc = "previous tab" })
vim.keymap.set("n", "<leader>tc", ":tabnew<return>", { desc = "create tab" })

vim.keymap.set("n", "<leader>oe", vim.diagnostic.setloclist, { desc = "open errors panel" })

-- Standard modern Neovim keymap configuration
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Refactor: Rename symbol" })

-- TESTING
-- Enable autoread to reload files changed outside Neovim
vim.opt.autoread = true

-- Trigger checktime to refresh buffers when focus changes or cursor moves
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
	pattern = "*",
	callback = function()
		if vim.fn.mode() ~= "c" then
			vim.cmd("checktime")
		end
	end,
})

-- TODO: seamless nvim/tmux? ctrl+space in both?
