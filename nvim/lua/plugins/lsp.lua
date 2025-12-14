return {
	{
		"mason-org/mason.nvim",
		name = "mason",
		opts = {},
		config = function()
			require("mason").setup()
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		name = "mason-lspconfig",
		opts = {},
		dependencies = {
			"mason-org/mason.nvim",
			{ "neovim/nvim-lspconfig", name = "nvim-lspconfig" },
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"rust_analyzer",
					"ts_ls",
					"eslint",
					"html",
					"tailwindcss",
					"marksman",
					"yamlls",
					"jsonls",
					"docker_language_server",
				},
			})
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		name = "mason-null-ls",
		dependencies = {
			"mason-org/mason.nvim",
			{ "nvimtools/none-ls.nvim", name = "none-ls" },
		},
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = { "stylua", "markdownlint", "yamlfix" },
			})
		end,
	},
}
