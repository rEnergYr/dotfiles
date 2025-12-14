return {
	"nvim-treesitter/nvim-treesitter",
	name = "treesitter",
	branch = "master",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"lua",
				"rust",
				"javascript",
				"typescript",
				"tsx",
				"html",
				"css",
				"yaml",
				"hjson",
				"toml",
				"jsdoc",
				"dockerfile",
			},
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
