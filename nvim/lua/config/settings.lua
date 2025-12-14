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

vim.lsp.config("tailwindcss", {
	root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]),
})
