return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			auto_integrations = true,
			styles = {
				comments = { "italic" },
				conditionals = { "italic" },
				loops = { "italic" },
				keywords = { "italic" },
				types = { "italic" },
			},
			transparent_background = true, -- disables setting the background color.
			float = {
				transparent = true,
				solid = false, -- use solid styling for floating windows, see |winborder|
			},
		})
	end,
}
