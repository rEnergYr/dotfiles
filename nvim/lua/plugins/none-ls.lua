return {
	"nvimtools/none-ls.nvim",
	name = "none-ls",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvimtools/none-ls-extras.nvim", name = "none-ls-extras" },
	},
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.markdownlint,
				null_ls.builtins.formatting.yamlfix,
			},
		})
	end,
}
