--[[
  Module: lsp
  Description: Provides utilities for working with Neovim's built-in LSP.
               Includes functions to get the primary LSP client for the current buffer.

  Usage:
    local lsp_utils = require("utils.lsp")
    print(lsp_utils.get_primary_lsp())  -- returns the most relevant LSP name

  Functions:
    get_primary_lsp() : string|nil
      Returns the name of the primary LSP client for the current buffer,
      prioritizing LSPs that are attached and have a valid filetype match.
--]]

local M = {}

-- Returns the most relevant LSP for the current buffer
function M.get_primary_lsp()
	local buf_ft = vim.bo.filetype
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if not clients or #clients == 0 then
		return nil
	end

	-- LSP clients that are considered secondary (not language providers)
	local secondary = {
		["copilot"] = true,
		["GitHub Copilot"] = true,
		["tailwindcss"] = true,
		["null-ls"] = true,
		["stylua"] = true,
	}

	-- First: pick a primary LSP (the real language server)
	for _, client in ipairs(clients) do
		local supported = client.config
			and client.config.filetypes
			and vim.tbl_contains(client.config.filetypes, buf_ft)

		if supported and not secondary[client.name] then
			return client.name
		end
	end

	-- Fallback: return a secondary LSP if nothing else matches
	for _, client in ipairs(clients) do
		local supported = client.config
			and client.config.filetypes
			and vim.tbl_contains(client.config.filetypes, buf_ft)

		if supported then
			return client.name
		end
	end

	return nil
end

return M
