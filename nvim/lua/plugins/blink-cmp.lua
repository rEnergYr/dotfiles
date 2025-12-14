return {
	"saghen/blink.cmp",
	name = "blink-cmp",
	dependencies = {
		{ "rafamadriz/friendly-snippets", name = "friendly-snippets" },
	},
	opts = {
		fuzzy = {
			implementation = "lua",
			sorts = {
				"exact",
				"score",
				"sort_text",
			},
		},
		completion = {
			list = {
				max_items = 5,
			},
			menu = {
				border = "rounded",
				draw = {
					align_to = "cursor",
					columns = { { "kind_icon" }, { "label", "source_id", gap = 1 } },
				},
			},
			documentation = {
				auto_show = true,
				window = {
					border = "rounded",
					scrollbar = false,
				},
			},
		},
		keymap = {
			preset = "enter",
			["<Tab>"] = {
				"select_next",
				"snippet_forward",
				"fallback",
			},
			["<S-Tab>"] = {
				"select_prev",
				"snippet_backward",
				"fallback",
			},
		},
	},
}
