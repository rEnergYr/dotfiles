return {
	"rachartier/tiny-code-action.nvim",
	name = "tiny-code-action",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "folke/snacks.nvim" },
	},
	event = "LspAttach",
	opts = {},
}
