return {
	"akinsho/bufferline.nvim",
	name = "bufferline",
	version = "*",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons", name = "nvim-web-devicons" },
		"catppuccin/nvim",
		"folke/snacks.nvim",
	},
	config = function()
		require("bufferline").setup({
			highlights = require("catppuccin.special.bufferline").get_theme(),
			options = {
				diagnostics = "nvim_lsp",
				close_command = function(buf)
					require("snacks").bufdelete(buf)
				end,
				offsets = {
					{
						filetype = "snacks_layout_box",
						text = "󰙅  File Explorer",
						separator = true,
					},
				},
			},
		})
	end,
}
