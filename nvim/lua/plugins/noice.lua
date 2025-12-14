return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		{ "MunifTanjim/nui.nvim", name = "nui" },
	},
	opts = {
		lsp = {
			signature = {
				auto_open = { enabled = false },
			},
		},
	},
}
