-- vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.linebreak = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.cmd.colorscheme("lunaperche")

vim.diagnostic.config({
	virtual_text = true, -- Show errors inline
	signs = true, -- Show error icons in the sign column
	update_in_insert = false,
	underline = true,
	severity_sort = true,
})

-- Keymap to open error messages in a floating window
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { silent = true, desc = "Open diagnostic" })

-- Next diagnostic
vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({
		count = 1,
		-- float = true, -- DEPRECATED
		on_jump = function()
			vim.diagnostic.open_float({ focus = false })
		end,
	})
end, { desc = "Next Diagnostic" })

-- Previous diagnostic
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({
		count = -1,
		on_jump = function()
			vim.diagnostic.open_float({ focus = false })
		end,
	})
end, { desc = "Previous Diagnostic" })

vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 99 -- set the starting fold depth very high so I can see everything

vim.g.mapleader = " "
-- vim.opt.scrolloffpad = 1
-- vim.opt.scrolloff = 999

vim.pack.add({
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/folke/tokyonight.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/saghen/blink.lib" },
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/hedyhli/outline.nvim" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/sindrets/diffview.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-tree/nvim-tree.lua" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	-- { src = "https://github.com/mfussenegger/nvim-dap" },
	-- { src = "https://codeberg.org/mfussenegger/nvim-dap-python" },
})

require("fzf-lua").setup()

vim.keymap.set("n", "<leader><space>", FzfLua.global, { desc = "fzf global" })
vim.keymap.set("n", "<leader>ff", FzfLua.files, { desc = "fzf files" })
vim.keymap.set("n", "<leader>fg", FzfLua.live_grep, { desc = "fzf files" })
vim.keymap.set("n", "<leader>fs", FzfLua.lsp_document_symbols, { desc = "fzf document symbols" })
vim.keymap.set("n", "<leader>fb", FzfLua.buffers, { desc = "fzf buffers" })
vim.keymap.set("n", "<leader>fj", FzfLua.jumps, { desc = "fzf jumps" })

vim.keymap.set("n", "gd", FzfLua.lsp_definitions, { desc = "goto defintion" })

vim.keymap.set("n", "<leader>fc", function()
	vim.cmd.edit(vim.fn.stdpath("config") .. "/init.lua")
end, { desc = "Find (and edit) config file" })

require("mason").setup()
require("mason-lspconfig").setup()

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
-- vim.keymap.set("n", "<leader>e", ":e .<return>", { desc = "explore CWD with oil" })

-- GIT stuff
require("diffview").setup()

-- Folding
-- vim.keymap.set("n", "za", { desc = "toggle fold under cursor" })

-- require("snacks").setup({ picker = { enabled = true }, explorer = { enabled = false } })

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

-- LSP and Formatting
-- vim.lsp.enable("basedpyright")
-- vim.lsp.enable("shellcheck")
-- vim.lsp.enable("marksman")
--
-- vim.lsp.config.marksman = {
-- 	cmd = { 'marksman' },
-- 	filetypes = { 'markdown' }
-- }
--
-- vim.lsp.config.bashls = {
-- 	cmd = { 'bash-language-server', 'start' },
-- 	filetypes = { 'bash', 'sh' }
-- }
-- vim.lsp.enable 'bashls'
--
-- Overrides the mason-lspconfig settings?
vim.lsp.enable("lua_ls")
vim.lsp.config.lua_ls = {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", "FzfLua" },
			},
		},
	},
}

-- vim.lsp.enable("ruff")
vim.keymap.set("n", "<leader>lr", "<cmd>lsp restart<CR>", { desc = "restart lsp" })

-- setting up conform.nvim
-- this plugin actually calls the formatters that I've installed with mason
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- -- Conform will run multiple formatters sequentially
		python = { "ruff" },
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
-- require("tokyonight").setup({
-- 	-- use the night style
-- 	style = "night",
-- 	-- disable italic for functions
-- 	styles = {
-- 		functions = {},
-- 	},
-- 	-- Change the "hint" color to the "orange" color, and make the "error" color bright red
-- 	on_colors = function(colors)
-- 		colors.hint = colors.orange
-- 		colors.error = "#ff0000"
-- 		colors.bg = "#000000"
-- 		colors.fg = "#eeeeee"
-- 	end,
-- })
-- vim.cmd("colorscheme tokyonight-night")

vim.keymap.set("n", "<leader>it", function()
	vim.api.nvim_put({ os.date() }, "c", true, true)
end, { desc = "insert date timestamp" })

-- UI
require("outline").setup({})
vim.keymap.set("n", "<leader>uo", "<cmd>Outline<CR>", { desc = "Toggle outline" })

require("nvim-tree").setup()
-- vim.api.nvim_set_hl(0, "NvimTreeHighlights")

vim.keymap.set("n", "<leader>ut", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })

vim.keymap.set("n", "<leader>ue", vim.diagnostic.setloclist, { desc = "open errors panel" })

-- Bindings
-- exit insert mode in terminal mode with escape
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])
vim.keymap.set("t", "<C-Space>", [[<C-\><C-n>]])

-- window management
vim.keymap.set("n", "<leader>ws", ":split<return>")
vim.keymap.set("n", "<leader>wv", ":vsplit<return>")
vim.keymap.set("n", "<leader>wc", ":close<return>")

vim.keymap.set("n", "<leader>tn", ":tabnext<return>", { desc = "next tab" })
vim.keymap.set("n", "<leader>tp", ":tabprevious<return>", { desc = "previous tab" })
vim.keymap.set("n", "<leader>tc", ":tabnew<return>", { desc = "create tab" })

-- TESTING THIS
vim.api.nvim_create_autocmd("DiagnosticChanged", {
	callback = function()
		vim.diagnostic.setloclist({ open = false })
	end,
})

-- Standard modern Neovim keymap configuration
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Refactor: Rename symbol" })

-- TESTING
-- Enable autoread to reload files changed outside Neovim
vim.opt.autoread = true

-- Trigger checktime to refresh buffers when focus changes or cursor moves
-- don't need this in 0.13!
-- vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
-- 	pattern = "*",
-- 	callback = function()
-- 		if vim.fn.mode() ~= "c" then
-- 			vim.cmd("checktime")
-- 		end
-- 	end,
-- })

-- TESTING
-- vim.keymap.set('n', '<leader>gd', diffview.open, { desc= 'git diff view'})
-- TODO: :set virtualedit=all for navigating
