return {
	"folke/which-key.nvim",
	name = "which-key",
	event = "VeryLazy",
	opts = {
		preset = "helix",
		icons = {
			rules = {
				{ pattern = "grep", icon = "󱎸", color = "green" },
			},
		},
	},
}
