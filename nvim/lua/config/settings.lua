-- Leader
vim.g.mapleader = " "

-- Indentation
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- Diagnostic
vim.diagnostic.config({
	virtual_text = true,
	signs = false,
})

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

-- Hide ~ (end-of-buffer) characters
vim.opt.fillchars:append({ eob = " " })

-- Clean dashboard (no numbers, no cursorline)
vim.api.nvim_create_autocmd("FileType", {
	pattern = "snacks_dashboard",
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.cursorline = false
		vim.opt_local.signcolumn = "no"
	end,
})

-- Theme
vim.cmd.colorscheme("catppuccin")
vim.opt.termguicolors = true

-- Configure LSP servers
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

vim.lsp.config("ts_ls", {
	on_attach = function(client)
		client.server_capabilities.documentFormattingProvider = false
	end,
})

vim.lsp.config("tailwindcss", {
	root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]),
})
