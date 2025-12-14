return {
	{
		"windwp/nvim-ts-autotag",
		name = "autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"m4xshen/autoclose.nvim",
		name = "autoclose",
		config = function()
			require("autoclose").setup()
		end,
	},
}
