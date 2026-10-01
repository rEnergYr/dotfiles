--[[
  Module: ai
  Description: AI-assisted actions powered by the GitHub Copilot CLI.
               Runs Copilot in non-interactive mode as an async job,
               shows a spinner notification while it works, then
               reloads the file and turns the notification into a check.

  Usage:
    local ai = require("utils.ai")
    ai.refactor_file()

  Functions:
    refactor_file() : nil
      Asks Copilot to refactor the current file in place
      (cleaner code, same behavior) and reloads it when done.
--]]

local M = {}

local running = false
local spinner_frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }

local function get_notifier()
	local ok, snacks = pcall(require, "snacks")
	if ok and snacks and snacks.notifier then
		return snacks.notifier
	end
	return nil
end

function M.refactor_file()
	if running then
		vim.notify("Copilot refactor already running", vim.log.levels.WARN, { title = "Copilot" })
		return
	end

	local path = vim.api.nvim_buf_get_name(0)
	if path == "" or vim.bo.buftype ~= "" then
		vim.notify("No file to refactor", vim.log.levels.WARN, { title = "Copilot" })
		return
	end
	if vim.fn.executable("copilot") ~= 1 then
		vim.notify("copilot CLI not found", vim.log.levels.ERROR, { title = "Copilot" })
		return
	end

	vim.cmd("silent write")
	local mtime_before = vim.fn.getftime(path)
	local fname = vim.fn.fnamemodify(path, ":t")
	local cwd = vim.fn.fnamemodify(path, ":h")
	running = true

	local notifier = get_notifier()
	local notif_id = "copilot-refactor"
	if notifier then
		notifier.notify("⠋ Refactoring " .. fname .. "…", "info", { id = notif_id, title = "Copilot", timeout = false })
	end

	local frame = 0
	local timer = (vim.uv or vim.loop).new_timer()
	timer:start(0, 120, function()
		frame = frame + 1
		local spin = spinner_frames[(frame % #spinner_frames) + 1]
		vim.schedule(function()
			if notifier then
				notifier.notify(spin .. " Refactoring " .. fname .. "…", "info", {
					id = notif_id,
					title = "Copilot",
					timeout = false,
				})
			end
		end)
	end)

	local errors = {}
	local prompt = "Refactor the file at "
		.. path
		.. " to be clean and idiomatic. Improve naming, structure and readability. "
		.. "Do NOT change its behavior, public API, or logic. "
		.. "Apply the edits directly to the file with your file tools."

	vim.fn.jobstart({ "copilot", "-p", prompt, "-s", "--model", "auto", "--allow-all-tools" }, {
		cwd = cwd,
		stdout_buffered = true,
		stderr_buffered = true,
		on_stderr = function(_, data)
			for _, line in ipairs(data) do
				if line ~= "" then
					table.insert(errors, line)
				end
			end
		end,
		on_exit = function(_, code)
			vim.schedule(function()
				running = false
				if not timer:is_closing() then
					timer:stop()
					timer:close()
				end
				if code ~= 0 then
					local detail = errors[#errors] or ("exit code " .. code)
					if notifier then
						notifier.notify("✗ Refactor failed: " .. detail, "error", {
							id = notif_id,
							title = "Copilot",
							timeout = 5000,
						})
					else
						vim.notify("Refactor failed: " .. detail, vim.log.levels.ERROR, { title = "Copilot" })
					end
					return
				end
				if vim.api.nvim_buf_get_name(0) == path and vim.bo.modified then
					if notifier then
						notifier.notify("✓ Copilot finished, but the buffer has unsaved changes (:e! to load)", "warn", {
							id = notif_id,
							title = "Copilot",
							timeout = 5000,
						})
					end
					return
				end
				if vim.api.nvim_buf_get_name(0) == path then
					vim.cmd("edit!")
				end
				pcall(vim.lsp.buf.format)
				local msg = "✓ Refactor applied: " .. fname
				if vim.fn.getftime(path) == mtime_before then
					msg = "✓ Nothing to refactor: " .. fname
				end
				if notifier then
					notifier.notify(msg, "info", { id = notif_id, title = "Copilot", timeout = 3000 })
				else
					vim.notify(msg, vim.log.levels.INFO, { title = "Copilot" })
				end
			end)
		end,
	})
end

return M
