return {
	"crnvl96/lazydocker.nvim",
	name = "lazydocker",
	config = function()
		require("lazydocker").setup({
			window = {
				settings = {
					width = 0.9,
					height = 0.9,
				},
			},
		})
	end,
}
