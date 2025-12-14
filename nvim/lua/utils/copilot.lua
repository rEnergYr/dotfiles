--[[
  Module: copilot
  Description: Provides utility functions to interact with GitHub Copilot in Neovim.
               Currently includes a function to check if Copilot is active for the current buffer.

  Usage:
    local copilot_utils = require("utils.copilot")
    if copilot_utils.is_copilot_active() then
      print("Copilot is active!")
    end

  Functions:
    is_copilot_active() : boolean
      Returns true if Copilot is currently active in the current buffer, false otherwise.
--]]

local M = {}

function M.is_copilot_active()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if not clients or #clients == 0 then
		return false
	end

	for _, client in ipairs(clients) do
		if client.name == "copilot" or client.name == "GitHub Copilot" then
			return true
		end
	end

	return false
end

return M
