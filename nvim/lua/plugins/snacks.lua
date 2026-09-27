return {
	"folke/snacks.nvim",
	name = "snacks",
	priority = 1000,
	lazy = false,
	opts = {
		dashboard = {
			preset = {
				header = [[                                                                       
       ████ ██████           █████      ██                     
      ███████████             █████                             
      █████████ ███████████████████ ███   ███████████   
     █████████  ███    █████████████ █████ ██████████████   
    █████████ ██████████ █████████ █████ █████ ████ █████   
  ███████████ ███    ███ █████████ █████ █████ ████ █████  
 ██████  █████████████████████ ████ █████ █████ ████ ██████]],
			},
		},
		notifier = {
			enabled = true,
			timeout = 3000,
		},
		picker = {
			sources = {
				explorer = {
					win = {
						list = {
							keys = {
								["<leader>/"] = { "picker_grep", desc = "Grep in directory" },
							},
						},
					},
				},
			},
		},
		dim = {
			animate = {
				enabled = false,
			},
		},
		indent = { enabled = true },
	},
}
