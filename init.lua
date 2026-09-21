-- vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.linebreak = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.timeoutlen = 100 -- show me things FAST
vim.cmd.colorscheme("lunaperche")

-- plugins
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

vim.diagnostic.config({
	virtual_text = true, -- Show errors inline
	signs = true, -- Show error icons in the sign column
	update_in_insert = false,
	underline = true,
	severity_sort = true,
})

local wk = require("which-key")

wk.add({
	-- 1. Define the Group Label for <space>d
	{ "<leader>d", group = "Diagnostics", mode = "n" },

	-- 2. Diagnostic Mappings under <space>d
	{
		"<leader>df",
		vim.diagnostic.open_float,
		desc = "Open Floating Diagnostic",
		mode = "n",
		silent = true,
	},
	{
		"<leader>dp",
		vim.diagnostic.setqflist,
		desc = "Open Diagnostic Quickfix",
		mode = "n",
		silent = true,
	},

	-- 3. Navigation Mappings (Outside the prefix group, but still tracked)
	{
		"]d",
		function()
			vim.diagnostic.jump({
				count = 1,
				on_jump = function()
					vim.diagnostic.open_float({ focus = false })
				end,
			})
		end,
		desc = "Next Diagnostic",
		mode = "n",
	},
	{
		"[d",
		function()
			vim.diagnostic.jump({
				count = -1,
				on_jump = function()
					vim.diagnostic.open_float({ focus = false })
				end,
			})
		end,
		desc = "Previous Diagnostic",
		mode = "n",
	},
})

vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 99 -- set the starting fold depth very high so I can see everything

vim.g.mapleader = " "
-- vim.opt.scrolloffpad = 1
-- vim.opt.scrolloff = 999

require("fzf-lua").setup()

wk.add({
	{ "<leader>s", group = "Search", mode = "n" },
	{
		"<leader><leader>",
		FzfLua.global,
		mode = "n",
		silent = true,
	},
	{
		"<leader>sf",
		FzfLua.files,
		desc = "search files",
		silent = true,
		mode = "n",
	},
	{
		"<leader>sg",
		FzfLua.live_grep,
		desc = "search files",
		mode = "n",
		silent = true,
	},
	{
		"<leader>ss",
		FzfLua.lsp_document_symbols,
		desc = "search document symbols",
		mode = "n",
		silent = true,
	},
	{
		"<leader>sb",
		FzfLua.buffers,
		desc = "search buffers",
		mode = "n",
		silent = true,
	},
	{
		"<leader>sj",
		FzfLua.jumps,
		desc = "search jumps",
		mode = "n",
		silent = true,
	},
})

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

vim.lsp.enable("bashls")
vim.lsp.config.bashls = {
	cmd = { "bash-language-server", "start" },
	filetypes = { "bash", "sh" },
}

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

-- TESTING
-- vim.keymap.set('n', '<leader>gd', diffview.open, { desc= 'git diff view'})
--
-- Copy file path / selection reference for pasting into AI chats
local function copy_ref(opts)
	-- "%" is the current buffer's file name; ":." makes it relative to the cwd
	local path = vim.fn.expand("%:.")
	-- ref is what ends up in the clipboard; start with just the path
	local ref = path

	if opts.visual then
		-- '< and '> are only set after leaving visual mode, so read the live selection:
		-- "v" is the line where visual mode was started (the anchor)
		local start_line = vim.fn.line("v")
		-- "." is the line the cursor is on now (the moving end of the selection)
		local end_line = vim.fn.line(".")
		-- if the selection was made upward, swap so start is always the smaller line
		if start_line > end_line then
			start_line, end_line = end_line, start_line
		end
		-- append the range, e.g. "lua/config/keymaps.lua:1:23"
		ref = path .. ":" .. start_line .. ":" .. end_line
	end

	-- ask for an optional free-text note on the command line (Enter to skip)
	local note = vim.fn.input("Prompt (optional): ")
	if note ~= "" then
		-- append the note after the ref, separated by a space
		ref = ref .. " " .. note
	end

	-- write ref into the "+" register, which is the system clipboard
	vim.fn.setreg("+", ref)
	-- show a confirmation message with what was copied
	vim.notify("Copied: " .. ref)
end

-- normal mode: copy just the file path
vim.keymap.set("n", "<leader>cp", function()
	copy_ref({})
end, { desc = "Copy file path" })

-- visual mode: copy the file path plus the selected line range
vim.keymap.set("v", "<leader>cp", function()
	copy_ref({ visual = true })
end, { desc = "Copy file path with line range" })
-- TODO: :set virtualedit=all for navigating
