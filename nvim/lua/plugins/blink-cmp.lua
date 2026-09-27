return {
	"saghen/blink.cmp",
	name = "blink-cmp",
	dependencies = {
		{ "saghen/blink.lib", name = "blink-lib" },
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
				function(cmp)
					local ok, suggestion = pcall(vim.fn["copilot#GetDisplayedSuggestion"])
					if ok and suggestion and suggestion.text ~= nil and suggestion.text ~= "" then
						cmp.hide()
						-- copilot#Accept() returns ALREADY-encoded keycodes:
						-- do not pass them through vim.keycode()/replace_termcodes
						-- (double encoding => <80> leftovers), feed them raw.
						vim.api.nvim_feedkeys(vim.fn["copilot#Accept"](), "n", false)
						return true
					end
				end,
				"fallback",
			},
			["<S-Tab>"] = {
				"fallback",
			},
		},
	},
}
