local media = require("utils.media")
local copilot = require("utils.copilot")
local lsp = require("utils.lsp")

return {
	"nvim-lualine/lualine.nvim",
	name = "lualine",
	dependencies = { "nvim-tree/nvim-web-devicons", name = "nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = { "snacks_dashboard" },
					winbar = { "snacks_dashboard" },
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					function()
						local track = media.now_playing
						if not track then
							return ""
						end

						local icon = (track.playing_state == "playing") and "󰎆" or "󰏤" -- play / pause icons

						local title = track.title
						if #title > 30 then
							title = title:sub(1, 27) .. "..."
						end

						return string.format("%s %s", icon, title)
					end,
				},
				lualine_c = {
					{
						function()
							if copilot.is_copilot_active() then
								return ""
							end
							return ""
						end,
						on_click = function()
							vim.cmd("Copilot status")
						end,
					},
				},
				lualine_x = {
					{
						function()
							local primary = lsp.get_primary_lsp()

							if primary then
								return primary
							end
							return ""
						end,

						on_click = function()
							vim.cmd("LspInfo")
						end,
					},
				},
				lualine_y = { "progress" },
				lualine_z = {
					function()
						return "󱑎 " .. os.date("%H:%M")
					end,
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
		})
	end,
}
